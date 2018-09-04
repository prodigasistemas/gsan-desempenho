module RecadastramentosHelper
  def qnt_colspan(em_revisao)
    em_revisao ? 7 : 6
  end

  def exibir_imoveis_options
    [["Pendentes", SituacaoAtualizacaoCadastral::SITUACOES[:"TRANSMITIDO"]],
     ["Em Revisão", SituacaoAtualizacaoCadastral::SITUACOES[:"EM REVISAO"]],
     ["Revisados", SituacaoAtualizacaoCadastral::SITUACOES[:"REVISADO"]],
     ["Pré-Aprovados", SituacaoAtualizacaoCadastral::SITUACOES[:"PRE APROVADO"]],
     ["Revisita", SituacaoAtualizacaoCadastral::SITUACOES[:"REVISITA"]],
     ["Pré-Aprovar em Lote", -2],
     ["Todos", -1]
    ]
  end
end
