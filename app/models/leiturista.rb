class Leiturista < ClienteAPI::Model

  attr_accessor :id,
                :funcionario_id,
                :cliente_id,
                :codigo_ddd,
                :numero_telefone,
                :indicador_uso,
                :ultima_alteracao,
                :empresa_id,
                :numero_celular,
                :usuario_id,
                :versao_mobile_id,
                :indicador_leiturista_agente_comercial,
                :unidade_comercial_id,
                :nome

  belongs_to :usuario
  belongs_to :empresa
end
