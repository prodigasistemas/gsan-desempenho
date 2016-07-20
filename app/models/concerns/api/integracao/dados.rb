module API
  module Integracao
    module Dados
      extend ActiveSupport::Concern
      include API::Integracao::Requisicao

      def self.included(base)
        base.extend(ClassMethods)
      end

      def save
        begin
          params = {}
          params[self.class.resource_name.singularize] = self.attributes
          json = post [], params
          self.class.new json["entidade"]
        rescue RestClient::UnprocessableEntity => e
          erro = API::Integracao::Requisicao::ExcecaoNaoConcluido.new(self.class, e)
          erro.entidade
        end
      end

      def update(params={})
        return unless self.id

        begin
          request_params = {}
          request_params[self.class.resource_name.singularize] = params
          json = put [self.id], request_params
          self.class.new json["entidade"]
        rescue RestClient::UnprocessableEntity => e
          erro = API::Integracao::Requisicao::ExcecaoNaoConcluido.new(self.class, e)
          erro.entidade
        rescue RestClient::ResourceNotFound => e
          false
        end
      end

      def destroy
        return unless self.id

        begin
          delete [self.id]
        rescue RestClient::UnprocessableEntity => e
          erro = API::Integracao::Requisicao::ExcecaoNaoConcluido.new(self.class, e)
          erro.entidade
        rescue RestClient::ResourceNotFound => e
          false
        end
      end

      module ClassMethods
        include API::Integracao::Requisicao

        def create(params={})
          begin
            request_params = {}
            request_params[self.resource_name.singularize] = params
            json = post [], request_params
            self.new json["entidade"]
          rescue RestClient::UnprocessableEntity => e
            erro = API::Integracao::Requisicao::ExcecaoNaoConcluido.new(self, e)
            erro.entidade
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

        def filter(terms = "", options = {})
          filters = {
            tipo: self.resource_name,
            filtros: {
              termo: terms,
              incluir: options.fetch(:includes, [])
            }
          }

          begin
            json = get([], filters)
            entidades = json["entidades"]
            entidades.map {|entidade| self.new entidade }
          rescue RestClient::BadRequest => e
            []
          end
        end
      end
    end
  end
end