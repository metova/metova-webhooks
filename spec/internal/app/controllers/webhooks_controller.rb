class WebhooksController < ActionController::Base
  respond_to :json
  around_filter :rescue_not_found
  include Metova::WebhooksBase

  def create
    super do |webhook|
      webhook.errors.add :user, 'must be jami' unless webhook.user.try(:email) == 'jami.couch@metova.com'
    end
  end

  protected
    def current_user
      nil
    end

    def rescue_not_found
      yield
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: [ e.message ] }, status: :not_found
    end
end
