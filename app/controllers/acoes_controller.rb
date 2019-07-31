class AcoesController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def index
    acoes = Acao.all

    acoes = Acao.filter(params[:filter]) if params[:filter].present?

    @acoes = smart_listing_create :acoes,
                                  acoes,
                                  partial: 'acoes/list',
                                  sort_attributes: [[:titulo, "acoes.titulo"]],
                                  default_sort: {titulo: "asc"}
  end

  def new
    @acao = Acao.new
    @contratos = ContratoMedicao.all
  end

  def create
    @acao = Acao.create(acao_params)

    if @acao.valid?
      redirect_to(acoes_path, notice: 'Ação cadastrado com sucesso')
    else
      @contratos = ContratoMedicao.all
      flash[:error] = "Não foi possível cadastrar a Ação"
      render :new
    end
  end

  def edit
    @acao = Acao.find(params[:id])
    @contratos = ContratoMedicao.all
  end

  def update
    @acao = Acao.find(params[:id])
    if @acao.update(acao_params)
      redirect_to(acoes_path, notice: 'Contrato atualizado com sucesso')
    end
  end

  def show
    @acao = Acao.find(params[:id])
  end

  private

  def acao_params
    params.require(:acao).permit(
      :id,
      :contrato_medicao_id,
      :titulo,
      :descricao
    ).to_h rescue {}
  end
end
