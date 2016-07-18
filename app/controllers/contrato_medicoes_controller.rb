class ContratoMedicoesController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def index
    contratos = ContratoMedicao.all

    contratos = contratos.filter(params[:filter]) if params[:filter].present?
    @contratos = smart_listing_create :contrato_medicoes,
                                  contratos,
                                  partial: 'contrato_medicoes/list',
                                  sort_attributes: [[:numero, "contratos.numero"]],

                                   #                [:client_name, "clients.name"]],

                                  default_sort: {numero: "asc"}
  end

  def new
    @contrato_medicao = ContratoMedicao.new
    @empresas = Empresa.all
  end

  def create
    @contrato_medicao = ContratoMedicao.create(params)

    if @contrato_medicao.valid?
      redirect_to(contrato_medicoes_path, notice: 'Contrato cadastrado com sucesso')
    else
      @empresas = Empresa.all
      render :new
    end
  end

  def edit
    @contrato_medicao = ContratoMedicao.find(params[:id])
    @empresas = Empresa.all
  end

  def update
    @contrato_medicao = ContratoMedicao.find(params[:id])
    if @contrato_medicao.update(params)
      redirect_to(contrato_medicoes_path, notice: 'Contrato atualizado com sucesso')
    end
  end

  def show
    @contrato = ContratoMedicao.find(params[:id])
  end

  def destroy
    @contrato_medicao = ContratoMedicao.find(params[:id])

    if @contrato_medicao.destroy
      redirect_to contrato_medicoes_path, notice: 'Contrato destivado com sucesso'
    else
      redirect_to contrato_medicao_path(@contrato_medicao.id), notice: 'Não foi possível remover o contrato'
    end
  end

  private

  def contrato_medicao_params
    params.require(:contrato_medicao).permit(
      :id,
      :numero,
      :vigencia_inicial,
      :vigencia_final, :data_assinatura,
      :empresa_id,
      :atualizado_em
    )
  end
end
