module API
  module Integracao
    module Dados
      extend ActiveSupport::Concern
      include API::Integracao::Requisicao

      def self.included(base)
        base.extend(ClassMethods)
      end

      def update(params={})
        return unless self.id

        begin
          json = put [self.id], params
          self.class.new json["entidade"]
        rescue RestClient::UnprocessableEntity => e
          entidade = self.class.new
          entidade.errors = ActiveModel::Errors.new(entidade)
          entidade
        rescue RestClient::ResourceNotFound => e
          false
        end
      end

      def destroy
        return unless self.id

        begin
          delete [self.id]
        rescue RestClient::UnprocessableEntity => e
          entidade = self.class.new
          entidade.errors = ActiveModel::Errors.new(entidade)
          entidade
        rescue RestClient::ResourceNotFound => e
          false
        end
      end

      module ClassMethods
        include API::Integracao::Requisicao

        def create(params={})
          begin
            json = post [], params
            self.new json["entidade"]
          rescue RestClient::UnprocessableEntity => e
            entidade = self.new
            entidade.errors = ActiveModel::Errors.new(entidade)
            entidade
          end
        end

        def all
          begin
            json = get
            entidades = json["entidades"]
            entidades.map {|entidade| self.new entidade }
          rescue RestClient::ResourceNotFound
            []
          end
        end

        def find(id)
          begin
            json = get([id])
            self.new json["entidade"]
          rescue RestClient::ResourceNotFound
            nil
          end
        end
      end
    end
  end
end