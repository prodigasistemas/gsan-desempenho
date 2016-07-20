class Abrangencia < API::Model
  attr_accessor :id, :contrato_medicao_id, :imovel_id

  belongs_to :contrato_medicao
  belongs_to :imovel
end