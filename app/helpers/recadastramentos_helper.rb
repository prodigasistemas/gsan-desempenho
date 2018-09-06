module RecadastramentosHelper
  def qnt_colspan(em_revisao)
    em_revisao ? 7 : 6
  end

  def exibir_imoveis_options
    opcoes = SituacaoAtualizacaoCadastral::SITUACOES.map {|s, a| [s.to_s.titlecase, a]}
    opcoes << ["Pendentes", SituacaoAtualizacaoCadastral::SITUACOES[:"TRANSMITIDO"]]
    opcoes << ["Pré-Aprovar em Lote", -2]
    opcoes << ["Todos", -1]
    opcoes
  end
end
