class RecadastramentosController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :find_empresas, :find_leituristas, :find_cadastro_ocorrencias, only: [:index]
  before_action :find_imovel_controle_atualizacao_cadastral, only: [:show, :update]
  before_action :find_imovel, :find_coluna_atualizacao_cadastrais, :verificar_se_houve_revisao,
                  :find_imagens, only: [:show]

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
                                                   page_sizes: [50]
  end

  def show
    unless @imovel_controle_atualizacao_cadastral.is_transmitido_revisao_ou_pre_aprovado?
      raise ActionController::RoutingError.new('Cadastro não encontrado')
    else
      @campos = smart_listing_create :campos,
                                     @coluna_atualizacao_cadastrais,
                                     partial: 'campos_list',
                                     page_sizes: [10000]
    end
  end

  def update
    parametros = { situacao_atualizacao_cadastral_id: params[:situacao] }
    parametros[:revisoes] = params[:revisoes] unless params[:revisoes].blank?
    @imovel_controle_atualizacao_cadastral = @imovel_controle_atualizacao_cadastral.update(parametros)
    redirect_to recadastramento_path(@imovel_controle_atualizacao_cadastral.imovel_id),
                  notice: "Imóvel colocado na situação '#{SituacaoAtualizacaoCadastral.descricao_situacao(params[:situacao].try(:to_i))}' com sucesso"
  end

  def pre_aprovar_em_lote
    params[:query][:situacao_cadastral_id] = SituacaoAtualizacaoCadastral::SITUACOES[:"PRE APROVADO"]
    if AtualizacaoCadastral.put([], params)
      redirect_to recadastramentos_path, flash: { notice: "A Pre-aprovação em Lote ocorrá em um processamento posterior, em até 24 horas" }
    else
      flash[:error] = "Falha na Pre-aprovação em Lote, tente novamente mais tarde"
      redirect_to recadastramentos_path(query: params[:query])
    end
  end

  def enviar_para_revisao_em_lote
    params[:query][:situacao_cadastral_id] = SituacaoAtualizacaoCadastral::SITUACOES[:"EM REVISAO"]
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
      if atualizacao_cadastrais.empty?
        @coluna_atualizacao_cadastrais = []
      else
        @coluna_atualizacao_cadastrais = ColunaAtualizacaoCadastral.where(atualizacao_cadastral_id: atualizacao_cadastrais.map(&:id))
      end
    end

    def find_imovel
      @imovel = Imovel.where(id: params[:id], page: 1, per_page: 10).try(:first)
    end

    def verificar_se_houve_revisao
      @teve_revisao = !(@coluna_atualizacao_cadastrais.select { |c| !c.valor_revisado.blank? }).empty?
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

    def find_imagens
      @imagens = ImagemRetorno.where(imovel_id: params[:id])
    end
end
