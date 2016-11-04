class Coeficiente < ClienteAPI::Model
  attr_accessor :id, :contrato_medicao_id, :contrato_medicao, :coeficiente,
                :ligacao_agua_id, :ligacao_agua_situacao, :usuario_id

  belongs_to :contrato_medicao
  belongs_to :ligacao_agua_situacao
end