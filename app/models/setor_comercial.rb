class SetorComercial < ClienteAPI::Model
  attr_accessor :id, :nome, :localidade_id, :codigo,
                :indicador_uso, :municipio_id, :ultima_alteracao,
                :indicador_alternativo, :indicador_bloqueio
end