class Empresa < ClienteAPI::Model
  include API::Integracao::Requisicao

  attr_accessor :id, :nome, :email, :ativo, :ultima_alteracao,
                :principal, :cobranca, :leitura,
                :encerramento_contrato, :meses_pagamento, :validar_pagamento

  has_many :contrato_medicoes
  has_many :imovel_retornos

  def self.do_usuario(usuario_id)
    json = JSON.parse(RestClient.get("#{API::Base::URL_BASE}/empresas_usuario/#{usuario_id}"))
    entidades = json["entidades"]
    entidades.map {|entidade| self.new entidade }
  end
end