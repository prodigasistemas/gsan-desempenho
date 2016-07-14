module API
  module Integracao
    module Autenticacao
      def autenticar(params)
        begin
          self.new autenticar_usuario(params)
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

      def autenticar_usuario(params)
        response = RestClient.post "#{API::Base::URL_BASE}/autenticacao", login: params[:nome_usuario],
                                                                senha: params[:senha]
        json = JSON.parse(response.body)

        json["usuario"]
      end
    end
  end
end