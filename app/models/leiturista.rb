class Leiturista
  attr_accessor :id, :nome

  def initialize(params)
    @id = params[:id]
    @nome = params[:nome]
  end
end
