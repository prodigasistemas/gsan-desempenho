class SessionsController < ApplicationController
  layout 'home'

  def new
    @usuario = Usuario.new
  end

  def create
    @usuario = Usuario.new usuario_params

    if @usuario.login
      usuario_autenticado(@usuario)
      redirect_to(root_path, notice: 'Bem vindo!')
    else
      flash[:alert] = "Login ou senha inválidos"
      render :new
    end
  end

  protected

  def usuario_params
    params.require(:usuario).permit(:nome_usuario, :senha)
  end
end
