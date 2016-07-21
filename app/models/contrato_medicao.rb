class ContratoMedicao < API::Model

  attr_accessor :id, :numero, :vigencia_inicial,
                :vigencia_final, :data_assinatura,
                :empresa_id, :atualizado_em, :empresa, :imoveis, :coeficientes

  belongs_to :empresa
  has_many :imoveis
  has_many :coeficientes

  def vigencia_inicial=(vigencia_inicial)
    @vigencia_inicial = vigencia_inicial.to_date
  end

  def vigencia_final=(vigencia_final)
    @vigencia_final = vigencia_final.to_date
  end

  def data_assinatura=(data_assinatura)
    @data_assinatura = data_assinatura.to_date
  end

  def localidades
    if imoveis.any?
      locais = imoveis.map(&:localidade)
      locais.map(&:nome).uniq!
    else
      []
    end
  end
end