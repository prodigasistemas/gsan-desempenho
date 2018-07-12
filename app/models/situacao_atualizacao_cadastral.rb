class SituacaoAtualizacaoCadastral < ClienteAPI::Model
  attr_accessor :id,
                :descricao,
                :indicador_uso,
                :ultima_alteracao

  has_many :imovel_controle_atualizacao_cadastral
end
