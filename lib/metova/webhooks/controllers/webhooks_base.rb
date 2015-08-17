module Metova::WebhooksBase
  extend ActiveSupport::Concern

  def index
    respond_with Metova::Webhook.where(user: current_user)
  end

  def create
    @webhook = Metova::Webhook.new permitted_params.merge(user: current_user)
    if block_given?
      yield @webhook
    end
    @webhook.save if @webhook.errors.empty?
    respond_with @webhook, location: nil
  end

  def destroy
    @webhook = Metova::Webhook.where(user: current_user).find(params[:id])
    @webhook.destroy
    respond_with @webhook
  end

  protected
    def permitted_params
      params.require(:webhook).permit(:event, :url)
    end
end
