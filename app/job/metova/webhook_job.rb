module Metova
  class WebhookJob < ActiveJob::Base
    queue_as :default

    def perform(event, payload)
      Webhook.where(event: event).each do |webhook|
        begin
          url = URI.parse(webhook.url)
          Net::HTTP.post_form url, JSON.parse(payload)
        rescue Exception => e
          Rails.logger.error e.message
        end
      end
    end
  end
end
