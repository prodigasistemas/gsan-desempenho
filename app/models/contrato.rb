class Contrato
  include ActiveModel::Model
  extend ActiveModel::Naming

  attr_accessor :id, :numero_contrato, :vigencia_inicial

  def initialize(attributes={})
    super
    @errors = ActiveModel::Errors.new(self)
  end

end