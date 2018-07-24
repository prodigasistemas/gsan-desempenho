class Imovel < ClienteAPI::Model

  SITUACOES_AGUA = { 1 => "POTENCIAL",
                     2 => "FACTIVEL" ,
                     3 => "LIGADO",
                     4 => "EM_FISCALIZACAO",
                     5 => "CORTADO",
                     6 => "SUPRIMIDO",
                     7 => "SUPR_PARC",
                     8 => "SUPR_PARC_PEDIDO",
                     9 => "EM_CANCELAMENTO" }

  SITUACOES_ESGOTO = { 1 => "POTENCIAL",
                       2 => "FACTIVEL",
                       3 => "LIGADO",
                       4 => "EM_FISCALIZACAO",
                       5 => "LIG_FORA_DE_USO",
                       6 => "TAMPONADO" }

  attr_accessor :id, :localidade_id, :setor_comercial_id, :quadra_id, :numero_lote,
                :logradouro_bairro_id, :logradouro_cep_id, :bairro_id, :vencimento_mes_seguinte,
                :numero_sublote, :testada_lote, :numero_imovel, :complemento_endereco, :faixa_area_construida_id,
                :imovel_condominio_id, :indicador_imovel_condominio, :imovel_principal_id, :tipo_despejo_id,
                :volume_reservatorio_superior, :faixa_reservatorio_superior_id, :volume_reservatorio_inferior,
                :faixa_reservatorio_inferior_id, :tipo_pavimento_calcada_id, :tipo_pavimento_rua_id,
                :fonte_abastecimento_id, :situacao_ligacao_agua_id, :situacao_ligacao_esgoto_id,
                :perfil_imovel_id, :situacao_especial_de_cobranca_id, :situacao_especial_faturamento_id,
                :volume_piscina, :faixa_volume_piscina_id, :tipo_poco_id, :data_supressao_parcial,
                :data_infracao, :pontos_utilizacao, :moradores, :retificadores, :excecoes_leitura,
                :parcelamentos, :reparcelamentos, :reparcelamentos_consecutivos, :vencimento_alternativo,
                :iptu, :contrato, :indicador_emissao_extrato_faturamento, :indicador_debito_conta,
                :imovel_excluido, :coordenada_x, :coordenada_y, :anormalidade_id, :ocorrencia_id,
                :historico_instalacao_hidrometro_poco_id, :anormalidade_leitura_imoveis_sem_hidrometro_fiscalizado_leitura_id,
                :atualizado_em, :tarifa_id, :tipo_faturamento_id, :referencia_numero_id, :logradouro_id,
                :economias, :suspensao_abastecimento, :faturamento_situacao_motivo_id, :area_construida,
                :tipo_cobranca_situacao_id, :tipo_envio_conta_id, :jardim, :sequencial_rota_leitura,
                :nome, :funcionario_id, :habitacao_id, :tipo_propriedade_id, :tipo_constricao_id,
                :tipo_cobertura_id, :rota_entrega_id, :sequencia_rota_entrega, :data_contrato,
                :codigo_atualizacao_id, :logradouro_inicio_perimetro_id, :logradouro_final_perimetro_id,
                :face_quadra_id, :rota_alternativa_id, :medidor_energia_id, :visita_comercial_id,
                :informacoes, :codigo_debito_automatico, :reincidencia_infracao, :quadra_entrega,
                :ano_mes_exclusao_tarifa_social, :nivel_instalacao_esgoto, :utiliza_rateio_area_comum,
                :categoria, :subcategoria, :localidade, :setor_comercial, :percentual_abastecimento

  belongs_to :localidade
  belongs_to :setor_comercial
  belongs_to :quadra
  has_many :contas

  def self.imovel_nao_excluido(collection)
    collection.select { |i| i.imovel_excluido == nil or i.imovel_excluido != 1 }
  end

  def situacao_agua
    SITUACOES_AGUA[situacao_ligacao_agua_id]
  end

  def situacao_esgoto
    SITUACOES_ESGOTO[situacao_ligacao_esgoto_id]
  end
end
