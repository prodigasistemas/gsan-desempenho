class ImovelRetorno < API::Model
   attr_accessor :id, :numero_imovel,
                 :complemento_endereco,
                 :pontos_utilizacao,
                 :numero_moradores,
                 :numero_iptu,
                 :coordenada_x,
                 :coordenada_y,
                 :numero_hidrometro,
                 :numero_medidor_energia,
                 :outras_informacoes,
                 :tipo_entrevistado,
                 :tipo_operacao,
                 :ultima_alteracao,
                 :ligacao_agua_situacao_id,
                 :fonte_abastecimento_id,
                 :hidrometro_protecao_id,
                 :imovel_id,
                 :municipio_id,
                 :nome_municipio,
                 :logradouro_tipo_id,
                 :logradouro_id,
                 :descricao_logradouro,
                 :nome_bairro,
                 :codigo_cep,
                 :localidade_id,
                 :codigo_setor_comercial,
                 :numero_quadra,
                 :ligacao_esgoto_situacao_id,
                 :ramal_local_instalacao_id,
                 :hidrometro_marca_id,
                 :hidrometro_capacidade_id,
                 :classe_social,
                 :quantidade_animais_domesticos,
                 :volume_cisterna,
                 :volume_caixa_dagua,
                 :tipo_uso,
                 :acesso_hidrometro,
                 :quantidade_economias_social,
                 :quatidade_economias_outra,
                 :fonte_abastecimento_nome,
                 :ramal_local_instalacao_nome,
                 :volume_piscina,
                 :area_construida,
                 :situacao_atualizacao_cadastral_nome
end