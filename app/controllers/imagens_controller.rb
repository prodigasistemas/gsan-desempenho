class ImagensController < ApplicationController
  def index
    path = "/opt/remote/recadastramento#{params[:caminho]}"

    send_file(path, :disposition => 'inline', :type => 'image/jpeg', :x_sendfile => true )
  end
end
