class RecadastramentosController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :find_leituristas
  before_action :find_atualizacao_cadastral, :find_imovel, only: [:show]

  def index
    colunas = []
    @filtro = FiltroRecadastramento.new(params)
    if params[:query].present?
      params[:query][:empresa_id] = usuario_logado.empresa_id
      # colunas = ColunaAtualizacaoCadastral.where(@filtro, page: 1, per_page: 100)
    end
    @colunas = smart_listing_create :colunas, colunas, partial: 'list',
                                      sort_attributes: [[:atualizacao_cadastral_id, "coluna.atualizacao_cadastral_id"]],
                                      default_sort: { atualizacao_cadastral_id: "asc" }
  end

  def show
    @campos = smart_listing_create :campos,
                                   [],
                                   partial: 'campos_list',
                                   default_sort: { id: "asc" }
  end

  private
    def find_leituristas
      @leituristas = []
      l = Leiturista.new({ id: 1, nome: "Neymar Jr" })
      @leituristas << l
    end

    def find_atualizacao_cadastral
      @atualizacao_cadastral = AtualizacaoCadastral.where(id: params[:id], page: 1, per_page: 100).try(:first) || AtualizacaoCadastral.new
    end

    def find_imovel
      @imovel = Imovel.where(id: @atualizacao_cadastral.codigo_imovel, page: 1, per_page: 10).try(:first) unless @atualizacao_cadastral.nil?
    end
end
