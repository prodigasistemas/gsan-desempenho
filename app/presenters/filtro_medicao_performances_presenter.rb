class FiltroMedicaoPerformancesPresenter
  attr_accessor :contrato_medicao,
                :contrato_medicao_id,
                :localidade,
                :localidade_id,
                :setor_comercial,
                :setor_comercial_id,
                :rota,
                :rota_id,
                :referencia

  def initialize(params)
    @contrato_medicao    = params[:contrato_medicao]
    @contrato_medicao_id = params[:query][:contrato_medicao_id] if params[:query].present?
    @localidade          = params[:localidade]
    @localidade_id       = params[:query][:localidade_id]       if params[:query].present?
    @setor_comercial     = params[:setor_comercial]
    @setor_comercial_id  = params[:query][:setor_comercial_id]  if params[:query].present?
    @rota                = params[:rota]
    @rota_id             = params[:query][:quadra][:rota_id]    if params[:query].present? && params[:query][:quadra].present?
    @referencia          = params[:referencia]                  if params[:query].present?
  end
end