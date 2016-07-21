class Abrangencia < API::Model
  attr_accessor :id, :contrato_medicao_id, :imovel_id

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
      erro = API::Integracao::Requisicao::ExcecaoNaoConcluido.new(ContratoMedicao, e)
      erro.entidade
    end
  end
end