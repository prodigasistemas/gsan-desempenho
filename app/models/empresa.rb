class Empresa < API::Model
  attr_accessor :id, :nome, :email, :ativo, :ultima_alteracao,
                :principal, :cobranca, :leitura,
                :encerramento_contrato, :meses_pagamento, :validar_pagamento

  has_many :contrato_medicoes
  has_many :imovel_retornos
end