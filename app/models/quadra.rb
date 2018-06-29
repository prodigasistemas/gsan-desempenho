class Quadra < ClienteAPI::Model
  attr_accessor :id,
                :setor_comercial_id,
                :numero_quadra

  has_many :imoveis
end
