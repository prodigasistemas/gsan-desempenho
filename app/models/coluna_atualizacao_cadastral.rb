class ColunaAtualizacaoCadastral < ClienteAPI::Model
  attr_accessor :id,
                :atualizacao_cadastral_id,
                :tabela_coluna_id,
                :valor_anterior,
                :valor_atual,
                :autorizado,
                :data_processamento,
                :data_ultima_atualizacao,
                :usuario_id

  # belongs_to :atualizacao_cadastral, foreign_key: :tatc_id
  # belongs_to :tabela_coluna,         foreign_key: :tbco_id
  belongs_to :usuario
end