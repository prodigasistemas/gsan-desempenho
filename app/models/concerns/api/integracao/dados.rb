module API
  module Integracao
    module Dados
      def all
        begin
          json = get_request
          entidades = json["entidades"]
          entidades.map {|entidade| self.new entidade }
        rescue RestClient::ResourceNotFound
          []
        end
      end

      def find(id)
        begin
          json = get_request([id])
          self.new json["entidade"]
        rescue RestClient::ResourceNotFound
          nil
        end
      end

      def get_request(path=[])
        response = RestClient.get build_url(path)
        JSON.parse(response.body)
      end

      private

      def build_url(path)
        resource = self.name.downcase.pluralize
        url_base = "#{API::Base::URL_BASE}/#{resource}"

        path.each { |item| url_base.concat "/#{item}" }

        url_base
      end
    end
  end
end