class ImagemRetorno < ClienteAPI::Model
  attr_accessor :id,
                :imovel_retorno_id,
                :imovel_id,
                :nome_imagem,
                :caminho_imagem,
                :ultima_alteracao
end
