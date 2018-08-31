class ImagensController < ApplicationController
  def index
    path = "/opt/remote/recadastramento#{params[:caminho]}"

    if File.exist?(path)
      send_file(path, :disposition => 'inline', :type => 'image/jpeg', :x_sendfile => true )
    else
      render plain: "Imagem não encontrada no servidor!", status: :not_found
    end
  end
end
