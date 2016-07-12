require 'rest-client'

class ApiRestClient

  # tornar a url variavel de ambiente
  URL_BASE = 'http://localhost:3001/'

  def request(key, params={})
    send(key, params)
  end

  private

  def autenticacao(params)
    begin
      response = RestClient.post "#{URL_BASE}/autenticacao", login: params[:nome_usuario],
                                                            senha: params[:senha]
      JSON.parse(response.body)
    rescue
      nil
    end
  end
end