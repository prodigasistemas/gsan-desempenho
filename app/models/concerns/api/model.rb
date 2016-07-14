module API
  class Model
    include ActiveModel::Model
    extend ActiveModel::Naming
    include API::Base
    extend API::Integracao::Dados

    attr_reader :errors

    def initialize(attributes={})
      super
    end

    def read_attribute_for_validation(attr)
      send(attr)
    end

    def self.human_attribute_name(attr, options = {})
      attr
    end

    def self.lookup_ancestors
      [self]
    end
  end
end