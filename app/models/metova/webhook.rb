module Metova
  class Webhook < ActiveRecord::Base
    belongs_to :user, required: true

    validates_presence_of :event
    validates_presence_of :url
  end
end
