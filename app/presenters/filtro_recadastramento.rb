class FiltroRecadastramento
  attr_accessor :agente_cadastral,
                :periodo_inicial,
                :periodo_final,
                :localidade_inicial,
                :localidade_id_inicial,
                :setor_comercial_inicial,
                :setor_comercial_id_inicial,
                :rota_inicial,
                :rota_id_inicial,
                :localidade_final,
                :localidade_id_final,
                :setor_comercial_final,
                :setor_comercial_id_final,
                :rota_final,
                :rota_id_final,
                :exibir_imoveis,
                :ocorrencias_cadastro,
                :alteracao_hidrometro,
                :alteracao_agua,
                :alteracao_esgoto,
                :alteracao_categoria_subcategoria,
                :empresa_id,
                :leiturista_id,
                :alteracao_cpf,
                :cadastro_ocorrencia_id,
                :quantidade_visitas,
                :matricula,
                :cpf_ja_cadastrado

  def initialize(params)
    if params[:query].present?
        @agente_cadastral =                 params[:query][:agente_cadastral]
        @periodo_inicial =                  params[:query][:periodo_inicial]
        @periodo_final =                    params[:query][:periodo_final]
        @localidade_inicial =               params[:query][:localidade_inicial]
        @localidade_id_inicial =            params[:query][:localidade_id_inicial]
        @setor_comercial_inicial =          params[:query][:setor_comercial_inicial]
        @setor_comercial_id_inicial =       params[:query][:setor_comercial_id_inicial]
        @rota_inicial =                     params[:query][:rota_inicial]
        @rota_id_inicial =                  params[:query][:rota_id_inicial]
        @localidade_final =                 params[:query][:localidade_final]
        @localidade_id_final =              params[:query][:localidade_id_final]
        @setor_comercial_final =            params[:query][:setor_comercial_final]
        @setor_comercial_id_final =         params[:query][:setor_comercial_id_final]
        @rota_final =                       params[:query][:rota_final]
        @rota_id_final =                    params[:query][:rota_id_final]
        @exibir_imoveis =                   params[:query][:exibir_imoveis]
        @ocorrencias_cadastro =             params[:query][:ocorrencias_cadastro]
        @alteracao_hidrometro =             params[:query][:alteracao_hidrometro]
        @alteracao_agua =                   params[:query][:alteracao_agua]
        @alteracao_esgoto =                 params[:query][:alteracao_esgoto]
        @alteracao_categoria_subcategoria = params[:query][:alteracao_categoria_subcategoria]
        @empresa_id =                       params[:query][:empresa_id]
        @leiturista_id =                    params[:query][:leiturista_id]
        @alteracao_cpf =                    params[:query][:alteracao_cpf]
        @cadastro_ocorrencia_id =           params[:query][:cadastro_ocorrencia_id]
        @quantidade_visitas  =              params[:query][:quantidade_visitas]
        @matricula =                        params[:query][:matricula]
        @cpf_ja_cadastrado =                params[:query][:cpf_ja_cadastrado]
    end
  end
end
