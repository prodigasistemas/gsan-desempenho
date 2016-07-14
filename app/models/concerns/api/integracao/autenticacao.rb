module API
  module Integracao
    module Autenticacao
      def autenticacao(params)
        begin
          response = RestClient.post "#{API::Base::URL_BASE}/autenticacao", login: params[:nome_usuario],
                                                                senha: params[:senha]
          json = JSON.parse(response.body)

          json["usuario"]
        rescue RestClient::Unauthorized
          nil
        else
          raise "Falha na comunicação com a API"
        end
      end
    end
  end
end