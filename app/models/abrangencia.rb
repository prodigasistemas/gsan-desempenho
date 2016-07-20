class Abrangencia < API::Model
  attr_accessor :id, :contrato_medicao_id, :imovel_id

  belongs_to :contrato_medicao
  belongs_to :imovel

  def resource_path
    [["contrato_medicoes", contrato_medicao_id]]
  end

  def criar(params)
    begin
      json = post([], params)
      self.new json["entidade"]
    rescue RestClient::UnprocessableEntity => e
      erro = API::Integracao::Requisicao::ExcecaoNaoConcluido.new(self, e)
      erro.entidade
    end
  end
end