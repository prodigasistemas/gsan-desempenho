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
  resources :acoes, except: [:destroy]
  resources :hidrometro_instalacao_historicos
  resources :medicao_performances,   only: [:new]
  get 'segunda-via', to: 'segunda_via#index', as: :segunda_via
  resources :contas, only: [:index, :show]

  resources :recadastramentos, only: [:index, :show, :update]
  put "/pre_aprovar_em_lote", controller: :recadastramentos, action: :pre_aprovar_em_lote
  put "/enviar_para_revisao_em_lote", controller: :recadastramentos, action: :revisar_em_lote

  resources :imagens, only: [:index]
end
