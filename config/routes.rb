Rails.application.routes.draw do
  root to: 'home#index'

  resources :contrato_medicoes
  resource :session, only: [:new, :create, :destroy]
end