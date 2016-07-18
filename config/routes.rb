Rails.application.routes.draw do
  root to: 'home#index'

  resources :contrato_medicoes do
    resources :coeficientes, except: [:index, :show]
  end
  resource :session, only: [:new, :create, :destroy]
end