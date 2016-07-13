class Usuario < API::Model
  attr_accessor :id, :nome, :nome_usuario, :senha

  def login
    usuario = autenticar

    begin
      login!(usuario)
      true
    rescue
      false
    end
  end

  def login!(params={})
    if params.nil? and autenticar.nil?
      @errors[:nome_usuario] << "Nome de usuário ou Senha inválido"
      @errors[:senha] << "Nome de usuário ou Senha inválido"

      raise "Autenticação Inválida"
    else
      @id = params[:id]
      @nome = params[:nome]
    end
  end

  private

  def autenticar
    request(:autenticacao, nome_usuario: nome_usuario, senha: senha)
  end
end