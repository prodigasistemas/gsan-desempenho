module API
  class Model
    include ActiveModel::Model
    extend ActiveModel::Naming
    include API::Base
    include API::Integracao::Dados

    attr_accessor :errors

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

    def valid?
      return true if errors.nil?
      false
    end

    def attributes
      self.as_json.except("id")
    end

    def resource_name
      self.class.name.underscore.downcase
    end
  end
end