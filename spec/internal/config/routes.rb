Rails.application.routes.draw do
  resources :webhooks, only: [:index, :create, :destroy]
end
