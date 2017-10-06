class MedicaoPerformance < ClienteAPI::Model
  attr_accessor :id,                           :criado_em,
                :ano_mes_referencia,           :diferenca_consumo_agua,
                :valor_diferenca_consumo_agua, :valor_diferenca_consumo_esgoto,
                :percentual_consumo_esgoto,    :debito_credito_situacao_id,
                :contrato_medicao_id,          :imovel_id

  belongs_to :contrato_medicao
  belongs_to :imovel

  def relatorio(params={})
    begin
      url = get([:relatorio], params)
    rescue RestClient::UnprocessableEntity => e
      erro = ClienteAPI::Integracao::Requisicao::ExcecaoNaoConcluido.new(MedicaoPerformance, e)
      erro.entidade
    end
  end
end
