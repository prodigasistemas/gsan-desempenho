class Cliente < ClienteAPI::Model
  attr_accessor :id,
                :orgao_emissor_rg_id,
                :orgao_emissor_uf_id,
                :cliente_responsavel_superior_id,
                :ramo_atividade_id,
                :profissao_id,
                :pessoa_sexo_id,
                :cliente_tipo_id,
                :nome,
                :nome_abreviado,
                :cpf,
                :rg,
                :data_emissao_rg,
                :nascimento,
                :cnpj,
                :email,
                :atualizado_em,
                :vencimento,
                :nome_mae,
                :ativo,
                :acao_cobranca,
                :cobranca_acrescimos,
                :arquivo_texto,
                :vencimento_mes_seguinte,
                :gera_fatura_antecipada,
                :nome_fantasia_conta,
                :permite_negativacao,
                :negativacao_periodo

  has_many :imoveis
  has_many :cliente_contas
end
