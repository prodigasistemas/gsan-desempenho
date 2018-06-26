class RecadastramentosController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :find_leituristas

  def index
    colunas = []
    colunas = ColunaAtualizacaoCadastral.where(params[:query]) if params[:query].present?
    @colunas = smart_listing_create :colunas, colunas, partial: 'list',
                                      sort_attributes: [[:atualizacao_cadastral_id, "coluna.atualizacao_cadastral_id"]],
                                      default_sort: { atualizacao_cadastral_id: "asc" }
  end

  private
    def find_leituristas
      @leituristas = []
      l = Leiturista.new
      l.id = 1
      l.nome = "Neymar Jr"
      @leituristas << l
    end
end
