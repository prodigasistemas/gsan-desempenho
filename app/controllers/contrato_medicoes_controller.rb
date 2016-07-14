class ContratoMedicoesController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def index
    contratos = [ContratoMedicao.new(id:"1", numero: "123", vigencia_inicial:"12/07/2016")]

    contratos = contratos.filter(params[:filter]) if params[:filter].present?
    @contratos = smart_listing_create :contrato_medicoes,
                                  contratos,
                                  partial: 'contrato_medicoes/list',
                                  sort_attributes: [[:numero_contrato, "contratos.numero_contrato"]],
                                   #                [:client_name, "clients.name"]],


                                  default_sort: {numero_contrato: "asc"}
  end

  def new
    @contrato_medicao = ContratoMedicao.new
    @empresas = [Empresa.new(id: 1, nome: "Apple")]
  end

  def edit
    @contrato_medicao = ContratoMedicao.find(params[:id])
    @empresas = [Empresa.new(id: 1, nome: "Apple")]
  end

  def show
    @contrato = ContratoMedicao.find(params[:id])
  end

  def destroy
  end
end
