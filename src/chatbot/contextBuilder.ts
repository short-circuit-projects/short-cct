// src/chatbot/contextBuilder.ts
import { getDatabase } from './chatbotService'

// Common stop words to filter out
const STOP_WORDS = new Set([
  'what', 'is', 'how', 'explain', 'why', 'when', 'where', 'who', 'which',
  'can', 'could', 'would', 'should', 'do', 'does', 'did', 'done',
  'the', 'a', 'an', 'and', 'or', 'but', 'if', 'in', 'on', 'at', 'to', 'for',
  'of', 'with', 'by', 'from', 'that', 'this', 'these', 'those',
  'are', 'be', 'been', 'being', 'have', 'has', 'had',
  'i', 'you', 'he', 'she', 'it', 'we', 'they',
  'my', 'your', 'his', 'her', 'its', 'our', 'their',
  'about', 'as', 'just', 'so', 'than', 'very', 'more', 'most', 'some', 'any'
])

const GENERIC_WORDS = new Set([
  'system', 'lesson', 'lessons', 'course', 'courses', 'platform', 'project'
])

const MAX_CONTEXT_TOKENS = 1400
const MAX_LESSONS = 3
const LESSON_SNIPPET_TOKEN_BUDGET = 420
const STRONG_MATCH_THRESHOLD = 4

const SCORE_WEIGHTS = {
  titleExact: 5,
  titlePartial: 3,
  titleKeyword: 2,
  contentMatch: 1,
  multiKeywordBonusCap: 3,
} as const

type QueryKind = 'full_phrase' | 'phrase' | 'keyword'
type QueryField = 'title' | 'content_json'

interface LessonRow {
  id: string
  title: string
  content_json: string | null
}

interface QuerySignal {
  normalizedMessage: string
  keywords: string[]
  phrases: string[]
  fullPhrase: string
}

interface QueryTerm {
  text: string
  kind: QueryKind
  field: QueryField
}

interface LessonMatch extends LessonRow {
  score: number
  titleHits: number
  contentHits: number
  matchedTerms: Set<string>
  reasons: Set<string>
}

/**
 * Normalize text for matching/scoring.
 */
function normalizeText(value: string): string {
  return value
    .toLowerCase()
    .replace(/[^a-z0-9\s]/g, ' ')
    .replace(/\s+/g, ' ')
    .trim()
}

/**
 * Extract keywords and phrases from user message.
 * Phase 4 keeps both single-word and multi-word signals.
 */
function extractQuerySignal(message: string): QuerySignal {
  const normalizedMessage = normalizeText(message)
  const rawTokens = normalizedMessage.split(' ').filter(Boolean)

  const keywords = [...new Set(
    rawTokens.filter(token => token.length >= 2 && !STOP_WORDS.has(token))
  )]

  const phrases = new Set<string>()
  for (let i = 0; i < keywords.length - 1; i += 1) {
    const left = keywords[i]
    const right = keywords[i + 1]
    if (left && right) {
      phrases.add(`${left} ${right}`)
    }
  }

  // Prefer meaningful keywords for full phrase, but do not drop all tokens.
  const phraseTokens = keywords.filter(token => !GENERIC_WORDS.has(token))
  const fullPhrase = (phraseTokens.length >= 2 ? phraseTokens : keywords).join(' ').trim()

  return {
    normalizedMessage,
    keywords,
    phrases: [...phrases],
    fullPhrase,
  }
}

/**
 * Remove markdown, HTML, and oversized code noise.
 */
function cleanText(content: string): string {
  try {
    content = content
      .replace(/```[\s\S]*?```/g, ' ') // fenced code blocks
      .replace(/`[^`]+`/g, ' ') // inline code
      .replace(/^\s{4,}.*$/gm, ' ') // indented code blocks
      .replace(/<[^>]*>/g, ' ')
      .replace(/&nbsp;/g, ' ')
      .replace(/&quot;/g, '"')
      .replace(/&amp;/g, '&')
      .replace(/&#\d+;/g, ' ')
      .replace(/^#+\s+/gm, '') // Headers
      .replace(/[*_~`]/g, '') // Emphasis, code
      .replace(/\[([^\]]+)\]\([^\)]*\)/g, '$1') // Links
      .replace(/^\s*[-*+]\s+/gm, '') // Lists
      .split(/\s+/)
      .join(' ')
      .trim()

    return content
  } catch {
    return content
  }
}

/**
 * Estimate token count (rough approximation: 1 token ≈ 4 characters)
 */
function estimateTokens(text: string): number {
  return Math.ceil(text.length / 4)
}

/**
 * Build a query plan for Phase 4 multi-query retrieval.
 */
