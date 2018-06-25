class RecadastramentosController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :find_leituristas

  def index
    imoveis = []
    @imoveis = smart_listing_create :imoveis, imoveis, partial: 'list',
                                      sort_attributes: [[:situacao, "imovel.situal"]],
                                      default_sort: { situacao: "asc" }
  end

  private
    def find_leituristas
      @leituristas = []
      l = Leiturista.new
      l.id = 1
      l.nome = "Neymar Jr"
      @leituristas << l
    end
  #   def pesquisa_params
  #     params.require(:pesquisa).permit(
  #       :agente_cadastral,
  #       :periodo_inicial,
  #       :periodo_final,
  #       :localidade_inicial,
  #       :setor_comercial_inicial,
  #       :rota_inicial,
  #       :localidade_final,
  #       :setor_comercial_final,
  #       :rota_final,
  #       :exibir_imoveis,
  #       :ocorrencias_cadastro,
  #       :alteracao_hidrometro,
  #       :alteracao_agua,
  #       :alteracao_esgoto,
  #       :alteracao_categoria_subcategoria
  #   )
  #   end
end
