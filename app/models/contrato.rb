class Contrato
  include ActiveModel::Model
  extend ActiveModel::Naming

  attr_accessor :id, :numero, :vigencia_inicial, :vigencia_final, :data_assinatura, :empresa_id, :atualizado_em

  def initialize(attributes={})
    super
    @errors = ActiveModel::Errors.new(self)
  end

end