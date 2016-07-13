class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def usuario_autenticado(usuario)
    session.clear
    session[:usuario] = usuario.id
  end

  def usuario_logado
    if session[:usuario_id]
       Usuario.find { |u| u.id == session[:usuario_id] }
    else
      nil
    end
  end
end
