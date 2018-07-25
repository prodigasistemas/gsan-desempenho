class ImovelAtualizacaoCadastral < ClienteAPI::Model
  attr_accessor :id,
                :hidrometro_numero,
                :ligacao_agua_situacao_id,
                :ligacao_esgoto_situacao_id,
                :situacao_cadastral_id

end
