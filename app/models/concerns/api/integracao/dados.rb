module API
  module Integracao
    module Dados
      def find(id)
        begin
          resource = self.name.downcase.pluralize
          response = RestClient.get "#{API::Base::URL_BASE}/#{resource}/#{id}"
          json = JSON.parse(response.body)

          self.new json["usuario"]
        rescue RestClient::NotFound
          nil
        else
          raise "Falha na comunicação com a API"
        end
      end
    end
  end
end