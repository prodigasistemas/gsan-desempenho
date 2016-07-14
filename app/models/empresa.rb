class Empresa
  include ActiveModel::Model
  extend ActiveModel::Naming

  attr_accessor :id, :nome

  def initialize(attributes={})
    super
    @errors = ActiveModel::Errors.new(self)
  end

end