class RecadastramentosController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :verificar_parametros_obrigatorios, :find_empresas, :find_leituristas, only: [:index]
  before_action :find_coluna_atualizacao_cadastrais, :find_imovel, only: [:show]

  def index
    atualizacao_cadastrais = []
    @filtro = FiltroRecadastramento.new(params)
    if params[:query].present?
      unless flash[:error].nil?
        redirect_to recadastramentos_path
        return
      end
      atualizacao_cadastrais = AtualizacaoCadastral.where(params[:query])
    end
    @atualizacao_cadastrais = smart_listing_create :atualizacao_cadastrais,
                                                   atualizacao_cadastrais,
                                                   partial: 'list',
                                                   page_sizes: [25, 50]
  end

  def show
    @campos = smart_listing_create :campos,
                                   @coluna_atualizacao_cadastrais,
                                   partial: 'campos_list',
                                   page_sizes: [100]
  end

  private
    def find_leituristas
      @leituristas = []
    end

    def find_coluna_atualizacao_cadastrais
      atualizacao_cadastrais = AtualizacaoCadastral.where(codigo_imovel: params[:id])
      @coluna_atualizacao_cadastrais = ColunaAtualizacaoCadastral.where(atualizacao_cadastral_id: atualizacao_cadastrais.map(&:id))
    end

    def find_imovel
      @imovel = Imovel.where(id: params[:id], page: 1, per_page: 10).try(:first)
    end

    def find_empresas
      @empresas = Empresa.where(empr_id: usuario_logado.empresa_id)
      # @empresas = Empresa.where(leituristas: true)
    end

    def verificar_parametros_obrigatorios
      if params[:query].present?
        flash[:error] = "Período Inicial e Final são obrigatórios" if params[:query][:periodo_inicial].blank? or params[:query][:periodo_final].blank?
        flash[:error] = "Agente Cadastral é obrigatório" if params[:query][:leiturista_id].blank?
      end
    end
end
