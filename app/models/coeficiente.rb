class Coeficiente < API::Model
  attr_accessor :id, :contrato_medicao_id, :contrato_medicao, :coeficiente,
                :ligacao_agua_id, :ligacao_agua_situacao

  belongs_to :contrato_medicao
  belongs_to :ligacao_agua_situacao

  def resource_path
    [["contrato_medicoes", contrato_medicao_id]]
  end
end