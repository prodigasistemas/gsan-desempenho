module API
  module Integracao
    module Dados
      def find(id)
        begin
          resource = self.name.underscore.pluralize

          response = RestClient.get "#{API::Base::URL_BASE}/#{resource}/#{id}"

          json = JSON.parse(response.body)

          self.new json
        rescue RestClient::NotFound
          nil
        end
      end
    end
  end
end