class ContratoMedicao < API::Model
  RESOURCE_NAME = "contrato_medicao"

  attr_accessor :id, :numero, :vigencia_inicial,
                :vigencia_final, :data_assinatura,
                :empresa_id, :atualizado_em

  def self.pluralize_resource_name
    "contrato_medicoes"
  end
end