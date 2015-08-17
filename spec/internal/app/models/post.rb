class Post < ActiveRecord::Base
  include Metova::Webhookable

  belongs_to :user

  has_many :webhooks, source: 'Metova::Webhook'
end
