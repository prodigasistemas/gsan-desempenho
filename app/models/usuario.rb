class Usuario < ClienteAPI::Model
  extend ClienteAPI::Integracao::Autenticacao

  attr_accessor :id, :nome, :nome_usuario, :senha, :empresa_id, :admin

  has_many :empresas
  has_many :historico_arquivo_retornos

  def self.login(credenciais={})
    autenticar(credenciais)
  end
end
