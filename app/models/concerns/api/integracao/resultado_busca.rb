module API
  module Integracao
    class ResultadoBusca
      def self.build(object)
        object = object.deep_symbolize_keys

        if object[:meta] && object[:meta].any? && meta = object[:meta]
          total    = meta[:total]
          page     = meta[:pagina]
          per_page = meta[:por_pagina]

          Kaminari.paginate_array(object[:entidades], total_count: total).page(page).per(per_page)
        else
          object[:entidades]
        end
      end
    end
  end
end