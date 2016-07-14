Rails.application.routes.draw do
  root to: 'home#index'

  resources :contratos
  resources :sessions, only: [:new, :create]
end