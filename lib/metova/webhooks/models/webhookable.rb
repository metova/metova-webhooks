module Metova::Webhookable
  extend ActiveSupport::Concern

  included do
    after_create :create_hook
    after_update :update_hook
    after_destroy :destroy_hook
  end

  def namespace
    ''
  end

  def hook_name
    self.class.to_s.underscore
  end

  def webhook_event(event)
    [namespace, hook_name, event].reject(&:empty?).join(':')
  end

  def create_hook
    Metova::WebhookJob.perform_later webhook_event('create'), self.webhook_serialize
  end

  def update_hook
    Metova::WebhookJob.perform_later webhook_event('update'), self.webhook_serialize
  end

  def destroy_hook
    Metova::WebhookJob.perform_later webhook_event('destroy'), self.webhook_serialize
  end

  def webhook_serialize
    self.to_json
  end
end
