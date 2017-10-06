class ClienteConta < ClienteAPI::Model
 attr_accessor :id,
               :cliente_id,
               :conta_id,
               :tipo_relacao,
               :nome_conta,
               :ultima_alteracao

  belongs_to :conta
  belongs_to :cliente
end
