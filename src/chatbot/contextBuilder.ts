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

interface LessonMatch {
  id: string
  title: string
  content_json: string | null
  priority: 'title' | 'content'
  score: number
}

/**
 * Extract keywords from user message
 * Filters stop words, keeps meaningful terms
 */
function extractKeywords(message: string): string[] {
  const normalized = message.toLowerCase()
  const words = normalized
    .split(/[\s\-\.,;:!?\/\\()[\]{}\"\']+/)
    .filter(w => w.length > 2 && !STOP_WORDS.has(w))
  
  // Remove duplicates and return
  return [...new Set(words)]
}

/**
 * Clean HTML, JSON, Markdown to plain text
 */
function cleanContent(content: string): string {
  try {
    // If it looks like JSON, try to extract text from it
    if (content.startsWith('{') || content.startsWith('[')) {
      try {
        const parsed = JSON.parse(content)
        
        // For video lessons, extract text from description/notes
        if (parsed.description) {
          content = parsed.description
        } else if (parsed.text) {
          content = parsed.text
        } else if (parsed.notes) {
          content = parsed.notes
        } else if (typeof parsed === 'string') {
          content = parsed
        } else {
          // Stringify and try again
          content = JSON.stringify(parsed)
        }
      } catch {
        // Not valid JSON, continue with original
      }
    }

    // Remove HTML tags
    content = content
      .replace(/<[^>]*>/g, ' ')
      .replace(/&nbsp;/g, ' ')
      .replace(/&quot;/g, '"')
      .replace(/&amp;/g, '&')
      .replace(/&#\d+;/g, ' ')

    // Remove Markdown formatting
    content = content
      .replace(/^#+\s+/gm, '') // Headers
      .replace(/[*_~`]/g, '') // Emphasis, code
      .replace(/\[([^\]]+)\]\([^\)]*\)/g, '$1') // Links
      .replace(/^\s*[-*+]\s+/gm, '') // Lists

    // Clean up whitespace
    content = content
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
 * Query lessons from D1 database
 */
async function queryLessons(keywords: string[]): Promise<LessonMatch[]> {
  const db = getDatabase()
  if (!db) {
    console.warn('Database not configured in context builder')
    return []
  }

  try {
    const results: LessonMatch[] = []
    
    // Try each keyword and collect matches
    for (const keyword of keywords) {
      const pattern = `%${keyword}%`
      
      // Query by title (higher priority)
      try {
        const titleResults = await db
          .prepare(
            `SELECT id, title, content_json, 'title' as priority, 1 as score
             FROM lessons
             WHERE is_published = 1 AND title LIKE ?
             LIMIT 2`
          )
          .bind(pattern)
          .all()
        
        if (titleResults.success && titleResults.results) {
          for (const row of titleResults.results) {
            results.push({
              id: (row as any).id,
              title: (row as any).title,
              content_json: (row as any).content_json,
              priority: 'title',
              score: 1
            })
          }
        }
      } catch (e) {
        console.error('Title query error:', e)
      }

      // Query by content (lower priority, only if no title matches yet)
      if (results.length === 0) {
        try {
          const contentResults = await db
            .prepare(
              `SELECT id, title, content_json, 'content' as priority, 0.5 as score
               FROM lessons
               WHERE is_published = 1 AND content_json LIKE ?
               LIMIT 2`
            )
            .bind(pattern)
            .all()
          
          if (contentResults.success && contentResults.results) {
            for (const row of contentResults.results) {
              results.push({
                id: (row as any).id,
                title: (row as any).title,
                content_json: (row as any).content_json,
                priority: 'content',
                score: 0.5
              })
            }
          }
        } catch (e) {
          console.error('Content query error:', e)
        }
      }
      
      // Stop if we have good results
      if (results.length >= 2) {
        break
      }
    }

    return results
  } catch (error) {
    console.error('Error querying lessons:', error)
    return []
  }
}

/**
 * Format lessons into context string with token budget
 */
function formatContext(lessons: LessonMatch[], maxTokens: number = 1500): string {
  if (lessons.length === 0) {
    return ''
  }

  // Deduplicate by id
  const seen = new Set<string>()
  const unique = lessons.filter(l => {
    if (seen.has(l.id)) return false
    seen.add(l.id)
    return true
  })

  // Sort by priority (title first) then by score
  unique.sort((a, b) => {
    if (a.priority !== b.priority) {
      return a.priority === 'title' ? -1 : 1
    }
    return b.score - a.score
  })

  // Take top 3 lessons
  const topLessons = unique.slice(0, 3)

  let contextLines: string[] = []
  let tokenCount = 0

  for (const lesson of topLessons) {
    // Clean content
    let contentText = ''
    if (lesson.content_json) {
      contentText = cleanContent(lesson.content_json)
    }

    // Truncate content to reasonable size
    const contentPreview = contentText.substring(0, 500)
    
    // Build lesson block
    const lessonBlock = `Lesson: ${lesson.title}
${contentPreview ? contentPreview + '...' : '(No content preview available)'}`

    const blockTokens = estimateTokens(lessonBlock)
    
    // Check if adding this lesson exceeds budget
    if (tokenCount + blockTokens > maxTokens) {
      // Try to fit what we can
      const remaining = maxTokens - tokenCount
      if (remaining > 100) {
        // Add shortened version
        const shortened = lessonBlock.substring(0, remaining * 4)
        contextLines.push(shortened + '...')
      }
      break
    }

    contextLines.push(lessonBlock)
    tokenCount += blockTokens
  }

  return contextLines.join('\n\n')
}

/**
 * Main entry point: get context for user message
 */
export async function getContext(message: string): Promise<string> {
  try {
    // Extract keywords
    const keywords = extractKeywords(message)
    
    if (keywords.length === 0) {
      // No meaningful keywords, return empty context
      return ''
    }

    // Query lessons
    const matches = await queryLessons(keywords)
    
    // Format and truncate
    const context = formatContext(matches, 1500)
    
    return context
  } catch (error) {
    console.error('Error in getContext:', error)
    // Fail gracefully - return empty string instead of throwing
    return ''
  }
}