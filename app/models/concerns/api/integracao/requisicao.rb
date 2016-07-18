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
        resource = self.resource_name
        url_base = "#{API::Base::URL_BASE}/#{resource}"

        path.each { |item| url_base.concat "/#{item}" }

        url_base
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