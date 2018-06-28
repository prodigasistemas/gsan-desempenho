class RecadastramentosController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :find_leituristas

  def index
    colunas = []
    @filtro = FiltroRecadastramento.new(params)
    if params[:query].present?
      params[:query][:empresa_id] = usuario_logado.empresa_id
      # colunas = ColunaAtualizacaoCadastral.where(@filtro)
    end
    @colunas = smart_listing_create :colunas, colunas, partial: 'list',
                                      sort_attributes: [[:atualizacao_cadastral_id, "coluna.atualizacao_cadastral_id"]],
                                      default_sort: { atualizacao_cadastral_id: "asc" }
  end

  private
    def find_leituristas
      @leituristas = []
      l = Leiturista.new({id: 1, nome: "Neymar Jr"})
      @leituristas << l
    end
end
