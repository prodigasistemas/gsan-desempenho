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
    abrangencia.criar(abrangencia_params)

    redirect_to abrangencias_path, notice: "Abrangência criada com sucesso!"
  end

  private

  def abrangencia_params
    params.require(:abrangencia).permit(imoveis: [])
  end
end