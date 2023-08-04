class WebhookJob < ApplicationJob
  queue_as :default

  def perform(distination:, type:, subject:, message:, url:)
    conn = Faraday.new(
      url: distination,
      params: {
        activity: {
          type: type,
          subject: subject,
        },
        message: message,
        url: url,
      },
      headers: { 'Content-Type' => 'application/json' }
    )
    conn.post('')
  end
end
