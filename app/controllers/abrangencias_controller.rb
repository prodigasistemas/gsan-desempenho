class AbrangenciasController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def index
    @contrato_medicao = ContratoMedicao.find(params[:contrato_medicao_id])

    abrangencias = Abrangencia.all

    abrangencias = abrangencias.filter(params[:filter]) if params[:filter].present?
    @abrangencias = smart_listing_create :abrangencias,
                                  abrangencias,
                                  partial: 'abrangencias/list',
                                  sort_attributes: [[:numero, "abrangencias.numero"]],

                                   #                [:client_name, "clients.name"]],

                                  default_sort: {numero: "asc"}
  end

  def new
    @contrato_medicao = ContratoMedicao.find(params[:contrato_medicao_id])
    @abrangencia = Abrangencia.new
  end
end