class ClienteAtualizacaoCadastral < ClienteAPI::Model
  include ClienteAPI::Integracao::Requisicao

  attr_accessor :id,
                :cliente_id,
                :imovel_id,
                :nome,
                :cliente_tipo_id,
                :rg,
                :data_emissao_rg,
                :data_nascimento,
                :profissao_id,
                :pessoa_sexo_id,
                :cpf,
                :email,
                :indicador_uso,
                :ultima_alteracao,
                :nome_mae,
                :endereco_tipo_id,
                :logradouro_id,
                :descricao_logradouro,
                :codigo_cep,
                :bairro_id,
                :nome_bairro,
                :endereco_referencia_id,
                :numero_imovel,
                :complemento_endereco,
                :cnae,
                :cliente_relacaoTipo_id,
                :descricao_logradouro_titulo,
                :descricao_logradouro_tipo,
                :logradouro_titulo_id,
                :logradouro_tipo_id,
                :municipio_id,
                :nome_municipio,
                :uinidade_federacao_id,
                :descricao_uf_sigla_municipio,
                :descricao_abreviada_orgao_expedidor_rg,
                :descricao_uf_sigla_orgao_expedidor_rg,
                :ramo_atividade_id
end
