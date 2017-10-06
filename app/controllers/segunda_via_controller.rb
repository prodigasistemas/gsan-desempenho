class SegundaViaController < ApplicationController
  skip_before_action :acesso_restrito

  def index
    Rails.cache.write(:ids_gsan, nil)
  end
end
