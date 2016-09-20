class ImovelRetornoController < ApplicationController
  def index
    @historico = @historico = HistoricoArquivoRetorno.filtrar_por(
                    :imovel_retorno,
                    @usuario_logado.historico_arquivo_retornos).sort!{ |a,b| b.id <=> a.id }

    if @usuario_logado.admin
      @empresas = Empresa.all
    else
      @empresas = Empresa.do_usuario(@usuario_logado.id)
    end
  end
end