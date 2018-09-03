module RecadastramentosHelper
  def qnt_colspan(em_revisao)
    em_revisao ? 7 : 6
  end

  def exibir_imoveis_options
    [["Pendentes", 3],
     ["Em Revisão", 8],
     ["Revisados", 9],
     ["Pré-Aprovados", 7],
     ["Pré-Aprovar em Lote", -2],
     ["Todos", -1]
    ]
  end
end
