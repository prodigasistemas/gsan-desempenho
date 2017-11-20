require 'rails_helper'

describe Usuario do

  let(:usuario_valido) {{ nome_usuario: 'admin', senha: '123456' }}
  let(:usuario_invalido) {{ nome_usuario: 'admin', senha: '12345678' }}

  it 'valid authentication' do
    retorno_api = { :"id" => "1", :"nome" => "Administrador", :"nome_usuario" => "admin", :"senha" => "123456" }
    expect(Usuario).to receive(:autenticar_usuario)
                       .with(usuario_valido)
                       .and_return(retorno_api)

    usuario = Usuario.login(usuario_valido)
    expect(usuario.valid?).to be true
    expect(usuario.nome).to eq retorno_api[:nome]
  end

  context 'invalid authentication' do
    before do
      expect(Usuario).to receive(:autenticar_usuario).at_least(:once).times
                         .with(usuario_invalido)
                         .and_raise(RestClient::Unauthorized)
    end

    it {
      expect(Usuario.login(usuario_invalido).valid?).to be false
    }

    it 'messages' do
      usuario = Usuario.login(usuario_invalido)
      expect(usuario.errors.messages).to_not be_empty
      expect(usuario.errors.messages[:nome_usuario].first).to eq "Nome de usuário ou Senha inválido"
      expect(usuario.errors.messages[:senha].first).to eq "Nome de usuário ou Senha inválido"
    end
  end
end
