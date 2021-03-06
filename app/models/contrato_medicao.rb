class ContratoMedicao < ClienteAPI::Model

  attr_accessor :id, :numero, :vigencia_inicial,
                :vigencia_final, :data_assinatura,
                :empresa_id, :atualizado_em, :empresa,
                :imoveis, :coeficientes

  belongs_to :empresa
  has_many :coeficientes, order: :ligacao_agua_id
  has_many :abrangencias

  def self.iniciar_coeficientes(ligacoes_agua)
    @coeficientes = []

    ligacoes_agua.each do |ligacao_agua|
      @coeficientes << Coeficiente.new(ligacao_agua_situacao: ligacao_agua, ligacao_agua_id: ligacao_agua.id)
    end

    @coeficientes
  end

  def nome_empresa_com_numero
    self.empresa.nome + ' - ' + self.numero
  end

  def nome_empresa
    empresa.try(:nome)
  end

  def vigencia_inicial=(vigencia_inicial)
    @vigencia_inicial = vigencia_inicial.to_date if vigencia_inicial.present?
  end

  def vigencia_final=(vigencia_final)
    @vigencia_final = vigencia_final.to_date if vigencia_final.present?
  end

  def data_assinatura=(data_assinatura)
    @data_assinatura = data_assinatura.to_date if data_assinatura.present?
  end

  def buscar_imoveis_pela_referencia(referencia)
    
  end
end