class Visita < ClienteAPI::Model
  include ClienteAPI::Integracao::Requisicao
  
  attr_accessor :id,
                :imovel_controle_atualizacao_cadastral_id,
                :cadastro_ocorrencia_id,
                :atualizado_em,
                :coordenada_x,
                :coordenada_y

  belongs_to :imovel_controle_atualizacao_cadastral
  belongs_to :cadastro_ocorrencia
end
