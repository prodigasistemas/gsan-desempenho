class ClienteImovel < ClienteAPI::Model
  include ClienteAPI::Integracao::Requisicao

  attr_accessor :id,
                :cliente_id,
                :imovel_id,
                :data_inicio_relacao,
                :data_fim_relacao,
                :motivo_fim_relacao_id,
                :ultima_alteracao,
                :tipo_relacao,
                :nome_conta,
                :cliente_relacao_tipo_id

  belongs_to :imovel
  belongs_to :cliente

end
