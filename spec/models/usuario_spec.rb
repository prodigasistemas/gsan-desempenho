require 'rails_helper'

describe Usuario do

  let(:usuario_valido) {{ nome_usuario: 'admin', senha: '123456' }}
  let(:usuario_invalido) {{ nome_usuario: 'admin', senha: '12345678' }}

  it 'valid authentication' do
    retorno_api = {id: 1, nome: "Administrador", nome_usuario: "admin", senha: "123456"}

    expect_any_instance_of(Usuario).to receive(:request)
                                             .with(:autenticacao, usuario_valido)
                                             .and_return(retorno_api)
    usuario = Usuario.new usuario_valido
    expect(usuario.login).to be true
    expect(usuario.nome).to eq retorno_api[:nome]
  end

  context 'invalid authentication' do
    let(:usuario) { Usuario.new usuario_invalido }

    it {
      expect_any_instance_of(Usuario).to receive(:request).twice
                                             .with(:autenticacao, usuario_invalido)
                                             .and_return(nil)
      expect(usuario.login).to be false
    }

    it 'messages' do
      expect_any_instance_of(Usuario).to receive(:request).twice
                                             .with(:autenticacao, usuario_invalido)
                                             .and_return(nil)
      usuario.login
      expect(usuario.errors.messages).to_not be_empty
    end

    it 'exception message' do
      expect {usuario.login!(nil)}.to raise_error("Autenticação Inválida")
    end
  end
end