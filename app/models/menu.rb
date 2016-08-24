class Menu

  def self.get(usuario_id)
    response = RestClient.get("#{API::Base::URL_BASE}/menu/#{usuario_id}")

    JSON.parse(response.body)
  end
end