function buildQueryTerms(signal: QuerySignal): QueryTerm[] {
  const terms: QueryTerm[] = []

  if (signal.fullPhrase && signal.fullPhrase.length >= 4) {
    terms.push({ text: signal.fullPhrase, kind: 'full_phrase', field: 'title' })
    terms.push({ text: signal.fullPhrase, kind: 'full_phrase', field: 'content_json' })
  }

  for (const phrase of signal.phrases) {
    if (phrase.length >= 4) {
      terms.push({ text: phrase, kind: 'phrase', field: 'title' })
      terms.push({ text: phrase, kind: 'phrase', field: 'content_json' })
    }
  }

  for (const keyword of signal.keywords) {
    if (keyword.length >= 2) {
      terms.push({ text: keyword, kind: 'keyword', field: 'title' })
      terms.push({ text: keyword, kind: 'keyword', field: 'content_json' })
    }
  }

  const dedup = new Map<string, QueryTerm>()
  for (const term of terms) {
    dedup.set(`${term.kind}|${term.field}|${term.text}`, term)
  }

  return [...dedup.values()]
}

function queryLimit(kind: QueryKind): number {
  if (kind === 'full_phrase') return 8
  if (kind === 'phrase') return 6
  return 4
}

/**
 * Query lessons from D1 using multiple retrieval strategies.
 */
async function queryCandidateLessons(signal: QuerySignal): Promise<LessonRow[]> {
  const db = getDatabase()
  if (!db) {
    console.warn('Database not configured in context builder')
    return []
  }

  try {
    const terms = buildQueryTerms(signal)
    const candidates = new Map<string, LessonRow>()

    for (const term of terms) {
      const field = term.field === 'title' ? 'title' : 'content_json'
      const limit = queryLimit(term.kind)

      try {
        const rows = await db
          .prepare(
            `SELECT id, title, content_json
             FROM lessons
             WHERE is_published = 1
               AND lower(${field}) LIKE ?
             LIMIT ?`
          )
          .bind(`%${term.text}%`, limit)
          .all()

        if (rows.success && rows.results) {
          for (const row of rows.results) {
            const lesson = row as unknown as LessonRow
            if (!candidates.has(lesson.id)) {
              candidates.set(lesson.id, {
                id: lesson.id,
                title: lesson.title,
                content_json: lesson.content_json,
              })
            }
          }
        }
      } catch (queryError) {
        console.error('Phase 4 query error:', queryError)
      }

      if (candidates.size >= 40) {
        break
      }
    }

    return [...candidates.values()]
  } catch (error) {
    console.error('Error querying candidate lessons:', error)
    return []
  }
}

/**
 * Score one lesson based on title/content matches.
 */
function scoreLesson(lesson: LessonRow, signal: QuerySignal): LessonMatch {
  const titleNorm = normalizeText(lesson.title)
  const contentNorm = normalizeText(lesson.content_json ?? '')

  const reasons = new Set<string>()
  const matchedTerms = new Set<string>()
  let score = 0
  let titleHits = 0
  let contentHits = 0

  if (signal.fullPhrase.length >= 4) {
    if (titleNorm === signal.fullPhrase) {
      score += SCORE_WEIGHTS.titleExact
      titleHits += 1
      matchedTerms.add(signal.fullPhrase)
      reasons.add('title_exact')
    } else if (titleNorm.includes(signal.fullPhrase)) {
      score += SCORE_WEIGHTS.titlePartial
      titleHits += 1
      matchedTerms.add(signal.fullPhrase)
      reasons.add('title_partial_phrase')
    }

    if (contentNorm.includes(signal.fullPhrase)) {
      score += SCORE_WEIGHTS.contentMatch
      contentHits += 1
      matchedTerms.add(signal.fullPhrase)
      reasons.add('content_phrase')
    }
  }

  for (const phrase of signal.phrases) {
    if (titleNorm.includes(phrase)) {
      score += SCORE_WEIGHTS.titlePartial
      titleHits += 1
      matchedTerms.add(phrase)
      reasons.add('title_phrase')
    }
    if (contentNorm.includes(phrase)) {
      score += SCORE_WEIGHTS.contentMatch
      contentHits += 1
      matchedTerms.add(phrase)
      reasons.add('content_phrase')
    }
  }

  for (const keyword of signal.keywords) {
    const titleKeywordRegex = new RegExp(`\\b${keyword}\\b`, 'i')
    if (titleKeywordRegex.test(titleNorm)) {
      score += SCORE_WEIGHTS.titleKeyword
      titleHits += 1
      matchedTerms.add(keyword)
      reasons.add('title_keyword')
    }

    if (contentNorm.includes(keyword)) {
      score += SCORE_WEIGHTS.contentMatch
      contentHits += 1
      matchedTerms.add(keyword)
      reasons.add('content_keyword')
    }
  }

  if (matchedTerms.size > 1) {
    score += Math.min(matchedTerms.size - 1, SCORE_WEIGHTS.multiKeywordBonusCap)
    reasons.add('multi_term_bonus')
  }

  return {
    ...lesson,
    score,
    titleHits,
    contentHits,
    matchedTerms,
    reasons,
  }
}

function pushPriorityChunk(chunks: Array<{ priority: number; text: string }>, value: unknown, priority: number): void {
  if (!value) return

  if (typeof value === 'string') {
    const cleaned = cleanText(value)
    if (cleaned) {
      chunks.push({ priority, text: cleaned })
    }
    return
  }

  if (Array.isArray(value)) {
    const arrayText = cleanText(value.map(item => (typeof item === 'string' ? item : JSON.stringify(item))).join(' | '))
    if (arrayText) {
      chunks.push({ priority, text: arrayText })
    }
  }
}

