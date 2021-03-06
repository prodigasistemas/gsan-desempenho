class AbrangenciasController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def index
    @contrato_medicao = ContratoMedicao.find(params[:contrato_medicao_id])
    @abrangencias = @contrato_medicao.abrangencias(page: params[:page] || 1)
  end

  def new
    @contrato_medicao = ContratoMedicao.find(params[:contrato_medicao_id])
    @abrangencia = Abrangencia.new
    @filtro = FiltroImovelPresenter.new(params)

    if params[:query].present?
      query = (params[:query].permit! || {}).merge(page: params[:page])

      @imoveis = Imovel.where(query)
    end
  end

  def create
    abrangencia = Abrangencia.new(contrato_medicao_id: params[:contrato_medicao_id])
    imoveis = Imovel.where(params[:query])

    @contrato_medicao = abrangencia.definir_abrangencia({ imoveis: imoveis.collect(&:id) })

    if @contrato_medicao.valid?
      render json: { notice: "Abrangência criada com sucesso!" }, status: :ok
    else
      render json: { errors: @contrato_medicao.errors }, status: :unprocessable_entity
    end
  end

  def redefinir
    abrangencia = Abrangencia.new(contrato_medicao_id: params[:contrato_medicao_id])
    @contrato_medicao = abrangencia.redefinir_abrangencia
    if @contrato_medicao.valid?
      redirect_to contrato_medicao_path(@contrato_medicao.id), notice: "Todos os imóveis foram removidos!"
    else
      redirect_to contrato_medicao_abrangencias_path(@contrato_medicao.id), notice: "Não foi possível remover os imóveis!"
    end
  end

  def destroy
    @contrato_medicao = ContratoMedicao.find params[:contrato_medicao_id]
    abrangencia = Abrangencia.where(imovel_id: params[:imovel_id], contrato_medicao_id: @contrato_medicao.id).first

    if abrangencia.destroy
      redirect_to contrato_medicao_abrangencias_path(@contrato_medicao.id), notice: "Imóvel foi removido da abrangência com sucesso"
    else
      flash[:error] = "Não foi possível remover o imóvel da abrangência"
      render :index
    end
  end

  private

  def abrangencia_params
    params.require(:abrangencia).permit(imoveis: []).to_h rescue {}
  end
end