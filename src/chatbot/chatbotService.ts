// src/chatbot/chatbotService.ts
import { buildPrompt } from './promptBuilder'
import { getContext } from './contextBuilder'
import { GroqProvider } from './providers/groq'
import type { LLMProvider } from './providers/types'

let provider: LLMProvider | null = null
let database: D1Database | null = null

export function configureChatbot(apiKey: string, db?: D1Database): void {
  provider = new GroqProvider(apiKey)
  if (db) {
    database = db
  }
}

export function getDatabase(): D1Database | null {
  return database
}

export async function getChatbotReply(message: string): Promise<string> {
  if (!provider) {
    throw new Error('Chatbot provider is not configured')
  }

  const context = await getContext(message)
  const prompt = buildPrompt(message, context)
  const response = await provider.generate(prompt)
  return response
}
