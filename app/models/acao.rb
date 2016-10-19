class Acao < ClienteAPI::Model
  attr_accessor :id, :titulo, :descricao, :contrato_medicao_id, :contrato_medicao,
                :data_criacao, :data_atualizacao

  belongs_to :contrato_medicao

  def data_criacao=(data_criacao)
    @data_criacao = data_criacao.to_date if data_criacao.present?
  end

  def data_atualizacao=(data_atualizacao)
    @data_atualizacao = data_atualizacao.to_date if data_atualizacao.present?
  end
end