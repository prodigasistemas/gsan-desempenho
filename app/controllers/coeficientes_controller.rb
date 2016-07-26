class CoeficientesController < ApplicationController
  def show
    @coeficiente = Coeficiente.find params[:id]

    @contrato_medicao = ContratoMedicao.find params[:contrato_medicao_id]
  end

  def new
    @coeficientes = []
    @contrato_medicao = ContratoMedicao.find params[:contrato_medicao_id]
    @ligacoes_agua = LigacaoAguaSituacao.all

    redirect_to contrato_medicao_coeficientes_path(@contrato_medicao.id) and return if @contrato_medicao.coeficientes.any?

    @ligacoes_agua.sort_by(&:id).each do |ligacao_agua|
      @coeficientes << Coeficiente.new(ligacao_agua_situacao: ligacao_agua, ligacao_agua_id: ligacao_agua.id)
    end
  end

  def edit
    @contrato_medicao = ContratoMedicao.find params[:contrato_medicao_id]
    @coeficientes = @contrato_medicao.coeficientes.sort_by(&:ligacao_agua_id)

    redirect_to new_contrato_medicao_coeficiente_path(@contrato_medicao.id) and return if @coeficientes.empty?
  end

  def create
    @contrato_medicao = ContratoMedicao.find params[:contrato_medicao_id]
    coeficiente = Coeficiente.new(contrato_medicao_id: params[:contrato_medicao_id])

    if coeficiente.save(coeficientes: coeficiente_params)
      redirect_to contrato_medicao_path(@contrato_medicao.id), notice: "Coeficiente cadastrado com sucesso"
    else
      @coeficientes = []

      coeficiente_params.each do |p|
        @coeficientes << Coeficiente.new(p)
      end

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
      @coeficientes = @contrato_medicao.coeficientes.sort_by(&:ligacao_agua_id)

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