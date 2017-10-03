class ContasController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  skip_before_action :acesso_restrito
  before_action :find_matricula

  def index
    redirect_to segunda_via_index_path if @matricula.blank?
    contas = Conta.all
    contas << Conta.new({data_conta: "08/2017", valor: "120,00"})
    contas << Conta.new({data_conta: "09/2017", valor: "120,00"})
    contas << Conta.new({data_conta: "10/2017", valor: "133,00"})
    @contas = smart_listing_create :contas, contas, partial: 'list',
                                    sort_attributes: [[:data_conta, "conta.data_conta"]],
                                    default_sort: { data_conta: "asc" }
  end

  private

  def find_matricula
    @matricula = params[:matricula]
  end
end
