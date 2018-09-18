class AtualizacaoCadastral < ClienteAPI::Model
  attr_accessor :id,
                :tabela_id,
                :leiturista_id,
                :arquivo_texto_atlz_cad_id,
                :codigo_imovel,
                :codigo_cliente,
                :agente_cadastral,
                :situacao,
                :complemento,
                :tipo_alteracao

  has_many :coluna_atualizacao_cadastrais

  def descricao_imovel
    return "Exclusão" if tipo_alteracao.to_i == 3
    imovel_novo? ? "Novo Imóvel" : "#{codigo_imovel}"
  end

  def imovel_novo?
    tipo_alteracao.to_i == 2
  end
end
