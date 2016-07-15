FactoryGirl.define do
  factory :contrato_medicao, class: ContratoMedicao do
    numero 1
    vigencia_inicial DateTime.now
    vigencia_final { DateTime.now + 30.days }
    data_assinatura DateTime.now
    empresa_id 1
  end
end