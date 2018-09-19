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

  def descricao_tabela
      eh_fake? ? "Cliente" : "Subcateg. #{descricao_categoria} - #{abreviacao}"
  end

  def descricao_campo
    eh_fake? ? "Numero CPF/CNPJ" : "Quantidade de Economias"
  end

  def valor
    quantidade
  end

  def eh_fake?
    id.nil?
  end

  def self.criar_subcategoria_fake_cpf(cpf_cnpj)
    Subcategoria.new(quantidade: cpf_cnpj)
  end
end