/**
 * Prioritize objective/key points/explanation text from structured lesson JSON.
 */
function extractLessonSummary(rawContent: string | null): string {
  if (!rawContent) {
    return ''
  }

  const chunks: Array<{ priority: number; text: string }> = []

  try {
    const parsed = JSON.parse(rawContent) as Record<string, unknown>

    pushPriorityChunk(chunks, parsed.objective, 5)
    pushPriorityChunk(chunks, parsed.objectives, 5)
    pushPriorityChunk(chunks, parsed.key_points, 5)
    pushPriorityChunk(chunks, parsed.keyPoints, 5)
    pushPriorityChunk(chunks, parsed.explanation, 4)
    pushPriorityChunk(chunks, parsed.overview, 4)
    pushPriorityChunk(chunks, parsed.summary, 4)
    pushPriorityChunk(chunks, parsed.background, 4)
    pushPriorityChunk(chunks, parsed.description, 3)

    const sections = parsed.sections
    if (Array.isArray(sections)) {
      for (const section of sections) {
        if (!section || typeof section !== 'object') continue
        const sectionObj = section as Record<string, unknown>
        const heading = String(sectionObj.title ?? sectionObj.heading ?? sectionObj.name ?? '').trim()
        const body = String(sectionObj.content ?? sectionObj.text ?? sectionObj.description ?? '').trim()
        const joined = `${heading ? `${heading}: ` : ''}${body}`.trim()

        if (joined) {
          const priority = /objective|key point|explanation|overview|concept|summary/i.test(heading) ? 4 : 2
          pushPriorityChunk(chunks, joined, priority)
        }
      }
    }

    if (chunks.length === 0) {
      return cleanText(rawContent)
    }

    chunks.sort((a, b) => b.priority - a.priority)
    return chunks.map(chunk => chunk.text).join(' ')
  } catch {
    return cleanText(rawContent)
  }
}

/**
 * Select top lessons with score + diversity constraints.
 */
function selectTopLessons(scored: LessonMatch[]): LessonMatch[] {
  const sorted = [...scored].sort((a, b) => {
    if (b.score !== a.score) return b.score - a.score
    if (b.titleHits !== a.titleHits) return b.titleHits - a.titleHits
    return b.contentHits - a.contentHits
  })

  const selected: LessonMatch[] = []
  for (const lesson of sorted) {
    if (selected.length >= MAX_LESSONS) break
    if (selected.some(item => item.id === lesson.id)) continue
    selected.push(lesson)
  }

  return selected
}

/**
 * Build context string under token budget.
 */
function formatContext(lessons: LessonMatch[], maxTokens: number = MAX_CONTEXT_TOKENS): string {
  if (lessons.length === 0) {
    return ''
  }

  let tokenCount = 0
  const blocks: string[] = []

  for (const lesson of lessons) {
    const summary = extractLessonSummary(lesson.content_json)
    const maxLessonChars = LESSON_SNIPPET_TOKEN_BUDGET * 4
    const snippet = summary.slice(0, maxLessonChars).trim()
    const block = `Lesson: ${lesson.title}\n${snippet || '(No content preview available)'}`
    const blockTokens = estimateTokens(block)

    if (tokenCount + blockTokens > maxTokens) {
      const remainingTokens = maxTokens - tokenCount
      if (remainingTokens >= 80) {
        blocks.push(`${block.slice(0, remainingTokens * 4).trim()}...`)
      }
      break
    }

    blocks.push(block)
    tokenCount += blockTokens
  }

  return blocks.join('\n\n')
}

/**
 * Main entry point: get context for user message
 */
export async function getContext(message: string): Promise<string> {
  try {
    const signal = extractQuerySignal(message)

    if (signal.keywords.length === 0) {
      console.log({
        phase: 'contextBuilder-v4',
        keywords: [],
        matches: [],
      })
      return ''
    }

    const candidates = await queryCandidateLessons(signal)
    const scoredMatches = candidates.map(candidate => scoreLesson(candidate, signal))
    const ranked = selectTopLessons(scoredMatches)

    console.log({
      phase: 'contextBuilder-v4',
      keywords: signal.keywords,
      phrases: signal.phrases,
      fullPhrase: signal.fullPhrase,
      matches: ranked.map(match => ({
        id: match.id,
        title: match.title,
        score: match.score,
        titleHits: match.titleHits,
        contentHits: match.contentHits,
        reasons: [...match.reasons],
      })),
    })

    const strongMatches = ranked.filter(match => match.score >= STRONG_MATCH_THRESHOLD)
    if (strongMatches.length > 0) {
      return formatContext(strongMatches, MAX_CONTEXT_TOKENS)
    }

    // Fallback strategy: return a minimal best guess if any weak match exists.
    if (ranked.length > 0) {
      return formatContext([ranked[0]], Math.min(MAX_CONTEXT_TOKENS, 350))
    }

    // No match fallback.
    return ''
  } catch (error) {
    console.error('Error in getContext:', error)
    return ''
  }
}