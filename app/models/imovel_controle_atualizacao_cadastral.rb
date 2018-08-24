class ImovelControleAtualizacaoCadastral < ClienteAPI::Model
  attr_accessor :id,
                :imovel_id,
                :tempo_geracao,
                :tempo_retorno,
                :tempo_aprovacao,
                :situacao_atualizacao_cadastral_id,
                :imovel_retorno_id,
                :tempo_processamento,
                :cadastro_imovel_id,
                :data_hora_pre_aprovacao

  belongs_to :cadastro_ocorrencia
  belongs_to :imovel
  belongs_to :imovel_retorno
  belongs_to :situacao_atualizacao_cadastral

  def descricao_ocorrencia
    cadastro_ocorrencia.try(:descricao)
  end

  def situacao_cadastral_id
    situacao_atualizacao_cadastral.try(:id)
  end

  def is_pre_aprovado?
    SituacaoAtualizacaoCadastral::SITUACOES[:"PRE APROVADO"] == situacao_atualizacao_cadastral_id
  end

  def is_revisado?
    SituacaoAtualizacaoCadastral::SITUACOES[:"REVISADO"] == situacao_atualizacao_cadastral_id
  end

  def is_em_revisao?
    SituacaoAtualizacaoCadastral::SITUACOES[:"EM REVISAO"] == situacao_atualizacao_cadastral_id
  end

  def is_transmitido_revisao_ou_pre_aprovado?
    pode_ser_pre_aprovado? or pode_ser_revisado? or is_pre_aprovado?
  end

  def pode_ser_pre_aprovado?
    SituacaoAtualizacaoCadastral.pode_ser_pre_aprovado? situacao_atualizacao_cadastral_id
  end

  def pode_ficar_em_revisao?
    SituacaoAtualizacaoCadastral.pode_ficar_em_revisao? situacao_atualizacao_cadastral_id
  end

  def pode_ser_revisado?
    SituacaoAtualizacaoCadastral.pode_ser_revisado? situacao_atualizacao_cadastral_id
  end

  def situacao
    SituacaoAtualizacaoCadastral.descricao_situacao situacao_atualizacao_cadastral_id
  end
end
