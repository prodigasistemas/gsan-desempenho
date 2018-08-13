class RecadastramentosController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :find_empresas, :find_leituristas, :find_cadastro_ocorrencias, only: [:index]
  before_action :find_coluna_atualizacao_cadastrais, :find_imovel, only: [:show]
  before_action :find_imovel_controle_atualizacao_cadastral, only: [:show, :update]

  def index
    atualizacao_cadastrais = []
    @filtro = FiltroRecadastramento.new(params)
    if params[:query].present?
      unless flash[:error].nil?
        redirect_to recadastramentos_path
        return
      end
      atualizacao_cadastrais = AtualizacaoCadastral.where(params[:query])
    end
    @atualizacao_cadastrais = smart_listing_create :atualizacao_cadastrais,
                                                   atualizacao_cadastrais,
                                                   partial: 'list',
                                                   page_sizes: [25, 50]
  end

  def show
    @campos = smart_listing_create :campos,
                                   @coluna_atualizacao_cadastrais,
                                   partial: 'campos_list',
                                   page_sizes: [100]
  end

  def update
    @imovel_controle_atualizacao_cadastral = @imovel_controle_atualizacao_cadastral.update({ situacao_atualizacao_cadastral_id: params[:situacao] })
    if params[:situacao] == "7"
      msgm = "Imóvel Pré-avaliado com sucesso"
    else
      msgm = "Imóvel enviado para Revisão"
    end
    redirect_to recadastramento_path(@imovel_controle_atualizacao_cadastral.id), notice: msgm
  end

  def pre_aprovar_em_lote
    params[:query][:situacao_cadastral_id] = 7
    if AtualizacaoCadastral.put([], params)
      redirect_to recadastramentos_path, flash: { notice: "Pre-aprovação em Lote ocorreu com sucesso" }
    else
      flash[:error] = "Falha na Pre-aprovação em Lote, tente novamente mais tarde"
      redirect_to recadastramentos_path(query: params[:query])
    end
  end

  def revisar_em_lote
    params[:query][:situacao_cadastral_id] = 8
    if AtualizacaoCadastral.put([], params)
      redirect_to recadastramentos_path, flash: { notice: "Revisão em Lote ocorreu com sucesso" }
    else
      flash[:error] = "Falha na Revisão em Lote, tente novamente mais tarde"
      redirect_to recadastramentos_path(query: params[:query])
    end
  end

  private
    def find_cadastro_ocorrencias
      @cadastro_ocorrencias = CadastroOcorrencia.all
    end

    def find_imovel_controle_atualizacao_cadastral
      @imovel_controle_atualizacao_cadastral = ImovelControleAtualizacaoCadastral.find params[:id]
    end

    def find_leituristas
      if params[:query].present? and params[:query][:empresa_id].present?
        @leituristas = Leiturista.where(empr_id: params[:query][:empresa_id])
      else
        @leituristas = []
      end
    end

    def find_coluna_atualizacao_cadastrais
      atualizacao_cadastrais = AtualizacaoCadastral.where(codigo_imovel: params[:id])
      @coluna_atualizacao_cadastrais = ColunaAtualizacaoCadastral.where(atualizacao_cadastral_id: atualizacao_cadastrais.map(&:id))
    end

    def find_imovel
      @imovel = Imovel.where(id: params[:id], page: 1, per_page: 10).try(:first)
    end

    def find_empresas
      empresa = Empresa.find(usuario_logado.empresa_id)
      if empresa.principal
        @empresas = Empresa.all
      else
        @empresas = []
        @empresas << empresa
      end
    end
end
