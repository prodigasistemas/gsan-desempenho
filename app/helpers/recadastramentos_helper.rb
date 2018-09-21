module RecadastramentosHelper
  def qnt_colspan(em_revisao)
    em_revisao ? 7 : 6
  end

  def exibir_imoveis_options
    opcoes = SituacaoAtualizacaoCadastral::SITUACOES.sort.map {|s, a| [s.to_s.titlecase, a]}
    opcoes << ["Pendentes", -3]
    opcoes << ["Todos", -1]
    opcoes
  end
end
