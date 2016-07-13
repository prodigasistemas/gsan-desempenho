require 'rest-client'

module API
  module Base
    include API::Integracao::Autenticacao

    # remover daqui e passar como variável de ambiente
    URL_BASE = 'http://localhost:3001/'

    def request(key, params={})
      send(key, params)
    end
  end
end