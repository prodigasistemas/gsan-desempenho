require 'rails_helper'

describe Usuario do

  let(:usuario_valido) {{ nome_usuario: 'usuario1', senha: '123456' }}
  let(:usuario_invalido) {{ nome_usuario: 'usuario1', senha: '12345678' }}

  it 'valid authentication' do
    expect_any_instance_of(ApiRestClient).to receive(:request)
                                             .with(:autenticacao, usuario_valido)
                                             .and_return({message: "Autenticacao realizada com sucesso!"})
    usuario = Usuario.new usuario_valido
    expect(usuario.login).to be true
  end

  context 'invalid authentication' do
    let(:usuario) { Usuario.new usuario_invalido }

    it {
      expect_any_instance_of(ApiRestClient).to receive(:request)
                                             .with(:autenticacao, usuario_invalido)
                                             .and_return(nil)
      expect(usuario.login).to be false
    }

    it 'messages' do
      expect_any_instance_of(ApiRestClient).to receive(:request)
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