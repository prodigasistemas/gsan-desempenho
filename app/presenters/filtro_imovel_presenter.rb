class FiltroImovelPresenter
  attr_accessor :matricula, 
                :localidade, 
                :localidade_id, 
                :setor_comercial, 
                :setor_comercial_id,
                :rota,
                :rota_id,
                :quadra,
                :quadra_id,
                :numero_lote,
                :numero_sublote

  def initialize(params)
    @matricula = params[:query][:id] if params[:query].present?
    @localidade = params[:localidade]
    @localidade_id = params[:query][:localidade_id] if params[:query].present?
    @setor_comercial = params[:setor_comercial]
    @setor_comercial_id = params[:query][:setor_comercial_id] if params[:query].present?
    @rota = params[:rota]
    @rota_id = params[:query][:quadra][:rota_id] if params[:query].present?
    @quadra = params[:quadra] if params[:query].present?
    @quadra_id = params[:query][:qdra_id] if params[:query].present?
    @numero_lote = params[:query][:numero_lote] if params[:query].present?
    @numero_sublote = params[:query][:numero_sublote] if params[:query].present?
  end
end