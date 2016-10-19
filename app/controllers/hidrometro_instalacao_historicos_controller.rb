class HidrometroInstalacaoHistoricosController < ApplicationController
  def new
    @filtro = FiltroImovelPresenter.new(params)
    @historico = HistoricoArquivoRetorno.filtrar_por(
                    :hidrometro_historico,
                    @usuario_logado.historico_arquivo_retornos).sort!{ |a,b| b.id <=> a.id }
  end
end