class ImovelControleAtualizacaoCadastral < ClienteAPI::Model
  attr_accessor :id,
                :imovel_id,
                :tempo_geracao,
                :tempo_retorno,
                :tempo_aprovacao,
                :situacao_atualizacao_cadastral_id,
                :imovel_retorno_id,
                :tempo_processamento,
                :cadastro_imovel_id

  belongs_to :cadastro_ocorrencia
  belongs_to :imovel
  belongs_to :imovel_retorno
  belongs_to :situacao_atualizacao_cadastral

  def descricao_ocorrencia
    cadastro_ocorrencia.try(:descricao)
  end
end
