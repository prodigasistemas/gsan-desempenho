class CoeficientesController < ApplicationController
  def show
    @coeficiente = Coeficiente.find params[:id]
    @contrato_medicao = @coeficiente.contrato_medicao
  end

  def new
    @contrato_medicao = ContratoMedicao.find params[:contrato_medicao_id]
    @ligacoes_agua = LigacaoAguaSituacao.sorted

    redirect_to contrato_medicao_coeficientes_path(@contrato_medicao.id) and return if @contrato_medicao.coeficientes.any?

    @coeficientes = ContratoMedicao.iniciar_coeficientes(@ligacoes_agua)
  end

  def edit
    @contrato_medicao = ContratoMedicao.find params[:contrato_medicao_id]
    @coeficientes = @contrato_medicao.coeficientes

    redirect_to new_contrato_medicao_coeficiente_path(@contrato_medicao.id) and return if @coeficientes.empty?
  end

  def create
    @contrato_medicao = ContratoMedicao.find params[:contrato_medicao_id]

    if Coeficiente.create(coeficientes: coeficiente_params)
      redirect_to contrato_medicao_path(@contrato_medicao.id), notice: "Coeficiente cadastrado com sucesso"
    else
      @coeficientes = coeficiente_params.map{ |coeficiente| Coeficiente.new(coeficiente) }

      flash[:error] = "Não foi possível cadastrar o Coeficiente"
      render :new
    end
  end

  def update
    @contrato_medicao = ContratoMedicao.find params[:contrato_medicao_id]

    coeficiente_params.each do |coeficiente|
      @coeficiente = Coeficiente.find coeficiente[:id]
      @coeficiente = @coeficiente.update coeficiente

      break unless @coeficiente.valid?
    end

    if @coeficiente.valid?
      redirect_to contrato_medicao_path(@contrato_medicao.id), notice: "Coeficiente atualizado com sucesso"
    else
      @coeficientes = @contrato_medicao.coeficientes

      flash[:error] = "Erro ao atualizar coeficiente #{@coeficiente.id}"
      render :edit
    end
  end

  protected

  def coeficiente_params
    params.require(:coeficiente).map do |hash|
      hash.merge!(contrato_medicao_id: params[:contrato_medicao_id], usuario_id: @usuario_logado.id)
      ActionController::Parameters.new(hash).permit(:id, :contrato_medicao_id, :ligacao_agua_id, :coeficiente, :usuario_id)
    end
  end
end