class CadastroOcorrencia < ClienteAPI::Model
  attr_accessor :id,
                :descricao,
                :indicador_uso,
                :ultima_alteracao,
                :indicador_suspende_contrato,
                :indicador_validacao
end
