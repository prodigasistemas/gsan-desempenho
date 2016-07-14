require 'rails_helper'

describe Usuario do

  let(:usuario_valido) {{ nome_usuario: 'admin', senha: '123456' }}
  let(:usuario_invalido) {{ nome_usuario: 'admin', senha: '12345678' }}

  it 'valid authentication' do
    retorno_api = {"id": 1, "nome": "Administrador", "nome_usuario": "admin", "senha": "123456"}

    expect_any_instance_of(Usuario).to receive(:request)
                                             .with(:autenticacao, usuario_valido)
                                             .and_return(retorno_api)
    usuario = Usuario.new usuario_valido
    expect(usuario.login).to be true
    expect(usuario.nome).to eq retorno_api["nome"]
  end

  context 'invalid authentication' do
    let(:usuario) { Usuario.new usuario_invalido }

    before do
      expect_any_instance_of(Usuario).to receive(:request).at_least(:once).times
                                             .with(:autenticacao, usuario_invalido)
                                             .and_return(nil)
    end

    it {
      expect(usuario.login).to be false
    }

    it 'messages' do
      usuario.login
      expect(usuario.errors.messages).to_not be_empty
      expect(usuario.errors.messages[:nome_usuario].first).to eq "Nome de usuário ou Senha inválido"
      expect(usuario.errors.messages[:senha].first).to eq "Nome de usuário ou Senha inválido"
    end

    it 'exception message' do
      expect {usuario.login!(nil)}.to raise_error("Autenticação Inválida")
    end
  end
end