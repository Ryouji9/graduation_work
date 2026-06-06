class AnthropicService
  def initialize
    @api_key = ENV["ANTHROPIC_API_KEY"]
  end

  def generate_episode(era, worries, feeling)
    prompt = build_prompt(era, worries, feeling)
    
    client = Anthropic::Client.new(api_key: @api_key)
    response = client.messages.create(
      model: "claude-haiku-4-5-20251001",
      max_tokens: 1024,
      messages: [
        { role: "user", content: prompt }
      ]
    )
    response.content.first.text
  #rescue => e
  #  Rails.logger.error "Anthropic API error: #{e.message}"
  #  "エピソードの生成中にエラーが発生しました。もう一度お試しください。"
  end

  private

  def build_prompt(era, worries, feeling)
    worries_text = Array(worries).join("、")
    <<~PROMPT
      あなたは歴史上の偉人のエピソードを紹介する専門家です。
      以下の条件に当てはまる偉人のエピソードを日本語で紹介してください。

      【ユーザーの状況】
      - 年代：#{era}
      - 悩み：#{worries_text}
      - 今の気持ち：#{feeling}

      【出力形式】
      - 偉人名（生没年）
      - 共通点：ユーザーとの共通点を2〜3文で説明
      - エピソード：逆転や挑戦のエピソードを200〜300文字で紹介
      - メッセージ：ユーザーへの励ましのメッセージを1〜2文で

      ※エピソードはAIによる生成のため、詳細は各自でご確認ください。
    PROMPT
  end
end
