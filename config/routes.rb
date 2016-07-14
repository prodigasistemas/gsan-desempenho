Rails.application.routes.draw do
  root to: 'home#index'

  resources :contratos
  resource :session, only: [:new, :create, :destroy]
end