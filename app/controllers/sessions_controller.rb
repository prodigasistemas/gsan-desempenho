
class SessionsController < ApplicationController
  layout 'home'

  def new
    @user = {username:"user@mail.com", password:"123"}
  end

  def create
    @user = login(params[:username], params[:password])

    if @user
      redirect_to(root_path, notice: 'Bem vindo!')
    else
      flash[:alert] = "Login ou senha inválidos"
      render :new
    end
  end
end
