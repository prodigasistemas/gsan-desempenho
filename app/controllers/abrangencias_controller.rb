class AbrangenciasController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def index
    @contrato_medicao = ContratoMedicao.find(params[:contrato_medicao_id])

    imoveis = @contrato_medicao.imoveis

    imoveis = imoveis.filter(params[:filter]) if params[:filter].present?
    @imoveis = smart_listing_create :imoveis,
                                  imoveis,
                                  partial: 'abrangencias/list',
                                  sort_attributes: [[:numero, "imoveis.numero"]],

                                   #                [:client_name, "clients.name"]],

                                  default_sort: {numero: "asc"}
  end

  def new
    @contrato_medicao = ContratoMedicao.find(params[:contrato_medicao_id])
    @abrangencia = Abrangencia.new

    if params[:query].present?
      @imoveis = Imovel.where(params[:query])
    end
  end

  def create
    abrangencia = Abrangencia.new(contrato_medicao_id: params[:contrato_medicao_id])
    @contrato_medicao = abrangencia.definir_abrangencia(abrangencia_params)
    if @contrato_medicao.valid?
      redirect_to contrato_medicao_abrangencias_path(@contrato_medicao.id), notice: "Abrangência criada com sucesso!"
    else
      render :new
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

  private

  def abrangencia_params
    params.require(:abrangencia).permit(imoveis: [])
  end
end