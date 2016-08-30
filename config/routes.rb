Rails.application.routes.draw do
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
    resources :imovel, only: :none do
      resource :abrangencia, only: :destroy
    end
  end

  resources :imovel_retorno
end