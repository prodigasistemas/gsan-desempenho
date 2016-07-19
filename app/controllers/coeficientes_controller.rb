class CoeficientesController < ApplicationController
  def show
    @coeficiente = Coeficiente.find params[:id]
    @contrato_medicao = ContratoMedicao.find params[:contrato_medicao_id]
  end

  def new
    @contrato_medicao = ContratoMedicao.find params[:contrato_medicao_id]
    @ligacoes_agua = LigacaoAguaSituacao.all
    @coeficiente = Coeficiente.new
  end

  def edit
    @contrato_medicao = ContratoMedicao.find params[:contrato_medicao_id]
    @ligacoes_agua = LigacaoAguaSituacao.all
    @coeficiente = Coeficiente.find params[:id]
  end

  def create
    coeficiente = Coeficiente.new coeficiente_params.merge(contrato_medicao_id: params[:contrato_medicao_id])
    @contrato = ContratoMedicao.find params[:contrato_medicao_id]
    @coeficiente = coeficiente.save

    if @coeficiente.valid?
      # alterar o retorno da url
      redirect_to contrato_medicao_path(@contrato.id), notice: "Coeficiente cadastrado com sucesso"
    else
      flash[:error] = "Erro ao cadastrar coeficiente"
      render :new
    end
  end

  def update
    coeficiente = Coeficiente.find params[:id]
    coeficiente = coeficiente.update coeficiente_params.merge(contrato_medicao_id: params[:contrato_medicao_id])
    if coeficiente.valid?
      redirect_to contrato_medicoes_path, notice: "Coeficiente atualizado com sucesso"
    else
      flash[:error] = "Erro ao atualizar coeficiente"
      render :edit
    end
  end

  def destroy
    coeficiente = Coeficiente.find(params[:id])
    @contrato = ContratoMedicao.find params[:contrato_medicao_id]

    coeficiente.destroy

    redirect_to contrato_medicao_path(@contrato.id), notice: "Coeficiente removido com sucesso"
  end

  protected

  def coeficiente_params
    params.require(:coeficiente).permit(:ligacao_agua_id, :coeficiente)
  end
end