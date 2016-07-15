class Usuario < API::Model
  extend API::Integracao::Autenticacao

  RESOURCE_NAME = "usuario"

  attr_accessor :id, :nome, :nome_usuario, :senha

  def self.login(credenciais={})
    autenticar(credenciais)
  end

  def self.pluralize_resource_name
    "usuarios"
  end
end