class Coeficiente < API::Model
  attr_accessor :id, :contrato_medicao_id, :coeficiente, :ligacao_agua_id

  def resource_path
    [["contrato_medicoes", contrato_medicao_id]]
  end
end