class Usuario
  include ActiveModel::Model
  extend ActiveModel::Naming

  attr_accessor :nome_usuario, :senha
  attr_reader :errors

  def initialize(attributes={})
    super
    @errors = ActiveModel::Errors.new(self)
  end

  def login
    response = ApiRestClient.new.request :autenticacao, nome_usuario: nome_usuario, senha: senha

    begin
      login!(response)
      true
    rescue
      false
    end
  end

  def login!(params={})
    return unless params.nil?

    @errors[:nome_usuario] << "Nome de usuário ou Senha inválido"
    @errors[:senha] << "Nome de usuário ou Senha inválido"

    raise "Autenticação Inválida"
  end

  def read_attribute_for_validation(attr)
    send(attr)
  end

  def self.human_attribute_name(attr, options = {})
    attr
  end

  def self.lookup_ancestors
    [self]
  end
end