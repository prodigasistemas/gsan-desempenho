class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def usuario_autenticado(usuario)
    return nil unless usuario.valid?
    session.clear
    session[:usuario_id] = usuario.id
  end

  def usuario_logado
    if session[:usuario_id]
       Usuario.find session[:usuario_id]
    else
      nil
    end
  end

  def acesso_restrito
    if session[:usuario_id]
      @usuario_logado = usuario_logado
    else
      redirect_to(new_session_path, alert: "Efetue seu login no GSAN")
    end
  end
end
