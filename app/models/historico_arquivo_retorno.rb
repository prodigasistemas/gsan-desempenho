class HistoricoArquivoRetorno < API::Model
  attr_accessor :id, :usuario_id, :empresa_id, :criado_em, :caminho, :situacao_arquivo

  belongs_to :usuario
  belongs_to :empresa
end