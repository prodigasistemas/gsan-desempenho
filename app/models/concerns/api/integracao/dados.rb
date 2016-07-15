module API
  module Integracao
    module Dados
      extend ActiveSupport::Concern
      include API::Integracao::Requisicao

      module ClassMethods
        include API::Integracao::Requisicao

        def create(params={})
          begin
            resource_params = {}
            resource_params[self.name.underscore.downcase] = params
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
      end

      def update(params={})
        return unless self.id

        begin
          resource_params = {}
          resource_params[self.name.underscore.downcase] = self.attributes
          json = put_request [self.id], resource_params
          self.new json["entidade"]
        rescue RestClient::UnprocessableEntity => e
          entidade = self.new
          entidade.errors = ActiveModel::Errors.new(entidade)
          entidade
        rescue RestClient::ResourceNotFound => e
          false
        end
      end

      def destroy
        return unless self.id

        begin
          delete_request [self.id]
        rescue RestClient::UnprocessableEntity => e
          entidade = self.new
          entidade.errors = ActiveModel::Errors.new(entidade)
          entidade
        rescue RestClient::ResourceNotFound => e
          false
        end
      end
    end
  end
end