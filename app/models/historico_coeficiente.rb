class HistoricoCoeficiente < API::Model
  attr_accessor :id, :coeficiente, :coeficiente_id, :numero_coeficiente, :usuario, :usuario_id, :ligacao_agua_situacao, :ligacao_agua_id, :criado_em

  belongs_to :ligacao_agua_situacao
  belongs_to :coeficiente
  belongs_to :usuario
end