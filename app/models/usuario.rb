class Usuario < API::Model
  extend API::Integracao::Autenticacao

  attr_accessor :id, :nome, :nome_usuario, :senha

  def self.login(credenciais={})
    autenticar(credenciais)
  end
end