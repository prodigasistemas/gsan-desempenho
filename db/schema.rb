# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admindb_foreign_keys", id: false, force: :cascade do |t|
    t.string "table_schema"
    t.string "table_name"
    t.string "constraint_name"
    t.string "column_name"
  end

  create_table "bi_logradouro", id: false, force: :cascade do |t|
    t.integer  "logr_id",                                             null: false
    t.string   "logr_nmlogradouro",      limit: 40,                   null: false
    t.integer  "lgtt_id"
    t.integer  "lgtp_id",                                             null: false
    t.integer  "muni_id",                                             null: false
    t.integer  "logr_icuso",             limit: 2
    t.datetime "logr_tmultimaalteracao",            default: "now()", null: false
    t.string   "logr_nmpopular",         limit: 30
  end

  create_table "c_receber", primary_key: "conta", force: :cascade do |t|
    t.integer "mes_id"
    t.integer "perfil"
    t.integer "loca_id"
    t.date    "dt_venc"
    t.decimal "vlr_ag",   precision: 12, scale: 2
    t.decimal "vlr_esg",  precision: 12, scale: 2
    t.decimal "vlr_deb",  precision: 12, scale: 2
    t.decimal "vlr_cred", precision: 12, scale: 2
    t.date    "dt_pag"
  end

  create_table "cacmid_cobranca_documento", id: false, force: :cascade do |t|
    t.integer "cacm_id"
  end

  add_index "cacmid_cobranca_documento", ["cacm_id"], name: "xfk2_cacmid_cobranca_documento", using: :btree

  create_table "changelog", force: :cascade do |t|
    t.string "applied_at",  limit: 25,  null: false
    t.string "description", limit: 255, null: false
  end

  create_table "changelog_batch_project", force: :cascade do |t|
    t.string "applied_at",  limit: 25,  null: false
    t.string "description", limit: 255, null: false
  end

  create_table "changelog_operacional_project", force: :cascade do |t|
    t.string "applied_at",  limit: 25,  null: false
    t.string "description", limit: 255, null: false
  end

  create_table "cliente_endereco_max_cled_id", id: false, force: :cascade do |t|
    t.integer "clie_id"
    t.integer "lgbr_id"
    t.integer "lgcp_id"
    t.integer "cled_id"
  end

  create_table "cliente_endereco_max_nnimovel", id: false, force: :cascade do |t|
    t.integer "clie_id"
    t.integer "logr_id"
    t.text    "btrim"
    t.integer "max"
  end

  create_table "cliente_endereco_tmp", id: false, force: :cascade do |t|
    t.integer  "cled_id"
    t.integer  "clie_id"
    t.integer  "edtp_id"
    t.integer  "edrf_id"
    t.string   "cled_nnimovel",                  limit: 5
    t.string   "cled_dscomplementoendereco",     limit: 25
    t.integer  "cep_id"
    t.integer  "bair_id"
    t.integer  "cled_icenderecocorrespondencia", limit: 2
    t.datetime "cled_tmultimaalteracao"
    t.integer  "logr_id"
    t.integer  "lgbr_id"
    t.integer  "lgcp_id"
    t.integer  "logr_idinicioperimetro"
    t.integer  "logr_idfimperimetro"
  end

  create_table "conta_sicom_aberta", id: false, force: :cascade do |t|
    t.integer "matricula_cliente_imovel"
    t.integer "data_referencia"
    t.decimal "num_fatura"
    t.integer "matricula_cliente_centralizador"
    t.integer "data_emissao_fatura"
    t.integer "cnta_id"
  end

  create_table "dadosrelatorioenergiaeletrica", id: false, force: :cascade do |t|
    t.integer "idlocalidade",                                            null: false
    t.integer "idmunicipio",                                             null: false
    t.string  "mes",                limit: 255,                          null: false
    t.integer "uc",                                                      null: false
    t.decimal "consumo",                        precision: 19, scale: 2
    t.string  "nomelocalidade",     limit: 255
    t.string  "nomemunicipio",      limit: 255
    t.decimal "totalfatorpotencia",             precision: 19, scale: 2
    t.decimal "ultrapassagemkwh",               precision: 19, scale: 2
    t.decimal "ultrapassagemvalor",             precision: 19, scale: 2
    t.decimal "valortotal",                     precision: 19, scale: 2
  end

  create_table "fat_credito", id: false, force: :cascade do |t|
    t.integer "mes_id"
    t.integer "conta",                                                   null: false
    t.integer "uneg_id"
    t.integer "loca_id"
    t.integer "mes_ref"
    t.integer "crog_id",                                                 null: false
    t.decimal "vl_credito",                     precision: 13, scale: 2
    t.integer "num_prestacao",        limit: 2
    t.integer "num_prestacaocredito", limit: 2
  end

  create_table "faturado_arrecadado", id: false, force: :cascade do |t|
    t.integer "pgmt_amreferenciapagamento"
    t.integer "pgmt_amreferenciaarrecadacao"
    t.integer "qtde_contas"
    t.decimal "cnta_vlagua",                  precision: 13, scale: 2, null: false
    t.decimal "cnta_vlesgoto",                precision: 13, scale: 2, null: false
    t.integer "cnta_nnconsumoagua"
  end

  create_table "hdt_form1", primary_key: "imov_id", force: :cascade do |t|
    t.string "cpf",          limit: 11
    t.string "sitimov",      limit: 1,   null: false
    t.string "uccelpa",      limit: 11
    t.string "sitligagua",   limit: 1,   null: false
    t.string "iptu",         limit: 11
    t.string "tppadraoinst", limit: 1,   null: false
    t.string "rg_num",       limit: 13
    t.string "rg_orgao",     limit: 13
    t.string "rg_uf",        limit: 2
    t.date   "rg_emiss"
    t.string "email",        limit: 40
    t.string "fone",         limit: 20
    t.string "observ",       limit: 150
    t.string "data_form1",   limit: 11
  end

  create_table "ligacaounidadeoperacional", id: false, force: :cascade do |t|
    t.string "source_id",   limit: 255, null: false
    t.string "target_id",   limit: 255, null: false
    t.string "source_name", limit: 255
    t.string "target_name", limit: 255
  end

  create_table "logr", primary_key: "logr_id", force: :cascade do |t|
    t.string "logr_nmlogradouro", limit: 50
  end

  create_table "nodesigma", force: :cascade do |t|
    t.string "label", limit: 255
    t.string "type",  limit: 255
  end

  create_table "orig_arrecadado", id: false, force: :cascade do |t|
    t.integer "arr_id",                                             default: "nextval('seq_arr'::regclass)", null: false
    t.integer "conta"
    t.integer "imovel"
    t.decimal "mes_id",                    precision: 6
    t.string  "un_id",           limit: 4
    t.string  "municipio_id",    limit: 9
    t.integer "bairro_id"
    t.integer "logr_id"
    t.string  "subcategoria_id", limit: 2
    t.integer "grupo"
    t.integer "setor"
    t.integer "rota"
    t.integer "quadra"
    t.integer "lote"
    t.integer "sublote"
    t.integer "perfil"
    t.integer "sit_agua"
    t.integer "sit_esg"
    t.integer "fonte_abast"
    t.integer "lig_agua"
    t.integer "qt_econ"
    t.date    "dt_pagto"
    t.integer "anomes_pagto"
    t.decimal "vl_pag",                    precision: 12, scale: 2
    t.string  "cat_count",       limit: 2
    t.integer "tp_doc"
    t.decimal "mes_ori",                   precision: 6
    t.integer "form_arr",                                           default: 0
    t.integer "tp_deb"
    t.integer "tp_hab"
    t.integer "tp_prop"
    t.integer "tp_const"
    t.integer "tp_cob"
    t.string  "tp_med",          limit: 1,                          default: "F"
    t.decimal "vl_desc",                   precision: 12, scale: 2, default: 0.0
    t.integer "documento",                                          default: 1
    t.integer "cd_banco",                                           default: 0
    t.decimal "vl_tar_cad",                precision: 12, scale: 2
    t.decimal "vl_tar_cob",                precision: 12, scale: 2
    t.integer "cbsp_id",                                            default: 0
    t.integer "cltp_id"
    t.integer "epod_id"
    t.date    "dt_venc"
    t.integer "amit_id"
    t.integer "cbst_id",                                            default: 0
    t.integer "ftst_id",                                            default: 0
    t.integer "seq_arr"
  end

  create_table "orig_c_receber", primary_key: "conta", force: :cascade do |t|
    t.integer "mes_id"
    t.integer "perfil"
    t.integer "loca_id"
    t.date    "dt_venc"
    t.decimal "vlr_ag",   precision: 12, scale: 2
    t.decimal "vlr_esg",  precision: 12, scale: 2
    t.decimal "vlr_deb",  precision: 12, scale: 2
    t.decimal "vlr_cred", precision: 12, scale: 2
    t.date    "dt_pag"
  end

  create_table "orig_c_receber2", primary_key: "conta", force: :cascade do |t|
    t.integer "mes_id"
    t.integer "perfil"
    t.integer "loca_id"
    t.date    "dt_venc"
    t.decimal "vlr_ag",   precision: 12, scale: 2
    t.decimal "vlr_esg",  precision: 12, scale: 2
    t.decimal "vlr_deb",  precision: 12, scale: 2
    t.decimal "vlr_cred", precision: 12, scale: 2
    t.date    "dt_pag"
  end

  create_table "pagamentos_cosanpa", id: false, force: :cascade do |t|
    t.integer "cnta_id"
    t.integer "pgmt_amreferenciapagamento",                          null: false
    t.decimal "pgmt_vlpagamento",           precision: 13, scale: 2
    t.date    "pgmt_dtpagamento"
    t.integer "imov_id",                                             null: false
    t.decimal "cnta_vlconta",               precision: 13, scale: 2
    t.decimal "cnhi_vlconta",               precision: 13, scale: 2
  end

  create_table "rgat", primary_key: "rgat_id", force: :cascade do |t|
    t.string "rgat_nmrgatadouro", limit: 500
  end

  create_table "seguranca_bkp_20091113", id: false, force: :cascade do |t|
    t.integer  "oper_id"
    t.integer  "fncd_id"
    t.string   "oper_dsoperacao",         limit: 60
    t.string   "oper_dsabreviado",        limit: 10
    t.string   "oper_dscaminhourl",       limit: 100
    t.datetime "oper_tmultimaalteracao"
    t.integer  "oper_idoperacaopesquisa"
    t.integer  "tbco_id"
    t.integer  "optp_id"
    t.integer  "tbco_idargumento"
  end

  create_table "temporaria_categoria_contas", id: false, force: :cascade do |t|
    t.integer  "crar_id"
    t.integer  "imov_id"
    t.integer  "crti_id"
    t.integer  "rgat_id"
    t.datetime "crar_tmatucredito"
    t.integer  "crar_amreferenciacredito"
    t.integer  "crar_amcobrancacredito"
    t.integer  "crar_amreferenciacontabil"
    t.decimal  "crar_vlresidualmesanterior",            precision: 13, scale: 2
    t.decimal  "crar_vlcredito",                        precision: 13, scale: 2
    t.integer  "crar_nnprestacaocredito",     limit: 2
    t.integer  "crar_nnprestacaorealizadas",  limit: 2
    t.integer  "loca_id"
    t.integer  "qdra_id"
    t.integer  "crar_cdsetorcomercial"
    t.integer  "crar_nnquadra"
    t.integer  "crar_nnlote",                 limit: 2
    t.integer  "crar_nnsublote",              limit: 2
    t.integer  "orse_id"
    t.datetime "crar_tmultimaalteracao"
    t.integer  "lict_id"
    t.integer  "dcst_idatual"
    t.integer  "dcst_idanterior"
    t.integer  "crog_id"
    t.integer  "parc_id"
    t.integer  "dotp_id"
    t.integer  "crar_idorigem"
    t.integer  "crar_nnparcelabonus",         limit: 2
    t.integer  "crar_amreferenciaprestacao"
    t.integer  "usur_id"
    t.integer  "crac_nnparcelasantecipadas"
    t.decimal  "crar_vlresidualconcedidomes",           precision: 13, scale: 2
    t.integer  "rownum"
  end

  create_table "teste", id: false, force: :cascade do |t|
    t.integer "teste1"
  end

  create_table "todas_as_foreign_keys_20081028", id: false, force: :cascade do |t|
    t.string "table_schema"
    t.string "table_name"
    t.string "constraint_name"
    t.string "column_name"
  end

  create_table "todas_as_foreign_keys_basica", id: false, force: :cascade do |t|
    t.string "schema_name"
    t.string "tabel_name"
    t.string "constraint_name"
    t.text   "drop_constraint"
    t.text   "constraint_def"
  end

  create_table "todas_as_primary_keys_20081028", id: false, force: :cascade do |t|
    t.string "table_schema"
    t.string "table_name"
    t.string "constraint_name"
    t.string "column_name"
  end

  create_table "todas_as_tabelas", id: false, force: :cascade do |t|
    t.string "table_schema"
    t.string "table_name"
    t.string "table_type"
  end

  create_table "todas_as_tabelas_20091229", id: false, force: :cascade do |t|
    t.string  "table_schema"
    t.string  "table_name"
    t.integer "qtde_columns", limit: 8
  end

  create_table "todos_os_indices_20091218", id: false, force: :cascade do |t|
    t.string "schemaname"
    t.string "tablename"
    t.string "indexname"
    t.text   "drop_index"
    t.text   "indexdef"
    t.text   "tablespace_name"
  end

  create_table "todos_os_indices_20140602", id: false, force: :cascade do |t|
    t.string "schemaname"
    t.string "tablename"
    t.string "indexname"
    t.text   "indexdef"
    t.string "tablespace"
  end

  create_table "todos_os_indices_basica", id: false, force: :cascade do |t|
    t.string "schemaname"
    t.string "tablename"
    t.string "indexname"
    t.text   "drop_index"
    t.text   "indexdef"
    t.text   "tablespace_name"
  end

  create_table "todos_os_indices_cosanpa", id: false, force: :cascade do |t|
    t.string "schemaname"
    t.string "tablename"
    t.string "indexname"
    t.text   "drop_index"
    t.text   "indexdef"
    t.text   "tablespace_name"
  end

end
