module API
  module Integracao
    module Autenticacao
      def autenticar(params)
        begin
          response = RestClient.post "#{API::Base::URL_BASE}/autenticacao", login: params[:nome_usuario],
                                                                senha: params[:senha]
          json = JSON.parse(response.body)

          self.new json["usuario"]
        rescue RestClient::Unauthorized
          usuario = self.new
          usuario.errors = ActiveModel::Errors.new(usuario)
          usuario.errors[:nome_usuario] << "Nome de usuário ou Senha inválido"
          usuario.errors[:senha] << "Nome de usuário ou Senha inválido"
          usuario
        rescue
          raise "Falha na comunicação com a API"
        end
      end
    end
  end
end