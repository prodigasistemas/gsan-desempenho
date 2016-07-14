Rails.application.routes.draw do
  root to: 'home#index'

  resources :contrato_medicoes
  resources :sessions, only: [:new, :create]
end