class ImovelRetornoController < ApplicationController
  def index
    @imoveis = []
    
    if @usuario_logado.admin
      @empresas = Empresa.all
    else
      @empresas = Empresa.do_usuario(@usuario_logado.id)
    end
  end
end