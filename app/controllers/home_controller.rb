class HomeController < ApplicationController
  before_action :resticted_access

  def index
  end

  protected

  def resticted_access
    redirect_to(new_session_path, alert: "Efetue seu login no GSAN")
  end
end