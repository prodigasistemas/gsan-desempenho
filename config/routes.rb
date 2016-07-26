Rails.application.routes.draw do
  # root to: 'home#index'
  root to: 'contrato_medicoes#index'

  resources :contrato_medicoes do
    resources :coeficientes, except: [:edit, :update, :destroy] do
      collection do
        get :edit
        put :update
      end
    end
    resources :abrangencias, except: [:destroy]
    resource :abrangencias, only: :none do
      delete :redefinir
    end
  end
  resource :session, only: [:new, :create, :destroy]
end