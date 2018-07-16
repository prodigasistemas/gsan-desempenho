class RecadastramentosController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :find_leituristas
  before_action :verificar_parametros_obrigatorios, only: [:index]
  before_action :find_atualizacao_cadastral, :find_imovel, only: [:show]

  def index
    atualizacao_cadastrais = []
    @filtro = FiltroRecadastramento.new(params)
    if params[:query].present?
      unless flash[:error].nil?
        redirect_to recadastramentos_path
        return
      end
      params[:query][:empresa_id] = 50 #usuario_logado.empresa_id
      atualizacao_cadastrais = AtualizacaoCadastral.where(params[:query])
    end
    @atualizacao_cadastrais = smart_listing_create :atualizacao_cadastrais,
                                                   atualizacao_cadastrais,
                                                   partial: 'list'
  end

  def show
    @campos = smart_listing_create :campos,
                                   @coluna_atualizacao_cadastrais,
                                   partial: 'campos_list'
  end

  private
    def find_leituristas
      @leituristas = []
      l = Leiturista.new({ id: 1, nome: "Neymar Jr" })
      @leituristas << l
    end

    def find_atualizacao_cadastral
      @coluna_atualizacao_cadastrais = ColunaAtualizacaoCadastral.where(atualizacao_cadastral_id: params[:id])
    end

    def find_imovel
      # @imovel = Imovel.where(id: @atualizacao_cadastral.codigo_imovel, page: 1, per_page: 10).try(:first) unless @atualizacao_cadastral.nil?
    end

    def verificar_parametros_obrigatorios
      if params[:query].present?
        flash[:error] = "Período Inicial e Final são obrigatórios" if params[:query][:periodo_inicial].blank? or params[:query][:periodo_final].blank?
        flash[:error] = "Agente Cadastral é obrigatório" if params[:query][:agente_cadastral].blank?
      end
    end
end
