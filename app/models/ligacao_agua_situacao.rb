class LigacaoAguaSituacao < ClienteAPI::Model
  attr_accessor :id, :descricao, :indicador_uso, :ultima_alteracao

  def self.sorted
    all.sort_by(&:id)
  end
end