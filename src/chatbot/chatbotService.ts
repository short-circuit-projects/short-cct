// src/chatbot/chatbotService.ts
import { buildPrompt } from './promptBuilder'
import { groqChat, setGroqApiKey } from './providers/groq'

export function configureChatbot(apiKey: string): void {
  setGroqApiKey(apiKey)
}

export async function getChatbotReply(message: string): Promise<string> {
  const prompt = buildPrompt(message)
  const response = await groqChat(prompt)
  return response
}
