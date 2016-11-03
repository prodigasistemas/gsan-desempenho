class MedicaoPerformancesController < ApplicationController
  
  def new
    @medicao_performance = MedicaoPerformance.new

    @contratos = ContratoMedicao.all
    
    @filtro = FiltroMedicaoPerformancesPresenter.new(params)
  end
end