class ContratoMedicao < API::Model
  attr_accessor :id, :numero, :vigencia_inicial, :vigencia_final, :data_assinatura, :empresa, :empresa_id, :atualizado_em
end