class ContratoMedicao < API::Model

  attr_accessor :id, :numero, :vigencia_inicial,
                :vigencia_final, :data_assinatura,
                :empresa_id, :atualizado_em, :empresa, :imoveis

  belongs_to :empresa
  has_many :imoveis

  def vigencia_inicial=(vigencia_inicial)
    @vigencia_inicial = vigencia_inicial.to_date
  end

  def vigencia_final=(vigencia_final)
    @vigencia_final = vigencia_final.to_date
  end

  def data_assinatura=(data_assinatura)
    @data_assinatura = data_assinatura.to_date
  end
end