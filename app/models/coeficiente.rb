class Coeficiente < API::Model
  attr_accessor :id, :contrato_medicao_id, :contrato_medicao, :coeficiente, :ligacao_agua_id

  belongs_to :contrato_medicao

  def resource_path
    [["contrato_medicoes", contrato_medicao_id]]
  end
end