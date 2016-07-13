class ContratosController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def index
    contratos = [Contrato.new(id:"1", numero: "123", vigencia_inicial:"12/07/2016")]

    contratos = contratos.filter(params[:filter]) if params[:filter].present?
    @contratos = smart_listing_create :contratos,
                                  contratos,
                                  partial: 'contratos/list',
                                  sort_attributes: [[:numero_contrato, "contratos.numero_contrato"]],
                                   #                [:client_name, "clients.name"]],


                                  default_sort: {numero_contrato: "asc"}
  end

  def new
    @contrato = Contrato.new
    @empresas = [Empresa.new(id: 1, nome: "Apple")]
  end
end
