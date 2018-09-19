class Subcategoria < ClienteAPI::Model
  include ClienteAPI::Integracao::Requisicao
  
  attr_accessor :id,
                :categoria_id,
                :codigo,
                :descricao,
                :indicador_uso,
                :ultima_alteracao,
                :codigo_tarifa_social,
                :fator_fiscalizacao,
                :indicador_tarifa_consumo,
                :abreviacao,
                :codigo_grupo_subcategoria,
                :indicador_sazonalidade,
                :indicador_rural,
                :quantidade,
                :descricao_categoria

  def descricao_completa
    "Subcateg. #{descricao_categoria} - #{abreviacao}"
  end
end
