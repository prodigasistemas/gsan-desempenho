class AtualizacaoCadastral < ClienteAPI::Model
  attr_accessor :id,
                :tabela_id,
                :leiturista_id,
                :arquivo_texto_atlz_cad_id,
                :codigo_imovel,
                :codigo_cliente

  has_many :coluna_atualizacao_cadastrais
end
