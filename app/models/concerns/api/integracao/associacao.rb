module API
  module Integracao
    module Associacao
      extend ActiveSupport::Concern

      module ClassMethods
        def has_many relations
          instance_eval do
            define_method("#{relations}") do
              return [] unless attrs = self.attributes[relations.to_s]

              attrs.map do |relation|
                relations.classify.constantize.new(relation)
              end
            end
          end
        end

        def belongs_to relation
          instance_eval do
            define_method("#{relation}") do
              return unless attrs = self.attributes[relation.to_s]

              relation.to_s.classify.constantize.new(attrs)
            end
          end
        end

        alias_method :has_one, :belongs_to
      end
    end
  end
end