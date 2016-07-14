class HomeController < ApplicationController
  before_action :acesso_restrito

  def index
  end
end