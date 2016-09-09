class ImovelRetornoController < ApplicationController
  def index
    @imoveis = []
    
    @empresas = Empresa.all
  end
end