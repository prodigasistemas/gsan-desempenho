class CadastroOcorrencia < ClienteAPI::Model
  attr_accessor :id,
                :descricao,
                :indicador_uso,
                :ultima_alteracao,
                :indicador_suspende_contrato,
                :indicador_validacao

  def self.com_indicador_validacao(ocorrencias)
    ocorrencias.select { |o| o.is_indicador_validacao? }
  end

  def self.sem_indicador_validacao(ocorrencias)
    ocorrencias.select { |o| !o.is_indicador_validacao? }
  end

  def is_indicador_validacao?
    indicador_validacao.present? and indicador_validacao == 1
  end
end
