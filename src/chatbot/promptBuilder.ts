// src/chatbot/promptBuilder.ts
export function buildPrompt(message: string, context: string): string {
  return `SYSTEM:
You are a helpful tutor for a learning platform.

CONTEXT:
${context}

USER:
${message}`
}
