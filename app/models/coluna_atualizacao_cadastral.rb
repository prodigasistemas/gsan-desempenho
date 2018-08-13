class ColunaAtualizacaoCadastral < ClienteAPI::Model
  attr_accessor :id,
                :atualizacao_cadastral_id,
                :tabela_coluna_id,
                :valor_anterior,
                :valor_atual,
                :autorizado,
                :data_processamento,
                :data_ultima_atualizacao,
                :usuario_id,
                :tabela,
                :campo,
                :nome_usuario,
                :valor_revisado

  belongs_to :atualizacao_cadastral
  # belongs_to :tabela_coluna,         foreign_key: :tbco_id
  belongs_to :usuario

  def valor_final
    valor_atual || valor_revisado
  end
end
