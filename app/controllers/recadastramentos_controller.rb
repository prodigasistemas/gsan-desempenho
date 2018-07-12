class RecadastramentosController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :find_leituristas
  before_action :find_atualizacao_cadastral, :find_imovel, only: [:show]

  def index
    atualizacao_cadastrais = []
    @filtro = FiltroRecadastramento.new(params)
    if params[:query].present?
      params[:query][:empresa_id] = 50 #usuario_logado.empresa_id
      atualizacao_cadastrais = AtualizacaoCadastral.where(params[:query])
    end
    @atualizacao_cadastrais = smart_listing_create :atualizacao_cadastrais,
                                                   atualizacao_cadastrais,
                                                   partial: 'list',
                                                   default_sort: { leiturista_id: "desc" }
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
end
