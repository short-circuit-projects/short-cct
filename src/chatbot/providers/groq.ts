import type { LLMProvider } from './types'

export class GroqProvider implements LLMProvider {
  private readonly apiKey: string

  constructor(apiKey: string) {
    this.apiKey = apiKey
  }

  async generate(prompt: string): Promise<string> {
    const fallback = 'Something went wrong, try again.'
    const url = new URL('https://api.groq.com/openai/v1/chat/completions')
    const model = 'llama-3.1-8b-instant'

    if (!this.apiKey) {
      return fallback
    }

    try {
      const response = await fetch(url.toString(), {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${this.apiKey}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          model,
          messages: [{ role: 'user', content: prompt }],
        }),
      })

      if (!response.ok) {
        const errorText = await response.text().catch(() => '')
        console.log('GROQ ERROR:', response.status, errorText)
        return fallback
      }

      const data: unknown = await response.json().catch(() => null)
      const root = data as Record<string, unknown> | null
      const choices = Array.isArray(root?.choices) ? (root.choices as Array<Record<string, unknown>>) : []
      const message = choices[0]?.message as Record<string, unknown> | undefined
      if (typeof message?.content === 'string' && message.content.trim()) {
        return message.content.trim()
      }

      return fallback
    } catch {
      return fallback
    }
  }
}