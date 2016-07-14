class SessionsController < ApplicationController
  skip_before_action :acesso_restrito, only: [:new, :create]

  layout 'home'

  def new
    @usuario = Usuario.new
  end

  def create
    @usuario = Usuario.login usuario_params

    if usuario_autenticado(@usuario)
      redirect_to(root_path, notice: 'Bem vindo!')
    else
      flash[:alert] = "Login ou senha inválidos"
      render :new
    end
  end

  def destroy
    limpar_sessao

    redirect_to(new_session_path, notice: "Logout efetuado com sucesso!")
  end

  protected

  def usuario_params
    params.require(:usuario).permit(:nome_usuario, :senha)
  end
end
