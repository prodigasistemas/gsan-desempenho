module API
  module Integracao
    module Requisicao
      def get(path=[], params = {})
        if params.any?
          response = RestClient.get filter_url + params.to_query
        else
          response = RestClient.get build_url(path)
        end

        JSON.parse(response.body)
      end

      def get_relations(path=[], params = {})
        response = RestClient.get relations_url + params.to_query
        JSON.parse(response.body)
      end

      def get_with_params(path=[], params = {})
        query = { query: params }
        response = RestClient.get build_url(path) + "?" + query.to_query

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
        resource = self.resource_name
        url_base = "#{API::Base::URL_BASE}/#{resource}"

        path.each { |item| url_base.concat "/#{item}" }

        url_base
      end

      def filter_url
        "#{API::Base::URL_BASE}/filtros?"
      end

      def relations_url
        "#{API::Base::URL_BASE}/associacoes?"
      end

      class ExcecaoNaoConcluido < StandardError
        def initialize(klass, error)
          @klass = klass
          @error = error
        end

        def message
          @error.message
        end

        def entidade
          entidade = @klass.new

          entidade.errors = ActiveModel::Errors.new(entidade)
          errors = JSON.parse(@error.response)
          errors["errors"].each do |key, messages|
            messages.each { |message| entidade.errors[key] << message }
          end

          entidade
        end

      end
    end
  end
end