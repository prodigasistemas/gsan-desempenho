class SituacaoAtualizacaoCadastral < ClienteAPI::Model
  attr_accessor :id,
                :descricao,
                :indicador_uso,
                :ultima_alteracao

  has_many :imovel_controle_atualizacao_cadastral

  SITUACOES = {"DISPONIVEL": 0,
               "BLOQUEADO": 1,
               "EM CAMPO": 2,
               "TRANSMITIDO": 3,
               "APROVADO": 4,
               "EM FISCALIZACAO": 5,
               "ATUALIZADO": 6,
               "PRE APROVADO": 7,
               "REVISADO": 9,
               "EM REVISAO": 8,
               "A REVISAR": 10 }

  def self.pode_ser_pre_aprovado?(situacao)
    [SITUACOES[:"REVISADO"], SITUACOES[:"TRANSMITIDO"]].include?(situacao)
  end

  def self.pode_ficar_em_revisao?(situacao)
    [SITUACOES[:"TRANSMITIDO"]].include?(situacao)
  end

  def self.pode_ser_revisado?(situacao)
    [SITUACOES[:"EM REVISAO"]].include?(situacao)
  end

  def self.descricao_situacao(situacao)
    SITUACOES.key(situacao).try(:to_s)
  end

end
