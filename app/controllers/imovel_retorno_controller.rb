class ImovelRetornoController < ApplicationController
  def index
    @imoveis = []
    
    # @usuario_logado.empresas.each do |empresa|
    #   @imoveis.concat(empresa.imovel_retornos)
    # end
  end
end