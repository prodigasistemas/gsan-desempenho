class MedicaoPerformancesController < ApplicationController
  def new
    @historico = @historico = HistoricoArquivoRetorno.filtrar_por(
                    :medicao_performance_relatorios,
                    @usuario_logado.historico_arquivo_retornos).sort!{ |a,b| b.id <=> a.id }

    @medicao_performance = MedicaoPerformance.new

    @contratos = ContratoMedicao.all

    @filtro = FiltroMedicaoPerformancesPresenter.new(params)
  end
end