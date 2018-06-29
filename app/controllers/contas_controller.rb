class ContasController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  include ApplicationHelper

  skip_before_action :acesso_restrito
  before_action :find_matricula, :find_imovel

  def index
    if @matricula.blank?
      redirect_to segunda_via_path, notice: "Insira uma matricula"
    elsif @imovel.nil?
      redirect_to segunda_via_path, alert: "Matricula '#{@matricula}' não encontrada"
    else
      ids_gsan = obter_ids_contas_gsan(@matricula)
      contas = @imovel.contas
      contas = Conta.filtrar_contas(contas, ids_gsan)
      @nome = contas.last.try(:nome_cliente)
      @contas = smart_listing_create :contas, contas, partial: 'list',
                                      sort_attributes: [[:data_conta, "conta.data_conta"]],
                                      default_sort: { data_conta: "asc" }
    end
  end

  private

  def find_matricula
    @matricula = params[:matricula]
  end

  def find_imovel
    begin
      @imovel = Imovel.imovel_nao_excluido(Imovel.where(id: @matricula, page: 1, per_page: 10)).first if @matricula.present?
    rescue Exception => e
      @imovel = nil
      flash[:error] = "Erro interno. Tente novamente mais tarde"
      redirect_to segunda_via_path
    end
  end
end
