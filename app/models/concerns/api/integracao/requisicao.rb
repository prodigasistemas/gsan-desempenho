module API
  module Integracao
    module Requisicao
      def get(path=[])
        response = RestClient.get build_url(path)
        JSON.parse(response.body)
      end

      def post(path=[], params={})
        response = RestClient.post build_url(path), params
        JSON.parse(response.body)
      end

      def put(path=[], params={})
        response = RestClient.put build_url(path), params
        JSON.parse(response.body)
      end

      def delete(path=[])
        response = RestClient.delete build_url(path)
        JSON.parse(response.body)
      end

      def build_url(path)
        klass = self.is_a?(Class) ? self : self.class

        resource = klass.resource_name
        url_base = "#{API::Base::URL_BASE}/#{resource}"

        path.each { |item| url_base.concat "/#{item}" }

        url_base
      end
    end
  end
end