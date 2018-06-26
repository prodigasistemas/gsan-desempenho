class RecadastramentosController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :find_leituristas

  def index
    imoveis = []
    imoveis = Imovel.where(params[:query]) if params[:query].present?
    @imoveis = smart_listing_create :imoveis, imoveis, partial: 'list',
                                      sort_attributes: [[:situacao_ligacao_agua_id, "imovel.situacao_ligacao_agua_id"]],
                                      default_sort: { situacao_ligacao_agua_id: "asc" }
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
