class Usuario < API::Model
  extend API::Integracao::Autenticacao

  attr_accessor :id, :nome, :nome_usuario, :senha, :empresa_id, :admin

  has_many :empresas

  def self.login(credenciais={})
    autenticar(credenciais)
  end
end