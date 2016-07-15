module API
  module Integracao
    module Dados
      def create(params={})
        begin
          resource_params = {}
          resource_params[self::RESOURCE_NAME] = params
          json = post_request [], resource_params
          self.new json["entidade"]
        rescue RestClient::UnprocessableEntity => e
          entidade = self.new
          entidade.errors = ActiveModel::Errors.new(entidade)
          entidade
        end
      end

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

      def post_request(path=[], params={})
        response = RestClient.post build_url(path), params
        JSON.parse(response.body)
      end

      private

      def build_url(path)
        resource = self.pluralize_resource_name || self::RESOURCE_NAME
        url_base = "#{API::Base::URL_BASE}/#{resource}"

        path.each { |item| url_base.concat "/#{item}" }

        url_base
      end
    end
  end
end