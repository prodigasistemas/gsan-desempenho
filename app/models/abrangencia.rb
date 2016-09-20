class Abrangencia < ClienteAPI::Model
  attr_accessor :id, :contrato_medicao_id, :imovel_id, :criado_em, :atualizado_em

  belongs_to :contrato_medicao
  belongs_to :imovel

  def resource_path
    [["contrato_medicoes", contrato_medicao_id]]
  end

  def definir_abrangencia(params)
    begin
      json = post([], params)
      ContratoMedicao.new json["entidade"]
    rescue RestClient::UnprocessableEntity => e
      erro = ClienteAPI::Integracao::Requisicao::ExcecaoNaoConcluido.new(ContratoMedicao, e)
      erro.entidade
    end
  end

  def redefinir_abrangencia
    begin
      json = delete([:redefinir])
      ContratoMedicao.new json["entidade"]
    rescue RestClient::UnprocessableEntity => e
      erro = ClienteAPI::Integracao::Requisicao::ExcecaoNaoConcluido.new(ContratoMedicao, e)
      erro.entidade
    end
  end
end