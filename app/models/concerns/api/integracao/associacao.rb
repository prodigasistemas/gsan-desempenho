module API
  module Integracao
    module Associacao
      extend ActiveSupport::Concern

      module ClassMethods
        def has_many relations, options = {}
          instance_eval do
            define_method("#{relations}") do
              attrs = self.attributes[relations.to_s]
              attrs = fetch_lazy(relations) if attrs.blank?

              return [] if attrs.blank?

              attrs.map! do |relation|
                relations.to_s.classify.constantize.new(relation)
              end

              if sort_field = options[:order]
                attrs = attrs.sort_by{ |r| r.send(sort_field) }
              end

              attrs
            end
          end
        end

        def belongs_to relation
          instance_eval do
            define_method("#{relation}") do
              attrs = self.attributes[relation.to_s]
              attrs = fetch_lazy(relation) if attrs.blank?

              return if attrs.blank?

              relation.to_s.classify.constantize.new(attrs)
            end
          end
        end

        alias_method :has_one, :belongs_to
      end
    end
  end
end