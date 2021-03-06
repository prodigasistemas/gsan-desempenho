class HistoricoArquivoRetorno < ClienteAPI::Model
  attr_accessor :id, :usuario_id, :empresa_id, :criado_em, :caminho, :situacao_arquivo, :tipo_arquivo

  belongs_to :usuario
  belongs_to :empresa

  TIPO_ARQUIVO = {
    imovel_retorno: "recadastramento_imovel",
    hidrometro_historico: "hidrometro_historico",
    medicao_performance_analitico: "medicao_performance_analitico",
    medicao_performance_sintetico: "medicao_performance_sintetico"
  }

  def self.filtrar_por(tipo_arquivo, collection)
    attrs = {}
    attrs['entidades'] = send(tipo_arquivo.to_sym, collection)
    ClienteAPI::Integracao::Paginacao.build(attrs)
  end

  private

  def self.hidrometro_historico(collection)
    collection.select { |h| h.tipo_arquivo == TIPO_ARQUIVO[:hidrometro_historico] }
  end

  def self.imovel_retorno(collection)
    collection.select { |h| h.tipo_arquivo == TIPO_ARQUIVO[:imovel_retorno] or h.tipo_arquivo.blank? }
  end

  def self.medicao_performance_relatorios(collection)
    collection.select { |h| [
                              TIPO_ARQUIVO[:medicao_performance_sintetico],
                              TIPO_ARQUIVO[:medicao_performance_analitico]
                            ].include?(h.tipo_arquivo)}
  end
end