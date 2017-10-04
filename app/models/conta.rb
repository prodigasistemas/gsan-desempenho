class Conta < ClienteAPI::Model
  attr_accessor :id,
                :imovel_id,
                :ano_mes_referencia,
                :ligacao_agua_situacao_id,
                :data_vencimento_original,
                :debito_credito_situacao_id_atual,
                :debito_credito_situacao_id_anterior,
                :data_ultima_alteracao,
                :consumo_tarifa_id,
                :consumo_agua,
                :ano_mes_referencia_contabil,
                :data_vencimento,
                :percentual_esgoto,
                :valor_creditos,
                :valor_debitos,
                :valor_esgoto,
                :valor_agua,
                :indicador_cobranca_multa,
                :digito_verificador,
                :quadra_id,
                :localidade_id,
                :ligacao_esgoto_situacao

  belongs_to :imovel

  def total
    valor_debitos.to_f + valor_esgoto.to_f + valor_agua.to_f - valor_creditos.to_f
  end

  def ano_mes_referencia_formatado
    mes = ano_mes_referencia.to_s[4, 2]
    ano = ano_mes_referencia.to_s[0, 4]
    "#{mes}/#{ano}"
  end
end
