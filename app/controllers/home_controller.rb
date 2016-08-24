class HomeController < ApplicationController
  layout 'application'

  def index
    @menu = Menu.get(@usuario_logado.id).deep_symbolize_keys!
    @linhas = @menu[:menu][:submenu].size / 4
    @index = 3
    @inicio = 0
    @tamanho = 4
    # binding.pry
  end
end