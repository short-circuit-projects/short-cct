// src/chatbot/chatbotService.ts
import { buildPrompt } from './promptBuilder'
import { getContext } from './contextBuilder'
import { GroqProvider } from './providers/groq'
import type { LLMProvider } from './providers/types'

let provider: LLMProvider | null = null

export function configureChatbot(apiKey: string): void {
  provider = new GroqProvider(apiKey)
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
