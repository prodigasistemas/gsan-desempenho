class ApplicationController < ActionController::Base
  include LinksHelper

  before_action :acesso_restrito

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def usuario_logado
    if token = cookies[:gsan]
      id, expiracao = verifier.verify(token)

      if Time.zone.now < expiracao
        Usuario.find(id)
      end
    else
      nil
    end
  end

  def acesso_restrito
    if cookies[:gsan]
      @usuario_logado = usuario_logado
      return @usuario_logado unless @usuario_logado.nil?
    end
    session.clear

    redirect_to(login_url)
  end

  private

  def verifier
    @verifier ||= ActiveSupport::MessageVerifier.new('gsan', serializer: YAML)
  end
end
