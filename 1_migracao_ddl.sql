-- Encode in UTF-8-BOM / Convert to UTF-8-BOM
-- Keyword collect: select distinct t.txt_line_m from table (PKG_IMPORT_FORM.fu_form_lines_p (p_id => 1)) t order by t.txt_line_m;

-- Criar tabela de configuração com os valores de prefixo, sufixo, nomes, etc.
-- Criar documentação sobre cada objeto.
-- Criar documentação mostrando o que foi feito com cada objeto e como reutilizá-lo.
-- Criar páginas que explicam a finalidade do script.

-- Traduzir mensagens para o inglês.
-- Geração de dados de teste para as tabelas com PK/FK criadas.

-- OBJECT CREATION START.
create sequence s_m_disposable_contents      start with 1 minvalue 1 increment by 1 cycle maxvalue 999999999999999999999999999;
create sequence s_m_disposable_form_trg_lvl  start with 1 minvalue 1 increment by 1 cycle maxvalue 999999999999999999999999999;
create sequence s_m_form_keywords            start with 1 minvalue 1 increment by 1 cycle maxvalue 999999999999999999999999999;
create sequence s_m_form_keywords_values     start with 1 minvalue 1 increment by 1 cycle maxvalue 999999999999999999999999999;
create sequence s_m_languages                start with 1 minvalue 1 increment by 1 cycle maxvalue 999999999999999999999999999;
create sequence s_m_load_form                start with 1 minvalue 1 increment by 1 cycle maxvalue 999999999999999999999999999;
create sequence s_m_load_form_block_relation start with 1 minvalue 1 increment by 1 cycle maxvalue 999999999999999999999999999;
create sequence s_m_load_form_blocks_items   start with 1 minvalue 1 increment by 1 cycle maxvalue 999999999999999999999999999;
create sequence s_m_load_form_custom_disposa start with 1 minvalue 1 increment by 1 cycle maxvalue 999999999999999999999999999;
create sequence s_m_load_form_dispos_txt_typ start with 1 minvalue 1 increment by 1 cycle maxvalue 999999999999999999999999999;
create sequence s_m_load_form_glob_syst_parm start with 1 minvalue 1 increment by 1 cycle maxvalue 999999999999999999999999999;
create sequence s_m_load_form_lines          start with 1 minvalue 1 increment by 1 cycle maxvalue 999999999999999999999999999;
create sequence s_m_load_form_list_values    start with 1 minvalue 1 increment by 1 cycle maxvalue 999999999999999999999999999;
create sequence s_m_load_form_plsql_contents start with 1 minvalue 1 increment by 1 cycle maxvalue 999999999999999999999999999;
create sequence s_m_load_form_plsql_disc_rsn start with 1 minvalue 1 increment by 1 cycle maxvalue 999999999999999999999999999;
create sequence s_m_load_form_plsql_params   start with 1 minvalue 1 increment by 1 cycle maxvalue 999999999999999999999999999;
create sequence s_m_load_form_record_groups  start with 1 minvalue 1 increment by 1 cycle maxvalue 999999999999999999999999999;
create sequence s_m_load_form_static_values  start with 1 minvalue 1 increment by 1 cycle maxvalue 999999999999999999999999999;
create sequence s_m_load_form_trigger_types  start with 1 minvalue 1 increment by 1 cycle maxvalue 999999999999999999999999999;

-- GLOBAL TEMPORARY TABLES
create table m_load_form
(id                            integer not NULL,
 txt_original_file             varchar2(500),
 txt_form_blob                 blob,
 txt_form                      clob,
 txt_comments                  clob,
 txt_proposed_plsql_b          blob,
 txt_proposed_plsql            clob,
 txt_proposed_plsql_f          varchar2(500),
 txt_disposed_content_b        blob,
 txt_disposed_content          clob,
 txt_disposed_content_f        varchar2(500),
 txt_oracle_apex_plsql_calls_b blob,
 txt_oracle_apex_plsql_calls   clob,
 txt_oracle_apex_plsql_calls_f varchar2(500),
 txt_script_on_form_b          blob,
 txt_script_on_form            clob,
 txt_script_on_form_f          varchar2(500),
 txt_static_values_rg_b        blob,
 txt_static_values_rg          clob,
 txt_static_values_rg_f        varchar2(500),
 txt_static_values_li_b        blob,
 txt_static_values_li          clob,
 txt_static_values_li_f        varchar2(500),
 txt_domain_table_values_b     blob,
 txt_domain_table_values       clob,
 txt_domain_table_values_f     varchar2(500),
 txt_select_query_lov_b        blob,
 txt_select_query_lov          clob,
 txt_select_query_lov_f        varchar2(500),
 txt_mime_type                 varchar2(500),
 txt_filename                  varchar2(500),
 txt_charset                   varchar2(500),
 txt_blob_last_updated         date,
 txt_observacoes               varchar2(4000),
 user_create                   varchar2(50),
 date_create                   date,
 user_update                   varchar2(50),
 date_update                   date,
 app_create_id                 integer,
 app_create_page_id            integer,
 app_update_id                 integer,
 app_update_page_id            integer,
 constraint pk_m_load_form primary key (id));

create table m_load_form_lines
(id                  integer not NULL,
 id_form             integer,
 id_rownum           integer,
 txt_line            varchar2(4000),
 txt_line_m          varchar2(4000),
 txt_internal_name_m varchar2(4000),
 txt_line_p          varchar2(4000),
 txt_line_t          varchar2(4000),
 txt_internal_name_p varchar2(4000),
 txt_observacoes     varchar2(4000),
 user_create         varchar2(50),
 date_create         date,
 user_update         varchar2(50),
 date_update         date,
 app_create_id       integer,
 app_create_page_id  integer,
 app_update_id       integer,
 app_update_page_id  integer,
 constraint pk_m_load_form_lines primary key (id));

create table m_load_form_blocks_items
(id                             integer not NULL,
 id_form                        integer,
 id_rownum                      integer,
 txt_data_origin                varchar2(100),  -- "Colunas de Origem de Dados de Consulta" (Query Data Source Columns) ou seção "Itens" do bloco (Items)
 txt_block_name                 varchar2(50),   -- Nome do bloco
 txt_item_name                  varchar2(50),   -- Nome do item
 txt_disposable_data_block      varchar2(1),    -- Bloco pode ser descartado
 txt_block_item_name            varchar2(200),  -- :BLOCK.ITEM
 txt_variable_parameter_name    varchar2(100),
 txt_comments                   clob,           -- Comentários
 num_block_records_display      integer,        -- Número de Registros Exibidos
 txt_block_single_record        varchar2(10),   -- Registro Simples
 txt_block_database_data_block  varchar2(10),   -- Bloco de Dados do Banco de Dados
 txt_block_query_allowed        varchar2(10),   -- Consulta Permitida
 txt_block_insert_allowed       varchar2(10),   -- Inserção Permitida
 txt_block_update_allowed       varchar2(10),   -- Atualização Permitida
 txt_block_delete_allowed       varchar2(10),   -- Deleção Permitida
 txt_block_query_data_orig_type varchar2(50),   -- Tipo de Origem de Dados de Consulta
 txt_block_query_data_orig_name varchar2(4000), -- Nome de Origem dos Dados de Consulta
 txt_block_query_data_orig_clob clob,           -- "Query Data Source Type" = "FROM clause query"
 txt_block_where_clause         varchar2(4000), -- Cláusula WHERE
 txt_block_order_by             varchar2(4000), -- Cláusula ORDER BY
 txt_item_item_type             varchar2(50),   -- Tipo de item
 txt_item_enabled               varchar2(5),    -- Ativado
 txt_item_justification         varchar2(50),   -- Justificação
 txt_item_multiline             varchar2(5),    -- Várias Linhas
 txt_item_case_letter           varchar2(50),   -- Restrição a Maiúsculas/Minúsculas
 txt_item_conceal_data          varchar2(5),    -- Ocultar Dados
 txt_item_field_autofill        varchar2(5),    -- Salto Automático
 txt_item_field_datatype        varchar2(50),   -- Tipos de Dados
 txt_item_field_maxlength       varchar2(5),    -- Tamanho Máximo
 txt_item_field_precision       varchar2(5),    -- "Colunas de Origem de Dados de Consulta" / "Query Data Source Columns"
 txt_item_field_scale           varchar2(5),    -- "Colunas de Origem de Dados de Consulta" / "Query Data Source Columns"
 txt_item_field_inivalue        varchar2(4000), -- Valor Inicial
 txt_item_field_mandatory       varchar2(5),    -- Obrigatório
 txt_item_field_format_mask     varchar2(100),  -- Máscara de Formato
 txt_item_field_minvalue        varchar2(4000), -- Mínimo Valor Permitido
 txt_item_field_maxvalue        varchar2(4000), -- Máximo Valor Permitido
 txt_item_field_copy_value_from varchar2(4000), -- Copiar Valor a partir do Item
 txt_item_field_database        varchar2(5),    -- Item do Banco de Dados
 txt_item_field_db_col_name     varchar2(4000), -- Nome da Coluna (caso txt_field_database = YES)
 txt_item_field_primary_key     varchar2(5),    -- Chave Primária
 txt_item_field_read_only       varchar2(5),    -- Somente-Consulta
 txt_item_field_qry_allowed     varchar2(5),    -- Consulta Permitida
 txt_item_field_ins_allowed     varchar2(5),    -- Inserção Permitida
 txt_item_field_upd_allowed     varchar2(5),    -- Atualização Permitida
 txt_item_field_visible         varchar2(5),    -- Visível
 txt_item_field_prompt          varchar2(4000), -- Prompt
 txt_item_field_hint_1          varchar2(4000), -- Dica
 txt_item_field_hint_2          varchar2(4000), -- Dica de ferramenta
 txt_item_calculation_mode      varchar2(100),  -- Modo de Cálculo
-- origem dos dados: pode ser tabela (gerar o SQL que cria a tabela) ou query (transformar o bloco em função pipelined)
 txt_observacoes                varchar2(4000),
 user_create                    varchar2(50),
 date_create                    date,
 user_update                    varchar2(50),
 date_update                    date,
 app_create_id                  integer,
 app_create_page_id             integer,
 app_update_id                  integer,
 app_update_page_id             integer,
 constraint pk_m_load_form_blocks_items primary key (id));

create table m_load_form_static_values
(id                             integer not NULL,
 id_form                        integer,
 id_rownum                      integer,
 txt_static_data_origin         varchar2(100),  -- "STATIC_RECORD_GROUP" OR "BLOCK_ITEM"
 txt_block_name                 varchar2(50),   -- Nome do bloco
 txt_block_item_name            varchar2(50),   -- Nome do item
 txt_block_item_radbut_name     varchar2(4000), -- "Botões de Opção" -> Nome / "Radio Buttons" -> Name
 txt_block_item_radbut_label    varchar2(4000), -- "Etiqueta" / "Label"
 txt_block_item_radbut_value    varchar2(4000), -- "Valor do Botão de Opção" / "Radio Button Value"
 txt_record_group_name          varchar2(50),   -- Nome do grupo de registros (record group)
 txt_colspec_column_name        varchar2(500),  -- "Column Specifications" -> Name
 txt_colspec_maximum_length     integer,        -- "Column Specifications" -> Maximum Length
 txt_colspec_column_data_type   varchar2(500),  -- "Column Specifications" -> Column Data Type
 txt_recorg_group_col_val_lst_n varchar2(50),   -- "Column Value List" -> Name
 txt_recorg_group_col_val_lst_v varchar2(50),   -- "Column Value List" -> List Item Value
 txt_observacoes                varchar2(4000),
 user_create                    varchar2(50),
 date_create                    date,
 user_update                    varchar2(50),
 date_update                    date,
 app_create_id                  integer,
 app_create_page_id             integer,
 app_update_id                  integer,
 app_update_page_id             integer,
 constraint pk_m_load_form_static_values primary key (id));

create table m_load_form_block_relation
(id                         integer not NULL,
 id_form                    integer,
 id_rownum                  integer,
 txt_relation_name          varchar2(100),
 txt_relation_type          varchar2(100),
 txt_detailed_data_block    varchar2(100),
 txt_master_data_block      varchar2(100),
 txt_master_data_block_item varchar2(100),
 txt_detail_data_block      varchar2(100),
 txt_detail_data_block_item varchar2(100),
 txt_join_condition         varchar2(4000),
 txt_observacoes            varchar2(4000),
 user_create                varchar2(50),
 date_create                date,
 user_update                varchar2(50),
 date_update                date,
 app_create_id              integer,
 app_create_page_id         integer,
 app_update_id              integer,
 app_update_page_id         integer,
 constraint pk_m_load_form_block_relation primary key (id));

create table m_load_form_plsql_contents
(id                          integer not NULL,
 id_form                     integer,
 id_rownum                   integer,
 txt_generated_function_name varchar2(100),
 txt_plsql_program_unit_type varchar2(100),
 txt_plsql_source            varchar2(100),
 txt_block_source            varchar2(100),
 txt_block_item_source       varchar2(100),
 txt_plsql_object_name       varchar2(100),
 txt_comments                clob,
 clob_plsql_contents         clob,
 clob_plsql_contents_no_comm clob,
 txt_disposable_routine      varchar2(1),
 txt_disposable_reason       varchar2(4000),
 txt_observacoes             varchar2(4000),
 user_create                 varchar2(50),
 date_create                 date,
 user_update                 varchar2(50),
 date_update                 date,
 app_create_id               integer,
 app_create_page_id          integer,
 app_update_id               integer,
 app_update_page_id          integer,
 constraint pk_m_load_form_plsql_contents primary key (id));

create table m_load_form_plsql_params
(id                          integer not NULL,
 id_form                     integer,
 id_plsql_contents           integer,
 txt_block_item_gsp_variable varchar2(100), -- :GLOBAL.ITEM, :SYSTEM.ITEM, :PARAMETER.ITEM, :BLOCK.ITEM
 txt_variable_type           varchar2(50),
 txt_variable_declaration    varchar2(4000),
 txt_observacoes             varchar2(4000),
 user_create                 varchar2(50),
 date_create                 date,
 user_update                 varchar2(50),
 date_update                 date,
 app_create_id               integer,
 app_create_page_id          integer,
 app_update_id               integer,
 app_update_page_id          integer,
 constraint pk_m_load_form_plsql_params primary key (id));

create table m_load_form_record_groups
(id                            integer not NULL,
 id_form                       integer,
 id_rownum                     integer,
 txt_record_group_name         varchar2(50),
 txt_record_group_type         varchar2(50),
 clob_sql_query                clob,
 clob_sql_query_no_comm        clob,
 txt_record_group_col_name     varchar2(50),
 txt_record_group_col_maxsize  varchar2(10),
 txt_record_group_col_datatype varchar2(50),
 txt_observacoes               varchar2(4000),
 user_create                   varchar2(50),
 date_create                   date,
 user_update                   varchar2(50),
 date_update                   date,
 app_create_id                 integer,
 app_create_page_id            integer,
 app_update_id                 integer,
 app_update_page_id            integer,
 constraint pk_m_load_form_record_groups primary key (id));

create table m_load_form_glob_syst_parm
(id                          integer not NULL,
 id_form                     integer,
 id_rownum                   integer,
 txt_variable_type           varchar2(50),
 txt_variable_name           varchar2(100),
 txt_variable_parameter_name varchar2(100),
 txt_variable_data_type      varchar2(50),
 txt_variable_max_size       varchar2(10),
 txt_variable_ini_value      varchar2(4000),
 txt_observacoes             varchar2(4000),
 user_create                 varchar2(50),
 date_create                 date,
 user_update                 varchar2(50),
 date_update                 date,
 app_create_id               integer,
 app_create_page_id          integer,
 app_update_id               integer,
 app_update_page_id          integer,
 constraint pk_m_load_form_glob_syst_parm primary key (id));

create table m_load_form_custom_disposa
(id                             integer not NULL,
 txt_custom_disposable_text     varchar2(1000),
 id_disposable_text_type        integer,
 txt_disposable_text_has_params varchar2(1),
 txt_disposable_text_is_package varchar2(1),
 txt_disposable_text_detected   varchar2(1),
 txt_observacoes                varchar2(4000),
 user_create                    varchar2(50),
 date_create                    date,
 user_update                    varchar2(50),
 date_update                    date,
 app_create_id                  integer,
 app_create_page_id             integer,
 app_update_id                  integer,
 app_update_page_id             integer,
 constraint pk_m_load_form_custom_disposa primary key (id));

create table m_load_form_list_values
(id                         integer not NULL,
 id_form                    integer not NULL,
 txt_lov_name               varchar2(500),
 txt_lov_title              varchar2(500),
 txt_lov_type               varchar2(500),
 txt_lov_record_group       varchar2(500),
 txt_lov_item_name          varchar2(500),
 txt_lov_item_title         varchar2(500),
 txt_lov_item_return_item   varchar2(500),
 txt_lov_item_display_width varchar2(10),
 txt_observacoes            varchar2(4000),
 user_create                varchar2(50),
 date_create                date,
 user_update                varchar2(50),
 date_update                date,
 app_create_id              integer,
 app_create_page_id         integer,
 app_update_id              integer,
 app_update_page_id         integer,
 constraint pk_m_load_form_list_values primary key (id));

-- COMMON TABLES
create table m_languages
(id                 integer not NULL,
 txt_language       varchar2(100),
 txt_observacoes    varchar2(4000),
 user_create        varchar2(50),
 date_create        date,
 user_update        varchar2(50),
 date_update        date,
 app_create_id      integer,
 app_create_page_id integer,
 app_update_id      integer,
 app_update_page_id integer,
 constraint pk_m_languages primary key (id));

create table m_form_keywords
(id                       integer not NULL,
 txt_keyword              varchar2(1000),
 txt_internal_name        varchar2(100),
 id_language              integer,
 txt_observacoes          varchar2(4000),
 user_create              varchar2(50),
 date_create              date,
 user_update              varchar2(50),
 date_update              date,
 app_create_id            integer,
 app_create_page_id       integer,
 app_update_id            integer,
 app_update_page_id       integer,
 constraint pk_m_form_keywords primary key (id));

create table m_form_keywords_values
(id                 integer not NULL,
 txt_keyword        varchar2(1000),
 txt_internal_name  varchar2(100),
 id_language        integer,
 txt_observacoes    varchar2(4000),
 user_create        varchar2(50),
 date_create        date,
 user_update        varchar2(50),
 date_update        date,
 app_create_id      integer,
 app_create_page_id integer,
 app_update_id      integer,
 app_update_page_id integer,
 constraint pk_m_form_keywords_values primary key (id));

create table m_disposable_contents
(id                             integer not NULL,
 txt_disposable_text            varchar2(1000),
 id_disposable_text_type        integer,
 txt_disposable_text_has_params varchar2(1),
 txt_disposable_text_is_package varchar2(1),
 id_form_trigger_type           integer,
 txt_observacoes                varchar2(4000),
 user_create                    varchar2(50),
 date_create                    date,
 user_update                    varchar2(50),
 date_update                    date,
 app_create_id                  integer,
 app_create_page_id             integer,
 app_update_id                  integer,
 app_update_page_id             integer,
 constraint pk_m_disposable_contents primary key (id));

create table m_disposable_form_trg_lvl
(id                             integer not NULL,
 id_disposable_form_trg         integer,
 txt_disposa_trg_on_form_level  varchar2(1),
 txt_disposa_trg_on_block_level varchar2(1),
 txt_disposa_trg_on_item_level  varchar2(1),
 txt_observacoes                varchar2(4000),
 user_create                    varchar2(50),
 date_create                    date,
 user_update                    varchar2(50),
 date_update                    date,
 app_create_id                  integer,
 app_create_page_id             integer,
 app_update_id                  integer,
 app_update_page_id             integer,
 constraint pk_m_disposable_form_trg_lvl primary key (id));

create table m_load_form_trigger_types
(id                    integer not NULL,
 txt_trigger_type_name varchar2(100),
 txt_observacoes       varchar2(4000),
 user_create           varchar2(50),
 date_create           date,
 user_update           varchar2(50),
 date_update           date,
 app_create_id         integer,
 app_create_page_id    integer,
 app_update_id         integer,
 app_update_page_id    integer,
 constraint pk_m_load_form_trigger_types primary key (id));

create table m_load_form_dispos_txt_typ
(id                       integer not NULL,
 txt_disposable_text_type varchar2(200),
 txt_observacoes          varchar2(4000),
 user_create              varchar2(50),
 date_create              date,
 user_update              varchar2(50),
 date_update              date,
 app_create_id            integer,
 app_create_page_id       integer,
 app_update_id            integer,
 app_update_page_id       integer,
 constraint pk_m_load_form_dispos_txt_typ primary key (id));

create table m_load_form_plsql_disc_rsn
(id                             integer not NULL,
 txt_plsql_discard_reason       varchar2(100),
 txt_plsql_discard_reason_key   varchar2(10),
 txt_plsql_discard_reason_means varchar2(4000),
 txt_observacoes                varchar2(4000),
 user_create                    varchar2(50),
 date_create                    date,
 user_update                    varchar2(50),
 date_update                    date,
 app_create_id                  integer,
 app_create_page_id             integer,
 app_update_id                  integer,
 app_update_page_id             integer,
 constraint pk_m_load_form_plsql_disc_rsn primary key (id));

CREATE OR REPLACE PACKAGE pkg_m_validacao is
   p_pck_name varchar2(50) := 'PKG_M_VALIDACAO.';

-- fu_id_language
   FUNCTION fu_id_language (p_id                 M_LANGUAGES.id%TYPE,
                            p_msg_retorno IN OUT varchar2)
                            RETURN boolean;
END pkg_m_validacao;
/

CREATE OR REPLACE PACKAGE BODY pkg_m_validacao is
-- fu_id_language
   FUNCTION fu_id_language (p_id                 M_LANGUAGES.id%TYPE,
                            p_msg_retorno IN OUT varchar2)
                            RETURN boolean IS
      p_existe   integer        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_id_language (' || p_id || '): ';

   BEGIN
      if p_id is not NULL then
         BEGIN
            select 1
              into p_existe
              from m_languages ml
             where ml.id = p_id;

         EXCEPTION
            when no_data_found then
               p_msg_retorno := 'O idioma informado (' || p_id || ') não foi encontrado.';
               return FALSE;
            when others then
               p_msg_retorno := 'Erro SELECT 1 ML (' || p_id || ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_id_language;
END pkg_m_validacao;
/

CREATE OR REPLACE PACKAGE pkg_m_form_keywords is
   p_pck_name varchar2(50) := 'PKG_M_FORM_KEYWORDS.';

-- fu_ret_txt_internal_name_b
   FUNCTION fu_ret_txt_internal_name_b (p_txt_line                 varchar2,
                                        p_id_language              M_FORM_KEYWORDS.id_language%TYPE,
                                        p_txt_internal_name IN OUT varchar2,
                                        p_msg_retorno       IN OUT varchar2)
                                        RETURN boolean;

-- fu_val_m_form_keywords_b
   FUNCTION fu_val_m_form_keywords_b (p_m_form_keywords IN OUT m_form_keywords%ROWTYPE,
                                      p_msg_retorno     IN OUT varchar2)
                                      RETURN boolean;
END pkg_m_form_keywords;
/

CREATE OR REPLACE PACKAGE BODY pkg_m_form_keywords is
-- fu_ret_txt_internal_name_b
   FUNCTION fu_ret_txt_internal_name_b (p_txt_line                 varchar2,
                                        p_id_language              M_FORM_KEYWORDS.id_language%TYPE,
                                        p_txt_internal_name IN OUT varchar2,
                                        p_msg_retorno       IN OUT varchar2)
                                        RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_txt_internal_name_b (' || p_txt_line || ', ' || p_id_language || '): ';

   BEGIN
      if trim (p_txt_line) is NULL then
         p_txt_internal_name := NULL;
      else
         BEGIN
            select mfk.txt_internal_name
              into p_txt_internal_name
              from m_form_keywords mfk
             where mfk.id_language = p_id_language
               and trim (upper (mfk.txt_keyword)) = (trim (upper (translate (p_txt_line, chr(9), ' '))));

         EXCEPTION
            when no_data_found then
               p_txt_internal_name := NULL;
            when others then
               p_msg_retorno := 'Erro SELECT MFK em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_txt_internal_name_b;

-- fu_val_m_form_keywords_b
   FUNCTION fu_val_m_form_keywords_b (p_m_form_keywords IN OUT m_form_keywords%ROWTYPE,
                                      p_msg_retorno     IN OUT varchar2)
                                      RETURN boolean IS
      p_retorno  boolean        := NULL;
      p_existe   integer        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_val_m_form_keywords_b (' || p_m_form_keywords.id || '): ';
      pragma autonomous_transaction;

   BEGIN
      p_m_form_keywords.txt_keyword       := trim (p_m_form_keywords.txt_keyword);

      p_m_form_keywords.txt_internal_name := trim (upper (p_m_form_keywords.txt_internal_name));
      p_m_form_keywords.txt_observacoes   := trim (upper (p_m_form_keywords.txt_observacoes));

      if p_m_form_keywords.id_language is NULL then
         p_m_form_keywords.id_language := 1; -- PORTUGUÊS (BRASIL)
      end if;

      if p_m_form_keywords.id_language is not NULL then
         p_retorno := PKG_M_VALIDACAO.fu_id_language (p_m_form_keywords.id_language, p_msg_retorno);

         if p_retorno != TRUE then
            return p_retorno;
         end if;
      end if;

      if p_m_form_keywords.txt_keyword is NULL then
         p_msg_retorno := 'Keyword must be informed.';
         return FALSE;
      else
         BEGIN
            select 1
              into p_existe
              from m_form_keywords mfk
             where trim (upper (mfk.txt_keyword)) = trim (upper (p_m_form_keywords.txt_keyword))
               and mfk.id_language = p_m_form_keywords.id_language
               and ((mfk.id != p_m_form_keywords.id and p_m_form_keywords.id is not NULL) or p_m_form_keywords.id is NULL);

            p_msg_retorno := 'Keyword "' || p_m_form_keywords.txt_keyword || '" already informed for this language.';
            return FALSE;

         EXCEPTION
            when no_data_found then
               NULL;
            when others then
               p_msg_retorno := 'Erro SELECT MFL em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      if p_m_form_keywords.txt_internal_name is not NULL then
         BEGIN
            select 1
              into p_existe
              from m_form_keywords mfk
             where mfk.txt_internal_name = p_m_form_keywords.txt_internal_name
               and mfk.id_language       = p_m_form_keywords.id_language
               and ((mfk.id != p_m_form_keywords.id and p_m_form_keywords.id is not NULL) or p_m_form_keywords.id is NULL);

            p_msg_retorno := 'A palavra-chave informada já está cadastrada neste idioma.';
            return FALSE;

         EXCEPTION
            when no_data_found then
               NULL;
            when others then
               p_msg_retorno := 'Erro SELECT MFK em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_val_m_form_keywords_b;
END pkg_m_form_keywords;
/

CREATE OR REPLACE PACKAGE pkg_m_form_keywords_values is
   p_pck_name varchar2(50) := 'PKG_M_FORM_KEYWORDS_VALUES.';

-- fu_ret_txt_internal_name_b
   FUNCTION fu_ret_txt_internal_name_b (p_txt_line                 varchar2,
                                        p_id_language              M_FORM_KEYWORDS_VALUES.id_language%TYPE,
                                        p_txt_internal_name IN OUT varchar2,
                                        p_msg_retorno       IN OUT varchar2)
                                        RETURN boolean;

-- fu_val_m_form_keywords_value_b
   FUNCTION fu_val_m_form_keywords_value_b (p_m_form_keywords_values IN OUT m_form_keywords_values%ROWTYPE,
                                            p_msg_retorno            IN OUT varchar2)
                                            RETURN boolean;
END pkg_m_form_keywords_values;
/

CREATE OR REPLACE PACKAGE BODY pkg_m_form_keywords_values is
-- fu_ret_txt_internal_name_b
   FUNCTION fu_ret_txt_internal_name_b (p_txt_line                 varchar2,
                                        p_id_language              M_FORM_KEYWORDS_VALUES.id_language%TYPE,
                                        p_txt_internal_name IN OUT varchar2,
                                        p_msg_retorno       IN OUT varchar2)
                                        RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_txt_internal_name_b (' || p_txt_line || ', ' || p_id_language || '): ';

   BEGIN
      if trim (p_txt_line) is NULL then
         p_txt_internal_name := NULL;
      else
         BEGIN
            select mfkv.txt_internal_name
              into p_txt_internal_name
              from m_form_keywords_values mfkv
             where mfkv.id_language = p_id_language
               and trim (upper (mfkv.txt_keyword)) = (trim (upper (translate (p_txt_line, chr(9), ' '))));

         EXCEPTION
            when no_data_found then
               p_txt_internal_name := NULL;
            when others then
               p_msg_retorno := 'Erro SELECT MFKV em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_txt_internal_name_b;

-- fu_val_m_form_keywords_value_b
   FUNCTION fu_val_m_form_keywords_value_b (p_m_form_keywords_values IN OUT m_form_keywords_values%ROWTYPE,
                                            p_msg_retorno            IN OUT varchar2)
                                            RETURN boolean IS
      p_retorno  boolean        := NULL;
      p_existe   integer        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_val_m_form_keywords_value_b (' || p_m_form_keywords_values.id || '): ';
      pragma autonomous_transaction;

   BEGIN
      p_m_form_keywords_values.txt_keyword       := trim (upper (p_m_form_keywords_values.txt_keyword));
      p_m_form_keywords_values.txt_internal_name := trim (upper (p_m_form_keywords_values.txt_internal_name));
      p_m_form_keywords_values.txt_observacoes   := trim (upper (p_m_form_keywords_values.txt_observacoes));

      if p_m_form_keywords_values.id_language is NULL then
         p_m_form_keywords_values.id_language := 1; -- PORTUGUÊS - BRASIL
      end if;

      if p_m_form_keywords_values.id_language is not NULL then
         p_retorno := PKG_M_VALIDACAO.fu_id_language (p_m_form_keywords_values.id_language, p_msg_retorno);

         if p_retorno != TRUE then
            return p_retorno;
         end if;
      end if;

      if p_m_form_keywords_values.txt_keyword is NULL then
         p_msg_retorno := 'Keyword must be informed.';
         return FALSE;
      else
         BEGIN
            select 1
              into p_existe
              from m_form_keywords_values mfkv
             where translate (trim (upper (mfkv.txt_keyword)),                     'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC')
                 = translate (trim (upper (p_m_form_keywords_values.txt_keyword)), 'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC')
               and mfkv.id_language = p_m_form_keywords_values.id_language
               and ((mfkv.id != p_m_form_keywords_values.id and p_m_form_keywords_values.id is not NULL) or p_m_form_keywords_values.id is NULL);

            p_msg_retorno := 'Keyword "' || p_m_form_keywords_values.txt_keyword || '" already informed for this language.';
            return FALSE;

         EXCEPTION
            when no_data_found then
               NULL;
            when others then
               p_msg_retorno := 'Erro SELECT MFK em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      if p_m_form_keywords_values.txt_internal_name is not NULL then
         BEGIN
            select 1
              into p_existe
              from m_form_keywords_values mfkv
             where translate (trim (upper (mfkv.txt_internal_name)),                     'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC')
                 = translate (trim (upper (p_m_form_keywords_values.txt_internal_name)), 'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC')
               and mfkv.id_language = p_m_form_keywords_values.id_language
               and ((mfkv.id != p_m_form_keywords_values.id and p_m_form_keywords_values.id is not NULL) or p_m_form_keywords_values.id is NULL);

            p_msg_retorno := 'Internal name "' || p_m_form_keywords_values.txt_internal_name || '" already informed for this language.';
            return FALSE;

         EXCEPTION
            when no_data_found then
               NULL;
            when others then
               p_msg_retorno := 'Erro SELECT MFK em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_val_m_form_keywords_value_b;
END pkg_m_form_keywords_values;
/

CREATE OR REPLACE PACKAGE pkg_m_disposable_contents IS
   p_pck_name varchar2(50) := 'PKG_M_DISPOSABLE_CONTENTS.';

-- fu_ret_id_txt_disposable_txt_b
   FUNCTION fu_ret_id_txt_disposable_txt_b (p_txt_disposable_text        M_DISPOSABLE_CONTENTS.txt_disposable_text%TYPE,
                                            p_id                  IN OUT M_DISPOSABLE_CONTENTS.id%TYPE,
                                            p_msg_retorno         IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_id_txt_disposable_txt_i
   FUNCTION fu_ret_id_txt_disposable_txt_i (p_txt_disposable_text M_DISPOSABLE_CONTENTS.txt_disposable_text%TYPE)
                                            RETURN M_DISPOSABLE_CONTENTS.id%TYPE;

-- fu_val_m_disposable_contents_b
   FUNCTION fu_val_m_disposable_contents_b (p_m_disposable_contents IN OUT m_disposable_contents%ROWTYPE,
                                            p_msg_retorno           IN OUT varchar2)
                                            RETURN boolean;
END pkg_m_disposable_contents;
/

CREATE OR REPLACE PACKAGE BODY pkg_m_disposable_contents IS
-- fu_ret_id_txt_disposable_txt_b
   FUNCTION fu_ret_id_txt_disposable_txt_b (p_txt_disposable_text        M_DISPOSABLE_CONTENTS.txt_disposable_text%TYPE,
                                            p_id                  IN OUT M_DISPOSABLE_CONTENTS.id%TYPE,
                                            p_msg_retorno         IN OUT varchar2)
                                            RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_id_txt_disposable_txt_b (' || p_txt_disposable_text || '): ';

   BEGIN
      if trim (p_txt_disposable_text) is NULL then
         p_id := NULL;
      else
         BEGIN
            select mdc.id
              into p_id
              from m_disposable_contents mdc
             where translate (trim (upper (mdc.txt_disposable_text)), 'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC')
                 = translate (trim (upper (p_txt_disposable_text)),   'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC');

         EXCEPTION
            when no_data_found then
               p_id := NULL;
            when others then
               p_msg_retorno := 'Erro SELECT MDC em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_id_txt_disposable_txt_b;

-- fu_ret_id_txt_disposable_txt_i
   FUNCTION fu_ret_id_txt_disposable_txt_i (p_txt_disposable_text M_DISPOSABLE_CONTENTS.txt_disposable_text%TYPE)
                                            RETURN M_DISPOSABLE_CONTENTS.id%TYPE IS
      p_id M_DISPOSABLE_CONTENTS.id%TYPE := NULL;
      p_retorno     boolean        := NULL;
      p_prc_name    varchar2(1000) := p_pck_name || 'fu_ret_id_txt_disposable_txt_i (' || p_txt_disposable_text || '): ';
      p_msg_retorno varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_M_DISPOSABLE_CONTENTS.fu_ret_id_txt_disposable_txt_b (p_txt_disposable_text, p_id, p_msg_retorno);

      if p_retorno = TRUE then
         return p_id;
      else
         return NULL;
      end if;

   EXCEPTION
      when others then
         return NULL;
   END fu_ret_id_txt_disposable_txt_i;

-- fu_val_m_disposable_contents_b
   FUNCTION fu_val_m_disposable_contents_b (p_m_disposable_contents IN OUT m_disposable_contents%ROWTYPE,
                                            p_msg_retorno           IN OUT varchar2)
                                            RETURN boolean IS
      p_existe   integer        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_val_m_disposable_contents_b (' || p_m_disposable_contents.id || '): ';
      pragma autonomous_transaction;

   BEGIN
      p_m_disposable_contents.txt_disposable_text            := trim (upper (p_m_disposable_contents.txt_disposable_text));
      p_m_disposable_contents.txt_observacoes                := trim (upper (p_m_disposable_contents.txt_observacoes));

      p_m_disposable_contents.txt_disposable_text_has_params := nvl (trim (upper (p_m_disposable_contents.txt_disposable_text_has_params)), 'N');
      p_m_disposable_contents.txt_disposable_text_is_package := nvl (trim (upper (p_m_disposable_contents.txt_disposable_text_is_package)), 'N');

      if p_m_disposable_contents.txt_disposable_text_has_params not in ('Y', 'N', 'B') then -- YES/NO/BOTH (EXAMPLE: CLEAR_FORM BUILT-IN)
         p_m_disposable_contents.txt_disposable_text_has_params := 'N';
      end if;

      if p_m_disposable_contents.txt_disposable_text_is_package not in ('Y', 'N') then
         p_m_disposable_contents.txt_disposable_text_is_package := 'N';
      end if;

      if p_m_disposable_contents.txt_disposable_text is NULL then
         p_msg_retorno := 'Disposable Oracle Forms text (either trigger or built-in) must be informed.';
         return FALSE;
      else
         BEGIN
            select 1
              into p_existe
              from m_disposable_contents mdc
             where translate (trim (upper (mdc.txt_disposable_text)),                     'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC')
                 = translate (trim (upper (p_m_disposable_contents.txt_disposable_text)), 'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC')
               and ((mdc.id != p_m_disposable_contents.id and p_m_disposable_contents.id is not NULL) or p_m_disposable_contents.id is NULL);

            p_msg_retorno := 'Disposable text "' || p_m_disposable_contents.txt_disposable_text || '" already informed.';
            return FALSE;

         EXCEPTION
            when no_data_found then
               NULL;
            when others then
               p_msg_retorno := 'Erro SELECT MLFTT (' || p_m_disposable_contents.txt_disposable_text ||
                                              ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_val_m_disposable_contents_b;
END pkg_m_disposable_contents;
/

CREATE OR REPLACE PACKAGE pkg_m_load_form_dispos_txt_typ IS
   p_pck_name varchar2(50) := 'PKG_M_LOAD_FORM_DISPOS_TXT_TYP.';

-- fu_ret_disposable_text_type_b
   FUNCTION fu_ret_disposable_text_type_b (p_txt_disposable_text_type        M_LOAD_FORM_DISPOS_TXT_TYP.txt_disposable_text_type%TYPE,
                                           p_id                       IN OUT M_LOAD_FORM_DISPOS_TXT_TYP.id%TYPE,
                                           p_msg_retorno              IN OUT varchar2)
                                           RETURN boolean;

-- fu_ret_disposable_text_type_i
   FUNCTION fu_ret_disposable_text_type_i (p_txt_disposable_text_type M_LOAD_FORM_DISPOS_TXT_TYP.txt_disposable_text_type%TYPE)
                                           RETURN M_LOAD_FORM_DISPOS_TXT_TYP.id%TYPE;

-- fu_val_m_load_form_dispos_tx_b
   FUNCTION fu_val_m_load_form_dispos_tx_b (p_m_load_form_dispos_txt_typ IN OUT m_load_form_dispos_txt_typ%ROWTYPE,
                                            p_msg_retorno                IN OUT varchar2)
                                            RETURN boolean;
END pkg_m_load_form_dispos_txt_typ;
/

CREATE OR REPLACE PACKAGE BODY pkg_m_load_form_dispos_txt_typ IS
-- fu_ret_disposable_text_type_b
   FUNCTION fu_ret_disposable_text_type_b (p_txt_disposable_text_type        M_LOAD_FORM_DISPOS_TXT_TYP.txt_disposable_text_type%TYPE,
                                           p_id                       IN OUT M_LOAD_FORM_DISPOS_TXT_TYP.id%TYPE,
                                           p_msg_retorno              IN OUT varchar2)
                                           RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_disposable_text_type_b (' || p_txt_disposable_text_type || '): ';

   BEGIN
      if trim (p_txt_disposable_text_type) is NULL then
         p_id := NULL;
      else
         BEGIN
            select mlftt.id
              into p_id
              from m_load_form_dispos_txt_typ mlftt
             where translate (trim (mlftt.txt_disposable_text_type), 'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC')
                 = translate (trim (p_txt_disposable_text_type),     'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC');

         EXCEPTION
            when no_data_found then
               p_msg_retorno := 'Disposable text type "' || p_txt_disposable_text_type || '" not found.';
               return FALSE;
            when others then
               p_msg_retorno := 'Erro SELECT MLFTT em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_disposable_text_type_b;

-- fu_ret_disposable_text_type_i
   FUNCTION fu_ret_disposable_text_type_i (p_txt_disposable_text_type M_LOAD_FORM_DISPOS_TXT_TYP.txt_disposable_text_type%TYPE)
                                           RETURN M_LOAD_FORM_DISPOS_TXT_TYP.id%TYPE IS
      p_id M_LOAD_FORM_DISPOS_TXT_TYP.id%TYPE := NULL;
      p_retorno     boolean        := NULL;
      p_prc_name    varchar2(1000) := p_pck_name || 'fu_ret_disposable_text_type_i (' || p_txt_disposable_text_type || '): ';
      p_msg_retorno varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_M_LOAD_FORM_DISPOS_TXT_TYP.fu_ret_disposable_text_type_b (p_txt_disposable_text_type, p_id, p_msg_retorno);

      if p_retorno = TRUE then
         return p_id;
      else
         return NULL;
      end if;

   EXCEPTION
      when others then
         return NULL;
   END fu_ret_disposable_text_type_i;

-- fu_val_m_load_form_dispos_tx_b
   FUNCTION fu_val_m_load_form_dispos_tx_b (p_m_load_form_dispos_txt_typ IN OUT m_load_form_dispos_txt_typ%ROWTYPE,
                                            p_msg_retorno                IN OUT varchar2)
                                            RETURN boolean IS
      p_existe   integer        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_val_m_load_form_trigger_t_b (' || p_m_load_form_dispos_txt_typ.id || '): ';
      pragma autonomous_transaction;

   BEGIN
      p_m_load_form_dispos_txt_typ.txt_disposable_text_type := trim (upper (p_m_load_form_dispos_txt_typ.txt_disposable_text_type));
      p_m_load_form_dispos_txt_typ.txt_observacoes          := trim (upper (p_m_load_form_dispos_txt_typ.txt_observacoes));

      if p_m_load_form_dispos_txt_typ.txt_disposable_text_type is NULL then
         p_msg_retorno := 'Disposable text type must be informed.';
         return FALSE;
      else
         BEGIN
            select 1
              into p_existe
              from m_load_form_dispos_txt_typ mlfdtt
             where translate (trim (upper (mlfdtt.txt_disposable_text_type)),                       'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC')
                 = translate (trim (upper (p_m_load_form_dispos_txt_typ.txt_disposable_text_type)), 'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC')
               and ((mlfdtt.id != p_m_load_form_dispos_txt_typ.id and p_m_load_form_dispos_txt_typ.id is not NULL) or p_m_load_form_dispos_txt_typ.id is NULL);

            p_msg_retorno := 'Disposable text type "' || p_m_load_form_dispos_txt_typ.txt_disposable_text_type || '" already informed.';
            return FALSE;

         EXCEPTION
            when no_data_found then
               NULL;
            when others then
               p_msg_retorno := 'Erro SELECT MLFDTT (' || p_m_load_form_dispos_txt_typ.txt_disposable_text_type ||
                                               ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_val_m_load_form_dispos_tx_b;
END pkg_m_load_form_dispos_txt_typ;
/

CREATE OR REPLACE PACKAGE pkg_m_load_form_plsql_disc_rsn IS
   p_pck_name varchar2(50) := 'PKG_M_LOAD_FORM_PLSQL_DISC_RSN.';

-- fu_ret_discard_reason_key_b
   FUNCTION fu_ret_discard_reason_key_b (p_txt_plsql_discard_reason_key        M_LOAD_FORM_PLSQL_DISC_RSN.txt_plsql_discard_reason_key%TYPE,
                                         p_txt_plsql_discard_reason     IN OUT M_LOAD_FORM_PLSQL_DISC_RSN.txt_plsql_discard_reason%TYPE,
                                         p_msg_retorno                  IN OUT varchar2)
                                         RETURN boolean;

-- fu_ret_discard_reason_key_v
   FUNCTION fu_ret_discard_reason_key_v (p_txt_plsql_discard_reason_key M_LOAD_FORM_PLSQL_DISC_RSN.txt_plsql_discard_reason_key%TYPE)
                                         RETURN M_LOAD_FORM_PLSQL_DISC_RSN.txt_plsql_discard_reason%TYPE;

-- fu_val_m_load_form_plsql_dis_b
   FUNCTION fu_val_m_load_form_plsql_dis_b (p_m_load_form_plsql_disc_rsn IN OUT m_load_form_plsql_disc_rsn%ROWTYPE,
                                            p_msg_retorno                IN OUT varchar2)
                                            RETURN boolean;
END pkg_m_load_form_plsql_disc_rsn;
/

CREATE OR REPLACE PACKAGE BODY pkg_m_load_form_plsql_disc_rsn IS
-- fu_ret_discard_reason_key_b
   FUNCTION fu_ret_discard_reason_key_b (p_txt_plsql_discard_reason_key        M_LOAD_FORM_PLSQL_DISC_RSN.txt_plsql_discard_reason_key%TYPE,
                                         p_txt_plsql_discard_reason     IN OUT M_LOAD_FORM_PLSQL_DISC_RSN.txt_plsql_discard_reason%TYPE,
                                         p_msg_retorno                  IN OUT varchar2)
                                         RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_discard_reason_key_b (' || p_txt_plsql_discard_reason_key || '): ';

   BEGIN
      if trim (p_txt_plsql_discard_reason_key) is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'a chave deve ser informada.';
         return FALSE;
      else
         BEGIN
            select mlfpdr.txt_plsql_discard_reason
              into p_txt_plsql_discard_reason
              from m_load_form_plsql_disc_rsn mlfpdr
             where mlfpdr.txt_plsql_discard_reason_key = trim (upper (p_txt_plsql_discard_reason_key));

         EXCEPTION
            when no_data_found then
               p_txt_plsql_discard_reason := NULL;
            when others then
               p_msg_retorno := 'Erro SELECT MLFPDR em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_discard_reason_key_b;

-- fu_ret_discard_reason_key_v
   FUNCTION fu_ret_discard_reason_key_v (p_txt_plsql_discard_reason_key M_LOAD_FORM_PLSQL_DISC_RSN.txt_plsql_discard_reason_key%TYPE)
                                         RETURN M_LOAD_FORM_PLSQL_DISC_RSN.txt_plsql_discard_reason%TYPE IS
      p_txt_plsql_discard_reason M_LOAD_FORM_PLSQL_DISC_RSN.txt_plsql_discard_reason%TYPE := NULL;
      p_retorno     boolean        := NULL;
      p_prc_name    varchar2(1000) := p_pck_name || 'fu_ret_discard_reason_key_v (' || p_txt_plsql_discard_reason_key || '): ';
      p_msg_retorno varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_M_LOAD_FORM_PLSQL_DISC_RSN.fu_ret_discard_reason_key_b (p_txt_plsql_discard_reason_key, p_txt_plsql_discard_reason, p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_plsql_discard_reason;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_discard_reason_key_v;

-- fu_val_m_load_form_plsql_dis_b
   FUNCTION fu_val_m_load_form_plsql_dis_b (p_m_load_form_plsql_disc_rsn IN OUT m_load_form_plsql_disc_rsn%ROWTYPE,
                                            p_msg_retorno                IN OUT varchar2)
                                            RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_val_m_load_form_plsql_dis_b (' || p_m_load_form_plsql_disc_rsn.id || '): ';

   BEGIN
      p_m_load_form_plsql_disc_rsn.txt_plsql_discard_reason       := trim (upper (p_m_load_form_plsql_disc_rsn.txt_plsql_discard_reason));
      p_m_load_form_plsql_disc_rsn.txt_plsql_discard_reason_key   := trim (upper (p_m_load_form_plsql_disc_rsn.txt_plsql_discard_reason_key));
      p_m_load_form_plsql_disc_rsn.txt_plsql_discard_reason_means := trim (upper (p_m_load_form_plsql_disc_rsn.txt_plsql_discard_reason_means));
      p_m_load_form_plsql_disc_rsn.txt_observacoes                := trim (upper (p_m_load_form_plsql_disc_rsn.txt_observacoes));

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_val_m_load_form_plsql_dis_b;
END pkg_m_load_form_plsql_disc_rsn;
/

CREATE OR REPLACE PACKAGE pkg_import_form is
   p_pck_name                     varchar2(50)   := 'PKG_IMPORT_FORM.';

   p_directory_name ALL_DIRECTORIES.directory_name%TYPE := 'SCRIPT'; -- C:\oraclexe\script
   p_discard_invalid_trigger_name boolean        := TRUE;
   p_plsql_count                  integer        := 0; -- This variable counts every PL/SQL function name being generated.
   p_oracle_objects_size          integer        := 30;
   p_separator                    varchar2(5)    := chr(9);
   p_foreign_key_name_prefix      varchar2(5)    := 'FK_';
   p_primary_key_name_prefix      varchar2(5)    := 'PK_';
   p_function_pipelined_suffix    varchar2(5)    := '_p';
   p_function_sysrefcursor_suffix varchar2(5)    := '_c';
   p_parameter_prefix             varchar2(5)    := 'p_';
   p_prefix                       varchar2(5)    := 'fn_';
   p_suffix                       varchar2(5)    := '_b';
   p_piperow_variable_prefix      varchar2(5)    := 'r_';
   p_sysrefcursor_variable_prefix varchar2(5)    := 'c_';
   p_table_of_type_name_prefix    varchar2(5)    := 'h_';
   p_type_name_prefix             varchar2(5)    := 't_';
   p_indent                       varchar2(10)   := '   '; -- Indent 3 spaces
   p_oracle_apex_prefix           varchar2(10)   := ':P0000_';
   p_package_prefix               varchar2(10)   := 'pkg_';
   p_txt_proposed_plsql_s         varchar2(50)   := '.proposed_plsql.sql';
   p_txt_disposed_content_s       varchar2(50)   := '.disposed_content.sql';
   p_txt_oracle_apex_plsql_call_s varchar2(50)   := '.oracle_apex_plsql_calls.sql';
   p_txt_script_on_form_s         varchar2(50)   := '.script_on_form.sql';
   p_txt_static_values_rg_s       varchar2(50)   := '.static_values_from_radio_groups.csv';
   p_txt_static_values_li_s       varchar2(50)   := '.static_values_from_list_items.csv';
   p_txt_domain_table_values_s    varchar2(50)   := '.domain_table_values.sql';
   p_txt_select_query_lovs_s      varchar2(50)   := '.select_from_lov.sql';
   p_error_text_v                 varchar2(100)  := 'Error';
   p_msg_retorno_v                varchar2(100)  := 'p_msg_return';
   p_pattern                      varchar2(100)  := chr(13) || chr(10) || chr(9) || ' ,;):=|';
   p_pck_name_v                   varchar2(100)  := 'p_pck_name';
   p_prc_name_v                   varchar2(100)  := 'p_prc_name';
   p_retorno_v                    varchar2(100)  := 'p_return';
   p_form_parameters              varchar2(4000) := NULL;
   p_id_language M_FORM_KEYWORDS.id_language%TYPE := 2;

   type t_form_lines is record (id                  M_LOAD_FORM.id%TYPE,
                                id_rownum           integer,
                                txt_line            varchar2(32767),
                                txt_line_m          varchar2(32767),
                                txt_internal_name_m M_FORM_KEYWORDS.txt_internal_name%TYPE,
                                txt_line_p          varchar2(32767),
                                txt_internal_name_p M_FORM_KEYWORDS_VALUES.txt_internal_name%TYPE);

   type p_form_lines is table of t_form_lines;

-- select * from table (PKG_IMPORT_FORM.fu_form_lines_p (p_id => 1)) t;
-- fu_form_lines_p
   FUNCTION fu_form_lines_p (p_id M_LOAD_FORM.id%TYPE)
                             RETURN p_form_lines PIPELINED;

   cursor c_imported_form (p_id            integer,
                           p_rownum_start  integer,
                           p_rownum_finish integer default 2147483648) is
      select mlfl.*
        from m_load_form_lines mlfl
       where mlfl.id_form   = p_id
         and mlfl.id_rownum between nvl (p_rownum_start,  0)
                                and nvl (p_rownum_finish, 0)
         and nvl (p_rownum_start,  0) > 0
         and nvl (p_rownum_finish, 0) > 0
         and nvl (p_rownum_start,  0) < nvl (p_rownum_finish, 0)
       order by mlfl.id;

   r_imported_form c_imported_form%ROWTYPE := NULL;

-- fu_informed_dir_exists_b
   FUNCTION fu_informed_dir_exists_b (p_directory_name        ALL_DIRECTORIES.directory_name%TYPE,
                                      p_msg_retorno    IN OUT varchar2)
                                      RETURN boolean;

-- fu_loaded_form_blob_to_clob_b
   FUNCTION fu_loaded_form_blob_to_clob_b (p_txt_form_blob        M_LOAD_FORM.txt_form_blob%TYPE,
                                           p_txt_form      IN OUT M_LOAD_FORM.txt_form%TYPE,
                                           p_msg_retorno   IN OUT varchar2)
                                           RETURN boolean;

-- fu_loaded_form_blob_to_clob_c
   FUNCTION fu_loaded_form_blob_to_clob_c (p_txt_form_blob        M_LOAD_FORM.txt_form_blob%TYPE,
                                           p_msg_retorno   IN OUT varchar2)
                                           RETURN M_LOAD_FORM.txt_form%TYPE;

-- fu_form_lines_from_clob_b
   FUNCTION fu_form_lines_from_clob_b (p_id                 M_LOAD_FORM.id%TYPE,
                                       p_msg_retorno IN OUT varchar2)
                                       RETURN boolean;

-- fu_import_form_from_dir_b
   FUNCTION fu_import_form_from_dir_b (p_directory_name           ALL_DIRECTORIES.directory_name%TYPE,
                                       p_txt_original_file        M_LOAD_FORM.txt_original_file%TYPE,
                                       p_msg_retorno       IN OUT varchar2)
                                       RETURN boolean;

-- fu_existe_id_form_b
   FUNCTION fu_existe_id_form_b (p_id                 M_LOAD_FORM.id%TYPE,
                                 p_msg_retorno IN OUT varchar2)
                                 RETURN boolean;

-- fu_return_txt_form_b
   FUNCTION fu_return_txt_form_b (p_id                 M_LOAD_FORM.id%TYPE,
                                  p_txt_form    IN OUT M_LOAD_FORM.txt_form%TYPE,
                                  p_msg_retorno IN OUT varchar2)
                                  RETURN boolean;

-- fu_split_form_clob_lines_b
   FUNCTION fu_split_form_clob_lines_b (p_id                 M_LOAD_FORM.id%TYPE,
                                        p_msg_retorno IN OUT varchar2)
                                        RETURN boolean;

-- fu_obter_nome_form_b
   FUNCTION fu_obter_nome_form_b (p_id                   M_LOAD_FORM.id%TYPE,
                                  p_txt_form_name IN OUT varchar2,
                                  p_msg_retorno   IN OUT varchar2)
                                  RETURN boolean;

-- fu_obter_nome_form_v
   FUNCTION fu_obter_nome_form_v (p_id M_LOAD_FORM.id%TYPE)
                                  RETURN varchar2;

-- fu_txt_comments_form_level_b
   FUNCTION fu_txt_comments_form_level_b (p_id                  M_LOAD_FORM.id%TYPE,
                                          p_txt_comments IN OUT M_LOAD_FORM.txt_comments%TYPE,
                                          p_msg_retorno  IN OUT varchar2)
                                          RETURN boolean;

-- fu_txt_comments_form_level_c
   FUNCTION fu_txt_comments_form_level_c (p_id M_LOAD_FORM.id%TYPE)
                                          RETURN M_LOAD_FORM.txt_comments%TYPE;

-- fu_txt_comments_block_itm_lv_b
   FUNCTION fu_txt_comments_block_itm_lv_b (p_id_form               M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE,
                                            p_txt_block_name        M_LOAD_FORM_BLOCKS_ITEMS.txt_block_name%TYPE,
                                            p_txt_item_name         M_LOAD_FORM_BLOCKS_ITEMS.txt_item_name%TYPE default NULL,
                                            p_txt_comments   IN OUT M_LOAD_FORM_BLOCKS_ITEMS.txt_comments%TYPE,
                                            p_msg_retorno    IN OUT varchar2)
                                            RETURN boolean;

-- fu_txt_comments_block_itm_lv_c
   FUNCTION fu_txt_comments_block_itm_lv_c (p_id_form        M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE,
                                            p_txt_block_name M_LOAD_FORM_BLOCKS_ITEMS.txt_block_name%TYPE,
                                            p_txt_item_name  M_LOAD_FORM_BLOCKS_ITEMS.txt_item_name%TYPE default NULL)
                                            RETURN M_LOAD_FORM_BLOCKS_ITEMS.txt_comments%TYPE;

-- fu_generate_function_name_b
   FUNCTION fu_generate_function_name_b (p_txt_original_name         varchar2,
                                         p_txt_generated_name IN OUT varchar2,
                                         p_msg_retorno        IN OUT varchar2)
                                         RETURN boolean;

-- fu_generate_function_name_v
   FUNCTION fu_generate_function_name_v (p_txt_original_name varchar2)
                                         RETURN varchar2;

-- fu_ret_1st_occurrenc_keyword_b
   FUNCTION fu_ret_1st_occurrenc_keyword_b (p_id                         M_LOAD_FORM.id%TYPE,
                                            p_txt_internal_name_m        M_LOAD_FORM_LINES.txt_internal_name_m%TYPE,
                                            p_id_1st_occurrence   IN OUT integer,
                                            p_msg_retorno         IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_1st_occurrenc_keyword_i
   FUNCTION fu_ret_1st_occurrenc_keyword_i (p_id                  M_LOAD_FORM.id%TYPE,
                                            p_txt_internal_name_m M_LOAD_FORM_LINES.txt_internal_name_m%TYPE)
                                            RETURN integer;

-- fu_ret_plsql_form_triggers_b
   FUNCTION fu_ret_plsql_form_triggers_b (p_id                  M_LOAD_FORM.id%TYPE,
                                          p_type                varchar2,
                                          p_trigger_type        varchar2,
                                          p_msg_retorno  IN OUT varchar2)
                                          RETURN boolean;

-- fu_ret_original_name_b
   FUNCTION fu_ret_original_name_b (p_id_form            M_LOAD_FORM_LINES.id_form%TYPE,
                                    p_msg_retorno IN OUT varchar2)
                                    RETURN boolean;

-- fu_ret_id_rownum_txt_int_nam_b
   FUNCTION fu_ret_id_rownum_txt_int_nam_b (p_txt_internal_name        varchar2,
                                            p_rownum            IN OUT integer,
                                            p_msg_retorno       IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_glob_syst_par_vars_b
   FUNCTION fu_ret_glob_syst_par_vars_b (p_id_form            M_LOAD_FORM_LINES.id_form%TYPE,
                                         p_msg_retorno IN OUT varchar2)
                                         RETURN boolean;

-- fu_ret_record_group_name_b
   FUNCTION fu_ret_record_group_name_b (p_record_group_name                  varchar2,
                                        p_generated_record_group_name IN OUT varchar2,
                                        p_msg_retorno                 IN OUT varchar2)
                                        RETURN boolean;

-- fu_ret_record_group_name_v
   FUNCTION fu_ret_record_group_name_v (p_record_group_name varchar2)
                                        RETURN varchar2;

-- fu_ret_table_rec_group_name_b
   FUNCTION fu_ret_table_rec_group_name_b (p_table_rec_grp_name                varchar2,
                                           p_generated_tab_rec_grp_name IN OUT varchar2,
                                           p_msg_retorno                IN OUT varchar2)
                                           RETURN boolean;

-- fu_ret_table_rec_group_name_v
   FUNCTION fu_ret_table_rec_group_name_v (p_table_rec_grp_name varchar2)
                                           RETURN varchar2;

-- fu_ret_function_name_sys_ref_b
   FUNCTION fu_ret_function_name_sys_ref_b (p_function_name                     varchar2,
                                            p_generated_func_name_sysref IN OUT varchar2,
                                            p_msg_retorno                IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_function_name_sys_ref_v
   FUNCTION fu_ret_function_name_sys_ref_v (p_function_name varchar2)
                                            RETURN varchar2;

-- fu_ret_function_name_pipelin_b
   FUNCTION fu_ret_function_name_pipelin_b (p_function_name                       varchar2,
                                            p_generated_func_name_pipeline IN OUT varchar2,
                                            p_msg_retorno                  IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_function_name_pipelin_v
   FUNCTION fu_ret_function_name_pipelin_v (p_function_name varchar2)
                                            RETURN varchar2;

-- fu_sys_refcursor_variable_b
   FUNCTION fu_sys_refcursor_variable_b (p_variable_name                  varchar2,
                                         p_generated_variable_name IN OUT varchar2,
                                         p_msg_retorno             IN OUT varchar2)
                                         RETURN boolean;

-- fu_sys_refcursor_variable_v
   FUNCTION fu_sys_refcursor_variable_v (p_variable_name varchar2)
                                         RETURN varchar2;

-- fu_ret_piperow_variable_b
   FUNCTION fu_ret_piperow_variable_b (p_variable_name                  varchar2,
                                       p_generated_variable_name IN OUT varchar2,
                                       p_msg_retorno             IN OUT varchar2)
                                       RETURN boolean;

-- fu_ret_piperow_variable_v
   FUNCTION fu_ret_piperow_variable_v (p_variable_name varchar2)
                                       RETURN varchar2;

-- fu_ret_parameter_name_b
   FUNCTION fu_ret_parameter_name_b (p_parameter_name                  varchar2,
                                     p_generated_parameter_name IN OUT varchar2,
                                     p_msg_retorno              IN OUT varchar2)
                                     RETURN boolean;

-- fu_ret_parameter_name_v
   FUNCTION fu_ret_parameter_name_v (p_parameter_name varchar2)
                                     RETURN varchar2;

-- fu_ret_record_groups_b
   FUNCTION fu_ret_record_groups_b (p_id_form            M_LOAD_FORM_LINES.id_form%TYPE,
                                    p_type               varchar2,
                                    p_msg_retorno IN OUT varchar2)
                                    RETURN boolean;

-- fu_ret_form_list_values_b
   FUNCTION fu_ret_form_list_values_b (p_id                 M_LOAD_FORM.id%TYPE,
                                       p_msg_retorno IN OUT varchar2)
                                       RETURN boolean;

-- fu_ret_rec_group_related_lov_b
   FUNCTION fu_ret_rec_group_related_lov_b (p_id_form                     M_LOAD_FORM_LIST_VALUES.id_form%TYPE,
                                            p_txt_lov_record_group        M_LOAD_FORM_LIST_VALUES.txt_lov_record_group%TYPE,
                                            p_txt_related_lov      IN OUT varchar2,
                                            p_msg_retorno          IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_rec_group_related_lov_v
   FUNCTION fu_ret_rec_group_related_lov_v (p_id_form              M_LOAD_FORM_LIST_VALUES.id_form%TYPE,
                                            p_txt_lov_record_group M_LOAD_FORM_LIST_VALUES.txt_lov_record_group%TYPE)
                                            RETURN varchar2;

-- fu_ret_global_variable_name_b
   FUNCTION fu_ret_global_variable_name_b (p_global_variable_name        varchar2,
                                           p_variable_name        IN OUT varchar2,
                                           p_msg_retorno          IN OUT varchar2)
                                           RETURN boolean;

-- fu_ret_global_variable_name_v
   FUNCTION fu_ret_global_variable_name_v (p_global_variable_name varchar2)
                                           RETURN varchar2;

-- fu_chg_item_to_block_item_vr_b
   FUNCTION fu_chg_item_to_block_item_vr_b (p_id_form                         M_LOAD_FORM_LINES.id_form%TYPE,
                                            p_line_analysis                   varchar2,
                                            p_line_analysis_block_item IN OUT varchar2,
                                            p_msg_retorno              IN OUT varchar2)
                                            RETURN boolean;

-- fu_chg_item_to_block_item_vr_v
   FUNCTION fu_chg_item_to_block_item_vr_v (p_id_form       M_LOAD_FORM_LINES.id_form%TYPE,
                                            p_line_analysis varchar2)
                                            RETURN varchar2;

-- fu_chg_item_to_block_item_vr_c
   FUNCTION fu_chg_item_to_block_item_vr_c (p_id_form      M_LOAD_FORM_LINES.id_form%TYPE,
                                            p_clob_content clob)
                                            RETURN clob;

-- fu_ret_rec_grp_based_params_v
   FUNCTION fu_ret_rec_grp_based_params_v (p_id_form               M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE,
                                           p_txt_record_group_name M_LOAD_FORM_RECORD_GROUPS.txt_record_group_name%TYPE,
                                           p_txt_origin            varchar2)
                                           RETURN clob;

-- fu_ret_txt_multiline_b
   FUNCTION fu_ret_txt_multiline_b (p_id_form                    M_LOAD_FORM_LINES.id_form%TYPE,
                                    p_id_rownum_start            M_LOAD_FORM_LINES.id%TYPE,
                                    p_id_rownum_finish           M_LOAD_FORM_LINES.id%TYPE default 2147483648,
                                    p_txt_internal_name_m        M_LOAD_FORM_LINES.txt_internal_name_m%TYPE,
                                    p_txt_contents        IN OUT clob,
                                    p_msg_retorno         IN OUT varchar2)
                                    RETURN boolean;

-- fu_ret_txt_multiline_c
   FUNCTION fu_ret_txt_multiline_c (p_id_form             M_LOAD_FORM_LINES.id_form%TYPE,
                                    p_id_rownum_start     M_LOAD_FORM_LINES.id%TYPE,
                                    p_id_rownum_finish    M_LOAD_FORM_LINES.id%TYPE default 2147483648,
                                    p_txt_internal_name_m M_LOAD_FORM_LINES.txt_internal_name_m%TYPE)
                                    RETURN clob;

-- fu_ret_txt_multiline_v
   FUNCTION fu_ret_txt_multiline_v (p_id_form             M_LOAD_FORM_LINES.id_form%TYPE,
                                    p_id_rownum_start     M_LOAD_FORM_LINES.id%TYPE,
                                    p_id_rownum_finish    M_LOAD_FORM_LINES.id%TYPE default 2147483648,
                                    p_txt_internal_name_m M_LOAD_FORM_LINES.txt_internal_name_m%TYPE)
                                    RETURN varchar2;

-- fu_ret_form_data_blocks_b
   FUNCTION fu_ret_form_data_blocks_b (p_id                 M_LOAD_FORM.id%TYPE,
                                       p_msg_retorno IN OUT varchar2)
                                       RETURN boolean;

-- fu_ret_block_tables_columns_b
   FUNCTION fu_ret_block_tables_columns_b (p_id                 M_LOAD_FORM.id%TYPE,
                                           p_msg_retorno IN OUT varchar2)
                                           RETURN boolean;

-- fu_remove_plsql_comments_b
   FUNCTION fu_remove_plsql_comments_b (p_clob_plsql_contents                M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE,
                                        p_clob_plsql_contents_no_comm IN OUT M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents_no_comm%TYPE,
                                        p_msg_retorno                 IN OUT varchar2)
                                        RETURN boolean;

-- fu_remove_plsql_comments_c
   FUNCTION fu_remove_plsql_comments_c (p_clob_plsql_contents M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE)
                                        RETURN M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE;

-- fu_collect_pck_program_units_b
   FUNCTION fu_collect_pck_program_units_b (p_id_form                      M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_txt_plsql_object_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_plsql_object_name%TYPE,
                                            p_msg_retorno           IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_plsql_program_units_b
   FUNCTION fu_ret_plsql_program_units_b (p_id_form            M_LOAD_FORM_LINES.id_form%TYPE,
                                          p_type               varchar2,
                                          p_msg_retorno IN OUT varchar2)
                                          RETURN boolean;

-- fu_ret_txt_select_query_name_c
   FUNCTION fu_ret_txt_select_query_name_c (p_id_form               M_LOAD_FORM.id%TYPE,
                                            p_txt_record_group_name M_LOAD_FORM_RECORD_GROUPS.txt_record_group_name%TYPE)
                                            RETURN clob;

-- fu_ret_txt_select_query_name_b
   FUNCTION fu_ret_txt_select_query_name_b (p_id_form                      M_LOAD_FORM.id%TYPE,
                                            p_txt_record_group_name        M_LOAD_FORM_RECORD_GROUPS.txt_record_group_name%TYPE,
                                            p_txt_plsql_routine     IN OUT clob,
                                            p_msg_retorno           IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_txt_select_query_lovs_b
   FUNCTION fu_ret_txt_select_query_lovs_b (p_id_form                     M_LOAD_FORM.id%TYPE,
                                            p_txt_select_query_lov IN OUT M_LOAD_FORM.txt_select_query_lov%TYPE,
                                            p_msg_retorno          IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_txt_select_query_lovs_c
   FUNCTION fu_ret_txt_select_query_lovs_c (p_id_form M_LOAD_FORM.id%TYPE)
                                            RETURN M_LOAD_FORM.txt_select_query_lov%TYPE;

-- fu_ret_static_values_b
   FUNCTION fu_ret_static_values_b (p_id_form            M_LOAD_FORM_LINES.id_form%TYPE,
                                    p_msg_retorno IN OUT varchar2)
                                    RETURN boolean;

-- fu_ret_id_language_b
   FUNCTION fu_ret_id_language_b (p_txt_line           M_LOAD_FORM_LINES.txt_line%TYPE,
                                  p_id_language IN OUT M_LANGUAGES.id%TYPE,
                                  p_msg_retorno IN OUT varchar2)
                                  RETURN boolean;

-- fu_ret_id_language_i
   FUNCTION fu_ret_id_language_i (p_txt_line M_LOAD_FORM_LINES.txt_line%TYPE)
                                  RETURN M_LANGUAGES.id%TYPE;

-- fu_detect_form_language_b
   FUNCTION fu_detect_form_language_b (p_id                 M_LOAD_FORM.id%TYPE,
                                       p_id_language IN OUT M_LANGUAGES.id%TYPE,
                                       p_msg_retorno IN OUT varchar2)
                                       RETURN boolean;

-- fu_detect_form_language_i
   FUNCTION fu_detect_form_language_i (p_id M_LOAD_FORM.id%TYPE)
                                       RETURN M_LANGUAGES.id%TYPE;

-- fu_ret_txt_block_query_data__b
   FUNCTION fu_ret_txt_block_query_data__b (p_id_form                             M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE,
                                            p_txt_block_name                      M_LOAD_FORM_BLOCKS_ITEMS.txt_block_name%TYPE,
                                            p_txt_block_query_data_orig_na IN OUT M_LOAD_FORM_BLOCKS_ITEMS.txt_block_query_data_orig_name%TYPE,
                                            p_msg_retorno                  IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_txt_block_query_data__v
   FUNCTION fu_ret_txt_block_query_data__v (p_id_form        M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE,
                                            p_txt_block_name M_LOAD_FORM_BLOCKS_ITEMS.txt_block_name%TYPE)
                                            RETURN M_LOAD_FORM_BLOCKS_ITEMS.txt_block_query_data_orig_name%TYPE;

-- fu_ret_block_relations_b
   FUNCTION fu_ret_block_relations_b (p_id                 M_LOAD_FORM.id%TYPE,
                                      p_msg_retorno IN OUT varchar2)
                                      RETURN boolean;

-- fu_ret_create_form_views_c
   FUNCTION fu_ret_create_form_views_c (p_id_form        M_LOAD_FORM.id%TYPE,
                                        p_txt_block_name M_LOAD_FORM_BLOCKS_ITEMS.txt_block_name%TYPE)
                                        RETURN clob;

-- fu_ret_create_form_views_b
   FUNCTION fu_ret_create_form_views_b (p_id_form                 M_LOAD_FORM.id%TYPE,
                                        p_txt_script_views IN OUT clob,
                                        p_msg_retorno      IN OUT varchar2)
                                        RETURN boolean;

-- fu_create_alter_table_cols_b
   FUNCTION fu_create_alter_table_cols_b (p_id                 M_LOAD_FORM.id%TYPE,
                                          p_msg_retorno IN OUT varchar2)
                                          RETURN boolean;

-- fu_convert_clob_to_blob_b
   FUNCTION fu_convert_clob_to_blob_b (p_clob_content clob) RETURN blob;

-- fu_ret_clob_sql_query_no_com_b
   FUNCTION fu_ret_clob_sql_query_no_com_b (p_id_form                       M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE,
                                            p_txt_record_group_name         M_LOAD_FORM_RECORD_GROUPS.txt_record_group_name%TYPE,
                                            p_clob_sql_query_no_comm IN OUT M_LOAD_FORM_RECORD_GROUPS.clob_sql_query_no_comm%TYPE,
                                            p_msg_retorno            IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_clob_sql_query_no_com_c
   FUNCTION fu_ret_clob_sql_query_no_com_c (p_id_form               M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE,
                                            p_txt_record_group_name M_LOAD_FORM_RECORD_GROUPS.txt_record_group_name%TYPE)
                                            RETURN M_LOAD_FORM_RECORD_GROUPS.clob_sql_query_no_comm%TYPE;

-- fu_ret_clob_sql_dblck_no_com_b
   FUNCTION fu_ret_clob_sql_dblck_no_com_b (p_id_form                             M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE,
                                            p_txt_block_name                      M_LOAD_FORM_BLOCKS_ITEMS.txt_block_name%TYPE,
                                            p_txt_block_query_data_orig_cl IN OUT M_LOAD_FORM_BLOCKS_ITEMS.txt_block_query_data_orig_clob%TYPE,
                                            p_msg_retorno                  IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_clob_sql_dblck_no_com_c
   FUNCTION fu_ret_clob_sql_dblck_no_com_c (p_id_form        M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE,
                                            p_txt_block_name M_LOAD_FORM_BLOCKS_ITEMS.txt_block_name%TYPE)
                                            RETURN M_LOAD_FORM_BLOCKS_ITEMS.txt_block_query_data_orig_clob%TYPE;

-- fu_ret_rpad_variable_i
   FUNCTION fu_ret_rpad_variable_i (p_id_form           M_LOAD_FORM_GLOB_SYST_PARM.id_form%TYPE,
                                    p_txt_variable_type M_LOAD_FORM_GLOB_SYST_PARM.txt_variable_type%TYPE)
                                    RETURN integer;

-- fu_retrieve_prog_unit_header_b
   FUNCTION fu_retrieve_prog_unit_header_b (p_clob_plsql_contents        clob,
                                            p_program_unit_header IN OUT clob,
                                            p_msg_retorno         IN OUT varchar2)
                                            RETURN boolean;

-- fu_retrieve_prog_unit_header_c
   FUNCTION fu_retrieve_prog_unit_header_c (p_clob_plsql_contents clob)
                                            RETURN clob;

-- fu_ret_prog_unit_no_header_b
   FUNCTION fu_ret_prog_unit_no_header_b (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                          p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                          p_clob_plsql_contents                M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE,
                                          p_clob_plsql_contents_c       IN OUT M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE,
                                          p_msg_retorno                 IN OUT varchar2)
                                          RETURN boolean;

-- fu_ret_prog_unit_no_header_c
   FUNCTION fu_ret_prog_unit_no_header_c (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                          p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                          p_analyze_clob_with_comments  boolean default TRUE)
                                          RETURN M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE;

-- fu_ret_program_unit_header_p_v
   FUNCTION fu_ret_program_unit_header_p_v (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                            RETURN varchar2;

-- fu_ret_function_type_return_v
   FUNCTION fu_ret_function_type_return_v (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                           p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                           RETURN varchar2;

-- fu_ret_prg_unit_orig_param_l_b
   FUNCTION fu_ret_prg_unit_orig_param_l_b (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE                     default NULL,
                                            p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE default NULL,
                                            p_clob_plsql_contents                M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE         default empty_clob(),
                                            p_original_parameter_list     IN OUT varchar2,
                                            p_msg_retorno                 IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_prg_unit_orig_param_l_v
   FUNCTION fu_ret_prg_unit_orig_param_l_v (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE                     default NULL,
                                            p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE default NULL,
                                            p_clob_plsql_contents         M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE         default empty_clob())
                                            RETURN varchar2;

-- fu_ret_prg_unit_hdr_all_parm_c
   FUNCTION fu_ret_prg_unit_hdr_all_parm_c (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                            RETURN clob;

-- fu_chg_item_to_block_item_b
   FUNCTION fu_chg_item_to_block_item_b (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                         p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                         p_analyze_clob_with_comments  boolean default TRUE)
                                         RETURN clob;

-- fu_chg_item_to_block_item_c
   FUNCTION fu_chg_item_to_block_item_c (p_id_form             M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                         p_clob_plsql_contents M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE)
                                         RETURN M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE;

-- fu_ret_rec_grp_function_parm_v
   FUNCTION fu_ret_rec_grp_function_parm_v (p_id_form               M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE,
                                            p_txt_record_group_name M_LOAD_FORM_RECORD_GROUPS.txt_record_group_name%TYPE,
                                            p_txt_origin            varchar2)
                                            RETURN varchar2;

-- fu_collect_block_items_b
   FUNCTION fu_collect_block_items_b (p_id_form             M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                      p_clob_plsql_contents M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE,
                                      p_parameter_list      IN OUT clob,
                                      p_msg_retorno         IN OUT varchar2)
                                      RETURN boolean;

-- fu_collect_block_items_c
   FUNCTION fu_collect_block_items_c (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                      p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                      RETURN clob;

-- fu_collect_glob_syst_param_b
   FUNCTION fu_collect_glob_syst_param_b (p_id_form             M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                          p_clob_plsql_contents M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE,
                                          p_parameter_list      IN OUT clob,
                                          p_msg_retorno         IN OUT varchar2)
                                          RETURN boolean;

-- fu_collect_glob_syst_param_c
   FUNCTION fu_collect_glob_syst_param_c (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                          p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                          RETURN clob;

-- fu_ret_header_parameters_com_b
   FUNCTION fu_ret_header_parameters_com_b (p_clob_plsql_contents        M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE,
                                            p_parameter_list      IN OUT varchar2,
                                            p_msg_retorno         IN OUT varchar2)
                                            RETURN boolean;

-- fu_collect_original_params_b
   FUNCTION fu_collect_original_params_b (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                          p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                          p_parameter_list              IN OUT varchar2,
                                          p_msg_retorno                 IN OUT varchar2)
                                          RETURN boolean;

-- fu_collect_original_params_v
   FUNCTION fu_collect_original_params_v (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                          p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                          RETURN varchar2;

-- fu_ret_plsql_contents_params_b
   FUNCTION fu_ret_plsql_contents_params_b (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                            p_plsql_object_parameters     IN OUT clob,
                                            p_msg_retorno                 IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_plsql_contents_params_c
   FUNCTION fu_ret_plsql_contents_params_c (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE default NULL)
                                            RETURN clob;

-- fu_chg_plsql_blocks_to_parms_b
   FUNCTION fu_chg_plsql_blocks_to_parms_b (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                            p_clob_plsql_contents         IN OUT M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE,
                                            p_msg_retorno                 IN OUT varchar2)
                                            RETURN boolean;

-- fu_chg_plsql_blocks_to_parms_c
   FUNCTION fu_chg_plsql_blocks_to_parms_c (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                            p_analyze_clob_with_comments  boolean default TRUE)
                                            RETURN M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents_no_comm%TYPE;

-- fu_ret_line_disposable_plsql_b
   FUNCTION fu_ret_line_disposable_plsql_b (p_line_analysis        varchar2,
                                            p_msg_retorno   IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_line_disposable_custm_b
   FUNCTION fu_ret_line_disposable_custm_b (p_line_analysis        varchar2,
                                            p_msg_retorno   IN OUT varchar2)
                                            RETURN boolean;

-- fu_discard_prg_marked_custom_b
   FUNCTION fu_discard_prg_marked_custom_b (p_id_form            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_msg_retorno IN OUT varchar2)
                                            RETURN boolean;

-- fu_discard_invalid_trg_name_b
   FUNCTION fu_discard_invalid_trg_name_b (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                           p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                           p_msg_retorno                 IN OUT varchar2)
                                           RETURN boolean;

-- fu_discard_invalid_trg_name_v
   FUNCTION fu_discard_invalid_trg_name_v (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                           p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                           RETURN varchar2;

-- fu_discard_prg_unit_per_line_b
   FUNCTION fu_discard_prg_unit_per_line_b (p_id_form                    M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_clob_plsql_contents        M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE,
                                            p_msg_retorno         IN OUT varchar2)
                                            RETURN boolean;

-- fu_unit_per_line_disposable_b
   FUNCTION fu_unit_per_line_disposable_b (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                           p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                           p_msg_retorno                 IN OUT varchar2)
                                           RETURN boolean;

-- fu_unit_per_line_disposable_v
   FUNCTION fu_unit_per_line_disposable_v (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                           p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                           RETURN varchar2;

-- fu_discard_data_blocks_b
   FUNCTION fu_discard_data_blocks_b (p_id_form            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                      p_msg_retorno IN OUT varchar2)
                                      RETURN boolean;

-- fu_discard_prg_identify_line_b
   FUNCTION fu_discard_prg_identify_line_b (p_id_form            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_msg_retorno IN OUT varchar2)
                                            RETURN boolean;

-- fu_discard_prg_plsql_trigger_b
   FUNCTION fu_discard_prg_plsql_trigger_b (p_id_form M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_msg_retorno IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_max_length_param_b
   FUNCTION fu_ret_max_length_param_b (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                       p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                       p_length_param                IN OUT integer,
                                       p_msg_retorno                 IN OUT varchar2)
                                       RETURN boolean;

-- fu_ret_max_length_param_i
   FUNCTION fu_ret_max_length_param_i (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                       p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                       RETURN integer;

-- fu_create_oracle_apex_calls_b
   FUNCTION fu_create_oracle_apex_calls_b (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                           p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                           p_txt_oracle_apex_plsql_calls IN OUT M_LOAD_FORM.txt_oracle_apex_plsql_calls%TYPE,
                                           p_msg_retorno                 IN OUT varchar2)
                                           RETURN boolean;

-- fu_create_oracle_apex_calls_c
   FUNCTION fu_create_oracle_apex_calls_c (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                           p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                           RETURN M_LOAD_FORM.txt_oracle_apex_plsql_calls%TYPE;

-- fu_generate_oracle_apex_call_c
   FUNCTION fu_generate_oracle_apex_call_c (p_id_form M_LOAD_FORM.id%TYPE)
                                            RETURN M_LOAD_FORM.txt_oracle_apex_plsql_calls%TYPE;

-- fu_generate_disposa_routines_c
   FUNCTION fu_generate_disposa_routines_c (p_id_form M_LOAD_FORM.id%TYPE)
                                            RETURN M_LOAD_FORM.txt_disposed_content%TYPE;

-- fu_generate_disposa_routines_b
   FUNCTION fu_generate_disposa_routines_b (p_id_form                     M_LOAD_FORM.id%TYPE,
                                            p_txt_disposed_content IN OUT M_LOAD_FORM.txt_disposed_content%TYPE,
                                            p_msg_retorno          IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_txt_record_groups_spc_b
   FUNCTION fu_ret_txt_record_groups_spc_b (p_id_form                 M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE,
                                            p_txt_record_group IN OUT clob,
                                            p_msg_retorno      IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_txt_record_groups_spc_c
   FUNCTION fu_ret_txt_record_groups_spc_c (p_id_form M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE)
                                            RETURN clob;

-- fu_ret_txt_record_groups_bdy_b
   FUNCTION fu_ret_txt_record_groups_bdy_b (p_id_form                 M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE,
                                            p_txt_record_group IN OUT clob,
                                            p_msg_retorno      IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_txt_record_groups_bdy_c
   FUNCTION fu_ret_txt_record_groups_bdy_c (p_id_form M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE)
                                            RETURN clob;

-- fu_ret_txt_frm_parameter_lst_c
   FUNCTION fu_ret_txt_frm_parameter_lst_c (p_id M_LOAD_FORM.id%TYPE)
                                            RETURN clob;

-- fu_ret_txt_frm_parameter_lst_b
   FUNCTION fu_ret_txt_frm_parameter_lst_b (p_id                           M_LOAD_FORM.id%TYPE,
                                            p_txt_frm_parameter_lst IN OUT clob,
                                            p_msg_retorno           IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_txt_frm_blk_itm_spc_c
   FUNCTION fu_ret_txt_frm_blk_itm_spc_c (p_id M_LOAD_FORM.id%TYPE)
                                          RETURN clob;

-- fu_ret_txt_frm_blk_itm_spc_b
   FUNCTION fu_ret_txt_frm_blk_itm_spc_b (p_id                         M_LOAD_FORM.id%TYPE,
                                          p_txt_frm_blk_itm_spc IN OUT clob,
                                          p_msg_retorno         IN OUT varchar2)
                                          RETURN boolean;

-- fu_ret_txt_program_units_spc_c
   FUNCTION fu_ret_txt_program_units_spc_c (p_id M_LOAD_FORM.id%TYPE)
                                            RETURN clob;

-- fu_ret_txt_program_units_spc_b
   FUNCTION fu_ret_txt_program_units_spc_b (p_id                           M_LOAD_FORM.id%TYPE,
                                            p_txt_program_units_spc IN OUT clob,
                                            p_msg_retorno           IN OUT varchar2)
                                            RETURN boolean;

-- fu_ret_txt_global_variables_c
   FUNCTION fu_ret_txt_global_variables_c (p_id M_LOAD_FORM.id%TYPE)
                                           RETURN clob;

-- fu_ret_txt_global_variables_b
   FUNCTION fu_ret_txt_global_variables_b (p_id                          M_LOAD_FORM.id%TYPE,
                                           p_txt_global_variables IN OUT clob,
                                           p_msg_retorno          IN OUT varchar2)
                                           RETURN boolean;

-- fu_ret_txt_system_variables_c
   FUNCTION fu_ret_txt_system_variables_c (p_id M_LOAD_FORM.id%TYPE)
                                           RETURN clob;

-- fu_ret_txt_system_variables_b
   FUNCTION fu_ret_txt_system_variables_b (p_id                          M_LOAD_FORM.id%TYPE,
                                           p_txt_system_variables IN OUT clob,
                                           p_msg_retorno          IN OUT varchar2)
                                           RETURN boolean;

-- fu_ret_txt_frm_blk_itm_bdy_c
   FUNCTION fu_ret_txt_frm_blk_itm_bdy_c (p_id M_LOAD_FORM.id%TYPE)
                                          RETURN clob;

-- fu_ret_txt_frm_blk_itm_bdy_b
   FUNCTION fu_ret_txt_frm_blk_itm_bdy_b (p_id                         M_LOAD_FORM.id%TYPE,
                                          p_txt_frm_blk_itm_bdy IN OUT clob,
                                          p_msg_retorno         IN OUT varchar2)
                                          RETURN boolean;

-- fu_ret_txt_program_units_bdy_c
   FUNCTION fu_ret_txt_program_units_bdy_c (p_id M_LOAD_FORM.id%TYPE)
                                            RETURN clob;

-- fu_ret_txt_program_units_bdy_b
   FUNCTION fu_ret_txt_program_units_bdy_b (p_id                           M_LOAD_FORM.id%TYPE,
                                            p_txt_program_units_bdy IN OUT clob,
                                            p_msg_retorno           IN OUT varchar2)
                                            RETURN boolean;

-- fu_generate_proposed_plsql_b
   FUNCTION fu_generate_proposed_plsql_b (p_id                 M_LOAD_FORM.id%TYPE,
                                          p_msg_retorno IN OUT varchar2)
                                          RETURN boolean;

-- fu_clean_global_temp_tables_b
   FUNCTION fu_clean_global_temp_tables_b (p_id                 M_LOAD_FORM.id%TYPE,
                                           p_msg_retorno IN OUT varchar2)
                                           RETURN boolean;

-- fu_count_txt_internal_name_p_b
   FUNCTION fu_count_txt_internal_name_p_b (p_id                 M_LOAD_FORM.id%TYPE,
                                            p_count       IN OUT integer,
                                            p_msg_retorno IN OUT varchar2)
                                            RETURN boolean;

-- fu_collect_form_data_b
   FUNCTION fu_collect_form_data_b (p_id                 M_LOAD_FORM.id%TYPE,
                                    p_msg_retorno IN OUT varchar2)
                                    RETURN boolean;

-- fu_generate_files_from_form_b
   FUNCTION fu_generate_files_from_form_b (p_id                 M_LOAD_FORM.id%TYPE,
                                           p_msg_retorno IN OUT varchar2)
                                           RETURN boolean;
END pkg_import_form;
/

CREATE OR REPLACE PACKAGE BODY pkg_import_form is
-- fu_form_lines_p
   FUNCTION fu_form_lines_p (p_id M_LOAD_FORM.id%TYPE)
                             RETURN p_form_lines PIPELINED IS
      p_txt_form            M_LOAD_FORM.txt_form%TYPE := NULL;
      p_retorno             boolean         := NULL;
      p_count               integer         := 0;
      p_amount              number          := 32767;
      p_len                 number          := NULL;
      p_offset              number          := 1;
      p_prc_name            varchar2(1000)  := p_pck_name || 'fu_form_lines_p (' || p_id || '): ';
      p_msg_retorno         varchar2(4000)  := NULL;
      p_txt_line_m          varchar2(32767) := NULL;
      p_txt_line_p          varchar2(32767) := NULL;
      p_buf                 varchar2(32767) := NULL;
      p_txt_internal_name_m varchar2(32767) := NULL;
      p_txt_internal_name_p varchar2(32767) := NULL;
      r_form_lines t_form_lines;

   BEGIN
      if p_id is NULL then
         raise_application_error (-20001, 'Erro ' || p_prc_name || 'o ID do form importado deve ser informado.');
      else
         p_retorno := PKG_IMPORT_FORM.fu_return_txt_form_b (p_id, p_txt_form, p_msg_retorno);

         if p_retorno != TRUE then
            raise_application_error (-20001, 'Erro P_RETORNO 1 em ' || p_prc_name || p_msg_retorno);
         end if;

         if p_txt_form is not NULL then
            p_len := DBMS_LOB.getlength (p_txt_form);

            while p_offset < p_len loop
               p_count  := p_count + 1;
               p_amount := least (DBMS_LOB.instr (p_txt_form, chr(10), p_offset) - p_offset, 32767);

               if p_amount > 0 then
                  DBMS_LOB.read (p_txt_form, p_amount, p_offset, p_buf);
                  p_offset := p_offset + p_amount + 1;
               else
                  p_buf    := NULL;
                  p_offset := p_offset + 1;
               end if;

               p_txt_line_m          := NULL;
               p_txt_line_p          := NULL;
               p_txt_internal_name_m := NULL;
               p_txt_internal_name_p := NULL;

               if substr (trim (p_buf), 1, 2) in ('* ', '- ', '^ ', 'o ') then
                  if instr (trim (p_buf), '  ') = 0 then
                     p_txt_line_m := trim (translate (trim (substr (trim (p_buf), 2)), chr(9), ' '));
                  else
                     p_txt_line_m := trim (translate (trim (substr (trim (p_buf), 2, instr (trim (p_buf), '  '))), chr(9), ' '));
                     p_txt_line_p := trim (upper (translate (trim (substr (trim (p_buf), instr (trim (p_buf), '  '))), chr(9), ' ')));
                  end if;

                  if p_txt_line_m is not NULL then
                     p_retorno := PKG_M_FORM_KEYWORDS.fu_ret_txt_internal_name_b (p_txt_line_m,
                                                                                  PKG_IMPORT_FORM.p_id_language,
                                                                                  p_txt_internal_name_m,
                                                                                  p_msg_retorno);

                     if p_retorno != TRUE then
                        raise_application_error (-20002, 'Erro P_RETORNO 2 em ' || p_prc_name || p_msg_retorno);
                     end if;
                  end if;

                  if p_txt_line_p is not NULL then
                     p_retorno := PKG_M_FORM_KEYWORDS_VALUES.fu_ret_txt_internal_name_b (p_txt_line_p,
                                                                                         PKG_IMPORT_FORM.p_id_language,
                                                                                         p_txt_internal_name_p,
                                                                                         p_msg_retorno);

                     if p_retorno != TRUE then
                        raise_application_error (-20003, 'Erro P_RETORNO 3 em ' || p_prc_name || p_msg_retorno);
                     end if;
                  end if;
               end if;

               r_form_lines.id                  := p_id;
               r_form_lines.id_rownum           := p_count;
               r_form_lines.txt_line            := p_buf;
               r_form_lines.txt_line_m          := p_txt_line_m;
               r_form_lines.txt_line_p          := p_txt_line_p;
               r_form_lines.txt_internal_name_m := p_txt_internal_name_m;
               r_form_lines.txt_internal_name_p := p_txt_internal_name_p;

               pipe row (r_form_lines);
            end loop;
         end if;
      end if;

   EXCEPTION
      when others then
         raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
   END fu_form_lines_p;

-- fu_informed_dir_exists_b
   FUNCTION fu_informed_dir_exists_b (p_directory_name        ALL_DIRECTORIES.directory_name%TYPE,
                                      p_msg_retorno    IN OUT varchar2)
                                      RETURN boolean IS
      p_existe   integer        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_informed_dir_exists_b (' || p_directory_name || '): ';

   BEGIN
      if trim (p_directory_name) is NULL then
         p_msg_retorno := 'O nome do diretório na tabela ALL_DIRECTORIES deve ser informado.';
         return FALSE;
      else
         BEGIN
            select 1
              into p_existe
              from all_directories ad
             where trim (upper (ad.directory_name)) = trim (upper (p_directory_name));

         EXCEPTION
            when no_data_found then
               p_msg_retorno := 'O diretório informado não foi encontrado na tabela ALL_DIRECTORIES.';
               return FALSE;
            when others then
               p_msg_retorno := 'Erro SELECT AD em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_informed_dir_exists_b;

-- fu_loaded_form_blob_to_clob_b
   FUNCTION fu_loaded_form_blob_to_clob_b (p_txt_form_blob        M_LOAD_FORM.txt_form_blob%TYPE,
                                           p_txt_form      IN OUT M_LOAD_FORM.txt_form%TYPE,
                                           p_msg_retorno   IN OUT varchar2)
                                           RETURN boolean IS
      v_start    pls_integer    := 1;
      v_buffer   pls_integer    := 32767;
      v_varchar  varchar2(32767);
      p_prc_name varchar2(1000) := p_pck_name || 'fu_loaded_form_blob_to_clob_b: ';

   BEGIN
      if DBMS_LOB.getlength (p_txt_form_blob) > 0 then
         BEGIN
            DBMS_LOB.createtemporary (p_txt_form, TRUE);

            for i in 1..ceil (DBMS_LOB.getlength (p_txt_form_blob) / v_buffer) loop
               v_varchar := UTL_RAW.cast_to_varchar2 (DBMS_LOB.substr (p_txt_form_blob, v_buffer, v_start));
               DBMS_LOB.writeappend (p_txt_form, length (v_varchar), v_varchar);
               v_start := v_start + v_buffer;
            end loop;

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro DBMS_LOB 2 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

--       DBMS_LOB.freetemporary (p_txt_form);
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_loaded_form_blob_to_clob_b;

-- fu_loaded_form_blob_to_clob_c
   FUNCTION fu_loaded_form_blob_to_clob_c (p_txt_form_blob        M_LOAD_FORM.txt_form_blob%TYPE,
                                           p_msg_retorno   IN OUT varchar2)
                                           RETURN M_LOAD_FORM.txt_form%TYPE IS
      p_txt_form M_LOAD_FORM.txt_form%TYPE := empty_clob();
      p_retorno  boolean        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_loaded_form_blob_to_clob_c: ';

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_loaded_form_blob_to_clob_b (p_txt_form_blob, p_txt_form, p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_form;
      else
         return p_msg_retorno;
      end if;

      return p_txt_form;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_loaded_form_blob_to_clob_c;

-- fu_form_lines_from_clob_b
   FUNCTION fu_form_lines_from_clob_b (p_id                 M_LOAD_FORM.id%TYPE,
                                       p_msg_retorno IN OUT varchar2)
                                       RETURN boolean IS
      cursor c_load_form (p_id integer) is
         select t.*
           from table (PKG_IMPORT_FORM.fu_form_lines_p (p_id => p_id)) t
          where t.id = p_id
          order by t.id;

      r_load_form c_load_form%ROWTYPE := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_form_lines_from_clob_b (' || p_id || '): ';

   BEGIN
      if p_id is not NULL then
         for r_load_form in c_load_form (p_id) loop
            BEGIN
               insert into m_load_form_lines (id_form,
                                              id_rownum,
                                              txt_line)
                                      values (p_id,
                                              r_load_form.id_rownum,
                                              r_load_form.txt_line);

            EXCEPTION
               when others then
                  p_msg_retorno := 'Erro INSERT MLFL (' || p_id || ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                  return FALSE;
            END;
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_form_lines_from_clob_b;

-- fu_import_form_from_dir_b
   FUNCTION fu_import_form_from_dir_b (p_directory_name           ALL_DIRECTORIES.directory_name%TYPE,
                                       p_txt_original_file        M_LOAD_FORM.txt_original_file%TYPE,
                                       p_msg_retorno       IN OUT varchar2)
                                       RETURN boolean IS
      p_id           M_LOAD_FORM.id%TYPE           := NULL;
      p_txt_comments M_LOAD_FORM.txt_comments%TYPE := NULL;
      p_txt_form     M_LOAD_FORM.txt_form%TYPE     := NULL;
      p_bfile        bfile;
      p_retorno      boolean        := NULL;
      p_dest_offset  integer        := 1;
      p_src_offset   integer        := 1;
      p_warning      integer        := NULL;
      p_lang_context integer        := DBMS_LOB.default_lang_ctx;
      p_prc_name     varchar2(1000) := p_pck_name || 'fu_import_form_from_dir_b (' || p_directory_name || ', ' || p_txt_original_file || '): ';

   BEGIN
      if    trim (p_directory_name) is NULL then
         p_msg_retorno := 'O nome do diretório na tabela ALL_DIRECTORIES deve ser informado.';
         return FALSE;
      elsif trim (p_txt_original_file) is NULL then
         p_msg_retorno := 'O nome do arquivo armazenado no diretório deve ser informado.';
         return FALSE;
      else
         p_retorno := PKG_IMPORT_FORM.fu_informed_dir_exists_b (p_directory_name, p_msg_retorno);

         if p_retorno != TRUE then
            return p_retorno;
         end if;

         BEGIN
            insert into m_load_form (txt_original_file,
                                     txt_form)
                             values (p_txt_original_file,
                                     empty_clob())
                          returning txt_form,
                                    id
                               into p_txt_form,
                                    p_id;

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro INSERT MLF em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

         p_bfile := bfilename (p_directory_name, p_txt_original_file);

         if p_id is not NULL then
            BEGIN
               DBMS_LOB.fileopen (p_bfile);

               DBMS_LOB.loadclobfromfile (p_txt_form,                   -- dest_lob       IN OUT NOCOPY   NOCOPY CLOB CHARACTER SET ANY_CS
                                          p_bfile,                      -- src_bfile      IN              BFILE
                                          DBMS_LOB.getlength (p_bfile), -- amount         IN              INTEGER
                                          p_dest_offset,                -- dest_offset    IN OUT          INTEGER
                                          p_src_offset,                 -- src_offset     IN OUT          INTEGER
                                          DBMS_LOB.default_csid,        -- bfile_csid     IN              NUMBER
                                          p_lang_context,               -- lang_context   IN OUT          INTEGER
                                          p_warning);                   -- warning        OUT             INTEGER

               DBMS_LOB.fileclose (p_bfile);

            EXCEPTION
               when others then
                  p_msg_retorno := 'Erro DBMS_LOB 1 (P_ID = ' || p_id || ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                  return FALSE;
            END;

            p_retorno := PKG_IMPORT_FORM.fu_form_lines_from_clob_b (p_id, p_msg_retorno);

            if p_retorno = TRUE then
               commit;

               p_txt_comments := PKG_IMPORT_FORM.fu_ret_txt_multiline_c (p_id_form             => p_id,
                                                                         p_id_rownum_start     => 3,
                                                                         p_txt_internal_name_m => 'HELP_BOOK_TITLE');

               if trim (p_txt_comments) is not NULL then
                  BEGIN
                     update m_load_form mlf
                        set mlf.txt_comments = p_txt_comments
                      where mlf.id           = p_id;

                  EXCEPTION
                     when others then
                        p_msg_retorno := 'Erro UPDATE MLF 1 (P_ID = ' || p_id || ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                        return FALSE;
                  END;
               end if;
            else
               return p_retorno;
            end if;
         end if;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_import_form_from_dir_b;

-- fu_existe_id_form_b
   FUNCTION fu_existe_id_form_b (p_id                 M_LOAD_FORM.id%TYPE,
                                 p_msg_retorno IN OUT varchar2)
                                 RETURN boolean IS
      p_existe   integer        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_existe_id_form_b (' || p_id || '): ';

   BEGIN
      if p_id is NULL then
         p_msg_retorno := 'O ID do form carregado deve ser informado.';
         return FALSE;
      else
         BEGIN
            select 1
              into p_existe
              from m_load_form mlf
             where mlf.id = p_id;

         EXCEPTION
            when no_data_found then
               p_msg_retorno := 'O ID informado não foi encontrado.';
               return FALSE;
            when others then
               p_msg_retorno := 'Erro SELECT MLF 3 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_existe_id_form_b;

-- fu_return_txt_form_b
   FUNCTION fu_return_txt_form_b (p_id                 M_LOAD_FORM.id%TYPE,
                                  p_txt_form    IN OUT M_LOAD_FORM.txt_form%TYPE,
                                  p_msg_retorno IN OUT varchar2)
                                  RETURN boolean IS
      p_retorno  boolean        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_return_txt_form_b (' || p_id || '): ';

   BEGIN
      if p_id is NULL then
         p_msg_retorno := 'O ID do form carregado deve ser informado.';
         return FALSE;
      else
         p_retorno := PKG_IMPORT_FORM.fu_existe_id_form_b (p_id, p_msg_retorno);

         if p_retorno != TRUE then
            return p_retorno;
         end if;

         BEGIN
            select mlf.txt_form
              into p_txt_form
              from m_load_form mlf
             where mlf.id = p_id;

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro SELECT MLF 4 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_return_txt_form_b;

-- fu_split_form_clob_lines_b
   FUNCTION fu_split_form_clob_lines_b (p_id                 M_LOAD_FORM.id%TYPE,
                                        p_msg_retorno IN OUT varchar2)
                                        RETURN boolean IS
      p_txt_form M_LOAD_FORM.txt_form%TYPE := NULL;
      p_retorno  boolean        := NULL;
      p_amount   number         := 32767;
      p_len      number         := NULL;
      p_offset   number         := 1;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_split_form_clob_lines_b (' || p_id || '): ';
      p_buf      varchar2(32767);

   BEGIN
      if p_id is NULL then
         p_msg_retorno := 'O ID do form carregado deve ser informado.';
         return FALSE;
      else
         p_retorno := PKG_IMPORT_FORM.fu_return_txt_form_b (p_id, p_txt_form, p_msg_retorno);

         if p_retorno != TRUE then
            return p_retorno;
         end if;

         if p_txt_form is not NULL then
            p_len := DBMS_LOB.getlength (p_txt_form);

            while p_offset < p_len loop
               p_amount := least (DBMS_LOB.instr (p_txt_form, chr(10), p_offset) - p_offset, 32767);

               if p_amount > 0 then
                  DBMS_LOB.read (p_txt_form, p_amount, p_offset, p_buf);
                  p_offset := p_offset + p_amount + 1;
               else
                  p_buf    := NULL;
                  p_offset := p_offset + 1;
               end if;

               DBMS_OUTPUT.put_line (p_buf);
            end loop;
         end if;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_split_form_clob_lines_b;

-- fu_obter_nome_form_b
   FUNCTION fu_obter_nome_form_b (p_id                   M_LOAD_FORM.id%TYPE,
                                  p_txt_form_name IN OUT varchar2,
                                  p_msg_retorno   IN OUT varchar2)
                                  RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_obter_nome_form_b (' || p_id || '): ';

   BEGIN
      if p_id is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
         return FALSE;
      else
         BEGIN
            select lower (substr (mlf.txt_original_file, 1, instr (mlf.txt_original_file, '.') - 1)) as txt_form_name
              into p_txt_form_name
              from m_load_form mlf
             where mlf.id = p_id;

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro SELECT MLF 5 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

         if p_txt_form_name is NULL then
            BEGIN
               select trim (substr (mlfl.txt_line, instr (mlfl.txt_line, '  '))) as txt_form_name
                 into p_txt_form_name
                 from m_load_form_lines mlfl
                where mlfl.id_form   = p_id
                  and mlfl.id_rownum = 1;

            EXCEPTION
               when others then
                  p_msg_retorno := 'Erro SELECT MLFL em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                  return FALSE;
            END;
         end if;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_obter_nome_form_b;

-- fu_obter_nome_form_v
   FUNCTION fu_obter_nome_form_v (p_id M_LOAD_FORM.id%TYPE)
                                  RETURN varchar2 IS
      p_retorno       boolean        := NULL;
      p_prc_name      varchar2(1000) := p_pck_name || 'fu_obter_nome_form_v (' || p_id || '): ';
      p_msg_retorno   varchar2(4000) := NULL;
      p_txt_form_name varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_obter_nome_form_b (p_id, p_txt_form_name, p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_form_name;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_obter_nome_form_v;

-- fu_txt_comments_form_level_b
   FUNCTION fu_txt_comments_form_level_b (p_id                  M_LOAD_FORM.id%TYPE,
                                          p_txt_comments IN OUT M_LOAD_FORM.txt_comments%TYPE,
                                          p_msg_retorno  IN OUT varchar2)
                                          RETURN boolean IS
      p_txt_comments_e M_LOAD_FORM.txt_comments%TYPE := empty_clob();
      p_instr_chr_10   integer        := NULL;
      p_prc_name       varchar2(1000) := p_pck_name || 'fu_txt_comments_form_level_b (' || p_id || '): ';
      p_line_analysis  varchar2(4000) := NULL;

   BEGIN
      if p_id is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
         return FALSE;
      else
         BEGIN
            select mlf.txt_comments
              into p_txt_comments_e
              from m_load_form mlf
             where mlf.id = p_id;

         EXCEPTION
            when no_data_found then
               p_txt_comments_e := empty_clob();
            when others then
               p_msg_retorno  := 'Erro SELECT MLF 1 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

         if p_txt_comments_e != empty_clob() then
            loop
               p_instr_chr_10   := instr (p_txt_comments_e, chr(10));
               exit when p_instr_chr_10 = 0; -- EXITS LOOP WHEN NO NEW LINES ARE FOUND (NO MORE PL/SQL CONTENTS)

               p_line_analysis  := '-- ' || rtrim (substr (p_txt_comments_e, 1, p_instr_chr_10));
               p_txt_comments_e := substr (p_txt_comments_e, p_instr_chr_10 + 1);
               p_txt_comments   := p_txt_comments || p_line_analysis;
            end loop;
         end if;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_txt_comments_form_level_b;

-- fu_txt_comments_form_level_c
   FUNCTION fu_txt_comments_form_level_c (p_id M_LOAD_FORM.id%TYPE)
                                          RETURN M_LOAD_FORM.txt_comments%TYPE IS
      p_txt_comments M_LOAD_FORM.txt_comments%TYPE := empty_clob();
      p_retorno     boolean        := NULL;
      p_prc_name    varchar2(1000) := p_pck_name || 'fu_txt_comments_form_level_c (' || p_id || '): ';
      p_msg_retorno varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_txt_comments_form_level_b (p_id, p_txt_comments, p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_comments;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_txt_comments_form_level_c;

-- fu_txt_comments_block_itm_lv_b
   FUNCTION fu_txt_comments_block_itm_lv_b (p_id_form               M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE,
                                            p_txt_block_name        M_LOAD_FORM_BLOCKS_ITEMS.txt_block_name%TYPE,
                                            p_txt_item_name         M_LOAD_FORM_BLOCKS_ITEMS.txt_item_name%TYPE default NULL,
                                            p_txt_comments   IN OUT M_LOAD_FORM_BLOCKS_ITEMS.txt_comments%TYPE,
                                            p_msg_retorno    IN OUT varchar2)
                                            RETURN boolean IS
      p_txt_comments_e M_LOAD_FORM_BLOCKS_ITEMS.txt_comments%TYPE := empty_clob();
      p_instr_chr_10   integer        := NULL;
      p_prc_name       varchar2(1000) := p_pck_name || 'fu_txt_comments_block_itm_lv_b (' || p_id_form || ', ' || p_txt_block_name || ', ' || p_txt_item_name || '): ';
      p_line_analysis  varchar2(4000) := NULL;

   BEGIN
      if p_id_form is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
         return FALSE;
      elsif p_txt_block_name is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o nome do bloco deve ser informado.';
         return FALSE;
      else
         BEGIN
            select mlfbi.txt_comments
              into p_txt_comments_e
              from m_load_form_blocks_items mlfbi
             where mlfbi.id_form         = p_id_form
               and mlfbi.txt_data_origin = 'BLOCKS AND ITEMS'
               and ((trim (p_txt_item_name) is     NULL and mlfbi.txt_block_name = trim (upper (p_txt_block_name)) and mlfbi.txt_item_name is NULL)
                 or (trim (p_txt_item_name) is not NULL and mlfbi.txt_block_name = trim (upper (p_txt_block_name)) and mlfbi.txt_item_name = trim (upper (p_txt_item_name))));

         EXCEPTION
            when no_data_found then
               p_txt_comments_e := empty_clob();
            when others then
               p_msg_retorno    := 'Erro SELECT MLFBI 3 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

         if p_txt_comments_e != empty_clob() then
            loop
               p_instr_chr_10   := instr (p_txt_comments_e, chr(10));
               exit when p_instr_chr_10 = 0; -- EXITS LOOP WHEN NO NEW LINES ARE FOUND (NO MORE PL/SQL CONTENTS)

               p_line_analysis  := '-- ' || rtrim (substr (p_txt_comments_e, 1, p_instr_chr_10));
               p_txt_comments_e := substr (p_txt_comments_e, p_instr_chr_10 + 1);
               p_txt_comments   := p_txt_comments || p_line_analysis;
            end loop;
         end if;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_txt_comments_block_itm_lv_b;

-- fu_txt_comments_block_itm_lv_c
   FUNCTION fu_txt_comments_block_itm_lv_c (p_id_form        M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE,
                                            p_txt_block_name M_LOAD_FORM_BLOCKS_ITEMS.txt_block_name%TYPE,
                                            p_txt_item_name  M_LOAD_FORM_BLOCKS_ITEMS.txt_item_name%TYPE default NULL)
                                            RETURN M_LOAD_FORM_BLOCKS_ITEMS.txt_comments%TYPE IS
      p_txt_comments M_LOAD_FORM_BLOCKS_ITEMS.txt_comments%TYPE := empty_clob();
      p_retorno     boolean        := NULL;
      p_prc_name    varchar2(1000) := p_pck_name || 'fu_txt_comments_block_itm_lv_c (' || p_id_form || ', ' || p_txt_block_name || ', ' || p_txt_item_name || '): ';
      p_msg_retorno varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_txt_comments_block_itm_lv_b (p_id_form, p_txt_block_name, p_txt_item_name, p_txt_comments, p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_comments;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_txt_comments_block_itm_lv_c;

-- fu_generate_function_name_b
   FUNCTION fu_generate_function_name_b (p_txt_original_name         varchar2,
                                         p_txt_generated_name IN OUT varchar2,
                                         p_msg_retorno        IN OUT varchar2)
                                         RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_generate_function_name_b (' || p_txt_original_name || '): ';

   BEGIN
      if trim (p_txt_original_name) is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o nome original deve ser informado.';
         return FALSE;
      else
         p_txt_generated_name := substr (lower (trim (PKG_IMPORT_FORM.p_prefix)) || replace (lower (trim (p_txt_original_name)), '-', '_'),
                                         1,
                                         PKG_IMPORT_FORM.p_oracle_objects_size - length ('_' || trim (to_char (PKG_IMPORT_FORM.p_plsql_count, '0000'))
                                         || lower (trim (p_suffix))))
                                 || '_' || trim (to_char (PKG_IMPORT_FORM.p_plsql_count, '0000')) || lower (trim (p_suffix));
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_generate_function_name_b;

-- fu_generate_function_name_v
   FUNCTION fu_generate_function_name_v (p_txt_original_name varchar2)
                                         RETURN varchar2 IS
      p_retorno            boolean        := NULL;
      p_txt_generated_name varchar2(30)   := NULL;
      p_prc_name           varchar2(1000) := p_pck_name || 'fu_generate_function_name_v (' || p_txt_original_name || '): ';
      p_msg_retorno        varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_generate_function_name_b (p_txt_original_name, p_txt_generated_name, p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_generated_name;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_generate_function_name_v;

-- fu_ret_1st_occurrenc_keyword_b
   FUNCTION fu_ret_1st_occurrenc_keyword_b (p_id                         M_LOAD_FORM.id%TYPE,
                                            p_txt_internal_name_m        M_LOAD_FORM_LINES.txt_internal_name_m%TYPE,
                                            p_id_1st_occurrence   IN OUT integer,
                                            p_msg_retorno         IN OUT varchar2)
                                            RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_1st_occurrenc_keyword_b (' || p_id || ', ' || p_txt_internal_name_m || '): ';

   BEGIN
      if    p_id is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
         return FALSE;
      elsif trim (p_txt_internal_name_m) is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'a palavra-chave a pesquisar deve ser informada.';
         return FALSE;
      else
         BEGIN
            select id_rownum
              into p_id_1st_occurrence
              from (select mlfl.id_rownum
                      from m_load_form_lines mlfl
                     where mlfl.id_form             = p_id
                       and mlfl.txt_internal_name_m = trim (upper (p_txt_internal_name_m))
                     order by mlfl.id)
             where rownum = 1;

         EXCEPTION
            when no_data_found then
               p_msg_retorno := 'Erro ' || p_prc_name || 'o ID e/ou a palavra-chave informada não foram encontrados.';
               return FALSE;
            when others then
               p_msg_retorno := 'Erro SELECT MLFL em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_1st_occurrenc_keyword_b;

-- fu_ret_1st_occurrenc_keyword_i
   FUNCTION fu_ret_1st_occurrenc_keyword_i (p_id                  M_LOAD_FORM.id%TYPE,
                                            p_txt_internal_name_m M_LOAD_FORM_LINES.txt_internal_name_m%TYPE)
                                            RETURN integer IS
      p_retorno           boolean        := NULL;
      p_id_1st_occurrence integer        := NULL;
      p_prc_name          varchar2(1000) := p_pck_name || 'fu_ret_1st_occurrenc_keyword_i (' || p_id || ', ' || p_txt_internal_name_m || '): ';
      p_msg_retorno       varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_1st_occurrenc_keyword_b (p_id, p_txt_internal_name_m, p_id_1st_occurrence, p_msg_retorno);

      if p_retorno = TRUE then
         return p_id_1st_occurrence;
      else
         return NULL;
      end if;

   EXCEPTION
      when others then
         return NULL;
   END fu_ret_1st_occurrenc_keyword_i;

-- fu_ret_plsql_form_triggers_b
   FUNCTION fu_ret_plsql_form_triggers_b (p_id                  M_LOAD_FORM.id%TYPE,
                                          p_type                varchar2,
                                          p_trigger_type        varchar2,
                                          p_msg_retorno  IN OUT varchar2)
                                          RETURN boolean IS
      p_m_load_form_plsql_contents  m_load_form_plsql_contents%ROWTYPE := NULL;
      r_imported_form               c_imported_form%ROWTYPE            := NULL;
      p_id_rownum                   M_LOAD_FORM_PLSQL_CONTENTS.id_rownum%TYPE := NULL;
      p_retorno                     boolean        := FALSE;
      p_block_item_triggers_section boolean        := FALSE;
      p_block_items_section         boolean        := FALSE;
      p_block_relations_section     boolean        := FALSE;
      p_block_section               boolean        := FALSE;
      p_block_triggers_section      boolean        := FALSE;
      p_export_plsql_contents       boolean        := FALSE;
      p_rownum_finish               integer        := NULL;
      p_rownum_start                integer        := NULL;
      p_function_name               varchar2(30)   := NULL;
      p_object_name                 varchar2(1000) := NULL;
      p_object_block_name           varchar2(1000) := NULL;
      p_object_block_item_name      varchar2(1000) := NULL;
      p_object_relation_name        varchar2(1000) := NULL;
      p_object_trigger_name         varchar2(1000) := NULL;
      p_prc_name                    varchar2(1000) := p_pck_name || 'fu_ret_plsql_form_triggers_b (' || p_id || ', ' || p_type || ', ' || p_trigger_type || '): ';

   BEGIN
      if p_id is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
         return FALSE;
      else
         if    p_trigger_type = 'FORM' then
            p_rownum_start  := PKG_IMPORT_FORM.fu_ret_1st_occurrenc_keyword_i (p_id, 'TRIGGERS');
            p_rownum_finish := PKG_IMPORT_FORM.fu_ret_1st_occurrenc_keyword_i (p_id, 'ALERTS');
         elsif p_trigger_type = 'BLOCK' then
            p_rownum_start  := PKG_IMPORT_FORM.fu_ret_1st_occurrenc_keyword_i (p_id, 'BLOCKS');
            p_rownum_finish := PKG_IMPORT_FORM.fu_ret_1st_occurrenc_keyword_i (p_id, 'CANVASES');
         end if;

         if p_rownum_start is not NULL and p_rownum_finish is not NULL and p_rownum_start < p_rownum_finish then
            for r_imported_form in c_imported_form (p_id, p_rownum_start, p_rownum_finish) loop
               p_id_rownum := r_imported_form.id_rownum;
               p_m_load_form_plsql_contents.id_rownum := r_imported_form.id_rownum;

               if p_export_plsql_contents = TRUE and p_type = 'BODY' and nvl (r_imported_form.txt_internal_name_m, '.') != 'FIRE_ENTER_QUERY_MODE' then
                  p_m_load_form_plsql_contents.clob_plsql_contents := p_m_load_form_plsql_contents.clob_plsql_contents || r_imported_form.txt_line || chr(10);
               end if;

               if    r_imported_form.txt_internal_name_m = 'NAME' then
                  p_object_name                := r_imported_form.txt_line_p;
                  p_m_load_form_plsql_contents := NULL;
               elsif r_imported_form.txt_internal_name_m = 'NAVIGATION_STYLE' then
                  p_block_item_triggers_section := FALSE;
                  p_block_items_section         := FALSE;
                  p_block_relations_section     := FALSE;
                  p_block_section               := TRUE;
                  p_block_triggers_section      := FALSE;
                  p_object_block_name           := p_object_name;
               elsif r_imported_form.txt_internal_name_m = 'ITEMS' then
                  p_block_item_triggers_section := FALSE;
                  p_block_items_section         := TRUE;
                  p_block_relations_section     := FALSE;
                  p_block_section               := FALSE;
                  p_block_triggers_section      := FALSE;
               elsif r_imported_form.txt_internal_name_m = 'ITEM_TYPE' then
                  p_block_item_triggers_section := FALSE;
                  p_block_items_section         := TRUE;
                  p_block_relations_section     := FALSE;
                  p_block_section               := FALSE;
                  p_block_triggers_section      := FALSE;
                  p_object_block_item_name      := p_object_name;
               elsif r_imported_form.txt_internal_name_m = 'RELATION_TYPE' then
                  p_block_item_triggers_section := FALSE;
                  p_block_items_section         := FALSE;
                  p_block_relations_section     := TRUE;
                  p_block_section               := FALSE;
                  p_block_triggers_section      := FALSE;
                  p_object_relation_name        := p_object_name;
               elsif r_imported_form.txt_internal_name_m = 'COMMENTS' then
                  p_m_load_form_plsql_contents.txt_comments := PKG_IMPORT_FORM.fu_ret_txt_multiline_v (p_id_form             => p_id,
                                                                                                       p_id_rownum_start     => r_imported_form.id_rownum,
                                                                                                       p_txt_internal_name_m => 'TRIGGER_STYLE');
               elsif r_imported_form.txt_internal_name_m = 'TRIGGER_STYLE' then
                  p_object_trigger_name         := p_object_name;
                  p_function_name               := PKG_IMPORT_FORM.fu_generate_function_name_v (p_object_trigger_name);
                  p_m_load_form_plsql_contents.txt_generated_function_name := p_function_name;

                  if p_block_section = TRUE then
                     p_object_block_item_name := NULL;
                  end if;
               elsif r_imported_form.txt_internal_name_m = 'TRIGGER_TEXT' then
                  p_export_plsql_contents := TRUE;
                  p_m_load_form_plsql_contents.id_form               := r_imported_form.id_form;
                  p_m_load_form_plsql_contents.txt_plsql_object_name := p_object_name;

                  if    p_object_block_name is NULL and p_object_block_item_name is NULL then
                     p_m_load_form_plsql_contents.txt_plsql_source      := 'FORM TRIGGER';
                     p_m_load_form_plsql_contents.txt_block_source      := NULL;
                     p_m_load_form_plsql_contents.txt_block_item_source := NULL;
                  elsif p_object_block_name is not NULL and p_object_block_item_name is NULL then
                     p_m_load_form_plsql_contents.txt_plsql_source      := 'BLOCK TRIGGER';
                     p_m_load_form_plsql_contents.txt_block_source      := p_object_block_name;
                  elsif p_object_block_name is not NULL and p_object_block_item_name is not NULL then
                     p_m_load_form_plsql_contents.txt_plsql_source      := 'BLOCK.ITEM TRIGGER';
                     p_m_load_form_plsql_contents.txt_block_source      := p_object_block_name;
                     p_m_load_form_plsql_contents.txt_block_item_source := p_object_block_item_name;
                  end if;

                  PKG_IMPORT_FORM.p_plsql_count := PKG_IMPORT_FORM.p_plsql_count + 1;

                  if PKG_IMPORT_FORM.p_plsql_count > 9999 then
                     PKG_IMPORT_FORM.p_plsql_count := 0;
                  end if;
               elsif r_imported_form.txt_internal_name_m = 'FIRE_ENTER_QUERY_MODE' then
                  p_export_plsql_contents := FALSE;

                  if p_m_load_form_plsql_contents.clob_plsql_contents != empty_clob() then
                     BEGIN
                        insert into m_load_form_plsql_contents values p_m_load_form_plsql_contents;

                     EXCEPTION
                        when others then
                           p_msg_retorno := 'Erro INSERT MLFPC 1 (' || p_m_load_form_plsql_contents.id_rownum ||
                                            ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                           return FALSE;
                     END;
                  end if;
               end if;
            end loop;
         end if;
      end if;

      commit;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro (ID_ROWNUM = ' || p_id_rownum || ') ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_plsql_form_triggers_b;

-- fu_ret_original_name_b
   FUNCTION fu_ret_original_name_b (p_id_form            M_LOAD_FORM_LINES.id_form%TYPE,
                                    p_msg_retorno IN OUT varchar2)
                                    RETURN boolean IS
      p_txt_original_file M_LOAD_FORM.txt_original_file%TYPE := NULL;
      p_txt_line_p        M_LOAD_FORM_LINES.txt_line_p%TYPE  := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_original_name_b (' || p_id_form || '): ';

   BEGIN
      if p_id_form is not NULL then
         BEGIN
            select mlf.txt_original_file -- ORIGINAL FILE NAME FOUND
              into p_txt_original_file
              from m_load_form mlf
             where mlf.id = p_id_form;

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro SELECT MLF 2 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

         BEGIN
            select mlfl.txt_line_p -- FORM NAME DECLARED ON ORIGINAL OBJECT LIST REPORT
              into p_txt_line_p
              from m_load_form_lines mlfl
             where mlfl.id_form             = p_id_form
--             and mlfl.txt_internal_name_m = 'NAME'
               and rownum                   = 1;

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro SELECT MLFL em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_original_name_b;

-- fu_ret_id_rownum_txt_int_nam_b
   FUNCTION fu_ret_id_rownum_txt_int_nam_b (p_txt_internal_name        varchar2,
                                            p_rownum            IN OUT integer,
                                            p_msg_retorno       IN OUT varchar2)
                                            RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_id_rownum_txt_int_nam_b (' || p_txt_internal_name || '): ';

   BEGIN
      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_id_rownum_txt_int_nam_b;

-- fu_ret_glob_syst_par_vars_b
   FUNCTION fu_ret_glob_syst_par_vars_b (p_id_form            M_LOAD_FORM_LINES.id_form%TYPE,
                                         p_msg_retorno IN OUT varchar2)
                                         RETURN boolean IS
      cursor c_global_variables (p_id_form M_LOAD_FORM_LINES.id_form%TYPE) is
         select distinct
                trim (replace (upper (mlfl.txt_line), chr(9), ' ')) as txt_line
           from m_load_form_lines mlfl
          where mlfl.id_form = p_id_form
            and upper (mlfl.txt_line) like '%:GLOBAL.%';

      cursor c_system_variables (p_id_form M_LOAD_FORM_LINES.id_form%TYPE) is
         select distinct
                trim (replace (upper (mlfl.txt_line), chr(9), ' ')) as txt_line
           from m_load_form_lines mlfl
          where mlfl.id_form = p_id_form
            and upper (mlfl.txt_line) like '%:SYSTEM.%';

      cursor c_param_variables (p_id_form M_LOAD_FORM_LINES.id_form%TYPE) is
         select mlfl.*
           from m_load_form_lines mlfl
          where mlfl.id_form   = p_id_form
            and mlfl.id_rownum between (select mlfl_1.id_rownum
                                          from m_load_form_lines mlfl_1
                                         where mlfl_1.id_form             = mlfl.id_form
                                           and mlfl_1.txt_internal_name_m = 'FORM_PARAMETERS')
                                   and (select mlfl_2.id_rownum
                                          from m_load_form_lines mlfl_2
                                         where mlfl_2.id_form             = mlfl.id_form
                                           and mlfl_2.txt_internal_name_m = 'LISTS_OF_VALUES')
          order by mlfl.id;

      p_m_load_form_glob_syst_parm m_load_form_glob_syst_parm%ROWTYPE := NULL;
      r_global_variables           c_global_variables%ROWTYPE         := NULL;
      r_param_variables            c_param_variables%ROWTYPE          := NULL;
      r_system_variables           c_system_variables%ROWTYPE         := NULL;
      p_pos                 integer        := NULL;
      p_parameter_data_type varchar2(50)   := NULL;
      p_parameter_name      varchar2(50)   := NULL;
      p_caracter            varchar2(100)  := NULL;
      p_global_variable     varchar2(300)  := NULL;
      p_param_variable      varchar2(300)  := NULL;
      p_system_variable     varchar2(300)  := NULL;
      p_global_var_tmp      varchar2(300)  := NULL;
      p_param_var_tmp       varchar2(300)  := NULL;
      p_system_var_tmp      varchar2(300)  := NULL;
      p_prc_name            varchar2(1000) := p_pck_name || 'fu_ret_glob_syst_par_vars_b (' || p_id_form || '): ';
      p_global_vars_list    varchar2(4000) := NULL;
      p_param_vars_list     varchar2(4000) := NULL;
      p_system_vars_list    varchar2(4000) := NULL;

   BEGIN
      if p_id_form is not NULL then
         BEGIN
            for r_global_variables in c_global_variables (p_id_form) loop
               p_global_var_tmp := r_global_variables.txt_line;

               loop
                  p_pos             := instr (p_global_var_tmp, ':GLOBAL.') + length (':GLOBAL.');
                  exit when instr (p_global_var_tmp, ':GLOBAL.') = 0;

                  p_global_var_tmp  := substr (p_global_var_tmp, p_pos);
                  p_global_variable := ':GLOBAL.';

                  for i in 1..length (p_global_var_tmp) loop
                     p_caracter        := substr (p_global_var_tmp, i, 1);
                     exit when p_caracter not between chr(65) and chr(90) -- A..Z
                           and p_caracter not between chr(48) and chr(57) -- 0..9
                           and p_caracter not in (chr(36), chr(95));      -- _$
                     p_global_variable := p_global_variable || p_caracter;
                  end loop;

                  if (p_global_vars_list not like ';%' || p_global_variable || '%;' and p_global_vars_list is not NULL) or p_global_vars_list is NULL then
                     p_global_vars_list := nvl (p_global_vars_list, ';') || upper (p_global_variable) || ';';

                     p_m_load_form_glob_syst_parm.id_form                := p_id_form;
                     p_m_load_form_glob_syst_parm.txt_variable_type      := 'GLOBAL';
                     p_m_load_form_glob_syst_parm.txt_variable_name      := p_global_variable;
                     p_m_load_form_glob_syst_parm.txt_variable_data_type := 'VARCHAR2';
                     p_m_load_form_glob_syst_parm.txt_variable_max_size  := 255;

                     BEGIN
                        insert into m_load_form_glob_syst_parm values p_m_load_form_glob_syst_parm;

                     EXCEPTION
                        when others then
                           p_msg_retorno := 'Erro INSERT MLFGSP 1 (' || p_m_load_form_glob_syst_parm.txt_variable_name ||
                                            ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                           return FALSE;
                     END;

                     p_m_load_form_glob_syst_parm := NULL;
                  end if;
               end loop;
            end loop;

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro FOR..LOOP 1 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

         BEGIN
            for r_system_variables in c_system_variables (p_id_form) loop
               p_system_var_tmp := r_system_variables.txt_line;

               loop
                  p_pos             := instr (p_system_var_tmp, ':SYSTEM.') + length (':SYSTEM.');
                  exit when instr (p_system_var_tmp, ':SYSTEM.') = 0;

                  p_system_var_tmp  := substr (p_system_var_tmp, p_pos);
                  p_system_variable := ':SYSTEM.';

                  for i in 1..length (p_system_var_tmp) loop
                     p_caracter        := substr (p_system_var_tmp, i, 1);
                     exit when p_caracter not between chr(65) and chr(90) -- A..Z
                           and p_caracter not between chr(48) and chr(57) -- 0..9
                           and p_caracter not in (chr(36), chr(95));      -- _$
                     p_system_variable := p_system_variable || p_caracter;
                  end loop;

                  if (p_system_vars_list not like ';%' || p_system_variable || '%;' and p_system_vars_list is not NULL) or p_system_vars_list is NULL then
                     p_system_vars_list := nvl (p_system_vars_list, ';') || upper (p_system_variable) || ';';

                     p_m_load_form_glob_syst_parm.id_form                := p_id_form;
                     p_m_load_form_glob_syst_parm.txt_variable_type      := 'SYSTEM';
                     p_m_load_form_glob_syst_parm.txt_variable_name      := p_system_variable;
                     p_m_load_form_glob_syst_parm.txt_variable_data_type := 'VARCHAR2';
                     p_m_load_form_glob_syst_parm.txt_variable_max_size  := 255;

                     BEGIN
                        insert into m_load_form_glob_syst_parm values p_m_load_form_glob_syst_parm;

                     EXCEPTION
                        when others then
                           p_msg_retorno := 'Erro INSERT MLFGSP 2 (' || p_m_load_form_glob_syst_parm.txt_variable_name ||
                                            ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                           return FALSE;
                     END;

                     p_m_load_form_glob_syst_parm := NULL;
                  end if;
               end loop;
            end loop;

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro FOR..LOOP 2 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

         BEGIN
            for r_param_variables in c_param_variables (p_id_form) loop
               if    r_param_variables.txt_internal_name_m = 'NAME' then
                  p_param_vars_list := nvl (p_param_vars_list, ';') || r_param_variables.txt_line_p || ';';
                  p_parameter_name  := r_param_variables.txt_line_p;

                  p_m_load_form_glob_syst_parm.id_form           := p_id_form;
                  p_m_load_form_glob_syst_parm.id_rownum         := r_param_variables.id_rownum;
                  p_m_load_form_glob_syst_parm.txt_variable_type := 'PARAMETER';
                  p_m_load_form_glob_syst_parm.txt_variable_name := ':PARAMETER.' || r_param_variables.txt_line_p;
               elsif r_param_variables.txt_internal_name_m = 'PARAMETER_DATA_TYPE' then
                  p_parameter_data_type := r_param_variables.txt_internal_name_p;
                  p_m_load_form_glob_syst_parm.txt_variable_data_type := r_param_variables.txt_internal_name_p;
               elsif r_param_variables.txt_internal_name_m = 'MAXIMUM_LENGTH' then
                  p_m_load_form_glob_syst_parm.txt_variable_max_size := nvl (r_param_variables.txt_line_p, 255);
               elsif r_param_variables.txt_internal_name_m = 'PARAMETER_INITIAL_VALUE' then
                  p_m_load_form_glob_syst_parm.txt_variable_ini_value := r_param_variables.txt_line_p;

                  BEGIN
                     insert into m_load_form_glob_syst_parm values p_m_load_form_glob_syst_parm;

                  EXCEPTION
                     when others then
                        p_msg_retorno := 'Erro INSERT MLFGSP 3 (' || p_m_load_form_glob_syst_parm.txt_variable_name ||
                                         ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                        return FALSE;
                  END;

                  p_m_load_form_glob_syst_parm := NULL;
               end if;
            end loop;

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro FOR..LOOP 3 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      commit;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_glob_syst_par_vars_b;

-- fu_ret_record_group_name_b
   FUNCTION fu_ret_record_group_name_b (p_record_group_name                  varchar2,
                                        p_generated_record_group_name IN OUT varchar2,
                                        p_msg_retorno                 IN OUT varchar2)
                                        RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_record_group_name_b (' || p_record_group_name || '): ';

   BEGIN
      if trim (p_record_group_name) is NULL then
         p_generated_record_group_name := NULL;
      else
         p_generated_record_group_name := translate (lower (trim (p_type_name_prefix) || substr (p_record_group_name,
                                                                                                 1,
                                                                                                 p_oracle_objects_size
                                                                                                 - length (trim (p_type_name_prefix)))),
                                                     'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ.',
                                                     'AAAAAEEEEIIIIOOOOOUUUUYNC_');
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_record_group_name_b;

-- fu_ret_record_group_name_v
   FUNCTION fu_ret_record_group_name_v (p_record_group_name varchar2)
                                        RETURN varchar2 IS
      p_retorno                     boolean        := NULL;
      p_generated_record_group_name varchar2(100)  := NULL;
      p_prc_name                    varchar2(1000) := p_pck_name || 'fu_ret_record_group_name_b (' || p_record_group_name || '): ';
      p_msg_retorno                 varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_record_group_name_b (p_record_group_name, p_generated_record_group_name, p_msg_retorno);

      if p_retorno = TRUE then
         return p_generated_record_group_name;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_record_group_name_v;

-- fu_ret_table_rec_group_name_b
   FUNCTION fu_ret_table_rec_group_name_b (p_table_rec_grp_name                varchar2,
                                           p_generated_tab_rec_grp_name IN OUT varchar2,
                                           p_msg_retorno                IN OUT varchar2)
                                           RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_table_rec_group_name_b (' || p_table_rec_grp_name || '): ';

   BEGIN
      if trim (p_table_rec_grp_name) is NULL then
         p_generated_tab_rec_grp_name := NULL;
      else
         p_generated_tab_rec_grp_name := translate (lower (trim (p_table_of_type_name_prefix) || substr (p_table_rec_grp_name,
                                                                                                         1,
                                                                                                         p_oracle_objects_size
                                                                                                         - length (trim (p_table_of_type_name_prefix)))),
                                                    'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ.',
                                                    'AAAAAEEEEIIIIOOOOOUUUUYNC_');
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_table_rec_group_name_b;

-- fu_ret_table_rec_group_name_v
   FUNCTION fu_ret_table_rec_group_name_v (p_table_rec_grp_name varchar2)
                                           RETURN varchar2 IS
      p_retorno                    boolean        := NULL;
      p_generated_tab_rec_grp_name varchar2(100)  := NULL;
      p_prc_name                   varchar2(1000) := p_pck_name || 'fu_ret_table_rec_group_name_v (' || p_table_rec_grp_name || '): ';
      p_msg_retorno                varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_table_rec_group_name_b (p_table_rec_grp_name, p_generated_tab_rec_grp_name, p_msg_retorno);

      if p_retorno = TRUE then
         return p_generated_tab_rec_grp_name;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_table_rec_group_name_v;

-- fu_ret_function_name_sys_ref_b
   FUNCTION fu_ret_function_name_sys_ref_b (p_function_name                     varchar2,
                                            p_generated_func_name_sysref IN OUT varchar2,
                                            p_msg_retorno                IN OUT varchar2)
                                            RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_function_name_sys_ref_b (' || p_function_name || '): ';

   BEGIN
      if trim (p_function_name) is NULL then
         p_generated_func_name_sysref := NULL;
      else
         p_generated_func_name_sysref := translate (lower (trim (p_prefix) || substr (p_function_name,
                                                                                      1,
                                                                                      p_oracle_objects_size
                                                                                      - length (trim (p_prefix))
                                                                                      - length (trim (p_function_sysrefcursor_suffix)))
                                                                           || p_function_sysrefcursor_suffix),
                                                    'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ.',
                                                    'AAAAAEEEEIIIIOOOOOUUUUYNC_');
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_function_name_sys_ref_b;

-- fu_ret_function_name_sys_ref_v
   FUNCTION fu_ret_function_name_sys_ref_v (p_function_name varchar2)
                                            RETURN varchar2 IS
      p_retorno                    boolean        := NULL;
      p_generated_func_name_sysref varchar2(100)  := NULL;
      p_prc_name                   varchar2(1000) := p_pck_name || 'fu_ret_function_name_sys_ref_v (' || p_function_name || '): ';
      p_msg_retorno                varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_function_name_sys_ref_b (p_function_name, p_generated_func_name_sysref, p_msg_retorno);

      if p_retorno = TRUE then
         return p_generated_func_name_sysref;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_function_name_sys_ref_v;

-- fu_ret_function_name_pipelin_b
   FUNCTION fu_ret_function_name_pipelin_b (p_function_name                       varchar2,
                                            p_generated_func_name_pipeline IN OUT varchar2,
                                            p_msg_retorno                  IN OUT varchar2)
                                            RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_function_name_pipelin_b (' || p_function_name || '): ';

   BEGIN
      if trim (p_function_name) is NULL then
         p_generated_func_name_pipeline := NULL;
      else
         p_generated_func_name_pipeline := translate (lower (trim (p_prefix) || substr (p_function_name,
                                                                                        1,
                                                                                        p_oracle_objects_size
                                                                                        - length (trim (p_prefix))
                                                                                        - length (trim (p_function_pipelined_suffix)))
                                                                             || p_function_pipelined_suffix),
                                                      'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ.',
                                                      'AAAAAEEEEIIIIOOOOOUUUUYNC_');
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_function_name_pipelin_b;

-- fu_ret_function_name_pipelin_v
   FUNCTION fu_ret_function_name_pipelin_v (p_function_name varchar2)
                                            RETURN varchar2 IS
      p_retorno                      boolean        := NULL;
      p_generated_func_name_pipeline varchar2(100)  := NULL;
      p_prc_name                     varchar2(1000) := p_pck_name || 'fu_ret_function_name_pipelin_v (' || p_function_name || '): ';
      p_msg_retorno                  varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_function_name_pipelin_b (p_function_name, p_generated_func_name_pipeline, p_msg_retorno);

      if p_retorno = TRUE then
         return p_generated_func_name_pipeline;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_function_name_pipelin_v;

-- fu_sys_refcursor_variable_b
   FUNCTION fu_sys_refcursor_variable_b (p_variable_name                  varchar2,
                                         p_generated_variable_name IN OUT varchar2,
                                         p_msg_retorno             IN OUT varchar2)
                                         RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_sys_refcursor_variable_b (' || p_variable_name || '): ';

   BEGIN
      if trim (p_variable_name) is NULL then
         p_generated_variable_name := NULL;
      else
         p_generated_variable_name := translate (lower (trim (p_sysrefcursor_variable_prefix) || substr (p_variable_name,
                                                                                                         1,
                                                                                                         p_oracle_objects_size
                                                                                                         - length (trim (p_sysrefcursor_variable_prefix)))),
                                                 'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ.',
                                                 'AAAAAEEEEIIIIOOOOOUUUUYNC_');
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_sys_refcursor_variable_b;

-- fu_sys_refcursor_variable_v
   FUNCTION fu_sys_refcursor_variable_v (p_variable_name varchar2)
                                         RETURN varchar2 IS
      p_retorno                 boolean        := NULL;
      p_generated_variable_name varchar2(100)  := NULL;
      p_prc_name                varchar2(1000) := p_pck_name || 'fu_sys_refcursor_variable_v (' || p_variable_name || '): ';
      p_msg_retorno             varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_sys_refcursor_variable_b (p_variable_name, p_generated_variable_name, p_msg_retorno);

      if p_retorno = TRUE then
         return p_generated_variable_name;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_sys_refcursor_variable_v;

-- fu_ret_piperow_variable_b
   FUNCTION fu_ret_piperow_variable_b (p_variable_name                  varchar2,
                                       p_generated_variable_name IN OUT varchar2,
                                       p_msg_retorno             IN OUT varchar2)
                                       RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_piperow_variable_b (' || p_variable_name || '): ';

   BEGIN
      if trim (p_variable_name) is NULL then
         p_generated_variable_name := NULL;
      else
         p_generated_variable_name := translate (lower (trim (p_piperow_variable_prefix) || substr (p_variable_name,
                                                                                                    1,
                                                                                                    p_oracle_objects_size
                                                                                                    - length (trim (p_piperow_variable_prefix)))),
                                                 'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ.',
                                                 'AAAAAEEEEIIIIOOOOOUUUUYNC_');
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_piperow_variable_b;

-- fu_ret_piperow_variable_v
   FUNCTION fu_ret_piperow_variable_v (p_variable_name varchar2)
                                       RETURN varchar2 IS
      p_retorno                 boolean        := NULL;
      p_generated_variable_name varchar2(100)  := NULL;
      p_prc_name                varchar2(1000) := p_pck_name || 'fu_ret_piperow_variable_v (' || p_variable_name || '): ';
      p_msg_retorno             varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_piperow_variable_b (p_variable_name, p_generated_variable_name, p_msg_retorno);

      if p_retorno = TRUE then
         return p_generated_variable_name;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_piperow_variable_v;

-- fu_ret_parameter_name_b
   FUNCTION fu_ret_parameter_name_b (p_parameter_name                  varchar2,
                                     p_generated_parameter_name IN OUT varchar2,
                                     p_msg_retorno              IN OUT varchar2)
                                     RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_parameter_name_b (' || p_parameter_name || '): ';

   BEGIN
      if trim (p_parameter_name) is NULL then
         p_generated_parameter_name := NULL;
      else
         p_generated_parameter_name := lower (trim (PKG_IMPORT_FORM.p_parameter_prefix) || substr (p_parameter_name,
                                                                                                   1,
                                                                                                   PKG_IMPORT_FORM.p_oracle_objects_size
                                                                                                   - length (trim (PKG_IMPORT_FORM.p_parameter_prefix))));
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_parameter_name_b;

-- fu_ret_parameter_name_v
   FUNCTION fu_ret_parameter_name_v (p_parameter_name varchar2)
                                     RETURN varchar2 IS
      p_retorno                  boolean        := NULL;
      p_generated_parameter_name varchar2(100)  := NULL;
      p_prc_name                 varchar2(1000) := p_pck_name || 'fu_ret_parameter_name_v (' || p_parameter_name || '): ';
      p_msg_retorno              varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_parameter_name_b (p_parameter_name, p_generated_parameter_name, p_msg_retorno);

      if p_retorno = TRUE then
         return p_generated_parameter_name;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_parameter_name_v;

-- fu_ret_record_groups_b
   FUNCTION fu_ret_record_groups_b (p_id_form            M_LOAD_FORM_LINES.id_form%TYPE,
                                    p_type               varchar2,
                                    p_msg_retorno IN OUT varchar2)
                                    RETURN boolean IS
      cursor c_record_groups (p_id_form M_LOAD_FORM_LINES.id_form%TYPE) is
         select mlfl.*
           from m_load_form_lines mlfl
          where mlfl.id_form   = p_id_form
            and mlfl.id_rownum between (select mlfl_1.id_rownum
                                          from m_load_form_lines mlfl_1
                                         where mlfl_1.id_form             = mlfl.id_form
                                           and mlfl_1.txt_internal_name_m = 'REGISTRY_GROUPS')
                                   and (select mlfl_2.id_rownum
                                          from m_load_form_lines mlfl_2
                                         where mlfl_2.id_form             = mlfl.id_form
                                           and mlfl_2.txt_internal_name_m = 'REPORTS')
          order by mlfl.id;

      p_m_load_form_record_groups   m_load_form_record_groups%ROWTYPE := NULL;
      r_imported_form_query         c_imported_form%ROWTYPE           := NULL;
      r_record_groups               c_record_groups%ROWTYPE           := NULL;
      p_txt_keyword_reg_group_query M_FORM_KEYWORDS.txt_keyword%TYPE  := NULL;
      p_record_group_columns_query  boolean        := FALSE;
      p_record_group_column_names   boolean        := FALSE;
      p_retorno                     boolean        := NULL;
      p_count_column_names          integer        := NULL;
      p_colspec_id_ini              integer        := NULL;
      p_colspec_id_fim              integer        := NULL;
      p_count_parameters            integer        := NULL;
      p_existe                      integer        := NULL;
      p_max_size_column             integer        := NULL;
      p_registry_group_query_id_sta integer        := NULL;
      p_package_name                varchar2(30)   := NULL;
      p_function_pipelined          varchar2(100)  := NULL;
      p_function_sysrefcursor       varchar2(100)  := NULL;
      p_function_parameter_name     varchar2(100)  := NULL;
      p_piperow_variable_name       varchar2(100)  := NULL;
      p_record_group_name           varchar2(100)  := NULL;
      p_sysrefcursor_variable_name  varchar2(100)  := NULL;
      p_table_of_record_group_name  varchar2(100)  := NULL;
      p_prc_name                    varchar2(1000) := p_pck_name || 'fu_ret_record_groups_b (' || p_id_form || ', ' || p_type || '): ';
      p_txt_form_name               varchar2(1000) := NULL;

   BEGIN
      if p_id_form is not NULL then
         BEGIN
            select mfk.txt_keyword
              into p_txt_keyword_reg_group_query
              from m_form_keywords mfk
             where mfk.id_language       = PKG_IMPORT_FORM.p_id_language
               and mfk.txt_internal_name = 'REGISTRY_GROUP_QUERY';

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro SELECT MFK em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

         for r_record_groups in c_record_groups (p_id_form) loop
            if    r_record_groups.txt_internal_name_m = 'NAME' and p_record_group_columns_query = FALSE and p_record_group_column_names = FALSE then
               p_count_column_names         := 0;
               p_record_group_name          := PKG_IMPORT_FORM.fu_ret_record_group_name_v (r_record_groups.txt_line_p);
               p_table_of_record_group_name := PKG_IMPORT_FORM.fu_ret_table_rec_group_name_v (r_record_groups.txt_line_p);
               p_function_sysrefcursor      := PKG_IMPORT_FORM.fu_ret_function_name_sys_ref_v (r_record_groups.txt_line_p);
               p_function_pipelined         := PKG_IMPORT_FORM.fu_ret_function_name_pipelin_v (r_record_groups.txt_line_p);
               p_sysrefcursor_variable_name := PKG_IMPORT_FORM.fu_sys_refcursor_variable_v (r_record_groups.txt_line_p);
               p_piperow_variable_name      := PKG_IMPORT_FORM.fu_ret_piperow_variable_v (r_record_groups.txt_line_p);

               p_m_load_form_record_groups.id_form                := p_id_form;
               p_m_load_form_record_groups.id_rownum              := r_record_groups.id_rownum;
               p_m_load_form_record_groups.txt_record_group_name  := r_record_groups.txt_line_p;
            elsif r_record_groups.txt_internal_name_m = 'REGISTRY_GROUP_QUERY' then
               p_m_load_form_record_groups.clob_sql_query         := PKG_IMPORT_FORM.fu_ret_txt_multiline_c (p_id_form             => p_id_form,
                                                                                                             p_id_rownum_start     => r_record_groups.id_rownum,
                                                                                                             p_txt_internal_name_m => 'REGISTRY_GROUP_SIZE_EXTRACT');
               p_m_load_form_record_groups.clob_sql_query_no_comm := PKG_IMPORT_FORM.fu_remove_plsql_comments_c (p_m_load_form_record_groups.clob_sql_query);
               p_m_load_form_record_groups.clob_sql_query_no_comm := PKG_IMPORT_FORM.fu_chg_item_to_block_item_vr_c (p_id_form,
                                                                                                                     p_m_load_form_record_groups.clob_sql_query_no_comm);
            elsif r_record_groups.txt_internal_name_m = 'REGISTRY_GROUP_TYPE' and r_record_groups.txt_internal_name_p != 'STATIC' then
               p_record_group_columns_query  := TRUE;
               p_registry_group_query_id_sta := r_record_groups.id + 1;

               p_m_load_form_record_groups.txt_record_group_type := r_record_groups.txt_internal_name_p;
            elsif r_record_groups.txt_internal_name_m = 'COLUMN_SPECIFICATION' and p_record_group_columns_query = TRUE then
               p_record_group_column_names := TRUE;
               p_colspec_id_ini            := r_record_groups.id + 1;
            elsif p_record_group_columns_query = TRUE and p_record_group_column_names = TRUE then
               if    r_record_groups.txt_internal_name_m = 'NAME' then
                  p_count_column_names := p_count_column_names + 1;

                  p_m_load_form_record_groups.txt_record_group_col_name := r_record_groups.txt_line_p;
               elsif r_record_groups.txt_internal_name_m = 'MAXIMUM_LENGTH' then
                  p_max_size_column := r_record_groups.txt_line_p;

                  p_m_load_form_record_groups.txt_record_group_col_maxsize := r_record_groups.txt_line_p;
               elsif r_record_groups.txt_internal_name_m = 'COLUMN_DATA_TYPE' then
                  p_m_load_form_record_groups.txt_record_group_col_datatype := r_record_groups.txt_internal_name_p;

                  if trim (upper (p_type)) = 'BODY' then
                     BEGIN
                        insert into m_load_form_record_groups values p_m_load_form_record_groups;

                     EXCEPTION
                        when others then
                           p_msg_retorno := 'Erro INSERT MLFRG (' || p_m_load_form_record_groups.id_rownum ||
                                            ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                           return FALSE;
                     END;
                  end if;
               elsif trim (r_record_groups.txt_line) = '----------' then
                  BEGIN
                     select 1
                       into p_existe
                       from m_load_form_lines mlfl
                      where mlfl.id_form   = p_id_form
                        and mlfl.id_rownum = r_record_groups.id_rownum + 1
                        and trim (mlfl.txt_line) = '----------';

                     p_record_group_columns_query := FALSE;
                     p_record_group_column_names  := FALSE;
                     p_count_column_names         := 0;
                     p_colspec_id_fim             := r_record_groups.id;

                     p_retorno := PKG_IMPORT_FORM.fu_obter_nome_form_b (p_id_form, p_txt_form_name, p_msg_retorno);

                     if p_retorno != TRUE then
                        return p_retorno;
                     end if;

                     p_package_name := upper (p_package_prefix || p_txt_form_name);

-- FUNCTION RETURN SYS_REFCURSOR
                     for r_imported_form in c_imported_form (p_id_form, p_colspec_id_ini, p_colspec_id_fim) loop
                        if    r_imported_form.txt_internal_name_m = 'NAME' then
                           p_function_parameter_name := PKG_IMPORT_FORM.fu_ret_parameter_name_v (r_imported_form.txt_line_p);
                        elsif r_imported_form.txt_internal_name_m = 'COLUMN_DATA_TYPE' then
                           p_count_column_names := p_count_column_names + 1;
                        end if;
                     end loop;

                     p_count_column_names := 0;

                     if    trim (upper (p_type)) = 'SPEC' then
                        NULL;
                     elsif trim (upper (p_type)) = 'BODY' then
                        p_count_parameters := 0;

                        for r_imported_form_parameters in c_imported_form (p_id_form, p_colspec_id_ini, p_colspec_id_fim) loop
                           if r_imported_form_parameters.txt_internal_name_m = 'NAME' then
                              p_count_parameters        := p_count_parameters + 1;
                              p_function_parameter_name := PKG_IMPORT_FORM.fu_ret_parameter_name_v (r_imported_form_parameters.txt_line_p);
                           end if;
                        end loop;

                        p_count_parameters := 0;

                        for r_imported_form_parameters in c_imported_form (p_id_form, p_colspec_id_ini, p_colspec_id_fim) loop
                           if r_imported_form_parameters.txt_internal_name_m = 'NAME' then
                              p_count_parameters := p_count_parameters + 1;
                           end if;
                        end loop;

                        p_count_parameters := 0;

                        for r_imported_form_parameters in c_imported_form (p_id_form, p_colspec_id_ini, p_colspec_id_fim) loop
                           if r_imported_form_parameters.txt_internal_name_m = 'NAME' then
                              p_count_parameters        := p_count_parameters + 1;
                              p_function_parameter_name := PKG_IMPORT_FORM.fu_ret_parameter_name_v (r_imported_form_parameters.txt_line_p);
                           end if;
                        end loop;
                     end if;

-- FUNCTION RETURN PIPELINED
                     for r_imported_form in c_imported_form (p_id_form, p_colspec_id_ini, p_colspec_id_fim) loop
                        if    r_imported_form.txt_internal_name_m = 'NAME' then
                           p_function_parameter_name := PKG_IMPORT_FORM.fu_ret_parameter_name_v (r_imported_form.txt_line_p);
                        elsif r_imported_form.txt_internal_name_m = 'COLUMN_DATA_TYPE' then
                           p_count_column_names      := p_count_column_names + 1;
                        end if;
                     end loop;

                     p_count_column_names := 0;

                     if    trim (upper (p_type)) = 'SPEC' then
                        NULL;
                     elsif trim (upper (p_type)) = 'BODY' then
                        p_count_parameters := 0;

                        for r_imported_form_parameters in c_imported_form (p_id_form, p_colspec_id_ini, p_colspec_id_fim) loop
                           if r_imported_form_parameters.txt_internal_name_m = 'NAME' then
                              p_count_parameters        := p_count_parameters + 1;
                              p_function_parameter_name := PKG_IMPORT_FORM.fu_ret_parameter_name_v (r_imported_form_parameters.txt_line_p);
                           end if;
                        end loop;

                        p_count_parameters := 0;

                        for r_imported_form_parameters in c_imported_form (p_id_form, p_colspec_id_ini, p_colspec_id_fim) loop
                           if r_imported_form_parameters.txt_internal_name_m = 'NAME' then
                              p_count_parameters        := p_count_parameters + 1;
                              p_function_parameter_name := PKG_IMPORT_FORM.fu_ret_parameter_name_v (r_imported_form_parameters.txt_line_p);
                           end if;
                        end loop;
                     end if;

                  EXCEPTION
                     when no_data_found then
                        NULL;
                     when others then
                        p_msg_retorno := 'Erro SELECT MLFL ROWNUM + 1 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                        return FALSE;
                  END;
               end if;
            end if;
         end loop;
      end if;

      commit;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_record_groups_b;

-- fu_ret_form_list_values_b
   FUNCTION fu_ret_form_list_values_b (p_id                 M_LOAD_FORM.id%TYPE,
                                       p_msg_retorno IN OUT varchar2)
                                       RETURN boolean IS
      p_m_load_form_list_values m_load_form_list_values%ROWTYPE := NULL;
      r_imported_form           c_imported_form%ROWTYPE         := NULL;
      p_txt_lov_item_name_new   boolean        := NULL;
      p_id_rownum_start         integer        := NULL;
      p_id_rownum_finish        integer        := NULL;
      p_eval_internal_name      varchar2(100)  := NULL;
      p_eval_lov_name           varchar2(100)  := NULL;
      p_eval_col_map_name       varchar2(100)  := NULL;
      p_prc_name                varchar2(1000) := p_pck_name || 'fu_ret_form_list_values_b (' || p_id || '): ';

   BEGIN
      if p_id is not NULL then
         p_id_rownum_start  := PKG_IMPORT_FORM.fu_ret_1st_occurrenc_keyword_i (p_id, 'LISTS_OF_VALUES');
         p_id_rownum_finish := PKG_IMPORT_FORM.fu_ret_1st_occurrenc_keyword_i (p_id, 'MENUS');

         if p_id_rownum_start is not NULL and p_id_rownum_finish is not NULL then
            p_txt_lov_item_name_new := FALSE;

            for r_imported_form in c_imported_form (p_id, p_id_rownum_start, p_id_rownum_finish) loop
               p_m_load_form_list_values.id_form := p_id;

               if    p_txt_lov_item_name_new = FALSE then
                  p_eval_internal_name := r_imported_form.txt_internal_name_m;
                  p_eval_lov_name      := p_m_load_form_list_values.txt_lov_name;

                  if    r_imported_form.txt_internal_name_m = 'NAME' then
                     p_m_load_form_list_values.txt_lov_name         := r_imported_form.txt_line_t;
                  elsif r_imported_form.txt_internal_name_m = 'TITLE' then
                     p_m_load_form_list_values.txt_lov_title        := r_imported_form.txt_line_t;
                  elsif r_imported_form.txt_internal_name_m = 'LIST_TYPE' then
                     p_m_load_form_list_values.txt_lov_type         := r_imported_form.txt_line_t;
                  elsif r_imported_form.txt_internal_name_m = 'RECORD_GROUP' then
                     p_m_load_form_list_values.txt_lov_record_group := r_imported_form.txt_line_t;
                  elsif r_imported_form.txt_internal_name_m = 'COLUMN_MAPPING_PROPERTIES' then
                     p_txt_lov_item_name_new := TRUE;
                  end if;
               elsif p_txt_lov_item_name_new = TRUE then
                  p_eval_col_map_name := r_imported_form.txt_internal_name_m;

                  if    r_imported_form.txt_internal_name_m = 'NAME' then
                     p_m_load_form_list_values.txt_lov_item_name          := r_imported_form.txt_line_t;
                  elsif r_imported_form.txt_internal_name_m = 'TITLE' then
                     p_m_load_form_list_values.txt_lov_item_title         := r_imported_form.txt_line_t;
                  elsif r_imported_form.txt_internal_name_m = 'RETURN_ITEM' then
                     p_m_load_form_list_values.txt_lov_item_return_item   := r_imported_form.txt_line_t;
                  elsif r_imported_form.txt_internal_name_m = 'DISPLAY_WIDTH' then
                     p_m_load_form_list_values.txt_lov_item_display_width := r_imported_form.txt_line_t;

                     BEGIN
                        insert into m_load_form_list_values values p_m_load_form_list_values;

                     EXCEPTION
                        when others then
                           p_msg_retorno := 'Erro INSERT MLFLV (' || p_m_load_form_list_values.txt_lov_name      ||
                                                             ', ' || p_m_load_form_list_values.txt_lov_item_name ||
                                                          ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                           return FALSE;
                     END;
                  elsif r_imported_form.txt_internal_name_m = 'FILTER_BEFORE_DISPLAY' then
                     p_txt_lov_item_name_new := FALSE;
                  end if;
               end if;
            end loop;
         end if;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro NAME = "' || p_eval_lov_name ||
                          '" internal name = "' || p_eval_internal_name ||
                          ' colmap = "' || p_eval_col_map_name ||
                          '" em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_form_list_values_b;

-- fu_ret_rec_group_related_lov_b
   FUNCTION fu_ret_rec_group_related_lov_b (p_id_form                     M_LOAD_FORM_LIST_VALUES.id_form%TYPE,
                                            p_txt_lov_record_group        M_LOAD_FORM_LIST_VALUES.txt_lov_record_group%TYPE,
                                            p_txt_related_lov      IN OUT varchar2,
                                            p_msg_retorno          IN OUT varchar2)
                                            RETURN boolean IS
      cursor c_m_load_form_list_values is
         select mlflv.*
           from m_load_form_list_values mlflv
          where mlflv.id_form              = p_id_form
            and mlflv.txt_lov_record_group = p_txt_lov_record_group;

      r_m_load_form_list_values c_m_load_form_list_values%ROWTYPE := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_rec_group_related_lov_b (' || p_id_form || ', ' || p_txt_lov_record_group || '): ';

   BEGIN
      if    p_id_form is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
         return FALSE;
      elsif trim (p_txt_lov_record_group) is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o nome do record group deve ser informado.';
         return FALSE;
      else
         p_txt_related_lov := p_txt_related_lov || '-- RECORD GROUP "' || p_txt_lov_record_group || '" IS RELATED TO THE LOV(S):';

         for r_m_load_form_list_values in c_m_load_form_list_values loop
            p_txt_related_lov := p_txt_related_lov || chr(10) ||
                                 '-- ' || r_m_load_form_list_values.txt_lov_name ||
                                 ' (LOV TITLE: "' || r_m_load_form_list_values.txt_lov_title ||
                                 '") ITEM: "' || r_m_load_form_list_values.txt_lov_item_name ||
                                 '" (ITEM TITLE: "' || r_m_load_form_list_values.txt_lov_item_title ||
                                 '"; RETURN ITEM VALUE TO BLOCK.ITEM "' || r_m_load_form_list_values.txt_lov_item_return_item ||
                                 '"; ITEM WIDTH = ' || r_m_load_form_list_values.txt_lov_item_display_width || ')';
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_rec_group_related_lov_b;

-- fu_ret_rec_group_related_lov_v
   FUNCTION fu_ret_rec_group_related_lov_v (p_id_form              M_LOAD_FORM_LIST_VALUES.id_form%TYPE,
                                            p_txt_lov_record_group M_LOAD_FORM_LIST_VALUES.txt_lov_record_group%TYPE)
                                            RETURN varchar2 IS
      p_retorno         boolean        := NULL;
      p_prc_name        varchar2(1000) := p_pck_name || 'fu_ret_rec_group_related_lov_b (' || p_id_form || ', ' || p_txt_lov_record_group || '): ';
      p_txt_related_lov varchar2(4000) := NULL;
      p_msg_retorno     varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_rec_group_related_lov_b (p_id_form, p_txt_lov_record_group, p_txt_related_lov, p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_related_lov;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_rec_group_related_lov_v;

-- fu_ret_global_variable_name_b
   FUNCTION fu_ret_global_variable_name_b (p_global_variable_name        varchar2,
                                           p_variable_name        IN OUT varchar2,
                                           p_msg_retorno          IN OUT varchar2)
                                           RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_global_variable_name_b (' || p_global_variable_name || '): ';

   BEGIN
      if trim (p_global_variable_name) is NULL then
         p_variable_name := NULL;
      else
         p_variable_name := lower (PKG_IMPORT_FORM.p_parameter_prefix || substr (replace (trim (upper (p_global_variable_name)), ':GLOBAL.', NULL),
                                                                                 1,
                                                                                 PKG_IMPORT_FORM.p_oracle_objects_size
                                                                                 - length (PKG_IMPORT_FORM.p_parameter_prefix)));
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_global_variable_name_b;

-- fu_ret_global_variable_name_v
   FUNCTION fu_ret_global_variable_name_v (p_global_variable_name varchar2)
                                           RETURN varchar2 IS
      p_retorno       boolean        := NULL;
      p_variable_name varchar2(100)  := NULL;
      p_prc_name      varchar2(1000) := p_pck_name || 'fu_ret_global_variable_name_b (' || p_global_variable_name || '): ';
      p_msg_retorno   varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_global_variable_name_b (p_global_variable_name,
                                                                  p_variable_name,
                                                                  p_msg_retorno);

      if p_retorno = TRUE then
         return p_variable_name;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_global_variable_name_v;

-- fu_chg_item_to_block_item_vr_b
   FUNCTION fu_chg_item_to_block_item_vr_b (p_id_form                         M_LOAD_FORM_LINES.id_form%TYPE,
                                            p_line_analysis                   varchar2,
                                            p_line_analysis_block_item IN OUT varchar2,
                                            p_msg_retorno              IN OUT varchar2)
                                            RETURN boolean IS
      cursor c_m_load_form_blocks_items (p_id_form M_LOAD_FORM_GLOB_SYST_PARM.id_form%TYPE) is
         select mlfbi.*
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form         = p_id_form
            and mlfbi.txt_data_origin = 'BLOCKS AND ITEMS'
            and mlfbi.txt_block_name  is not NULL
            and mlfbi.txt_item_name   is not NULL;

      r_m_load_form_blocks_items c_m_load_form_blocks_items%ROWTYPE := NULL;
      i                          integer        := NULL;
      p_pattern_char             varchar2(1)    := NULL;
      p_prc_name                 varchar2(4000) := p_pck_name || 'fu_chg_item_to_block_item_vr_b (' || p_id_form || ', ' || p_line_analysis || '): ';

   BEGIN
      if    p_id_form is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
         return FALSE;
      elsif trim (p_line_analysis) is NULL then
         p_line_analysis_block_item := NULL;
      else
         p_line_analysis_block_item := p_line_analysis;

         for i in 1..length (PKG_IMPORT_FORM.p_pattern) loop
            p_pattern_char := substr (PKG_IMPORT_FORM.p_pattern, i, 1);

-- TRANSFORM EACH OCCURRENCE OF :ITEM INTO :BLOCK.ITEM
            for r_m_load_form_blocks_items in c_m_load_form_blocks_items (p_id_form) loop
               if instr (upper (p_line_analysis_block_item), ':' || r_m_load_form_blocks_items.txt_item_name || p_pattern_char) > 0 then
                  p_line_analysis_block_item := regexp_replace (p_line_analysis_block_item,
                                                                ':' || r_m_load_form_blocks_items.txt_item_name || p_pattern_char,
                                                                r_m_load_form_blocks_items.txt_block_item_name || '[' || p_pattern_char || ']',
                                                                1,
                                                                0,
                                                                'i');
               end if;
            end loop;
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_chg_item_to_block_item_vr_b;

-- fu_chg_item_to_block_item_vr_v
   FUNCTION fu_chg_item_to_block_item_vr_v (p_id_form       M_LOAD_FORM_LINES.id_form%TYPE,
                                            p_line_analysis varchar2)
                                            RETURN varchar2 IS
      p_retorno                  boolean        := NULL;
      p_line_analysis_block_item varchar2(4000) := NULL;
      p_msg_retorno              varchar2(4000) := NULL;
      p_prc_name                 varchar2(4000) := p_pck_name || 'fu_chg_item_to_block_item_vr_v (' || p_id_form || ', ' || p_line_analysis || '): ';

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_chg_item_to_block_item_vr_b (p_id_form,
                                                                   p_line_analysis,
                                                                   p_line_analysis_block_item,
                                                                   p_msg_retorno);

      if p_retorno = TRUE then
         return p_line_analysis_block_item;
      else
         return 'Erro P_RETORNO em ' || p_prc_name || p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_chg_item_to_block_item_vr_v;

-- fu_chg_item_to_block_item_vr_c
   FUNCTION fu_chg_item_to_block_item_vr_c (p_id_form      M_LOAD_FORM_LINES.id_form%TYPE,
                                            p_clob_content clob)
                                            RETURN clob IS
      p_retorno                  boolean        := NULL;
      p_clob_edit                clob           := empty_clob();
      p_clob_return              clob           := empty_clob();
      p_instr_chr_10             integer        := NULL;
      p_line_analysis            varchar2(4000) := NULL;
      p_line_analysis_block_item varchar2(4000) := NULL;
      p_msg_retorno              varchar2(4000) := NULL;
      p_prc_name                 varchar2(4000) := p_pck_name || 'fu_chg_item_to_block_item_vr_c (' || p_id_form || '): ';

   BEGIN
      p_clob_edit := p_clob_content;

      loop
         p_instr_chr_10  := instr (p_clob_edit, chr(10));
         exit when p_instr_chr_10 = 0; -- EXITS LOOP WHEN NO NEW LINES ARE FOUND (NO MORE PL/SQL CONTENTS)

         p_line_analysis := rtrim (translate (substr (p_clob_edit, 1, p_instr_chr_10), chr(9) || chr(10), '  '));
         p_clob_edit     := substr (p_clob_edit, p_instr_chr_10 + 1);
         p_retorno       := PKG_IMPORT_FORM.fu_chg_item_to_block_item_vr_b (p_id_form,
                                                                            p_line_analysis,
                                                                            p_line_analysis_block_item,
                                                                            p_msg_retorno);

         if p_retorno = TRUE then
            p_clob_return := p_clob_return || p_line_analysis_block_item || chr(10);
         else
            return p_msg_retorno;
         end if;
      end loop;

      return p_clob_return;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_chg_item_to_block_item_vr_c;

-- fu_ret_rec_grp_based_params_v
   FUNCTION fu_ret_rec_grp_based_params_v (p_id_form               M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE,
                                           p_txt_record_group_name M_LOAD_FORM_RECORD_GROUPS.txt_record_group_name%TYPE,
                                           p_txt_origin            varchar2)
                                           RETURN clob IS
      cursor c_record_group_cols (p_id_form               M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE,
                                  p_txt_record_group_name M_LOAD_FORM_RECORD_GROUPS.txt_record_group_name%TYPE,
                                  p_txt_origin            varchar2) is
         select mlfrg.id,
                mlfrg.txt_record_group_col_name,
                mlfrg.txt_record_group_col_datatype
           from m_load_form_record_groups mlfrg
          where mlfrg.id_form               = p_id_form
            and mlfrg.txt_record_group_name = p_txt_record_group_name
            and p_txt_origin                = 'RECGRP'
          union
         select mlfbi.id,
                mlfbi.txt_item_name           as txt_record_group_col_name,
                mlfbi.txt_item_field_datatype as txt_record_group_col_datatype
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form        =  p_id_form
            and mlfbi.txt_block_name =  p_txt_record_group_name
            and mlfbi.txt_item_name  is not NULL
            and p_txt_origin         =  'SQLBLK'
          order by 1;

      cursor c_m_load_form_glob_syst_parm (p_id_form M_LOAD_FORM_GLOB_SYST_PARM.id_form%TYPE) is
         select mlfgsp.*
           from m_load_form_glob_syst_parm mlfgsp
          where mlfgsp.id_form = p_id_form;

      cursor c_m_load_form_blocks_items (p_id_form M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE) is
         select mlfbi.*
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form         =  p_id_form
            and mlfbi.txt_data_origin =  'BLOCKS AND ITEMS'
            and mlfbi.txt_block_name  is not NULL
            and mlfbi.txt_item_name   is not NULL;

      r_m_load_form_blocks_items   c_m_load_form_blocks_items%ROWTYPE                    := NULL;
      r_m_load_form_glob_syst_parm c_m_load_form_glob_syst_parm%ROWTYPE                  := NULL;
      r_record_group_cols          c_record_group_cols%ROWTYPE                           := NULL;
      p_clob_sql_query_edit        M_LOAD_FORM_RECORD_GROUPS.clob_sql_query%TYPE         := empty_clob();
      p_clob_sql_query_no_comm     M_LOAD_FORM_RECORD_GROUPS.clob_sql_query_no_comm%TYPE := empty_clob();
      p_rec_grp_based_params       clob           := empty_clob();
      i                            integer        := NULL;
      p_count_record_group_cols    integer        := NULL;
      p_instr_chr_10               integer        := NULL;
      p_pattern_char               varchar2(1)    := NULL;
      p_function_parameter_name    varchar2(100)  := NULL;
      p_function_sysrefcursor      varchar2(100)  := PKG_IMPORT_FORM.fu_ret_function_name_sys_ref_v (p_txt_record_group_name);
      p_prc_name                   varchar2(1000) := p_pck_name || 'fu_ret_rec_grp_based_params_v (' || p_id_form               ||
                                                                                                ', ' || p_txt_record_group_name ||
                                                                                                ', ' || p_txt_origin            || '): ';
      p_line_analysis              varchar2(4000) := NULL;
      p_parameter_list             varchar2(4000) := NULL;

   BEGIN
      p_count_record_group_cols := 0;

      for r_record_group_cols in c_record_group_cols (p_id_form, p_txt_record_group_name, p_txt_origin) loop
         p_count_record_group_cols := p_count_record_group_cols + 1;
         p_function_parameter_name := rpad (PKG_IMPORT_FORM.fu_ret_parameter_name_v (r_record_group_cols.txt_record_group_col_name),
                                            PKG_IMPORT_FORM.p_oracle_objects_size,
                                            ' ');

         if p_count_record_group_cols > 1 then
            p_rec_grp_based_params := p_rec_grp_based_params || lpad (', ',
                                                                      length (p_indent
                                                                              || 'FUNCTION '
                                                                              || p_function_sysrefcursor
                                                                              || ' ('),
                                                                      ' ');
         end if;

         p_rec_grp_based_params    := p_rec_grp_based_params || p_function_parameter_name ||
                                      ' ' || lower (r_record_group_cols.txt_record_group_col_datatype) ||
                                      ' default NULL' || chr(10);
      end loop;

      if    p_txt_origin = 'RECGRP' then
         p_clob_sql_query_no_comm := PKG_IMPORT_FORM.fu_ret_clob_sql_query_no_com_c (p_id_form, p_txt_record_group_name);
      elsif p_txt_origin = 'SQLBLK' then
         p_clob_sql_query_no_comm := PKG_IMPORT_FORM.fu_ret_clob_sql_dblck_no_com_c (p_id_form, p_txt_record_group_name);
      end if;

      if    p_txt_origin in ('RECGRP', 'SQLBLK') then
-- Retrieve :GLOBAL.item, :SYSTEM.item, :PARAMETER.item and :BLOCK.item fields and converts them into parameters
         if p_clob_sql_query_no_comm != empty_clob() then
            p_clob_sql_query_edit := p_clob_sql_query_no_comm;

            loop
               p_instr_chr_10        := instr (p_clob_sql_query_edit, chr(10));
               exit when p_instr_chr_10 = 0; -- EXITS LOOP WHEN NO NEW LINES ARE FOUND (NO MORE PL/SQL CONTENTS)

               p_line_analysis       := rtrim (translate (substr (p_clob_sql_query_edit, 1, p_instr_chr_10), chr(9) || chr(10), '  '));
               p_clob_sql_query_edit := substr (p_clob_sql_query_edit, p_instr_chr_10 + 1);

               if trim (p_line_analysis) is not NULL then
                  for i in 1..length (PKG_IMPORT_FORM.p_pattern) loop
                     p_pattern_char := substr (PKG_IMPORT_FORM.p_pattern, i, 1);

-- Detect :GLOBAL.item, :SYSTEM.item and :PARAMETER.item
                     for r_m_load_form_glob_syst_parm in c_m_load_form_glob_syst_parm (p_id_form) loop
                        if  instr (upper (p_line_analysis || p_pattern_char), r_m_load_form_glob_syst_parm.txt_variable_name || p_pattern_char) > 0
                         or instr (upper (p_line_analysis), r_m_load_form_glob_syst_parm.txt_variable_name || p_pattern_char) > 0 then
-- AVOID PARAMETER DUPLICATION
                           if  (upper (p_parameter_list) not like ';%' || upper (r_m_load_form_glob_syst_parm.txt_variable_parameter_name) || '%;' and p_parameter_list is not NULL)
                            or p_parameter_list is NULL then
                              p_parameter_list       := nvl (p_parameter_list, ';') || upper (r_m_load_form_glob_syst_parm.txt_variable_parameter_name) || ';';
                              p_rec_grp_based_params := p_rec_grp_based_params || lpad (', ',
                                                                                        length (p_indent
                                                                                                || 'FUNCTION '
                                                                                                || p_function_sysrefcursor
                                                                                                || ' ('),
                                                                                        ' ')
                                                                               || rpad (r_m_load_form_glob_syst_parm.txt_variable_parameter_name,
                                                                                        PKG_IMPORT_FORM.p_oracle_objects_size,
                                                                                        ' ');

-- All GLOBAL and SYSTEM variables are renamed and declared as VARCHAR2; PARAMETER variables are renamed and declared like original
                              if r_m_load_form_glob_syst_parm.txt_variable_type in ('GLOBAL', 'SYSTEM') then
                                 p_rec_grp_based_params := p_rec_grp_based_params || ' varchar2 default NULL';
                              else
                                 p_rec_grp_based_params := p_rec_grp_based_params || ' ' || lower (r_m_load_form_glob_syst_parm.txt_variable_data_type) || ' default ' ||
                                                                                     replace (r_m_load_form_glob_syst_parm.txt_variable_name, ':PARAMETER.', '');
                              end if;

                              p_rec_grp_based_params := p_rec_grp_based_params || chr(10);
                           end if;
                        end if;
                     end loop;

-- Detect :BLOCK.item
                     for r_m_load_form_blocks_items in c_m_load_form_blocks_items (p_id_form) loop
                        if  instr (upper (p_line_analysis || p_pattern_char), r_m_load_form_blocks_items.txt_block_item_name || p_pattern_char) > 0
                         or instr (upper (p_line_analysis), r_m_load_form_blocks_items.txt_block_item_name || p_pattern_char) > 0 then
-- AVOID PARAMETER DUPLICATION
                           if  (upper (p_parameter_list) not like ';%' || upper (r_m_load_form_blocks_items.txt_variable_parameter_name) || '%;' and p_parameter_list is not NULL)
                            or p_parameter_list is NULL then
                              p_parameter_list       := nvl (p_parameter_list, ';') || upper (r_m_load_form_blocks_items.txt_variable_parameter_name) || ';';
                              p_rec_grp_based_params := p_rec_grp_based_params || lpad (', ',
                                                                                        length (p_indent
                                                                                                || 'FUNCTION '
                                                                                                || p_function_sysrefcursor
                                                                                                || ' ('),
                                                                                  ' ') ||
                                                                                  rpad (r_m_load_form_blocks_items.txt_variable_parameter_name,
                                                                                        PKG_IMPORT_FORM.p_oracle_objects_size,
                                                                                        ' ');

-- If :BLOCK.item is based on a database table item, use its datatype (based on table.item), otherwise datatype based on form must be used
                              if   r_m_load_form_blocks_items.txt_block_database_data_block  =  'YES'
                               and r_m_load_form_blocks_items.txt_block_query_data_orig_type =  'TABLE'
                               and r_m_load_form_blocks_items.txt_block_query_data_orig_name is not NULL
                               and r_m_load_form_blocks_items.txt_item_field_database        =  'YES'
                               and r_m_load_form_blocks_items.txt_item_field_db_col_name     is not NULL then
                                 p_rec_grp_based_params := p_rec_grp_based_params || ' ' || r_m_load_form_blocks_items.txt_block_query_data_orig_name || '.'
                                                                                  || lower (r_m_load_form_blocks_items.txt_item_field_db_col_name) || '%TYPE';
                              else
                                 p_rec_grp_based_params := p_rec_grp_based_params || ' ' || lower (r_m_load_form_blocks_items.txt_item_field_datatype);
                              end if;

                              p_rec_grp_based_params := p_rec_grp_based_params || ' default NULL -- :' || r_m_load_form_blocks_items.txt_block_name
                                                                               || '.' || r_m_load_form_blocks_items.txt_item_name || chr(10);
                           end if;
                        end if;
                     end loop;
                  end loop;
               end if;
            end loop;
         end if;
      end if;

      return p_rec_grp_based_params;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_rec_grp_based_params_v;

-- fu_ret_txt_multiline_b
   FUNCTION fu_ret_txt_multiline_b (p_id_form                    M_LOAD_FORM_LINES.id_form%TYPE,
                                    p_id_rownum_start            M_LOAD_FORM_LINES.id%TYPE,
                                    p_id_rownum_finish           M_LOAD_FORM_LINES.id%TYPE default 2147483648,
                                    p_txt_internal_name_m        M_LOAD_FORM_LINES.txt_internal_name_m%TYPE,
                                    p_txt_contents        IN OUT clob,
                                    p_msg_retorno         IN OUT varchar2)
                                    RETURN boolean IS
      cursor c_imported_form_multiline (p_id            integer,
                                        p_rownum_start  integer,
                                        p_rownum_finish integer) is
         select mlfl.*
           from m_load_form_lines mlfl
          where mlfl.id_form = p_id
            and mlfl.id_rownum between nvl (p_rownum_start,  0)
                                   and nvl (p_rownum_finish, 0)
            and nvl (p_rownum_start,  0) > 0
            and nvl (p_rownum_finish, 0) > 0
            and nvl (p_rownum_start,  0) < nvl (p_rownum_finish, 0)
          order by mlfl.id;

      r_imported_form_multiline c_imported_form_multiline%ROWTYPE := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_txt_multiline_b (' || p_id_form             ||
                                                                       ', ' || p_id_rownum_start     ||
                                                                       ', ' || p_id_rownum_finish    ||
                                                                       ', ' || p_txt_internal_name_m || '): ';

   BEGIN
      if    p_id_form is NULL then
         p_msg_retorno := 'O ID do form carregado deve ser informado.';
         return FALSE;
      elsif p_id_rownum_start is NULL then
         p_msg_retorno := 'O ID da linha inicial deve ser informado.';
         return FALSE;
      elsif p_txt_internal_name_m is NULL then
         p_msg_retorno := 'O texto interno onde a busca termina deve ser informado.';
         return FALSE;
      else
         p_txt_contents := empty_clob();

         for r_imported_form_multiline in c_imported_form_multiline (p_id_form, p_id_rownum_start, p_id_rownum_finish) loop
            exit when r_imported_form_multiline.txt_internal_name_m = p_txt_internal_name_m;

            if r_imported_form_multiline.txt_line_m is not NULL then
               r_imported_form_multiline.txt_line := replace (trim (r_imported_form_multiline.txt_line), '* ' || r_imported_form_multiline.txt_line_m, ' ');
               r_imported_form_multiline.txt_line := replace (trim (r_imported_form_multiline.txt_line), '- ' || r_imported_form_multiline.txt_line_m, ' ');
               r_imported_form_multiline.txt_line := replace (trim (r_imported_form_multiline.txt_line), '^ ' || r_imported_form_multiline.txt_line_m, ' ');
               r_imported_form_multiline.txt_line := replace (trim (r_imported_form_multiline.txt_line), 'o ' || r_imported_form_multiline.txt_line_m, ' ');
            end if;

            p_txt_contents := p_txt_contents || trim (r_imported_form_multiline.txt_line) || chr(10);
         end loop;
      end if;

      if trim (p_txt_contents) = chr(10) then
         p_txt_contents := NULL;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_txt_multiline_b;

-- fu_ret_txt_multiline_c
   FUNCTION fu_ret_txt_multiline_c (p_id_form             M_LOAD_FORM_LINES.id_form%TYPE,
                                    p_id_rownum_start     M_LOAD_FORM_LINES.id%TYPE,
                                    p_id_rownum_finish    M_LOAD_FORM_LINES.id%TYPE default 2147483648,
                                    p_txt_internal_name_m M_LOAD_FORM_LINES.txt_internal_name_m%TYPE)
                                    RETURN clob IS
      p_retorno      boolean        := NULL;
      p_txt_contents clob           := empty_clob();
      p_prc_name     varchar2(1000) := p_pck_name || 'fu_ret_txt_multiline_c (' || p_id_form             ||
                                                                           ', ' || p_id_rownum_start     ||
                                                                           ', ' || p_id_rownum_finish    ||
                                                                           ', ' || p_txt_internal_name_m || '): ';
      p_msg_retorno  varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_txt_multiline_b (p_id_form,             -- p_id_form                    M_LOAD_FORM_LINES.id_form%TYPE
                                                           p_id_rownum_start,     -- p_id_rownum_start            M_LOAD_FORM_LINES.id%TYPE
                                                           p_id_rownum_finish,    -- p_id_rownum_finish           M_LOAD_FORM_LINES.id%TYPE default 2147483648
                                                           p_txt_internal_name_m, -- p_txt_internal_name_m        M_LOAD_FORM_LINES.txt_internal_name_m%TYPE
                                                           p_txt_contents,        -- p_txt_contents        IN OUT clob
                                                           p_msg_retorno);        -- p_msg_retorno         IN OUT varchar2

      if p_retorno = TRUE then
         return p_txt_contents;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_txt_multiline_c;

-- fu_ret_txt_multiline_v
   FUNCTION fu_ret_txt_multiline_v (p_id_form             M_LOAD_FORM_LINES.id_form%TYPE,
                                    p_id_rownum_start     M_LOAD_FORM_LINES.id%TYPE,
                                    p_id_rownum_finish    M_LOAD_FORM_LINES.id%TYPE default 2147483648,
                                    p_txt_internal_name_m M_LOAD_FORM_LINES.txt_internal_name_m%TYPE)
                                    RETURN varchar2 IS
      p_retorno      boolean        := NULL;
      p_prc_name     varchar2(1000) := p_pck_name || 'fu_ret_txt_multiline_v (' || p_id_form             ||
                                                                           ', ' || p_id_rownum_start     ||
                                                                           ', ' || p_id_rownum_finish    ||
                                                                           ', ' || p_txt_internal_name_m || '): ';
      p_msg_retorno  varchar2(4000) := NULL;
      p_txt_contents varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_txt_multiline_b (p_id_form,             -- p_id_form                    M_LOAD_FORM_LINES.id_form%TYPE
                                                           p_id_rownum_start,     -- p_id_rownum_start            M_LOAD_FORM_LINES.id%TYPE
                                                           p_id_rownum_finish,    -- p_id_rownum_finish           M_LOAD_FORM_LINES.id%TYPE default 2147483648
                                                           p_txt_internal_name_m, -- p_txt_internal_name_m        M_LOAD_FORM_LINES.txt_internal_name_m%TYPE
                                                           p_txt_contents,        -- p_txt_contents        IN OUT clob
                                                           p_msg_retorno);        -- p_msg_retorno         IN OUT varchar2

      if p_retorno = TRUE then
         return substr (p_txt_contents, 1, 4000);
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_txt_multiline_v;

-- fu_ret_form_data_blocks_b
   FUNCTION fu_ret_form_data_blocks_b (p_id                 M_LOAD_FORM.id%TYPE,
                                       p_msg_retorno IN OUT varchar2)
                                       RETURN boolean IS
      r_imported_form            c_imported_form%ROWTYPE          := NULL;
      p_m_load_form_blocks_items m_load_form_blocks_items%ROWTYPE := NULL;
      p_txt_internal_name_m      m_load_form_lines.txt_internal_name_m%TYPE := NULL;
      p_block_items_section      boolean        := FALSE;
      p_block_relations_section  boolean        := FALSE;
      p_block_section            boolean        := TRUE;
      p_block_triggers_section   boolean        := FALSE;
      p_item_triggers_section    boolean        := FALSE;
      p_id_rownum_start          integer        := NULL;
      p_id_rownum_finish         integer        := NULL;
      p_object_name              varchar2(4000) := NULL;
      p_prc_name                 varchar2(1000) := p_pck_name || 'fu_ret_form_data_blocks_b (' || p_id || '): ';

   BEGIN
      if p_id is NULL then
         p_msg_retorno := 'O ID do form carregado deve ser informado.';
         return FALSE;
      else
         p_id_rownum_start  := PKG_IMPORT_FORM.fu_ret_1st_occurrenc_keyword_i (p_id, 'BLOCKS');
         p_id_rownum_finish := PKG_IMPORT_FORM.fu_ret_1st_occurrenc_keyword_i (p_id, 'CANVASES');

         if p_id_rownum_start is not NULL and p_id_rownum_finish is not NULL then
            for r_imported_form in c_imported_form (p_id, p_id_rownum_start, p_id_rownum_finish) loop
               p_txt_internal_name_m := r_imported_form.txt_internal_name_m;
               p_m_load_form_blocks_items.id_form := p_id;

               if r_imported_form.txt_internal_name_m = 'NAME' then
                  p_object_name := r_imported_form.txt_line_p; -- Can be block/item/block trigger/item trigger/relation name
                  p_m_load_form_blocks_items.id_rownum := r_imported_form.id;

                  if p_block_items_section = TRUE and p_block_triggers_section = FALSE and p_item_triggers_section = FALSE then
                     p_m_load_form_blocks_items.txt_item_name := p_object_name;
                  end if;
               end if;

               if r_imported_form.txt_internal_name_m = 'NAVIGATION_STYLE' then -- LINE READING HAS ENTERED A NEW BLOCK
                  p_block_items_section     := FALSE;
                  p_block_relations_section := FALSE;
                  p_block_section           := TRUE;
                  p_block_triggers_section  := FALSE;
                  p_item_triggers_section   := FALSE;

                  p_m_load_form_blocks_items.txt_data_origin                := 'BLOCKS AND ITEMS';
                  p_m_load_form_blocks_items.txt_block_name                 := p_object_name;
                  p_m_load_form_blocks_items.txt_item_name                  := NULL;
--                p_m_load_form_blocks_items.txt_comments                   := NULL;
                  p_m_load_form_blocks_items.num_block_records_display      := NULL;
                  p_m_load_form_blocks_items.txt_block_single_record        := NULL;
--                p_m_load_form_blocks_items.txt_block_database_data_block  := NULL;
                  p_m_load_form_blocks_items.txt_block_query_allowed        := NULL;
                  p_m_load_form_blocks_items.txt_block_insert_allowed       := NULL;
                  p_m_load_form_blocks_items.txt_block_update_allowed       := NULL;
                  p_m_load_form_blocks_items.txt_block_delete_allowed       := NULL;
                  p_m_load_form_blocks_items.txt_block_query_data_orig_type := NULL;
                  p_m_load_form_blocks_items.txt_block_query_data_orig_name := NULL;
                  p_m_load_form_blocks_items.txt_block_query_data_orig_clob := NULL;
                  p_m_load_form_blocks_items.txt_block_where_clause         := NULL;
                  p_m_load_form_blocks_items.txt_block_order_by             := NULL;
                  p_m_load_form_blocks_items.txt_item_item_type             := NULL;
                  p_m_load_form_blocks_items.txt_item_enabled               := NULL;
                  p_m_load_form_blocks_items.txt_item_justification         := NULL;
                  p_m_load_form_blocks_items.txt_item_multiline             := NULL;
                  p_m_load_form_blocks_items.txt_item_case_letter           := NULL;
                  p_m_load_form_blocks_items.txt_item_conceal_data          := NULL;
                  p_m_load_form_blocks_items.txt_item_field_autofill        := NULL;
                  p_m_load_form_blocks_items.txt_item_field_datatype        := NULL;
                  p_m_load_form_blocks_items.txt_item_field_maxlength       := NULL;
                  p_m_load_form_blocks_items.txt_item_field_scale           := NULL;
                  p_m_load_form_blocks_items.txt_item_field_precision       := NULL;
                  p_m_load_form_blocks_items.txt_item_field_inivalue        := NULL;
                  p_m_load_form_blocks_items.txt_item_field_mandatory       := NULL;
                  p_m_load_form_blocks_items.txt_item_field_format_mask     := NULL;
                  p_m_load_form_blocks_items.txt_item_field_minvalue        := NULL;
                  p_m_load_form_blocks_items.txt_item_field_maxvalue        := NULL;
                  p_m_load_form_blocks_items.txt_item_field_copy_value_from := NULL;
                  p_m_load_form_blocks_items.txt_item_field_database        := NULL;
                  p_m_load_form_blocks_items.txt_item_field_db_col_name     := NULL;
                  p_m_load_form_blocks_items.txt_item_field_primary_key     := NULL;
                  p_m_load_form_blocks_items.txt_item_field_read_only       := NULL;
                  p_m_load_form_blocks_items.txt_item_field_qry_allowed     := NULL;
                  p_m_load_form_blocks_items.txt_item_field_ins_allowed     := NULL;
                  p_m_load_form_blocks_items.txt_item_field_upd_allowed     := NULL;
                  p_m_load_form_blocks_items.txt_item_field_visible         := NULL;
                  p_m_load_form_blocks_items.txt_item_field_prompt          := NULL;
                  p_m_load_form_blocks_items.txt_item_field_hint_1          := NULL;
                  p_m_load_form_blocks_items.txt_item_field_hint_2          := NULL;
                  p_m_load_form_blocks_items.txt_item_calculation_mode      := NULL;
                  p_m_load_form_blocks_items.txt_observacoes                := NULL;
               end if;

               if r_imported_form.txt_internal_name_m = 'ITEM_TYPE' then
                  p_block_items_section     := TRUE;
                  p_block_relations_section := FALSE;
                  p_block_section           := FALSE;
                  p_block_triggers_section  := FALSE;
                  p_item_triggers_section   := FALSE;

                  p_m_load_form_blocks_items.txt_item_name                  := p_object_name;
                  p_m_load_form_blocks_items.txt_comments                   := NULL;
                  p_m_load_form_blocks_items.num_block_records_display      := NULL;
                  p_m_load_form_blocks_items.txt_block_single_record        := NULL;
--                p_m_load_form_blocks_items.txt_block_database_data_block  := NULL;
                  p_m_load_form_blocks_items.txt_block_query_allowed        := NULL;
                  p_m_load_form_blocks_items.txt_block_insert_allowed       := NULL;
                  p_m_load_form_blocks_items.txt_block_update_allowed       := NULL;
                  p_m_load_form_blocks_items.txt_block_delete_allowed       := NULL;
                  p_m_load_form_blocks_items.txt_block_query_data_orig_type := NULL;
                  p_m_load_form_blocks_items.txt_block_query_data_orig_name := NULL;
                  p_m_load_form_blocks_items.txt_block_query_data_orig_clob := NULL;
                  p_m_load_form_blocks_items.txt_block_where_clause         := NULL;
                  p_m_load_form_blocks_items.txt_block_order_by             := NULL;
                  p_m_load_form_blocks_items.txt_item_item_type             := NULL;
                  p_m_load_form_blocks_items.txt_item_enabled               := NULL;
                  p_m_load_form_blocks_items.txt_item_justification         := NULL;
                  p_m_load_form_blocks_items.txt_item_multiline             := NULL;
                  p_m_load_form_blocks_items.txt_item_case_letter           := NULL;
                  p_m_load_form_blocks_items.txt_item_conceal_data          := NULL;
                  p_m_load_form_blocks_items.txt_item_field_autofill        := NULL;
                  p_m_load_form_blocks_items.txt_item_field_datatype        := NULL;
                  p_m_load_form_blocks_items.txt_item_field_maxlength       := NULL;
                  p_m_load_form_blocks_items.txt_item_field_scale           := NULL;
                  p_m_load_form_blocks_items.txt_item_field_precision       := NULL;
                  p_m_load_form_blocks_items.txt_item_field_inivalue        := NULL;
                  p_m_load_form_blocks_items.txt_item_field_mandatory       := NULL;
                  p_m_load_form_blocks_items.txt_item_field_format_mask     := NULL;
                  p_m_load_form_blocks_items.txt_item_field_minvalue        := NULL;
                  p_m_load_form_blocks_items.txt_item_field_maxvalue        := NULL;
                  p_m_load_form_blocks_items.txt_item_field_copy_value_from := NULL;
                  p_m_load_form_blocks_items.txt_item_field_database        := NULL;
                  p_m_load_form_blocks_items.txt_item_field_db_col_name     := NULL;
                  p_m_load_form_blocks_items.txt_item_field_primary_key     := NULL;
                  p_m_load_form_blocks_items.txt_item_field_read_only       := NULL;
                  p_m_load_form_blocks_items.txt_item_field_qry_allowed     := NULL;
                  p_m_load_form_blocks_items.txt_item_field_ins_allowed     := NULL;
                  p_m_load_form_blocks_items.txt_item_field_upd_allowed     := NULL;
                  p_m_load_form_blocks_items.txt_item_field_visible         := NULL;
                  p_m_load_form_blocks_items.txt_item_field_prompt          := NULL;
                  p_m_load_form_blocks_items.txt_item_field_hint_1          := NULL;
                  p_m_load_form_blocks_items.txt_item_field_hint_2          := NULL;
                  p_m_load_form_blocks_items.txt_item_calculation_mode      := NULL;
                  p_m_load_form_blocks_items.txt_observacoes                := NULL;
               end if;

               if r_imported_form.txt_internal_name_m = 'TRIGGERS' then
                  if    p_block_section = TRUE and p_block_triggers_section = FALSE then
                     p_block_triggers_section := TRUE;
                  elsif p_block_items_section = TRUE and p_item_triggers_section = FALSE then
                     p_item_triggers_section  := TRUE;
                  end if;

                  BEGIN
                     insert into m_load_form_blocks_items values p_m_load_form_blocks_items;

                  EXCEPTION
                     when others then
                        p_msg_retorno := 'Erro INSERT MLFBI em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                        return FALSE;
                  END;
               end if;

               if r_imported_form.txt_internal_name_m = 'TRIGGER_STYLE' then
                  p_block_items_section     := FALSE;
                  p_block_relations_section := FALSE;
                  p_block_section           := FALSE;
                  p_block_triggers_section  := TRUE;
                  p_item_triggers_section   := TRUE;
               end if;

               if p_block_items_section = FALSE and p_block_relations_section = FALSE and p_block_section = TRUE and p_block_triggers_section = FALSE and p_item_triggers_section = FALSE then
                  if    r_imported_form.txt_internal_name_m = 'COMMENTS' then
                     p_m_load_form_blocks_items.txt_comments                   := PKG_IMPORT_FORM.fu_ret_txt_multiline_v (p_id_form             => p_id,
                                                                                                                          p_id_rownum_start     => r_imported_form.id_rownum,
                                                                                                                          p_txt_internal_name_m => 'NAVIGATION_STYLE');
                  elsif r_imported_form.txt_internal_name_m = 'NUMBER_ITEMS_DISPLAYED' then
                     p_m_load_form_blocks_items.num_block_records_display      := r_imported_form.txt_line_p;
                  elsif r_imported_form.txt_internal_name_m = 'SINGLE_RECORD' then
                     p_m_load_form_blocks_items.txt_block_single_record        := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'DATABASE_DATA_BLOCK' then
                     p_m_load_form_blocks_items.txt_block_database_data_block  := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'QUERY_ALLOWED' then
                     p_m_load_form_blocks_items.txt_block_query_allowed        := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'INSERT_ALLOWED' then
                     p_m_load_form_blocks_items.txt_block_insert_allowed       := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'UPDATE_ALLOWED' then
                     p_m_load_form_blocks_items.txt_block_update_allowed       := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'DELETE_ALLOWED' then
                     p_m_load_form_blocks_items.txt_block_delete_allowed       := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'QUERY_DATA_SOURCE_TYPE' then
                     p_m_load_form_blocks_items.txt_block_query_data_orig_type := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'QUERY_DATA_SOURCE_NAME' then
                     if p_m_load_form_blocks_items.txt_block_query_data_orig_type = 'FROM_WHERE_CLAUSE' then
                        p_m_load_form_blocks_items.txt_block_query_data_orig_clob := PKG_IMPORT_FORM.fu_ret_txt_multiline_v (p_id_form             => p_id,
                                                                                                                             p_id_rownum_start     => r_imported_form.id_rownum,
                                                                                                                             p_txt_internal_name_m => 'QUERY_DATA_ORIGIN_COLUMNS');
                        p_m_load_form_blocks_items.txt_block_query_data_orig_name := NULL;
                     else
                        p_m_load_form_blocks_items.txt_block_query_data_orig_name := trim (upper (r_imported_form.txt_line_p));
                     end if;
                  elsif r_imported_form.txt_internal_name_m = 'WHERE_CLAUSE' then
                     p_m_load_form_blocks_items.txt_block_where_clause         := PKG_IMPORT_FORM.fu_ret_txt_multiline_v (p_id_form             => p_id,
                                                                                                                          p_id_rownum_start     => r_imported_form.id_rownum,
                                                                                                                          p_txt_internal_name_m => 'ORDER_BY_CLAUSE');
                  elsif r_imported_form.txt_internal_name_m = 'ORDER_BY_CLAUSE' then
                     p_m_load_form_blocks_items.txt_block_order_by             := PKG_IMPORT_FORM.fu_ret_txt_multiline_v (p_id_form             => p_id,
                                                                                                                          p_id_rownum_start     => r_imported_form.id_rownum,
                                                                                                                          p_txt_internal_name_m => 'OPTIMIZER_HINT');
                  end if;
               end if;

               if p_block_items_section = TRUE and p_block_relations_section = FALSE and p_block_section = FALSE and p_block_triggers_section = FALSE and p_item_triggers_section = FALSE then
                  if    r_imported_form.txt_internal_name_m = 'ITEM_TYPE' then
                     p_m_load_form_blocks_items.txt_item_item_type             := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'ENABLED' then
                     p_m_load_form_blocks_items.txt_item_enabled               := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'JUSTIFICATION' then
                     p_m_load_form_blocks_items.txt_item_justification         := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'MULTILINE' then
                     p_m_load_form_blocks_items.txt_item_multiline             := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'CASE_RESTRICTION' then
                     p_m_load_form_blocks_items.txt_item_case_letter           := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'CONCEAL_DATA' then
                     p_m_load_form_blocks_items.txt_item_conceal_data          := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'AUTOMATIC_SKIP' then
                     p_m_load_form_blocks_items.txt_item_field_autofill        := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'DATA_TYPE' then
                     p_m_load_form_blocks_items.txt_item_field_datatype        := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'MAXIMUM_LENGTH' then
                     p_m_load_form_blocks_items.txt_item_field_maxlength       := r_imported_form.txt_line_p;
                  elsif r_imported_form.txt_internal_name_m = 'INITIAL_VALUE' then
                     p_m_load_form_blocks_items.txt_item_field_inivalue        := r_imported_form.txt_line_p;
                  elsif r_imported_form.txt_internal_name_m = 'REQUIRED' then
                     p_m_load_form_blocks_items.txt_item_field_mandatory       := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'FORMAT_MASK' then
                     p_m_load_form_blocks_items.txt_item_field_format_mask     := r_imported_form.txt_line_p;
                  elsif r_imported_form.txt_internal_name_m = 'MIN_VALUE' then
                     p_m_load_form_blocks_items.txt_item_field_minvalue        := r_imported_form.txt_line_p;
                  elsif r_imported_form.txt_internal_name_m = 'MAX_VALUE' then
                     p_m_load_form_blocks_items.txt_item_field_maxvalue        := r_imported_form.txt_line_p;
                  elsif r_imported_form.txt_internal_name_m = 'COPY_VALUE_FROM_ITEM' then
                     p_m_load_form_blocks_items.txt_item_field_copy_value_from := r_imported_form.txt_line_p;
                  elsif r_imported_form.txt_internal_name_m = 'DATABASE_ITEM' then
                     p_m_load_form_blocks_items.txt_item_field_database        := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'COLUMN_NAME' and p_m_load_form_blocks_items.txt_item_field_database = 'YES' then
                     p_m_load_form_blocks_items.txt_item_field_db_col_name     := nvl (r_imported_form.txt_line_p, p_m_load_form_blocks_items.txt_item_name);
                  elsif r_imported_form.txt_internal_name_m = 'COLUMN_NAME' and p_m_load_form_blocks_items.txt_item_field_database = 'NO' then
                     p_m_load_form_blocks_items.txt_item_field_db_col_name     := NULL;
                  elsif r_imported_form.txt_internal_name_m = 'PRIMARY_KEY' then
                     p_m_load_form_blocks_items.txt_item_field_primary_key     := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'QUERY_ONLY' then
                     p_m_load_form_blocks_items.txt_item_field_read_only       := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'QUERY_ALLOWED' then
                     p_m_load_form_blocks_items.txt_item_field_qry_allowed     := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'INSERT_ALLOWED' then
                     p_m_load_form_blocks_items.txt_item_field_ins_allowed     := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'UPDATE_ALLOWED' then
                     p_m_load_form_blocks_items.txt_item_field_upd_allowed     := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'ITEM_VISIBLE' then
                     p_m_load_form_blocks_items.txt_item_field_visible         := r_imported_form.txt_internal_name_p;
                  elsif r_imported_form.txt_internal_name_m = 'PROMPT' then
                     p_m_load_form_blocks_items.txt_item_field_prompt          := r_imported_form.txt_line_p;
                  elsif r_imported_form.txt_internal_name_m = 'HINT' then
                     p_m_load_form_blocks_items.txt_item_field_hint_1          := r_imported_form.txt_line_p;
                  elsif r_imported_form.txt_internal_name_m = 'TOOLTIP_HINT' then
                     p_m_load_form_blocks_items.txt_item_field_hint_2          := r_imported_form.txt_line_p;
                  elsif r_imported_form.txt_internal_name_m = 'CALCULATION_MODE' then
                     p_m_load_form_blocks_items.txt_item_calculation_mode      := r_imported_form.txt_line_p;
                  elsif r_imported_form.txt_internal_name_m = 'COMMENTS' then
                     p_m_load_form_blocks_items.txt_comments                   := PKG_IMPORT_FORM.fu_ret_txt_multiline_v (p_id_form             => p_id,
                                                                                                                          p_id_rownum_start     => r_imported_form.id_rownum,
                                                                                                                          p_txt_internal_name_m => 'HELP_BOOK_TOPIC');
                  end if;

                  if    p_m_load_form_blocks_items.txt_item_field_datatype = 'NUMBER' then
                     if    p_m_load_form_blocks_items.txt_item_field_maxlength < 1 then
                        p_m_load_form_blocks_items.txt_observacoes          := p_m_load_form_blocks_items.txt_block_name || '.' ||
                                                                               p_m_load_form_blocks_items.txt_item_name || ': ' ||
                                                                               p_m_load_form_blocks_items.txt_item_field_datatype || '(' ||
                                                                               p_m_load_form_blocks_items.txt_item_field_maxlength || ')';
                        p_m_load_form_blocks_items.txt_item_field_maxlength := 1;
                     elsif p_m_load_form_blocks_items.txt_item_field_maxlength > 38 then
                        p_m_load_form_blocks_items.txt_observacoes          := p_m_load_form_blocks_items.txt_block_name || '.' ||
                                                                               p_m_load_form_blocks_items.txt_item_name || ': ' ||
                                                                               p_m_load_form_blocks_items.txt_item_field_datatype || '(' ||
                                                                               p_m_load_form_blocks_items.txt_item_field_maxlength || ')';
                        p_m_load_form_blocks_items.txt_item_field_maxlength := 38;
                     end if;
                  elsif p_m_load_form_blocks_items.txt_item_field_datatype = 'INTEGER' then
                     p_m_load_form_blocks_items.txt_observacoes          := p_m_load_form_blocks_items.txt_block_name || '.' ||
                                                                            p_m_load_form_blocks_items.txt_item_name || ': ' ||
                                                                            p_m_load_form_blocks_items.txt_item_field_datatype || '(' ||
                                                                            p_m_load_form_blocks_items.txt_item_field_maxlength || ')';
                     p_m_load_form_blocks_items.txt_item_field_maxlength := NULL;
                  end if;
               end if;
            end loop;
         end if;
      end if;

      commit;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro "' || p_txt_internal_name_m || '" em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_form_data_blocks_b;

-- fu_ret_block_tables_columns_b
   FUNCTION fu_ret_block_tables_columns_b (p_id                 M_LOAD_FORM.id%TYPE,
                                           p_msg_retorno IN OUT varchar2)
                                           RETURN boolean IS
      p_m_load_form_blocks_items     m_load_form_blocks_items%ROWTYPE := NULL;
      p_database_data_block          boolean        := NULL;
      p_query_data_source_type_table boolean        := NULL;
      p_column_count                 integer        := 0;
      p_column_length                integer        := NULL;
      p_column_precision             integer        := NULL;
      p_column_scale                 integer        := NULL;
      p_id_rownum_start              integer        := NULL;
      p_id_rownum_finish             integer        := NULL;
      p_column_type                  varchar2(100)  := NULL;
      p_object_name                  varchar2(100)  := NULL;
      p_txt_block_name               varchar2(100)  := NULL;
      p_prc_name                     varchar2(1000) := p_pck_name || 'fu_ret_block_tables_columns_b (' || p_id || '): ';

   BEGIN
      if p_id is NULL then
         p_msg_retorno := 'O ID do form carregado deve ser informado.';
         return FALSE;
      else
         p_id_rownum_start  := PKG_IMPORT_FORM.fu_ret_1st_occurrenc_keyword_i (p_id, 'BLOCKS');
         p_id_rownum_finish := PKG_IMPORT_FORM.fu_ret_1st_occurrenc_keyword_i (p_id, 'CANVASES');

         if p_id_rownum_start is not NULL and p_id_rownum_finish is not NULL then
            for r_imported_form in c_imported_form (p_id, p_id_rownum_start, p_id_rownum_finish) loop
               if r_imported_form.txt_internal_name_m = 'NAME' then
                  p_object_name                  := r_imported_form.txt_line_p;
                  p_column_count                 := 0;
                  p_column_type                  := NULL;
                  p_column_length                := NULL;
                  p_column_precision             := NULL;
                  p_column_scale                 := NULL;
                  p_database_data_block          := FALSE;
                  p_query_data_source_type_table := FALSE;
               end if;

               if r_imported_form.txt_internal_name_m = 'SUBCLASS_INFORMATION' then
                  p_txt_block_name := p_object_name;
               end if;

               if r_imported_form.txt_internal_name_m = 'DATABASE_DATA_BLOCK' and p_database_data_block = FALSE then
                  if    r_imported_form.txt_internal_name_p = 'YES' then
                     p_database_data_block := TRUE;
                  elsif r_imported_form.txt_internal_name_p = 'NO' then
                     p_database_data_block := FALSE;
                  end if;
               end if;

               if p_database_data_block = TRUE then
                  if r_imported_form.txt_internal_name_m = 'QUERY_DATA_SOURCE_TYPE' then
                     if r_imported_form.txt_internal_name_p = 'TABLE' then
                        p_query_data_source_type_table := TRUE;
                     else
                        p_query_data_source_type_table := FALSE;
                     end if;
                  end if;
               end if;

               if p_database_data_block = TRUE and p_query_data_source_type_table = TRUE then
                  if r_imported_form.txt_internal_name_m = 'QUERY_DATA_SOURCE_NAME' then
                     p_object_name              := nvl (r_imported_form.txt_line_p, p_object_name);
                     p_m_load_form_blocks_items := NULL;

                     p_m_load_form_blocks_items.id_form                        := p_id;
                     p_m_load_form_blocks_items.id_rownum                      := r_imported_form.id_rownum;
                     p_m_load_form_blocks_items.txt_block_name                 := p_txt_block_name;
                     p_m_load_form_blocks_items.txt_data_origin                := 'QUERY DATA SOURCE COLUMNS';
                     p_m_load_form_blocks_items.txt_block_query_data_orig_type := 'TABLE';
                     p_m_load_form_blocks_items.txt_block_query_data_orig_name := p_object_name;
                  end if;

                  if r_imported_form.txt_internal_name_m = 'COLUMN_NAME' then
                     p_m_load_form_blocks_items.id_form                        := p_id;
                     p_m_load_form_blocks_items.id_rownum                      := r_imported_form.id_rownum;
                     p_m_load_form_blocks_items.txt_block_name                 := p_txt_block_name;
                     p_m_load_form_blocks_items.txt_data_origin                := 'QUERY DATA SOURCE COLUMNS';
                     p_m_load_form_blocks_items.txt_block_query_data_orig_type := 'TABLE';
                     p_m_load_form_blocks_items.txt_block_query_data_orig_name := p_object_name;
                     p_m_load_form_blocks_items.txt_item_name                  := r_imported_form.txt_line_p;

                     p_column_count := p_column_count + 1;
                  end if;

                  if r_imported_form.txt_internal_name_m = 'COLUMN_TYPE' then
                     p_m_load_form_blocks_items.id_rownum                      := r_imported_form.id_rownum;
                     p_m_load_form_blocks_items.txt_item_field_datatype        := r_imported_form.txt_line_p;
                  end if;

                  if r_imported_form.txt_internal_name_m = 'COLUMN_LENGTH' then
                     p_m_load_form_blocks_items.id_rownum                      := r_imported_form.id_rownum;
                     p_m_load_form_blocks_items.txt_item_field_maxlength       := r_imported_form.txt_line_p;
                  end if;

                  if r_imported_form.txt_internal_name_m = 'COLUMN_PRECISION' then
                     p_m_load_form_blocks_items.id_rownum                      := r_imported_form.id_rownum;
                     p_m_load_form_blocks_items.txt_item_field_precision       := r_imported_form.txt_line_p;
                  end if;

                  if r_imported_form.txt_internal_name_m = 'COLUMN_SCALE' then
                     p_m_load_form_blocks_items.id_rownum                      := r_imported_form.id_rownum;
                     p_m_load_form_blocks_items.txt_item_field_scale           := r_imported_form.txt_line_p;
                  end if;

                  if r_imported_form.txt_internal_name_m = 'REQUIRED' then
                     p_m_load_form_blocks_items.id_rownum                      := r_imported_form.id_rownum;
                     p_m_load_form_blocks_items.txt_item_field_mandatory       := r_imported_form.txt_internal_name_p;
                  end if;
               end if;

               if   r_imported_form.txt_internal_name_m in ('QUERY_DATA_ORIGIN_COLUMNS', 'REQUIRED')
                and p_m_load_form_blocks_items.id_rownum is not NULL
                and p_column_count > 0 then
                  BEGIN
                     insert into m_load_form_blocks_items values p_m_load_form_blocks_items;
                     p_m_load_form_blocks_items := NULL;

                  EXCEPTION
                     when others then
                        p_msg_retorno := 'Erro INSERT MLFBI (' || r_imported_form.id_rownum ||
                                         ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                        return FALSE;
                  END;
               end if;
            end loop;
         end if;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_block_tables_columns_b;

-- fu_remove_plsql_comments_b
   FUNCTION fu_remove_plsql_comments_b (p_clob_plsql_contents                M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE,
                                        p_clob_plsql_contents_no_comm IN OUT M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents_no_comm%TYPE,
                                        p_msg_retorno                 IN OUT varchar2)
                                        RETURN boolean IS
      p_clob_plsql_contents_edit M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE := NULL;
      p_multiline_line_analysis  boolean        := FALSE;
      p_instr_chr_10             integer        := NULL;
      p_prc_name                 varchar2(1000) := p_pck_name || 'fu_remove_plsql_comments_b: ';
      p_line_analysis            varchar2(4000) := NULL;

   BEGIN
      if trim (p_clob_plsql_contents) in (NULL, empty_clob()) then
         p_msg_retorno := 'Erro ' || p_prc_name || 'PL/SQL was not informed.';
         return FALSE;
      else
         p_clob_plsql_contents_edit := p_clob_plsql_contents;
         p_multiline_line_analysis  := FALSE;

         loop
            p_instr_chr_10  := instr (p_clob_plsql_contents_edit, chr(10));
            exit when p_instr_chr_10 = 0; -- EXITS LOOP WHEN NO NEW LINES ARE FOUND (NO MORE PL/SQL CONTENTS)

            p_line_analysis := rtrim (translate (substr (p_clob_plsql_contents_edit, 1, p_instr_chr_10), chr(9) || chr(10), '  '));

-- REMOVE COMMENTS FROM PL/SQL LINE
            if instr (p_line_analysis, '--') > 0 then
               p_line_analysis := rtrim (substr (p_line_analysis, 1, instr (p_line_analysis, '--') - 1));
            end if;

            if instr (p_line_analysis, '/*') > 0 and instr (p_line_analysis, '*/') > 0 then
               p_line_analysis := rtrim (rtrim (substr (p_line_analysis, 1, instr (p_line_analysis, '/*') - 1)) || ' ' ||
                                         rtrim (substr (p_line_analysis,    instr (p_line_analysis, '*/') + 2)));
            end if;

            if    instr (p_line_analysis, '/*') > 0 and instr (p_line_analysis, '*/') = 0 and p_multiline_line_analysis = FALSE then
               p_multiline_line_analysis := TRUE;
            elsif instr (p_line_analysis, '/*') = 0 and instr (p_line_analysis, '*/') > 0 and p_multiline_line_analysis = TRUE then
               p_line_analysis           := rtrim (substr (p_line_analysis, instr (p_line_analysis, '*/') + 2));
               p_multiline_line_analysis := FALSE;
            end if;

            if p_multiline_line_analysis = TRUE then
               if    instr (p_line_analysis, '/*') > 0 then
                  p_line_analysis := rtrim (substr (p_line_analysis, 1, instr (p_line_analysis, '/*') - 2));
               elsif instr (p_line_analysis, '/*') = 0 and instr (p_line_analysis, '*/') = 0 then
                  p_line_analysis := NULL;
               elsif instr (p_line_analysis, '*/') > 0 then
                  p_line_analysis := rtrim (substr (p_line_analysis, instr (p_line_analysis, '*/') + 2));
               end if;
            end if;

            p_clob_plsql_contents_edit    := substr (p_clob_plsql_contents_edit, p_instr_chr_10 + 1);
            p_clob_plsql_contents_no_comm := p_clob_plsql_contents_no_comm || p_line_analysis || chr(10);
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_remove_plsql_comments_b;

-- fu_remove_plsql_comments_c
   FUNCTION fu_remove_plsql_comments_c (p_clob_plsql_contents M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE)
                                        RETURN M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE IS
      p_clob_plsql_contents_no_comm M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE := empty_clob();
      p_retorno     boolean        := NULL;
      p_prc_name    varchar2(1000) := p_pck_name || 'fu_remove_plsql_comments_c: ';
      p_msg_retorno varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_remove_plsql_comments_b (p_clob_plsql_contents,
                                                               p_clob_plsql_contents_no_comm,
                                                               p_msg_retorno);

      if p_retorno = TRUE then
         return p_clob_plsql_contents_no_comm;
      else
         return 'Error P_RETORNO at ' || p_prc_name || p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_remove_plsql_comments_c;

-- fu_collect_pck_program_units_b
   FUNCTION fu_collect_pck_program_units_b (p_id_form                      M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_txt_plsql_object_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_plsql_object_name%TYPE,
                                            p_msg_retorno           IN OUT varchar2)
                                            RETURN boolean IS
      p_m_load_form_plsql_contents  m_load_form_plsql_contents%ROWTYPE := NULL;
      p_clob_plsql_contents         M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE         := empty_clob();
      p_clob_plsql_contents_no_comm M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents_no_comm%TYPE := empty_clob();
      p_txt_plsql_program_unit_type M_LOAD_FORM_PLSQL_CONTENTS.txt_plsql_program_unit_type%TYPE := NULL;
      p_declaration_line_found boolean        := NULL;
      p_instr_prc_fnc          integer        := NULL;
      p_instr_package          integer        := NULL;
      p_instr_body             integer        := NULL;
      p_instr_pck_name         integer        := NULL;
      p_instr_is               integer        := NULL;
      p_instr_chr_10           integer        := NULL;
      p_prc_name               varchar2(1000) := p_pck_name || 'fu_collect_pck_program_units_b (' || p_id_form || ', ' || p_txt_plsql_object_name || '): ';
      p_line_analysis          varchar2(4000) := NULL;

   BEGIN
      if p_id_form is not NULL and trim (p_txt_plsql_object_name) is not NULL then
         BEGIN
            select mlfpc.*
              into p_m_load_form_plsql_contents
              from m_load_form_plsql_contents mlfpc
             where mlfpc.id_form                     = p_id_form
               and mlfpc.txt_plsql_object_name       = p_txt_plsql_object_name
               and mlfpc.txt_plsql_source            = 'PROGRAM UNIT'
               and mlfpc.txt_plsql_program_unit_type = 'PACKAGE_BODY';

            p_clob_plsql_contents_no_comm := p_m_load_form_plsql_contents.clob_plsql_contents_no_comm;

         EXCEPTION
            when no_data_found then
               p_msg_retorno := 'Error ' || p_prc_name || 'package not found.';
               return FALSE;
            when others then
               p_msg_retorno := 'Error SELECT MLFPC NO_COMM at ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

         if p_clob_plsql_contents_no_comm != empty_clob() then
            p_declaration_line_found := FALSE;

            loop
               p_instr_chr_10                := instr (p_clob_plsql_contents_no_comm, chr(10));
               exit when p_instr_chr_10 = 0; -- EXITS LOOP WHEN NO NEW LINES ARE FOUND (NO MORE PL/SQL CONTENTS)

               p_line_analysis               := rtrim (translate (substr (p_clob_plsql_contents_no_comm, 1, p_instr_chr_10), chr(9) || chr(10), '  '));
               p_clob_plsql_contents_no_comm := substr (p_clob_plsql_contents_no_comm, p_instr_chr_10 + 1);

               if p_declaration_line_found = FALSE then
                  p_instr_package  := instr (trim (upper (translate (p_line_analysis, chr(10), ' '))), 'PACKAGE ');
                  p_instr_body     := instr (trim (upper (translate (p_line_analysis, chr(10), ' '))), 'BODY ');
                  p_instr_pck_name := instr (trim (upper (translate (p_line_analysis, chr(10), ' '))), p_txt_plsql_object_name || ' ');
                  p_instr_is       := instr (upper (translate (p_line_analysis, chr(10), ' ')), ' IS');

                  if p_instr_package > 0 and p_instr_body > 0 and p_instr_pck_name > 0 and p_instr_is > 0 then
                     p_declaration_line_found := TRUE;
                  end if;
               else
                  p_instr_prc_fnc := instr (trim (upper (translate (p_line_analysis, chr(10), ' '))), 'PROCEDURE ');

                  if p_instr_prc_fnc = 0 then
                     p_instr_prc_fnc               := instr (trim (upper (translate (p_line_analysis, chr(9) || chr(10), '  '))), 'FUNCTION ');
                     p_txt_plsql_program_unit_type := 'FUNCTION';
                  else
                     p_txt_plsql_program_unit_type := 'PROCEDURE';
                  end if;

                  if p_instr_prc_fnc > 0 and nvl (trim (translate (p_clob_plsql_contents, chr(10), ' ')), chr(10)) != chr(10) then
                     p_m_load_form_plsql_contents.id_form                     := p_id_form;
                     p_m_load_form_plsql_contents.txt_plsql_program_unit_type := p_txt_plsql_program_unit_type;
                     p_m_load_form_plsql_contents.clob_plsql_contents         := p_clob_plsql_contents;

                     if    p_txt_plsql_program_unit_type = 'FUNCTION' then
                        p_m_load_form_plsql_contents.txt_plsql_object_name := 'F';
                     elsif p_txt_plsql_program_unit_type = 'PROCEDURE' then
                        p_m_load_form_plsql_contents.txt_plsql_object_name := 'P';
                     end if;

                     BEGIN
                        insert into m_load_form_plsql_contents values p_m_load_form_plsql_contents;

                     EXCEPTION
                        when others then
                           p_msg_retorno := 'Error INSERT MLFPC 1 at ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                           return FALSE;
                     END;

                     p_clob_plsql_contents := empty_clob();
                  end if;

                  p_clob_plsql_contents := p_clob_plsql_contents || p_line_analysis || chr(10);
               end if;
            end loop;

            p_m_load_form_plsql_contents.id_form                     := p_id_form;
            p_m_load_form_plsql_contents.txt_plsql_program_unit_type := p_txt_plsql_program_unit_type;
            p_m_load_form_plsql_contents.txt_plsql_object_name       := p_txt_plsql_object_name;
            p_m_load_form_plsql_contents.clob_plsql_contents         := p_clob_plsql_contents;

            BEGIN
               insert into m_load_form_plsql_contents values p_m_load_form_plsql_contents;

            EXCEPTION
               when others then
                  p_msg_retorno := 'Error INSERT MLFPC 1 at ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                  return FALSE;
            END;
         end if;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_collect_pck_program_units_b;

-- fu_ret_plsql_program_units_b
   FUNCTION fu_ret_plsql_program_units_b (p_id_form            M_LOAD_FORM_LINES.id_form%TYPE,
                                          p_type               varchar2,
                                          p_msg_retorno IN OUT varchar2)
                                          RETURN boolean IS
      cursor c_imported_form_prog_units (p_id           integer,
                                         p_rownum_start integer) is
         select mlfl.*
           from m_load_form_lines mlfl
          where mlfl.id_form   = p_id
            and mlfl.id_rownum > nvl (p_rownum_start, 0)
            and nvl (p_rownum_start, 0) > 0
          order by mlfl.id;

      cursor c_m_load_form_plsql_contents is
         select mlfpc.*
           from m_load_form_plsql_contents mlfpc
          where mlfpc.id_form = p_id_form;

      p_m_load_form_plsql_contents m_load_form_plsql_contents%ROWTYPE   := NULL;
      r_imported_form_prog_units   c_imported_form_prog_units%ROWTYPE   := NULL;
      r_m_load_form_plsql_contents c_m_load_form_plsql_contents%ROWTYPE := NULL;
      p_retorno                    boolean        := NULL;
      p_id_rownum_object_name      integer        := NULL;
      p_id_rownum_object_type      integer        := NULL;
      p_id_rownum_prog_unit_text   integer        := NULL;
      p_id_rownum_start            integer        := NULL;
      p_id_rownum_finish           integer        := NULL;
      p_object_name                varchar2(100)  := NULL;
      p_object_type                varchar2(100)  := NULL;
      p_prc_name                   varchar2(1000) := p_pck_name || 'fu_ret_plsql_program_units_b (' || p_id_form || ', ' || p_type || '): ';

   BEGIN
      if    p_id_form is NULL then
         p_msg_retorno := 'O ID do form carregado deve ser informado.';
         return FALSE;
      elsif trim (p_type) is NULL then
         p_msg_retorno := 'Informe o tipo (SPEC/BODY).';
         return FALSE;
      else
         p_id_rownum_start  := PKG_IMPORT_FORM.fu_ret_1st_occurrenc_keyword_i (p_id_form, 'PROGRAM_UNITS');
         p_id_rownum_finish := PKG_IMPORT_FORM.fu_ret_1st_occurrenc_keyword_i (p_id_form, 'PROPERTY_CLASSES');

         for r_imported_form in c_imported_form (p_id_form, p_id_rownum_start, p_id_rownum_finish) loop
            if    r_imported_form.txt_internal_name_m = 'NAME' then
               p_object_name                := r_imported_form.txt_line_p;
               p_id_rownum_object_name      := r_imported_form.id_rownum;
               p_m_load_form_plsql_contents := NULL;

               p_m_load_form_plsql_contents.id_form               := p_id_form;
               p_m_load_form_plsql_contents.id_rownum             := r_imported_form.id_rownum;
               p_m_load_form_plsql_contents.txt_plsql_object_name := p_object_name;
               p_m_load_form_plsql_contents.txt_plsql_source      := 'PROGRAM UNIT';
            elsif r_imported_form.txt_internal_name_m = 'PROGRAM_UNIT_TYPE' then
               p_object_type           := r_imported_form.txt_internal_name_p;
               p_m_load_form_plsql_contents.txt_plsql_program_unit_type := r_imported_form.txt_internal_name_p;
               p_id_rownum_object_type := r_imported_form.id_rownum;

               if p_m_load_form_plsql_contents.clob_plsql_contents is not NULL then
                  BEGIN
                     insert into m_load_form_plsql_contents values p_m_load_form_plsql_contents;

                  EXCEPTION
                     when others then
                        p_msg_retorno := 'Erro INSERT MLFPC 2 (' || p_m_load_form_plsql_contents.id_rownum ||
                                         ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                        return FALSE;
                  END;
               end if;
            elsif r_imported_form.txt_internal_name_m = 'PROGRAM_UNIT_TEXT' then
               p_id_rownum_prog_unit_text := r_imported_form.id_rownum;
            end if;

            if    trim (upper (p_type)) = 'SPEC' and p_object_name is not NULL and p_object_type is not NULL then
               p_object_name := NULL;
               p_object_type := NULL;
            elsif trim (upper (p_type)) = 'BODY' and p_id_rownum_prog_unit_text is not NULL then
               for r_imported_form_prog_units in c_imported_form_prog_units (p_id_form, p_id_rownum_prog_unit_text) loop
                  exit when r_imported_form_prog_units.txt_internal_name_m = 'PROGRAM_UNIT_TYPE';

                  p_m_load_form_plsql_contents.clob_plsql_contents := p_m_load_form_plsql_contents.clob_plsql_contents
                                                                      || r_imported_form_prog_units.txt_line || chr(10);
               end loop;

               p_id_rownum_prog_unit_text := NULL;
            end if;
         end loop;

--       if p_type = 'BODY' then
--          for r_m_load_form_plsql_contents in c_m_load_form_plsql_contents loop
--             if r_m_load_form_plsql_contents.txt_plsql_program_unit_type = 'PACKAGE_BODY' then
--                p_retorno := PKG_IMPORT_FORM.fu_collect_pck_program_units_b (r_m_load_form_plsql_contents.id_form,
--                                                                             r_m_load_form_plsql_contents.txt_plsql_object_name,
--                                                                             p_msg_retorno);
--
--                if p_retorno != TRUE then
--                   p_msg_retorno := 'Error COLLECT at ' || p_prc_name || p_msg_retorno;
--                   return FALSE;
--                end if;
--             end if;
--          end loop;
--       end if;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_plsql_program_units_b;

-- fu_ret_txt_select_query_name_c
   FUNCTION fu_ret_txt_select_query_name_c (p_id_form               M_LOAD_FORM.id%TYPE,
                                            p_txt_record_group_name M_LOAD_FORM_RECORD_GROUPS.txt_record_group_name%TYPE)
                                            RETURN clob IS
      cursor c_record_group_cols is
         select 't.' || lower (mlfrg.txt_record_group_col_name) as txt_record_group_col_name_t,
                mlfrg.txt_record_group_col_name
           from m_load_form_record_groups mlfrg
          where mlfrg.id_form               = p_id_form
            and mlfrg.txt_record_group_name = trim (upper (p_txt_record_group_name));

      r_record_group_cols  c_record_group_cols%ROWTYPE := NULL;
      p_txt_plsql_routine  clob           := empty_clob();
      p_count              integer        := 0;
      p_package_name       varchar2(50)   := NULL;
      p_txt_form_name      varchar2(50)   := NULL;
      p_function_pipelined varchar2(100)  := NULL;
      p_prc_name           varchar2(1000) := p_pck_name || 'fu_ret_txt_select_query_name_c (' || p_id_form || ', ' || p_txt_record_group_name || '): ';

   BEGIN
      if p_id_form is not NULL and trim (p_txt_record_group_name) is not NULL then
         p_txt_form_name      := PKG_IMPORT_FORM.fu_obter_nome_form_v (p_id_form);
         p_package_name       := upper (trim (PKG_IMPORT_FORM.p_package_prefix) || p_txt_form_name);
         p_function_pipelined := PKG_IMPORT_FORM.fu_ret_function_name_pipelin_v (p_txt_record_group_name);
         p_txt_plsql_routine  := '-- ' || p_txt_record_group_name || chr(10) ||
                                 'DECLARE' || chr(10) ||
                                 p_indent || p_prc_name_v || ' varchar2(100) := ''' || p_txt_record_group_name || ': '';' || chr(10) ||
                                 chr(10) ||
                                 'BEGIN' || chr(10);

         for r_record_group_cols in c_record_group_cols loop
            p_count             := p_count + 1;

            if p_count = 1 then
               p_txt_plsql_routine := p_txt_plsql_routine || p_indent || 'select ';
            else
               p_txt_plsql_routine := p_txt_plsql_routine || p_indent || '     , ';
            end if;

            p_txt_plsql_routine := p_txt_plsql_routine || r_record_group_cols.txt_record_group_col_name_t || chr(10);
         end loop;

         p_count             := 0;

         for r_record_group_cols in c_record_group_cols loop
            p_count             := p_count + 1;

            if p_count = 1 then
               p_txt_plsql_routine := p_txt_plsql_routine || p_indent || '  into ';
            else
               p_txt_plsql_routine := p_txt_plsql_routine || p_indent || '     , ';
            end if;

            p_txt_plsql_routine := p_txt_plsql_routine || PKG_IMPORT_FORM.p_oracle_apex_prefix || upper (r_record_group_cols.txt_record_group_col_name) || chr(10);
         end loop;

         p_txt_plsql_routine  := p_txt_plsql_routine || p_indent || '  from table (' || p_package_name || '.' || p_function_pipelined || ') t;' || chr(10) ||
                                 chr(10) ||
                                 'EXCEPTION' || chr(10) ||
                                 p_indent || 'when others then' || chr(10) ||
                                 p_indent || p_indent || 'APEX_ERROR.add_error (p_message => ''' || p_error_text_v ||
                                                         ' '' || ' || p_prc_name_v || ' || ' ||
                                                         'to_char (sqlcode) || '' - '' || sqlerrm, p_display_location => ''INLINE_IN_NOTIFICATION'');' ||
                                 chr(10) ||
                                 'END;' || chr(10) ||
                                 chr(10);
      end if;

      return p_txt_plsql_routine;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_txt_select_query_name_c;

-- fu_ret_txt_select_query_name_b
   FUNCTION fu_ret_txt_select_query_name_b (p_id_form                      M_LOAD_FORM.id%TYPE,
                                            p_txt_record_group_name        M_LOAD_FORM_RECORD_GROUPS.txt_record_group_name%TYPE,
                                            p_txt_plsql_routine     IN OUT clob,
                                            p_msg_retorno           IN OUT varchar2)
                                            RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_txt_select_query_name_b (' || p_id_form || ', ' || p_txt_record_group_name || '): ';

   BEGIN
      if    p_id_form is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form carregado deve ser informado.';
         return FALSE;
      elsif p_txt_record_group_name is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form carregado deve ser informado.';
         return FALSE;
      else
         p_txt_plsql_routine := PKG_IMPORT_FORM.fu_ret_txt_select_query_name_c (p_id_form, p_txt_record_group_name);
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_txt_select_query_name_b;

-- fu_ret_txt_select_query_lovs_b
   FUNCTION fu_ret_txt_select_query_lovs_b (p_id_form                     M_LOAD_FORM.id%TYPE,
                                            p_txt_select_query_lov IN OUT M_LOAD_FORM.txt_select_query_lov%TYPE,
                                            p_msg_retorno          IN OUT varchar2)
                                            RETURN boolean IS
      cursor c_m_load_form_record_groups is
         select distinct mlfrg.txt_record_group_name
           from m_load_form_record_groups mlfrg
          where mlfrg.id_form = p_id_form;

      r_m_load_form_record_groups c_m_load_form_record_groups%ROWTYPE := NULL;
      p_retorno           boolean        := NULL;
      p_txt_plsql_routine clob           := empty_clob();
      p_prc_name          varchar2(1000) := p_pck_name || 'fu_ret_txt_select_query_lovs_b (' || p_id_form || ', ' || p_txt_select_query_lov || '): ';

   BEGIN
      if p_id_form is NULL then
         p_msg_retorno := 'O ID do form carregado deve ser informado.';
         return FALSE;
      else
         for r_m_load_form_record_groups in c_m_load_form_record_groups loop
            p_retorno := PKG_IMPORT_FORM.fu_ret_txt_select_query_name_b (p_id_form, r_m_load_form_record_groups.txt_record_group_name, p_txt_plsql_routine, p_msg_retorno);

            if p_retorno = TRUE then
               p_txt_select_query_lov := p_txt_select_query_lov || p_txt_plsql_routine;
            else
               return p_retorno;
            end if;
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_txt_select_query_lovs_b;

-- fu_ret_txt_select_query_lovs_c
   FUNCTION fu_ret_txt_select_query_lovs_c (p_id_form M_LOAD_FORM.id%TYPE)
                                            RETURN M_LOAD_FORM.txt_select_query_lov%TYPE IS
      p_txt_select_query_lov M_LOAD_FORM.txt_select_query_lov%TYPE := empty_clob();
      p_retorno              boolean        := NULL;
      p_prc_name             varchar2(1000) := p_pck_name || 'fu_ret_txt_select_query_lovs_b (' || p_id_form || ', ' || p_txt_select_query_lov || '): ';
      p_msg_retorno          varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_txt_select_query_lovs_b (p_id_form, p_txt_select_query_lov, p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_select_query_lov;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_txt_select_query_lovs_c;

-- fu_ret_static_values_b
   FUNCTION fu_ret_static_values_b (p_id_form            M_LOAD_FORM_LINES.id_form%TYPE,
                                    p_msg_retorno IN OUT varchar2)
                                    RETURN boolean IS
      cursor c_lists_values (p_id_form M_LOAD_FORM_STATIC_VALUES.id_form%TYPE) is
         select 'LISTS OF VALUES' as txt_block_item_origin,
                mlfsv.txt_block_name,
                mlfsv.txt_block_item_name,
                mlfsv.txt_record_group_name,
                mlfsv.txt_recorg_group_col_val_lst_n,
                mlfsv.txt_recorg_group_col_val_lst_v,
                mlfsv.txt_colspec_column_name,
                mlfsv.txt_colspec_maximum_length,
                mlfsv.txt_colspec_column_data_type
           from m_load_form_static_values mlfsv
          where mlfsv.id_form = nvl (p_id_form, mlfsv.id_form)
            and mlfsv.txt_block_item_radbut_name is NULL
          order by mlfsv.id;

      cursor c_radio_groups (p_id_form M_LOAD_FORM_STATIC_VALUES.id_form%TYPE) is
         select 'RADIO GROUPS' as txt_block_item_origin,
                mlfsv.txt_block_name,
                mlfsv.txt_block_item_name,
                mlfsv.txt_block_item_radbut_name,
                mlfsv.txt_block_item_radbut_label,
                mlfsv.txt_block_item_radbut_value
           from m_load_form_static_values mlfsv
          where mlfsv.id_form = nvl (p_id_form, mlfsv.id_form)
            and mlfsv.txt_block_item_radbut_name is not NULL
          order by mlfsv.txt_block_name,
                   mlfsv.txt_block_item_name,
                   mlfsv.txt_block_item_radbut_name;

      cursor c_domain_table_values (p_id_form M_LOAD_FORM_STATIC_VALUES.id_form%TYPE) is
         select mlfsv.*
           from m_load_form_static_values mlfsv
          where mlfsv.id_form = p_id_form;

      r_domain_table_values          c_domain_table_values%ROWTYPE     := NULL;
      r_lists_values                 c_lists_values%ROWTYPE            := NULL;
      r_radio_groups                 c_radio_groups%ROWTYPE            := NULL;
      p_m_load_form_static_values    m_load_form_static_values%ROWTYPE := NULL;
      p_txt_static_values_rg         M_LOAD_FORM.txt_static_values_rg%TYPE    := empty_clob();
      p_txt_static_values_rg_b       M_LOAD_FORM.txt_static_values_rg_b%TYPE;
      p_txt_static_values_li         M_LOAD_FORM.txt_static_values_li%TYPE    := empty_clob();
      p_txt_static_values_li_b       M_LOAD_FORM.txt_static_values_li_b%TYPE;
      p_txt_domain_table_values      M_LOAD_FORM.txt_domain_table_values%TYPE := empty_clob();
      p_txt_domain_table_values_b    M_LOAD_FORM.txt_domain_table_values_b%TYPE;
      p_txt_select_query_lov         M_LOAD_FORM.txt_select_query_lov%TYPE    := empty_clob();
      p_txt_select_query_lov_b       M_LOAD_FORM.txt_select_query_lov_b%TYPE;
      p_id_rownum                    M_LOAD_FORM_LINES.id_rownum%TYPE := NULL;
      p_block_items_listitem_section boolean        := FALSE;
      p_block_items_radiogrp_section boolean        := FALSE;
      p_block_items_rgoption_buttons boolean        := FALSE;
      p_block_items_section          boolean        := FALSE;
      p_block_section                boolean        := FALSE;
      p_registry_group_type_static   boolean        := FALSE;
      p_retorno                      boolean        := NULL;
      p_count_names                  integer        := NULL;
      p_id_rownum_start              integer        := NULL;
      p_id_rownum_finish             integer        := NULL;
      p_max_length_field_01          integer        := 0;
      p_max_length_field_02          integer        := 0;
      p_max_length_field_03          integer        := 0;
      p_max_length_field_04          integer        := 0;
      p_max_length_field_05          integer        := 0;
      p_max_length_field_06          integer        := 0;
      p_max_length_field_07          integer        := 0;
      p_max_length_field_08          integer        := 0;
      p_max_length_field_09          integer        := 0;
      p_max_length_field_10          integer        := 0;
      p_max_length_field_11          integer        := 0;
      p_max_length_field_12          integer        := 0;
      p_object_name                  varchar2(1000) := NULL;
      p_object_block_name            varchar2(1000) := NULL;
      p_object_block_item_name       varchar2(1000) := NULL;
      p_prc_name                     varchar2(1000) := p_pck_name || 'fu_ret_static_values_b (' || p_id_form || '): ';
      p_txt_form_name                varchar2(1000) := NULL;

   BEGIN
      if p_id_form is NULL then
         p_msg_retorno := 'O ID do form carregado deve ser informado.';
         return FALSE;
      else
-- BLOCK_ITEM
         BEGIN
            p_id_rownum_start  := PKG_IMPORT_FORM.fu_ret_1st_occurrenc_keyword_i (p_id_form, 'BLOCKS');
            p_id_rownum_finish := PKG_IMPORT_FORM.fu_ret_1st_occurrenc_keyword_i (p_id_form, 'CANVASES');
            p_txt_form_name    := PKG_IMPORT_FORM.fu_obter_nome_form_v (p_id_form);

            if p_id_rownum_start is not NULL and p_id_rownum_finish is not NULL then
               p_block_section := TRUE;

               for r_imported_form in c_imported_form (p_id_form, p_id_rownum_start, p_id_rownum_finish) loop
                  p_id_rownum := r_imported_form.id_rownum;

                  if    r_imported_form.txt_internal_name_m = 'NAME' then
                     p_object_name                  := r_imported_form.txt_line_p; -- Can be block/item/block trigger/item trigger/relation name
                  elsif r_imported_form.txt_internal_name_m = 'NAVIGATION_STYLE' then
                     p_block_items_section          := FALSE;
                     p_block_section                := TRUE;
                     p_object_block_name            := p_object_name;
                  elsif r_imported_form.txt_internal_name_m = 'ITEMS' then
                     p_block_items_section          := TRUE;
                     p_block_section                := FALSE;
                  elsif r_imported_form.txt_internal_name_m = 'ITEM_TYPE' then
                     p_block_items_listitem_section := FALSE;
                     p_block_items_radiogrp_section := FALSE;
                     p_block_items_rgoption_buttons := FALSE;
                     p_block_items_section          := TRUE;
                     p_block_section                := FALSE;
                     p_object_block_item_name       := p_object_name;
                     p_m_load_form_static_values    := NULL;

                     if r_imported_form.txt_internal_name_p in ('LIST_ITEM', 'RADIO_GROUP') then
                        if    r_imported_form.txt_internal_name_p = 'LIST_ITEM' then
                           p_block_items_listitem_section := TRUE;
                           p_block_items_radiogrp_section := FALSE;
                           p_m_load_form_static_values.id_rownum := r_imported_form.id_rownum;
                        elsif r_imported_form.txt_internal_name_p = 'RADIO_GROUP' then
                           p_block_items_listitem_section := FALSE;
                           p_block_items_radiogrp_section := TRUE;
                           p_m_load_form_static_values.id_rownum := r_imported_form.id_rownum;
                        else
                           p_block_items_listitem_section := FALSE;
                           p_block_items_radiogrp_section := FALSE;
                        end if;

                        p_m_load_form_static_values.id_form                := p_id_form;
                        p_m_load_form_static_values.txt_static_data_origin := 'BLOCK ITEM STATIC CONTENTS';
                        p_m_load_form_static_values.txt_block_name         := p_object_block_name;
                        p_m_load_form_static_values.txt_block_item_name    := p_object_block_item_name;
                     end if;
                  end if;

                  if    p_block_items_listitem_section = TRUE then -- LIST_ITEM
                     if    r_imported_form.txt_internal_name_m = 'LABEL' then
                        p_m_load_form_static_values.txt_recorg_group_col_val_lst_n := r_imported_form.txt_line_t;
                     elsif r_imported_form.txt_internal_name_m = 'LIST_ITEM_VALUE' then
                        p_m_load_form_static_values.txt_recorg_group_col_val_lst_v := r_imported_form.txt_line_t;

                        BEGIN
                           insert into m_load_form_static_values values p_m_load_form_static_values;

                        EXCEPTION
                           when others then
                              p_msg_retorno := 'Erro INSERT MLFSV 1 ID_ROWNUM = ' || p_m_load_form_static_values.id_rownum ||
                                               ' em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                              return FALSE;
                        END;
                     elsif r_imported_form.txt_internal_name_m = 'INITIAL_VALUE' then
                        p_m_load_form_static_values.txt_recorg_group_col_val_lst_n := NULL;
                        p_m_load_form_static_values.txt_recorg_group_col_val_lst_v := NULL;
                        p_block_items_listitem_section := FALSE;

                        BEGIN
                           insert into m_load_form_static_values values p_m_load_form_static_values;

                        EXCEPTION
                           when others then
                              p_msg_retorno := 'Erro INSERT MLFSV 2 ID_ROWNUM = ' || p_m_load_form_static_values.id_rownum ||
                                               ' em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                              return FALSE;
                        END;
                     end if;
                  elsif p_block_items_radiogrp_section = TRUE then -- RADIO_GROUP
                     if r_imported_form.txt_internal_name_m = 'OPTION_BUTTONS' then
                        p_block_items_rgoption_buttons := TRUE;
                     end if;

                     if p_block_items_rgoption_buttons = TRUE then
                        if    r_imported_form.txt_internal_name_m = 'NAME' then
                           p_m_load_form_static_values.txt_block_item_radbut_name  := p_object_name;
                           p_m_load_form_static_values.id_rownum                   := r_imported_form.id_rownum;
                        elsif r_imported_form.txt_internal_name_m = 'LABEL' then
                           p_m_load_form_static_values.txt_block_item_radbut_label := r_imported_form.txt_line_t;
                        elsif r_imported_form.txt_internal_name_m = 'OPTION_BUTTON_VALUE' then
                           p_m_load_form_static_values.txt_block_item_radbut_value := r_imported_form.txt_line_t;

                           BEGIN
                              insert into m_load_form_static_values values p_m_load_form_static_values;

                           EXCEPTION
                              when others then
                                 p_msg_retorno := 'Erro INSERT MLFSV 3 ID_ROWNUM = ' || p_m_load_form_static_values.id_rownum ||
                                                  ' em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                                 return FALSE;
                           END;
                        end if;
                     end if;
                  end if;
               end loop;
            end if;

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro BLOCK_ITEM em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

-- STATIC_RECORD_GROUP
         BEGIN
            p_id_rownum_start            := PKG_IMPORT_FORM.fu_ret_1st_occurrenc_keyword_i (p_id_form, 'REGISTRY_GROUPS');
            p_id_rownum_finish           := PKG_IMPORT_FORM.fu_ret_1st_occurrenc_keyword_i (p_id_form, 'REPORTS');
            p_registry_group_type_static := FALSE;
            p_count_names                := 0;

            if p_id_rownum_start is not NULL and p_id_rownum_finish is not NULL then
               for r_imported_form in c_imported_form (p_id_form, p_id_rownum_start, p_id_rownum_finish) loop
                  p_m_load_form_static_values.id_rownum              := r_imported_form.id_rownum;
                  p_m_load_form_static_values.txt_static_data_origin := 'STATIC RECORD GROUP VALUES';

                  if    r_imported_form.txt_internal_name_m = 'NAME' then
                     p_m_load_form_static_values.id_form := p_id_form;
                     p_object_name                := r_imported_form.txt_line_p; -- Can be block/item/block trigger/item trigger/relation name
                     p_count_names                := p_count_names + 1;
                  elsif r_imported_form.txt_internal_name_m = 'REGISTRY_GROUP_TYPE' and r_imported_form.txt_line_p = 'STATIC' then
                     p_registry_group_type_static := TRUE;
                  end if;

                  if p_registry_group_type_static = TRUE then
                     if p_count_names = 1 then
                        p_m_load_form_static_values.txt_record_group_name := p_object_name;
                     end if;

                     if r_imported_form.txt_internal_name_m = 'MAXIMUM_LENGTH' then
                        p_m_load_form_static_values.txt_colspec_column_name        := p_object_name;
                        p_m_load_form_static_values.txt_colspec_maximum_length     := r_imported_form.txt_line_p;
                     end if;

                     if r_imported_form.txt_internal_name_m = 'COLUMN_DATA_TYPE' then
                        p_m_load_form_static_values.txt_colspec_column_data_type   := r_imported_form.txt_internal_name_p;
                     end if;

                     if r_imported_form.txt_internal_name_m = 'LIST_ITEM_VALUE' then
                        p_m_load_form_static_values.txt_recorg_group_col_val_lst_n := p_object_name;
                        p_m_load_form_static_values.txt_recorg_group_col_val_lst_v := r_imported_form.txt_line_t;

                        BEGIN
                           insert into m_load_form_static_values values p_m_load_form_static_values;

                        EXCEPTION
                           when others then
                              p_msg_retorno := 'Erro INSERT MLFSV 4 ID_ROWNUM = ' || p_m_load_form_static_values.id_rownum ||
                                               ' em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                              return FALSE;
                        END;
                     end if;
                  end if;

                  if r_imported_form.txt_internal_name_m = 'SUBCLASS_INFORMATION' then
                     p_registry_group_type_static := FALSE;
                     p_count_names                := 1;
                  end if;
               end loop;
            end if;

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro STATIC_RECORD_GROUP em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

-- HEADER
         BEGIN
            p_txt_static_values_rg := 'SEP='               || PKG_IMPORT_FORM.p_separator || chr(10) ||
                                      'BLOCK NAME'         || PKG_IMPORT_FORM.p_separator ||
                                      'ITEM NAME'          || PKG_IMPORT_FORM.p_separator ||
                                      'RADIO BUTTON NAME'  || PKG_IMPORT_FORM.p_separator ||
                                      'RADIO BUTTON LABEL' || PKG_IMPORT_FORM.p_separator ||
                                      'RADIO BUTTON VALUE' || chr(10);

            for r_radio_groups in c_radio_groups (p_id_form) loop
               p_txt_static_values_rg := p_txt_static_values_rg                     ||
                                         r_radio_groups.txt_block_name              || PKG_IMPORT_FORM.p_separator ||
                                         r_radio_groups.txt_block_item_name         || PKG_IMPORT_FORM.p_separator ||
                                         r_radio_groups.txt_block_item_radbut_name  || PKG_IMPORT_FORM.p_separator ||
                                         r_radio_groups.txt_block_item_radbut_label || PKG_IMPORT_FORM.p_separator ||
                                         r_radio_groups.txt_block_item_radbut_value || chr(10);
            end loop;

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro HEADER 1 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

         BEGIN
            p_txt_static_values_li := 'SEP='              || PKG_IMPORT_FORM.p_separator || chr(10) ||
                                      'BLOCK NAME'        || PKG_IMPORT_FORM.p_separator ||
                                      'ITEM NAME'         || PKG_IMPORT_FORM.p_separator ||
                                      'RECORD GROUP NAME' || PKG_IMPORT_FORM.p_separator ||
                                      'COLUMN NAME'       || PKG_IMPORT_FORM.p_separator ||
                                      'COLUMN DATA TYPE'  || PKG_IMPORT_FORM.p_separator ||
                                      'MAXIMUM LENGTH'    || PKG_IMPORT_FORM.p_separator ||
                                      'LIST ITEM TEXT'    || PKG_IMPORT_FORM.p_separator ||
                                      'LIST ITEM VALUE'   || chr(10);

            for r_lists_values in c_lists_values (p_id_form) loop
               p_txt_static_values_li := p_txt_static_values_li                        ||
                                         r_lists_values.txt_block_name                 || PKG_IMPORT_FORM.p_separator ||
                                         r_lists_values.txt_block_item_name            || PKG_IMPORT_FORM.p_separator ||
                                         r_lists_values.txt_record_group_name          || PKG_IMPORT_FORM.p_separator ||
                                         r_lists_values.txt_colspec_column_name        || PKG_IMPORT_FORM.p_separator ||
                                         r_lists_values.txt_colspec_column_data_type   || PKG_IMPORT_FORM.p_separator ||
                                         r_lists_values.txt_colspec_maximum_length     || PKG_IMPORT_FORM.p_separator ||
                                         r_lists_values.txt_recorg_group_col_val_lst_n || PKG_IMPORT_FORM.p_separator ||
                                         r_lists_values.txt_recorg_group_col_val_lst_v || chr(10);
            end loop;

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro HEADER 2 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

-- DOMAIN TABLE VALUES
         BEGIN
            p_txt_domain_table_values := 'set serveroutput on size unlimited' || chr(10) ||
                                         'set define off' || chr(10) || chr(10) ||
                                         'DECLARE' || chr(10) ||
                                         PKG_IMPORT_FORM.p_indent || PKG_IMPORT_FORM.p_prc_name_v || ' varchar2(50) := ''INSERT INTO DOMAIN TABLES: '';' || chr(10) || chr(10) ||
                                         'BEGIN' || chr(10);

            BEGIN
               select max (nvl (length (mlfsv.txt_static_data_origin         || ''', '), 0)) as max_length_field_01,
                      max (nvl (length (mlfsv.txt_block_name                 || ''', '), 0)) as max_length_field_02,
                      max (nvl (length (mlfsv.txt_block_item_name            || ''', '), 0)) as max_length_field_03,
                      max (nvl (length (mlfsv.txt_block_item_radbut_name     || ''', '), 0)) as max_length_field_04,
                      max (nvl (length (mlfsv.txt_block_item_radbut_label    || ''', '), 0)) as max_length_field_05,
                      max (nvl (length (mlfsv.txt_block_item_radbut_value    || ''', '), 0)) as max_length_field_06,
                      max (nvl (length (mlfsv.txt_record_group_name          || ''', '), 0)) as max_length_field_07,
                      max (nvl (length (mlfsv.txt_colspec_column_name        || ''', '), 0)) as max_length_field_08,
                      max (nvl (length (mlfsv.txt_colspec_maximum_length     || ''', '), 0)) as max_length_field_09,
                      max (nvl (length (mlfsv.txt_colspec_column_data_type   || ''', '), 0)) as max_length_field_10,
                      max (nvl (length (mlfsv.txt_recorg_group_col_val_lst_n || ''', '), 0)) as max_length_field_11,
                      max (nvl (length (mlfsv.txt_recorg_group_col_val_lst_v || ''', '), 0)) as max_length_field_12
                 into p_max_length_field_01,
                      p_max_length_field_02,
                      p_max_length_field_03,
                      p_max_length_field_04,
                      p_max_length_field_05,
                      p_max_length_field_06,
                      p_max_length_field_07,
                      p_max_length_field_08,
                      p_max_length_field_09,
                      p_max_length_field_10,
                      p_max_length_field_11,
                      p_max_length_field_12
                 from m_load_form_static_values mlfsv
                where mlfsv.id_form = p_id_form;

            EXCEPTION
               when others then
                  p_msg_retorno := 'Erro SELECT MAX MLFSV em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                  return FALSE;
            END;

            for r_domain_table_values in c_domain_table_values (p_id_form) loop
               p_txt_domain_table_values := p_txt_domain_table_values ||
                                            PKG_IMPORT_FORM.p_indent || 'insert into domain_table (field_01,' ||
                                                                                                 ' field_02,' ||
                                                                                                 ' field_03,' ||
                                                                                                 ' field_04,' ||
                                                                                                 ' field_05,' ||
                                                                                                 ' field_06,' ||
                                                                                                 ' field_07,' ||
                                                                                                 ' field_08,' ||
                                                                                                 ' field_09,' ||
                                                                                                 ' field_10,' ||
                                                                                                 ' field_11,' ||
                                                                                                 ' field_12)' ||
                                                                                         ' values (' ||
                                            '''' || rpad (r_domain_table_values.txt_static_data_origin         || ''', ', p_max_length_field_01, ' ') ||
                                            '''' || rpad (r_domain_table_values.txt_block_name                 || ''', ', p_max_length_field_02, ' ') ||
                                            '''' || rpad (r_domain_table_values.txt_block_item_name            || ''', ', p_max_length_field_03, ' ') ||
                                            '''' || rpad (r_domain_table_values.txt_block_item_radbut_name     || ''', ', p_max_length_field_04, ' ') ||
                                            '''' || rpad (r_domain_table_values.txt_block_item_radbut_label    || ''', ', p_max_length_field_05, ' ') ||
                                            '''' || rpad (r_domain_table_values.txt_block_item_radbut_value    || ''', ', p_max_length_field_06, ' ') ||
                                            '''' || rpad (r_domain_table_values.txt_record_group_name          || ''', ', p_max_length_field_07, ' ') ||
                                            '''' || rpad (r_domain_table_values.txt_colspec_column_name        || ''', ', p_max_length_field_08, ' ') ||
                                            '''' || rpad (r_domain_table_values.txt_colspec_maximum_length     || ''', ', p_max_length_field_09, ' ') ||
                                            '''' || rpad (r_domain_table_values.txt_colspec_column_data_type   || ''', ', p_max_length_field_10, ' ') ||
                                            '''' || rpad (r_domain_table_values.txt_recorg_group_col_val_lst_n || ''', ', p_max_length_field_11, ' ') ||
                                            '''' || rpad (r_domain_table_values.txt_recorg_group_col_val_lst_v || '''',   p_max_length_field_12, ' ') || ');' || chr(10);
            end loop;

            p_txt_domain_table_values := p_txt_domain_table_values || chr(10) || PKG_IMPORT_FORM.p_indent || 'commit;' || chr(10) || chr(10) ||
                                         'EXCEPTION' || chr(10) ||
                                         PKG_IMPORT_FORM.p_indent || 'when others then' || chr(10) ||
                                         PKG_IMPORT_FORM.p_indent || PKG_IMPORT_FORM.p_indent || 'rollback;' || chr(10) ||
                                         PKG_IMPORT_FORM.p_indent || PKG_IMPORT_FORM.p_indent || 'DBMS_OUTPUT.put_line (''' || p_error_text_v || ' '' || ' ||
                                                                                                 PKG_IMPORT_FORM.p_prc_name_v ||
                                                                                                 ' || to_char (sqlcode) || '' - '' || sqlerrm);' || chr(10) ||
                                         'END;' || chr(10) ||
                                         '/' || chr(10);

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro DOMAIN TABLES em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

-- SELECT QUERY FOR LISTS OF VALUES (LOV)
         p_retorno := PKG_IMPORT_FORM.fu_ret_txt_select_query_lovs_b (p_id_form, p_txt_select_query_lov, p_msg_retorno);

         if p_retorno != TRUE then
            return p_retorno;
         end if;

-- SAVE CONTENTS INTO TABLE
         BEGIN
            if trim (p_txt_static_values_li) = empty_clob() then
               p_txt_static_values_li_b    := empty_blob();
            else
               p_txt_static_values_li_b    := PKG_IMPORT_FORM.fu_convert_clob_to_blob_b (p_txt_static_values_li);
            end if;

            if trim (p_txt_static_values_rg) = empty_clob() then
               p_txt_static_values_rg_b    := empty_blob();
            else
               p_txt_static_values_rg_b    := PKG_IMPORT_FORM.fu_convert_clob_to_blob_b (p_txt_static_values_rg);
            end if;

            if trim (p_txt_domain_table_values) = empty_clob() then
               p_txt_domain_table_values_b := empty_blob();
            else
               p_txt_domain_table_values_b := PKG_IMPORT_FORM.fu_convert_clob_to_blob_b (p_txt_domain_table_values);
            end if;

--          if trim (p_txt_select_query_lov) = empty_clob() then
--             p_txt_select_query_lov_b    := empty_blob();
--          else
--             p_txt_select_query_lov_b    := PKG_IMPORT_FORM.fu_convert_clob_to_blob_b (p_txt_select_query_lov);
--          end if;

            update m_load_form mlf
               set mlf.txt_static_values_li      = p_txt_static_values_li,
                   mlf.txt_static_values_li_b    = p_txt_static_values_li_b,
                   mlf.txt_static_values_li_f    = p_txt_form_name || PKG_IMPORT_FORM.p_txt_static_values_li_s,
                   mlf.txt_static_values_rg      = p_txt_static_values_rg,
                   mlf.txt_static_values_rg_b    = p_txt_static_values_rg_b,
                   mlf.txt_static_values_rg_f    = p_txt_form_name || PKG_IMPORT_FORM.p_txt_static_values_rg_s,
                   mlf.txt_domain_table_values   = p_txt_domain_table_values,
                   mlf.txt_domain_table_values_b = p_txt_domain_table_values_b,
                   mlf.txt_domain_table_values_f = p_txt_form_name || PKG_IMPORT_FORM.p_txt_domain_table_values_s
--                 mlf.txt_select_query_lov      = p_txt_select_query_lov,
--                 mlf.txt_select_query_lov_b    = p_txt_select_query_lov_b,
--                 mlf.txt_select_query_lov_f    = p_txt_form_name || PKG_IMPORT_FORM.p_txt_select_query_lovs_s
             where mlf.id                        = p_id_form;

            DBMS_LOB.freetemporary (p_txt_static_values_li);
            DBMS_LOB.freetemporary (p_txt_static_values_rg);
            DBMS_LOB.freetemporary (p_txt_domain_table_values);
--          DBMS_LOB.freetemporary (p_txt_select_query_lov);

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro UPDATE MLF 2 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      commit;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro (ID_ROWNUM = ' || p_id_rownum || ') ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_static_values_b;

-- fu_ret_id_language_b
   FUNCTION fu_ret_id_language_b (p_txt_line           M_LOAD_FORM_LINES.txt_line%TYPE,
                                  p_id_language IN OUT M_LANGUAGES.id%TYPE,
                                  p_msg_retorno IN OUT varchar2)
                                  RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_id_language_b: ';

   BEGIN
      if    trim (p_txt_line) is NULL then
         p_msg_retorno := 'A linha deve ser informada.';
         return FALSE;
      elsif substr (trim (p_txt_line), 1, 2) not in ('* ', '- ', '^ ', 'o ') then
         p_msg_retorno := 'A linha informada deve conter a palavra-chave.';
         return FALSE;
      else
         BEGIN
            select mfk.id_language
              into p_id_language
              from m_form_keywords mfk
             where (instr (trim (p_txt_line), '  ')  = 0 and mfk.txt_keyword = trim (translate (trim (substr (trim (p_txt_line),
                                                                                                      2)), chr(9), ' ')))
                or (instr (trim (p_txt_line), '  ') != 0 and mfk.txt_keyword = trim (translate (trim (substr (trim (p_txt_line),
                                                                                                      2,
                                                                                                      instr (trim (p_txt_line), '  '))), chr(9), ' ')));

         EXCEPTION
            when no_data_found then
               p_id_language := NULL;
            when too_many_rows then
               p_id_language := NULL;
            when others then
               p_msg_retorno := 'Erro SELECT MFK em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_id_language_b;

-- fu_ret_id_language_i
   FUNCTION fu_ret_id_language_i (p_txt_line M_LOAD_FORM_LINES.txt_line%TYPE)
                                  RETURN M_LANGUAGES.id%TYPE IS
      p_id_language M_LANGUAGES.id%TYPE := NULL;
      p_retorno     boolean        := NULL;
      p_prc_name    varchar2(1000) := p_pck_name || 'fu_ret_id_language_i: ';
      p_msg_retorno varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_id_language_b (p_txt_line,     -- p_txt_line           M_LOAD_FORM_LINES.txt_line%TYPE
                                                         p_id_language,  -- p_id_language IN OUT M_LANGUAGES.id%TYPE
                                                         p_msg_retorno); -- p_msg_retorno IN OUT varchar2

      if p_retorno = TRUE then
         return p_id_language;
      else
         return NULL;
      end if;

   EXCEPTION
      when others then
         NULL;
   END fu_ret_id_language_i;

-- fu_detect_form_language_b
   FUNCTION fu_detect_form_language_b (p_id                 M_LOAD_FORM.id%TYPE,
                                       p_id_language IN OUT M_LANGUAGES.id%TYPE,
                                       p_msg_retorno IN OUT varchar2)
                                       RETURN boolean IS
      p_id_language_i M_LANGUAGES.id%TYPE := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_detect_form_language_b (' || p_id || '): ';

   BEGIN
      if p_id is NULL then
         p_msg_retorno := 'O ID do form carregado deve ser informado.';
         return FALSE;
      else
         for r_imported_form in c_imported_form (p_id           => p_id,
                                                 p_rownum_start => 1) loop
            p_id_language_i := PKG_IMPORT_FORM.fu_ret_id_language_i (r_imported_form.txt_line);

            if p_id_language_i is not NULL then
               if p_id_language is not NULL and p_id_language != p_id_language_i then
                  p_id_language := NULL;
                  exit;
               end if;

               p_id_language := p_id_language_i;
            end if;
         end loop;
      end if;

      p_id_language := nvl (p_id_language, PKG_IMPORT_FORM.p_id_language);

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_detect_form_language_b;

-- fu_detect_form_language_i
   FUNCTION fu_detect_form_language_i (p_id M_LOAD_FORM.id%TYPE)
                                       RETURN M_LANGUAGES.id%TYPE IS
      p_id_language M_LANGUAGES.id%TYPE := NULL;
      p_retorno     boolean        := NULL;
      p_prc_name    varchar2(1000) := p_pck_name || 'fu_detect_form_language_i (' || p_id || '): ';
      p_msg_retorno varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_detect_form_language_b (p_id,           -- p_id                 M_LOAD_FORM.id%TYPE
                                                              p_id_language,  -- p_id_language IN OUT M_LANGUAGES.id%TYPE
                                                              p_msg_retorno); -- p_msg_retorno IN OUT varchar2

      if p_retorno = TRUE then
         return p_id_language;
      else
         return NULL;
      end if;

   EXCEPTION
      when others then
         return NULL;
   END fu_detect_form_language_i;

-- fu_ret_txt_block_query_data__b
   FUNCTION fu_ret_txt_block_query_data__b (p_id_form                             M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE,
                                            p_txt_block_name                      M_LOAD_FORM_BLOCKS_ITEMS.txt_block_name%TYPE,
                                            p_txt_block_query_data_orig_na IN OUT M_LOAD_FORM_BLOCKS_ITEMS.txt_block_query_data_orig_name%TYPE,
                                            p_msg_retorno                  IN OUT varchar2)
                                            RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_txt_block_query_data__b (' || p_id_form || ', ' || p_txt_block_name || '): ';

   BEGIN
      if p_id_form is not NULL and trim (p_txt_block_name) is not NULL then
         BEGIN
            select distinct
                   mlfbi.txt_block_query_data_orig_name
              into p_txt_block_query_data_orig_na
              from m_load_form_blocks_items mlfbi
             where mlfbi.id_form                        =  p_id_form
               and mlfbi.txt_block_name                 =  p_txt_block_name
               and mlfbi.txt_block_query_data_orig_name is not NULL;

         EXCEPTION
            when no_data_found then
               p_txt_block_query_data_orig_na := NULL;
            when others then
               p_msg_retorno := 'Erro SELECT MLFBI 1 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_txt_block_query_data__b;

-- fu_ret_txt_block_query_data__v
   FUNCTION fu_ret_txt_block_query_data__v (p_id_form        M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE,
                                            p_txt_block_name M_LOAD_FORM_BLOCKS_ITEMS.txt_block_name%TYPE)
                                            RETURN M_LOAD_FORM_BLOCKS_ITEMS.txt_block_query_data_orig_name%TYPE IS
      p_txt_block_query_data_orig_na M_LOAD_FORM_BLOCKS_ITEMS.txt_block_query_data_orig_name%TYPE := NULL;
      p_retorno     boolean        := NULL;
      p_prc_name    varchar2(1000) := p_pck_name || 'fu_ret_txt_block_query_data__v (' || p_id_form || ', ' || p_txt_block_name || '): ';
      p_msg_retorno varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_txt_block_query_data__b (p_id_form,
                                                                   p_txt_block_name,
                                                                   p_txt_block_query_data_orig_na,
                                                                   p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_block_query_data_orig_na;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_txt_block_query_data__v;

-- fu_ret_block_relations_b
   FUNCTION fu_ret_block_relations_b (p_id                 M_LOAD_FORM.id%TYPE,
                                      p_msg_retorno IN OUT varchar2)
                                      RETURN boolean IS
      p_m_load_form_block_relation m_load_form_block_relation%ROWTYPE := NULL;
      r_imported_form              c_imported_form%ROWTYPE            := NULL;
      p_relation_type_join boolean        := FALSE;
      p_relations_section  boolean        := FALSE;
      p_id_rownum_start    integer        := NULL;
      p_id_rownum_finish   integer        := NULL;
      p_block_a            varchar2(200)  := NULL;
      p_block_item_a       varchar2(200)  := NULL;
      p_block_b            varchar2(200)  := NULL;
      p_block_item_b       varchar2(200)  := NULL;
      p_prc_name           varchar2(1000) := p_pck_name || 'fu_ret_block_relations_b (' || p_id || '): ';
      p_block_item_l       varchar2(4000) := NULL;
      p_block_item_r       varchar2(4000) := NULL;
      p_join_condition_r   varchar2(4000) := NULL;

   BEGIN
      if p_id is NULL then
         p_msg_retorno := 'O ID do form carregado deve ser informado.';
         return FALSE;
      else
         p_id_rownum_start  := PKG_IMPORT_FORM.fu_ret_1st_occurrenc_keyword_i (p_id, 'BLOCKS');
         p_id_rownum_finish := PKG_IMPORT_FORM.fu_ret_1st_occurrenc_keyword_i (p_id, 'CANVASES');

         for r_imported_form in c_imported_form (p_id, p_id_rownum_start, p_id_rownum_finish) loop
            if    r_imported_form.txt_internal_name_m = 'RELATIONS' then
               p_relations_section := TRUE;
            elsif r_imported_form.txt_internal_name_m = 'NAME' then
               p_m_load_form_block_relation.id_form           := p_id;
               p_m_load_form_block_relation.id_rownum         := r_imported_form.id_rownum;
               p_m_load_form_block_relation.txt_relation_name := r_imported_form.txt_line_p;
               p_relation_type_join := FALSE;
            elsif r_imported_form.txt_internal_name_m = 'RELATION_TYPE' then
               p_m_load_form_block_relation.txt_relation_type := r_imported_form.txt_internal_name_p;

               if p_m_load_form_block_relation.txt_relation_type = 'JOIN' then
                  p_relation_type_join := TRUE;
               end if;
            elsif r_imported_form.txt_internal_name_m = 'DETAIL_DATA_BLOCK' and p_relation_type_join = TRUE then
               p_m_load_form_block_relation.txt_detailed_data_block := r_imported_form.txt_line_p;
            elsif r_imported_form.txt_internal_name_m = 'JOIN_CONDITION' and p_relation_type_join = TRUE then
               p_join_condition_r := trim (translate (PKG_IMPORT_FORM.fu_ret_txt_multiline_v (p_id_form             => p_id,
                                                                                              p_id_rownum_start     => r_imported_form.id_rownum,
                                                                                              p_txt_internal_name_m => 'REGISTRY_BEHAVIOR_DELETE'),
                                                      chr(10), ' '));

               p_m_load_form_block_relation.txt_join_condition := p_join_condition_r;

               loop
                  p_block_item_l := trim (substr (upper (p_join_condition_r), 1, instr (upper (p_join_condition_r), '=') - 1));
                  p_block_item_r := trim (substr (upper (p_join_condition_r),    instr (upper (p_join_condition_r), '=') + 1));

                  if instr (upper (p_join_condition_r), ' AND ') > 0 then
                     p_block_item_r := trim (substr (upper (p_block_item_r), 1, instr (upper (p_block_item_r), ' ') - 1));
                  end if;

                  p_block_a      := trim (substr (upper (p_block_item_l), 1, instr (upper (p_block_item_l), '.') - 1));
                  p_block_item_a := trim (substr (upper (p_block_item_l),    instr (upper (p_block_item_l), '.') + 1));
                  p_block_b      := trim (substr (upper (p_block_item_r), 1, instr (upper (p_block_item_r), '.') - 1));
                  p_block_item_b := trim (substr (upper (p_block_item_r),    instr (upper (p_block_item_r), '.') + 1));

                  if p_block_a = p_m_load_form_block_relation.txt_detailed_data_block then
                     p_m_load_form_block_relation.txt_detail_data_block      := p_block_a;
                     p_m_load_form_block_relation.txt_detail_data_block_item := p_block_item_a;
                     p_m_load_form_block_relation.txt_master_data_block      := p_block_b;
                     p_m_load_form_block_relation.txt_master_data_block_item := p_block_item_b;
                  else
                     p_m_load_form_block_relation.txt_detail_data_block      := p_block_b;
                     p_m_load_form_block_relation.txt_detail_data_block_item := p_block_item_b;
                     p_m_load_form_block_relation.txt_master_data_block      := p_block_a;
                     p_m_load_form_block_relation.txt_master_data_block_item := p_block_item_a;
                  end if;

                  BEGIN
                     insert into m_load_form_block_relation values p_m_load_form_block_relation;

                  EXCEPTION
                     when others then
                        p_msg_retorno := 'Erro INSERT MLFBR (' || p_m_load_form_block_relation.txt_relation_name ||
                                                       ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                        return FALSE;
                  END;

                  if instr (upper (p_join_condition_r), ' AND ') = 0 then
                     exit;
                  else
                     p_join_condition_r := trim (substr (upper (p_join_condition_r), instr (upper (p_join_condition_r), ' AND ') + length (' AND ')));
                  end if;
               end loop;
            elsif r_imported_form.txt_internal_name_m = 'NAVIGATION_STYLE' then
               p_relations_section  := FALSE;
            end if;
         end loop;
      end if;

      commit;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_block_relations_b;

-- fu_ret_create_form_views_c
   FUNCTION fu_ret_create_form_views_c (p_id_form        M_LOAD_FORM.id%TYPE,
                                        p_txt_block_name M_LOAD_FORM_BLOCKS_ITEMS.txt_block_name%TYPE)
                                        RETURN clob IS
      p_txt_block_query_data_orig_cl M_LOAD_FORM_BLOCKS_ITEMS.txt_block_query_data_orig_clob%TYPE := empty_clob();
      p_clob     clob           := empty_clob();
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_create_form_views_c (' || p_id_form || ', ' || p_txt_block_name || '): ';

   BEGIN
      if p_id_form is NULL then
         return 'O ID do form carregado deve ser informado.';
      else
         p_clob := 'CREATE OR REPLACE VIEW ' || p_txt_block_name || ' IS' || chr(10);

         BEGIN
            select mlfbi.txt_block_query_data_orig_clob
              into p_txt_block_query_data_orig_cl
              from m_load_form_blocks_items mlfbi
             where mlfbi.id_form                         = p_id_form
               and mlfbi.txt_block_name                  = trim (upper (p_txt_block_name))
               and mlfbi.txt_data_origin                 = 'BLOCKS AND ITEMS'
               and mlfbi.txt_block_name                 is not NULL
               and mlfbi.txt_item_name                  is NULL
               and mlfbi.txt_block_query_data_orig_type  = 'FROM_WHERE_CLAUSE'
               and mlfbi.txt_block_query_data_orig_clob is not NULL;

         EXCEPTION
            when no_data_found then
               p_txt_block_query_data_orig_cl := empty_clob();
            when others then
               return 'Erro SELECT MFLBI em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         END;

         p_clob := p_clob || p_txt_block_query_data_orig_cl || chr(10) || '/';
      end if;

      return p_clob;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_create_form_views_c;

-- fu_ret_create_form_views_b
   FUNCTION fu_ret_create_form_views_b (p_id_form                 M_LOAD_FORM.id%TYPE,
                                        p_txt_script_views IN OUT clob,
                                        p_msg_retorno      IN OUT varchar2)
                                        RETURN boolean IS
      cursor c_form_views is
         select mlfbi.*
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form                         = p_id_form
            and mlfbi.txt_data_origin                 = 'BLOCKS AND ITEMS'
            and mlfbi.txt_block_name                 is not NULL
            and mlfbi.txt_item_name                  is NULL
            and mlfbi.txt_block_query_data_orig_type  = 'FROM_WHERE_CLAUSE'
            and mlfbi.txt_block_query_data_orig_name is not NULL;

      r_form_views c_form_views%ROWTYPE := NULL;
      p_retorno    boolean        := NULL;
      p_clob       clob           := empty_clob();
      p_prc_name   varchar2(1000) := p_pck_name || 'fu_ret_create_form_views_b (' || p_id_form || '): ';

   BEGIN
      if p_id_form is NULL then
         p_msg_retorno := 'O ID do form carregado deve ser informado.';
         return FALSE;
      else
         p_clob := p_clob || chr(10) || chr(10);

         for r_form_views in c_form_views loop
            p_clob             := PKG_IMPORT_FORM.fu_ret_create_form_views_c (p_id_form, r_form_views.txt_block_name);
            p_txt_script_views := p_txt_script_views || p_clob;
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_create_form_views_b;

-- fu_create_alter_table_cols_b
   FUNCTION fu_create_alter_table_cols_b (p_id                 M_LOAD_FORM.id%TYPE,
                                          p_msg_retorno IN OUT varchar2)
                                          RETURN boolean IS
      cursor c_database_tables_bi (p_id_form M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE) is
         select mlfbi.*
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form                         = p_id_form
            and mlfbi.txt_data_origin                 = 'BLOCKS AND ITEMS'
            and mlfbi.txt_block_database_data_block   = 'YES'
            and mlfbi.txt_block_query_data_orig_type  = 'TABLE'
            and mlfbi.txt_block_query_data_orig_name is not NULL
            and mlfbi.txt_item_name                  is NULL -- Obter somente os nomes de tabelas
          order by mlfbi.id;

      cursor c_database_table_items_bi (p_id_form        M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE,
                                        p_txt_block_name M_LOAD_FORM_BLOCKS_ITEMS.txt_block_name%TYPE) is
         select mlfbi.*
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form                  = p_id_form
            and mlfbi.txt_block_name           = p_txt_block_name
            and mlfbi.txt_data_origin          = 'BLOCKS AND ITEMS'
            and mlfbi.txt_item_field_database  = 'YES'
            and mlfbi.txt_item_name           is not NULL
          order by mlfbi.id;

      cursor c_database_tables_bi_pk (p_id_form M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE) is
         select mlfbi.*
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form                         = p_id_form
            and mlfbi.txt_data_origin                 = 'BLOCKS AND ITEMS'
            and mlfbi.txt_block_database_data_block   = 'YES'
            and mlfbi.txt_block_query_data_orig_type  = 'TABLE'
            and mlfbi.txt_block_query_data_orig_name is not NULL
            and mlfbi.txt_item_name                  is NULL -- Obter somente os nomes de tabelas
            and exists (select distinct 1
                          from m_load_form_blocks_items mlfbi_a
                         where mlfbi_a.id_form                    = mlfbi.id_form
                           and mlfbi_a.txt_block_name             = mlfbi.txt_block_name
                           and mlfbi_a.txt_item_field_primary_key = 'YES')
          order by mlfbi.id;

      cursor c_database_tables_items_pk (p_id_form        M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE,
                                         p_txt_block_name M_LOAD_FORM_BLOCKS_ITEMS.txt_block_name%TYPE) is
         select mlfbi.txt_item_name,
                mlfbi.txt_item_field_db_col_name
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form                    = p_id_form
            and mlfbi.txt_block_name             = p_txt_block_name
            and mlfbi.txt_item_field_database    = 'YES'
            and mlfbi.txt_item_field_primary_key = 'YES';

      cursor c_database_tables_qdsc (p_id_form M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE) is
         select distinct
                mlfbi.txt_block_name,
                mlfbi.txt_block_query_data_orig_name
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form                        = p_id_form
            and mlfbi.txt_data_origin                = 'QUERY DATA SOURCE COLUMNS'
            and mlfbi.txt_block_query_data_orig_type = 'TABLE';

      cursor c_database_tables_items_qdsc (p_id_form        M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE,
                                           p_txt_block_name M_LOAD_FORM_BLOCKS_ITEMS.txt_block_name%TYPE) is
         select mlfbi.*
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form                        = p_id_form
            and mlfbi.txt_block_name                 = p_txt_block_name
            and mlfbi.txt_data_origin                = 'QUERY DATA SOURCE COLUMNS'
            and mlfbi.txt_block_query_data_orig_type = 'TABLE'
          order by mlfbi.id;

      cursor c_block_relation_names (p_id_form M_LOAD_FORM_BLOCK_RELATION.id_form%TYPE) is
         select distinct
                mlfbr.txt_relation_name,
                mlfbr.txt_relation_type,
                mlfbr.txt_detailed_data_block,
                mlfbr.txt_master_data_block,
                mlfbr.txt_detail_data_block,
                mlfbr.txt_join_condition
           from m_load_form_block_relation mlfbr,
                m_load_form_blocks_items   mlfbi
          where mlfbr.id_form               = p_id_form
            and mlfbr.txt_relation_type     = 'JOIN'
            and mlfbr.id_form               = mlfbi.id_form
            and mlfbr.txt_master_data_block = mlfbi.txt_block_query_data_orig_name;

      cursor c_block_relation_names_items (p_id_form               M_LOAD_FORM_BLOCK_RELATION.id_form%TYPE,
                                           p_txt_master_data_block M_LOAD_FORM_BLOCK_RELATION.txt_master_data_block%TYPE,
                                           p_txt_detail_data_block M_LOAD_FORM_BLOCK_RELATION.txt_detail_data_block%TYPE,
                                           p_txt_relation_name     M_LOAD_FORM_BLOCK_RELATION.txt_relation_name%TYPE) is
         select mlfbr.txt_master_data_block,
                mlfbr.txt_master_data_block_item,
                mlfbr.txt_detail_data_block,
                mlfbr.txt_detail_data_block_item
           from m_load_form_block_relation mlfbr
          where mlfbr.id_form               = p_id_form
            and mlfbr.txt_master_data_block = p_txt_master_data_block
            and mlfbr.txt_detail_data_block = p_txt_detail_data_block
            and mlfbr.txt_relation_name     = p_txt_relation_name
            and mlfbr.txt_relation_type     = 'JOIN';

      cursor c_block_relation_names_pk (p_id_form           M_LOAD_FORM_BLOCK_RELATION.id_form%TYPE,
                                        p_txt_relation_name M_LOAD_FORM_BLOCK_RELATION.txt_relation_name%TYPE) is
         select mlfbr.*
           from m_load_form_block_relation mlfbr
          where mlfbr.id_form           = p_id_form
            and mlfbr.txt_relation_name = p_txt_relation_name
          order by id;

      cursor c_attempt_generate_pk (p_id_form                 M_LOAD_FORM_BLOCK_RELATION.id_form%TYPE,
                                    p_txt_detailed_data_block M_LOAD_FORM_BLOCK_RELATION.txt_detailed_data_block%TYPE) is
         select distinct
                mlfbr.txt_relation_name,
                mlfbr.txt_master_data_block,
                mlfbr.txt_detail_data_block
           from m_load_form_blocks_items   mlfbi,
                m_load_form_block_relation mlfbr
          where mlfbi.id_form                         = p_id_form
            and mlfbr.txt_detailed_data_block         = p_txt_detailed_data_block
            and mlfbi.txt_data_origin                 = 'BLOCKS AND ITEMS'
            and mlfbi.txt_block_database_data_block   = 'YES'
            and mlfbi.txt_block_query_data_orig_type  = 'TABLE'
            and mlfbi.txt_block_query_data_orig_name is not NULL
            and mlfbi.txt_item_name                  is NULL
            and (mlfbi.txt_block_query_data_orig_name = mlfbr.txt_master_data_block
              or mlfbi.txt_block_query_data_orig_name = mlfbr.txt_detail_data_block)
            and mlfbi.id_form                         = mlfbr.id_form;

      cursor c_attempt_generate_items_m_pk (p_id_form               M_LOAD_FORM_BLOCK_RELATION.id_form%TYPE,
                                            p_txt_relation_name     M_LOAD_FORM_BLOCK_RELATION.txt_relation_name%TYPE,
                                            p_txt_master_data_block M_LOAD_FORM_BLOCK_RELATION.txt_master_data_block%TYPE) is
         select distinct
                mlfbr.txt_relation_name,
                mlfbr.txt_master_data_block,
                mlfbr.txt_master_data_block_item
           from m_load_form_blocks_items   mlfbi,
                m_load_form_block_relation mlfbr
          where mlfbi.id_form                         = p_id_form
            and mlfbr.txt_relation_name               = p_txt_relation_name
            and mlfbr.txt_master_data_block           = p_txt_master_data_block
            and mlfbi.txt_data_origin                 = 'BLOCKS AND ITEMS'
            and mlfbi.txt_block_database_data_block   = 'YES'
            and mlfbi.txt_block_query_data_orig_type  = 'TABLE'
            and mlfbi.txt_block_query_data_orig_name is not NULL
            and mlfbi.txt_item_name                  is NULL
            and (mlfbi.txt_block_query_data_orig_name = mlfbr.txt_master_data_block
              or mlfbi.txt_block_query_data_orig_name = mlfbr.txt_detail_data_block)
            and mlfbi.id_form                         = mlfbr.id_form;

      cursor c_attempt_generate_items_d_pk (p_id_form               M_LOAD_FORM_BLOCK_RELATION.id_form%TYPE,
                                            p_txt_relation_name     M_LOAD_FORM_BLOCK_RELATION.txt_relation_name%TYPE,
                                            p_txt_detail_data_block M_LOAD_FORM_BLOCK_RELATION.txt_detail_data_block%TYPE) is
         select distinct
                mlfbr.txt_relation_name,
                mlfbr.txt_detail_data_block,
                mlfbr.txt_detail_data_block_item
           from m_load_form_blocks_items   mlfbi,
                m_load_form_block_relation mlfbr
          where mlfbi.id_form                         = p_id_form
            and mlfbr.txt_relation_name               = p_txt_relation_name
            and mlfbr.txt_detail_data_block           = p_txt_detail_data_block
            and mlfbi.txt_data_origin                 = 'BLOCKS AND ITEMS'
            and mlfbi.txt_block_database_data_block   = 'YES'
            and mlfbi.txt_block_query_data_orig_type  = 'TABLE'
            and mlfbi.txt_block_query_data_orig_name is not NULL
            and mlfbi.txt_item_name                  is NULL
            and (mlfbi.txt_block_query_data_orig_name = mlfbr.txt_master_data_block
              or mlfbi.txt_block_query_data_orig_name = mlfbr.txt_detail_data_block)
            and mlfbi.id_form                         = mlfbr.id_form;

      cursor c_database_data_blocks (p_id_form M_LOAD_FORM_BLOCK_RELATION.id_form%TYPE) is
         select mlfbi.txt_block_query_data_orig_name,
                mlfbi.txt_item_field_db_col_name,
                mlfbi.txt_item_field_datatype,
                nvl (mlfbi.txt_item_field_maxlength, 0) as txt_item_field_maxlength,
                nvl (mlfbi.txt_item_field_precision, 0) as txt_item_field_precision,
                nvl (mlfbi.txt_item_field_scale,     0) as txt_item_field_scale,
                mlfbi.txt_item_field_mandatory
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form         = p_id_form
            and mlfbi.txt_data_origin = 'BLOCKS AND ITEMS'
            and ((mlfbi.txt_block_database_data_block = 'YES' and mlfbi.txt_block_query_data_orig_type = 'TABLE')
              or (mlfbi.txt_item_field_database = 'YES' and mlfbi.txt_item_field_db_col_name is not NULL))
          order by mlfbi.id_rownum;

      cursor c_query_data_source_columns (p_id_form M_LOAD_FORM_BLOCK_RELATION.id_form%TYPE) is
         select mlfbi.txt_block_query_data_orig_name,
                mlfbi.txt_item_name,
                mlfbi.txt_item_field_datatype,
                mlfbi.txt_item_field_maxlength,
                mlfbi.txt_item_field_precision,
                mlfbi.txt_item_field_scale,
                mlfbi.txt_item_field_mandatory
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form                        = p_id_form
            and mlfbi.txt_data_origin                = 'QUERY DATA SOURCE COLUMNS'
            and mlfbi.txt_block_query_data_orig_type = 'TABLE';

      cursor c_relations_master_data_blocks (p_id_form M_LOAD_FORM_BLOCK_RELATION.id_form%TYPE) is
         select distinct
                mlfbr.txt_master_data_block
           from m_load_form_block_relation mlfbr
          where mlfbr.id_form           = p_id_form
            and mlfbr.txt_relation_type = 'JOIN';

      cursor c_relations_master_db_items (p_id_form               M_LOAD_FORM_BLOCK_RELATION.id_form%TYPE,
                                          p_txt_master_data_block M_LOAD_FORM_BLOCK_RELATION.txt_master_data_block%TYPE) is
         select distinct
                mlfbr.txt_master_data_block_item
           from m_load_form_block_relation mlfbr
          where mlfbr.id_form               = p_id_form
            and mlfbr.txt_master_data_block = p_txt_master_data_block
            and mlfbr.txt_relation_type     = 'JOIN';

      cursor c_blocks_and_items_no_qdsc (p_id_form M_LOAD_FORM_BLOCK_RELATION.id_form%TYPE) is
         select distinct
                mlfbi.txt_block_name,
                mlfbi.txt_block_query_data_orig_name
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form                        =  p_id_form
            and mlfbi.txt_data_origin                =  'BLOCKS AND ITEMS'
            and mlfbi.txt_block_database_data_block  =  'YES'
            and mlfbi.txt_block_query_data_orig_type =  'TABLE'
            and mlfbi.txt_block_query_data_orig_name is not NULL
            and mlfbi.txt_item_name                  is NULL
            and mlfbi.txt_block_query_data_orig_name not in (select distinct
                                                                    mlfbi_a.txt_block_query_data_orig_name
                                                               from m_load_form_blocks_items mlfbi_a
                                                              where mlfbi_a.id_form         = mlfbi.id_form
                                                                and mlfbi_a.txt_data_origin = 'QUERY DATA SOURCE COLUMNS');

      cursor c_blocks_items_compare_qdsc (p_id_form M_LOAD_FORM_BLOCK_RELATION.id_form%TYPE) is
         select mlfbi.txt_block_query_data_orig_name,
                mlfbi.txt_item_field_db_col_name,
                mlfbi.txt_item_field_datatype,
                nvl (mlfbi.txt_item_field_maxlength, 0) as txt_item_field_maxlength,
                nvl (mlfbi.txt_item_field_precision, 0) as txt_item_field_precision,
                nvl (mlfbi.txt_item_field_scale,     0) as txt_item_field_scale,
                mlfbi.txt_item_field_mandatory
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form                        =  p_id_form
            and mlfbi.txt_data_origin                =  'BLOCKS AND ITEMS'
            and mlfbi.txt_block_database_data_block  =  'YES'
            and mlfbi.txt_block_query_data_orig_type =  'TABLE'
            and mlfbi.txt_item_field_database        =  'YES'
            and mlfbi.txt_block_name                 is not NULL
            and mlfbi.txt_item_name                  is not NULL
            and mlfbi.txt_block_query_data_orig_name is not NULL
            and mlfbi.txt_item_field_db_col_name     is not NULL;

      p_m_load_form_blocks_items     m_load_form_blocks_items%ROWTYPE       := NULL;
      r_attempt_generate_items_d_pk  c_attempt_generate_items_d_pk%ROWTYPE  := NULL;
      r_attempt_generate_items_m_pk  c_attempt_generate_items_m_pk%ROWTYPE  := NULL;
      r_attempt_generate_pk          c_attempt_generate_pk%ROWTYPE          := NULL;
      r_block_relation_names         c_block_relation_names%ROWTYPE         := NULL;
      r_block_relation_names_items   c_block_relation_names_items%ROWTYPE   := NULL;
      r_block_relation_names_pk      c_block_relation_names_pk%ROWTYPE      := NULL;
      r_blocks_and_items_no_qdsc     c_blocks_and_items_no_qdsc%ROWTYPE     := NULL;
      r_blocks_items_compare_qdsc    c_blocks_items_compare_qdsc%ROWTYPE    := NULL;
      r_database_data_blocks         c_database_data_blocks%ROWTYPE         := NULL;
      r_database_table_items_bi      c_database_table_items_bi%ROWTYPE      := NULL;
      r_database_tables_bi           c_database_tables_bi%ROWTYPE           := NULL;
      r_database_tables_bi_pk        c_database_tables_bi_pk%ROWTYPE        := NULL;
      r_database_tables_items_pk     c_database_tables_items_pk%ROWTYPE     := NULL;
      r_database_tables_items_qdsc   c_database_tables_items_qdsc%ROWTYPE   := NULL;
      r_database_tables_qdsc         c_database_tables_qdsc%ROWTYPE         := NULL;
      r_query_data_source_columns    c_query_data_source_columns%ROWTYPE    := NULL;
      r_relations_master_data_blocks c_relations_master_data_blocks%ROWTYPE := NULL;
      r_relations_master_db_items    c_relations_master_db_items%ROWTYPE    := NULL;
      p_txt_script_on_form           M_LOAD_FORM.txt_script_on_form%TYPE    := empty_clob();
      p_txt_script_on_form_b         M_LOAD_FORM.txt_script_on_form_b%TYPE;
      p_query_data_source_exists     boolean        := NULL;
      p_retorno                      boolean        := NULL;
      p_column_count                 integer        := 0;
      p_column_count_pk              integer        := 0;
      p_existe                       integer        := NULL;
      p_foreign_key_count            integer        := 0;
      p_total                        integer        := 0;
      p_foreign_key_name             varchar2(100)  := NULL;
      p_primary_key_name             varchar2(100)  := NULL;
      p_detail_data_block            varchar2(100)  := NULL;
      p_master_data_block            varchar2(100)  := NULL;
      p_prc_name                     varchar2(1000) := p_pck_name || 'fu_create_alter_table_cols_b (' || p_id || '): ';
      p_txt_form_name                varchar2(1000) := NULL;

   BEGIN
      if p_id is NULL then
         p_msg_retorno := 'O ID do form carregado deve ser informado.';
         return FALSE;
      else
-- DATABASE DATA BLOCKS
         BEGIN
            p_txt_form_name      := PKG_IMPORT_FORM.fu_obter_nome_form_v (p_id);
            p_txt_script_on_form := '-- ACCORDING TO DATABASE DATA BLOCKS' || chr(10);

            for r_database_tables_bi in c_database_tables_bi (p_id_form => p_id) loop
-- Impede a criação de instruções "CREATE TABLE" sem colunas.
               BEGIN -- c_database_table_items_bi
                  select count (*) as total
                    into p_total
                    from m_load_form_blocks_items mlfbi
                   where mlfbi.id_form                  = p_id
                     and mlfbi.txt_block_name           = r_database_tables_bi.txt_block_name
                     and mlfbi.txt_data_origin          = 'BLOCKS AND ITEMS'
                     and mlfbi.txt_item_field_database  = 'YES'
                     and mlfbi.txt_item_name           is not NULL
                   order by mlfbi.id;

               EXCEPTION
                  when others then
                     p_msg_retorno := 'Erro SELECT COUNT MLFBI BLOCKS_AND_ITEMS (' || r_database_tables_bi.txt_block_name ||
                                      ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                     return FALSE;
               END;

               if p_total > 0 then
                  p_txt_script_on_form := p_txt_script_on_form || chr(10) ||
                                          '-- DATABASE DATA BLOCK: ' || r_database_tables_bi.txt_block_name ||
                                          chr(10) ||
                                          'CREATE TABLE ' || r_database_tables_bi.txt_block_query_data_orig_name || ' (' || chr(10);
                  p_column_count       := 0;

                  for r_database_table_items_bi in c_database_table_items_bi (p_id, r_database_tables_bi.txt_block_name) loop
                     p_column_count := p_column_count + 1;

                     if p_column_count = 1 then
                        p_txt_script_on_form := p_txt_script_on_form || '  ';
                     else
                        p_txt_script_on_form := p_txt_script_on_form || ', ';
                     end if;

                     p_txt_script_on_form := p_txt_script_on_form ||
                                             rpad (r_database_table_items_bi.txt_item_field_db_col_name, p_oracle_objects_size + 1, ' ') || ' ' ||
                                             r_database_table_items_bi.txt_item_field_datatype;

                     if    r_database_table_items_bi.txt_item_field_datatype = 'NUMBER' then
                        p_txt_script_on_form := p_txt_script_on_form ||
                                                '(' || r_database_table_items_bi.txt_item_field_maxlength ||
                                                ',' || nvl (r_database_table_items_bi.txt_item_field_precision, 0) || ')';
                     elsif r_database_table_items_bi.txt_item_field_datatype = 'VARCHAR2' then
                        p_txt_script_on_form := p_txt_script_on_form ||
                                                '(' || r_database_table_items_bi.txt_item_field_maxlength || ')';
                     end if;

                     if r_database_table_items_bi.txt_item_field_mandatory = 'YES' then
                        p_txt_script_on_form := p_txt_script_on_form || ' NOT NULL';
                     end if;

                     if r_database_table_items_bi.txt_item_field_db_col_name != r_database_table_items_bi.txt_item_name then
                        p_txt_script_on_form := p_txt_script_on_form || ' -- FIELD "' || r_database_table_items_bi.txt_item_name || '" AT THE FORM';
                     end if;

                     p_txt_script_on_form := p_txt_script_on_form || chr(10);
                  end loop;

                  p_txt_script_on_form := p_txt_script_on_form || ');' || chr(10) || '/' || chr(10) || chr(10);
               end if;

               for r_database_table_items_bi in c_database_table_items_bi (p_id, r_database_tables_bi.txt_block_name) loop
                  if   r_database_table_items_bi.txt_item_field_prompt is not NULL
                   and r_database_table_items_bi.txt_item_field_prompt != r_database_table_items_bi.txt_block_query_data_orig_name then
                     p_txt_script_on_form := p_txt_script_on_form ||
                                             'COMMENT ON COLUMN ' || r_database_tables_bi.txt_block_query_data_orig_name ||
                                             '.' || rpad (r_database_table_items_bi.txt_item_field_db_col_name, p_oracle_objects_size + 1, ' ') ||
                                             ' IS ''' || r_database_table_items_bi.txt_item_field_prompt || ''';' || chr(10);
                  end if;
               end loop;
            end loop;

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro FOR...LOOP 1 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

-- CREATE VIEWS
         p_retorno := PKG_IMPORT_FORM.fu_ret_create_form_views_b (p_id, p_txt_script_on_form, p_msg_retorno);

         if p_retorno != TRUE then
            return p_retorno;
         end if;

-- PRIMARY KEYS
         BEGIN
            p_column_count := 0;

            for r_database_tables_bi_pk in c_database_tables_bi_pk (p_id) loop
               p_primary_key_name   := p_primary_key_name_prefix || substr (r_database_tables_bi_pk.txt_block_query_data_orig_name,
                                                                            1,
                                                                            p_oracle_objects_size
                                                                            - length (p_primary_key_name_prefix));
               p_txt_script_on_form := p_txt_script_on_form || chr(10) ||
                                       '-- PRIMARY KEY OBTAINED FROM DATABASE DATA BLOCKS WITH PRIMARY KEY FIELDS' || chr(10) ||
                                       'ALTER TABLE ' || r_database_tables_bi_pk.txt_block_query_data_orig_name || chr(10) ||
                                       'ADD CONSTRAINT ' || p_primary_key_name || chr(10) ||
                                       'PRIMARY KEY (';
               p_column_count       := 0;

               for r_database_tables_items_pk in c_database_tables_items_pk (p_id, r_database_tables_bi_pk.txt_block_name) loop
                  p_column_count := p_column_count + 1;

                  if p_column_count = 1 then
                     p_txt_script_on_form := p_txt_script_on_form || r_database_tables_items_pk.txt_item_field_db_col_name;
                  else
                     p_txt_script_on_form := p_txt_script_on_form || ', ' || r_database_tables_items_pk.txt_item_field_db_col_name;
                  end if;
               end loop;

               p_txt_script_on_form := p_txt_script_on_form || ');' || chr(10) || '/' || chr(10) || chr(10);
            end loop;

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro FOR...LOOP 2 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

         BEGIN
            if p_column_count = 0 then
               if r_database_tables_bi.txt_block_query_data_orig_name is not NULL then
                  p_txt_script_on_form := p_txt_script_on_form ||
                                          '-- WARNING: NO PRIMARY KEY FOUND FOR TABLE ' ||
                                          r_database_tables_bi.txt_block_query_data_orig_name ||
                                          chr(10) || chr(10) ||
                                          '-- ATTEMPTING TO SUGGEST PRIMARY AND FOREIGN KEYS' ||
                                          chr(10);

                  for r_attempt_generate_pk in c_attempt_generate_pk (p_id, r_database_tables_bi.txt_block_query_data_orig_name) loop
                     p_txt_script_on_form := p_txt_script_on_form || chr(10) ||
                                             '-- PRIMARY KEY' || chr(10) ||
                                             'ALTER TABLE ' || r_attempt_generate_pk.txt_master_data_block || chr(10) ||
                                             'ADD CONSTRAINT' || chr(10) ||
                                             'PRIMARY KEY (';

                     p_column_count_pk := 0;

-- MASTER DATA BLOCK
                     for r_attempt_generate_items_m_pk in c_attempt_generate_items_m_pk (p_id,
                                                                                         r_attempt_generate_pk.txt_relation_name,
                                                                                         r_attempt_generate_pk.txt_master_data_block) loop
                        p_column_count_pk := p_column_count_pk + 1;

                        if p_column_count_pk > 1 then
                           p_txt_script_on_form := p_txt_script_on_form || ', ';
                        end if;

                        p_txt_script_on_form := p_txt_script_on_form || r_attempt_generate_items_m_pk.txt_master_data_block_item;
                     end loop;

                     p_txt_script_on_form := p_txt_script_on_form || ');' || chr(10) || chr(10);

-- DETAIL DATA BLOCK
                     p_column_count_pk := 0;

                     for r_attempt_generate_items_d_pk in c_attempt_generate_items_d_pk (p_id,
                                                                                         r_attempt_generate_pk.txt_relation_name,
                                                                                         r_attempt_generate_pk.txt_detail_data_block) loop
                        p_column_count_pk := p_column_count_pk + 1;

                        if p_column_count_pk > 1 then
                           p_txt_script_on_form := p_txt_script_on_form || ', ';
                        end if;

                        p_txt_script_on_form := p_txt_script_on_form || r_attempt_generate_items_d_pk.txt_detail_data_block_item;
                     end loop;
                  end loop;
               end if;
            end if;

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro FOR...LOOP 3 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

-- Cria as chaves primárias baseado nas relações que a tabela master faz com outras tabelas.
         BEGIN
            for r_relations_master_data_blocks in c_relations_master_data_blocks (p_id) loop
               BEGIN
                  select 1
                    into p_existe
                    from m_load_form_blocks_items mlfbi
                   where mlfbi.id_form                    = p_id
                     and mlfbi.txt_data_origin            = 'BLOCKS AND ITEMS'
                     and mlfbi.txt_item_field_primary_key = 'YES'
                     and mlfbi.txt_block_name             = r_relations_master_data_blocks.txt_master_data_block;

               EXCEPTION
                  when no_data_found then
                     p_existe := 0;
                  when too_many_rows then
                     p_existe := 1;
                  when others then
                     p_msg_retorno := 'Erro SELECT 1 MLFBI 1 MASTER_DATA_BLOCK (' || r_relations_master_data_blocks.txt_master_data_block ||
                                      ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                     return FALSE;
               END;

               if p_existe = 0 then
                  p_master_data_block := PKG_IMPORT_FORM.fu_ret_txt_block_query_data__v (p_id, r_relations_master_data_blocks.txt_master_data_block);

                  if p_master_data_block is not NULL then
                     p_primary_key_name   := p_primary_key_name_prefix || substr (p_master_data_block,
                                                                                  1,
                                                                                  p_oracle_objects_size
                                                                                  - length (p_primary_key_name_prefix));

                     p_txt_script_on_form := p_txt_script_on_form || chr(10) ||
                                             '-- PRIMARY KEY NOT DECLARED ON DATABASE DATA BLOCKS AND BASED ON ITS RELATIONS WITH DETAIL TABLE(S)' || chr(10) ||
                                             '-- MASTER: ' || r_relations_master_data_blocks.txt_master_data_block || chr(10) ||
                                             'ALTER TABLE ' || p_master_data_block || chr(10) ||
                                             'ADD CONSTRAINT ' || p_primary_key_name || chr(10) ||
                                             'PRIMARY KEY (';
                     p_column_count       := 0;

                     for r_relations_master_db_items in c_relations_master_db_items (p_id, r_relations_master_data_blocks.txt_master_data_block) loop
                        p_column_count := p_column_count + 1;

                        if p_column_count > 1 then
                           p_txt_script_on_form := p_txt_script_on_form || ', ';
                        end if;

                        p_txt_script_on_form := p_txt_script_on_form || r_relations_master_db_items.txt_master_data_block_item || chr(10);
                     end loop;

                     p_txt_script_on_form := p_txt_script_on_form || ');' || chr(10) || '/' || chr(10);
                  end if;
               end if;
            end loop;

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro FOR...LOOP 4 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

-- FOREIGN KEYS
         BEGIN
            for r_block_relation_names in c_block_relation_names (p_id) loop
               p_foreign_key_count := 0;

               if r_block_relation_names.txt_master_data_block is not NULL and r_block_relation_names.txt_detail_data_block is not NULL then
                  p_master_data_block  := PKG_IMPORT_FORM.fu_ret_txt_block_query_data__v (p_id, r_block_relation_names.txt_master_data_block);
                  p_detail_data_block  := PKG_IMPORT_FORM.fu_ret_txt_block_query_data__v (p_id, r_block_relation_names.txt_detail_data_block);
                  p_column_count       := 0;

                  if r_block_relation_names.txt_detailed_data_block is not NULL then
                     BEGIN
                        select 1
                          into p_existe
                          from m_load_form_blocks_items mlfbi
                         where mlfbi.txt_data_origin            = 'BLOCKS AND ITEMS'
                           and mlfbi.txt_block_name             = r_block_relation_names.txt_detailed_data_block
                           and mlfbi.txt_item_field_primary_key = 'YES';

                     EXCEPTION
                        when no_data_found then
                           p_existe      := 0;
                        when too_many_rows then
                           p_existe      := 1;
                        when others then
                           p_msg_retorno := 'Erro SELECT MLFBI 2 DETAILED (' || r_block_relation_names.txt_detailed_data_block ||
                                            ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                           return FALSE;
                     END;

                     if p_existe = 0 then
                        p_primary_key_name   := p_primary_key_name_prefix || substr (p_detail_data_block,
                                                                                     1,
                                                                                     p_oracle_objects_size
                                                                                     - length (p_primary_key_name_prefix));
                        p_txt_script_on_form := p_txt_script_on_form || chr(10) ||
                                                '-- PRIMARY KEY IS BASED ON MASTER-DETAIL RELATIONS' || chr(10) ||
                                                'ALTER TABLE ' || p_detail_data_block || chr(10) ||
                                                'ADD CONSTRAINT ' || p_primary_key_name || chr(10) ||
                                                'PRIMARY KEY (';

                        for r_block_relation_names_items in c_block_relation_names_items (p_id,
                                                                                          r_block_relation_names.txt_master_data_block,
                                                                                          r_block_relation_names.txt_detail_data_block,
                                                                                          r_block_relation_names.txt_relation_name) loop
                           if p_column_count > 0 then
                              p_txt_script_on_form := p_txt_script_on_form || ', ';
                           end if;

                           p_txt_script_on_form := p_txt_script_on_form || r_block_relation_names_items.txt_detail_data_block_item || chr(10);
                           p_column_count       := p_column_count + 1;
                        end loop;

                        p_txt_script_on_form := p_txt_script_on_form || ');' || chr(10) || '/' || chr(10) || chr(10);
                     end if;
                  end if;

                  p_foreign_key_count  := p_foreign_key_count + 1;
                  p_txt_script_on_form := p_txt_script_on_form ||
                                          '-- RELATION: ' || r_block_relation_names.txt_relation_name || chr(10) ||
                                          'ALTER TABLE ' || p_detail_data_block || chr(10) ||
                                          'ADD CONSTRAINT ';

                  if r_block_relation_names.txt_detailed_data_block = r_block_relation_names.txt_detail_data_block then
                     p_foreign_key_name := p_foreign_key_name_prefix || substr (p_detail_data_block,
                                                                                1,
                                                                                p_oracle_objects_size
                                                                                - length (p_foreign_key_name_prefix)
                                                                                - length ('_' || trim (to_char (p_foreign_key_count, '00'))))
                                                                     || '_' || trim (to_char (p_foreign_key_count, '00'));
                  else
                     p_foreign_key_name := p_foreign_key_name_prefix || substr (p_master_data_block,
                                                                                1,
                                                                                p_oracle_objects_size
                                                                                - length (p_foreign_key_name_prefix)
                                                                                - length ('_' || trim (to_char (p_foreign_key_count, '00'))))
                                                                     || '_' || trim (to_char (p_foreign_key_count, '00'));
                  end if;

                  p_txt_script_on_form := p_txt_script_on_form || p_foreign_key_name || chr(10) || 'FOREIGN KEY (';
                  p_column_count       := 0;

                  for r_block_relation_names_pk in c_block_relation_names_pk (p_id, r_block_relation_names.txt_relation_name) loop
                     p_column_count := p_column_count + 1;

                     if p_column_count = 1 then
                        p_txt_script_on_form := p_txt_script_on_form || r_block_relation_names_pk.txt_detail_data_block_item;
                     else
                        p_txt_script_on_form := p_txt_script_on_form || ', ' || r_block_relation_names_pk.txt_detail_data_block_item;
                     end if;
                  end loop;

                  p_column_count       := 0;
                  p_txt_script_on_form := p_txt_script_on_form || ')' || chr(10) || 'REFERENCES ' || p_master_data_block || ' (';

                  for r_block_relation_names_pk in c_block_relation_names_pk (p_id, r_block_relation_names.txt_relation_name) loop
                     p_column_count := p_column_count + 1;

                     if p_column_count = 1 then
                        p_txt_script_on_form := p_txt_script_on_form || r_block_relation_names_pk.txt_master_data_block_item;
                     else
                        p_txt_script_on_form := p_txt_script_on_form || ', ' || r_block_relation_names_pk.txt_master_data_block_item;
                     end if;
                  end loop;

                  p_txt_script_on_form := p_txt_script_on_form || ');' || chr(10) || '/' || chr(10) || chr(10);
               end if;
            end loop;

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro FOR...LOOP 5 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

-- QUERY DATA SOURCE
         BEGIN
            p_txt_script_on_form       := p_txt_script_on_form || chr(10) || '-- ACCORDING TO QUERY DATA SOURCE' || chr(10) || chr(10);
            p_query_data_source_exists := FALSE;

            for r_database_tables_qdsc in c_database_tables_qdsc (p_id) loop
               p_query_data_source_exists := TRUE;
               p_txt_script_on_form       := p_txt_script_on_form ||
                                             '-- QUERY DATA SOURCE COLUMNS: BLOCK: ' || r_database_tables_qdsc.txt_block_name ||
                                             chr(10) ||
                                             'CREATE TABLE ' || r_database_tables_qdsc.txt_block_query_data_orig_name || ' (' || chr(10);
               p_column_count             := 0;

               for r_database_tables_items_qdsc in c_database_tables_items_qdsc (p_id, r_database_tables_qdsc.txt_block_name) loop
                  p_column_count := p_column_count + 1;

                  if p_column_count = 1 then
                     p_txt_script_on_form := p_txt_script_on_form || '  ';
                  else
                     p_txt_script_on_form := p_txt_script_on_form || ', ';
                  end if;

                  p_txt_script_on_form := p_txt_script_on_form || rpad (r_database_tables_items_qdsc.txt_item_name, p_oracle_objects_size + 1, ' ') ||
                                          r_database_tables_items_qdsc.txt_item_field_db_col_name || ' ' ||
                                          r_database_tables_items_qdsc.txt_item_field_datatype;

                  if    r_database_tables_items_qdsc.txt_item_field_datatype = 'NUMBER' then
                     p_txt_script_on_form := p_txt_script_on_form ||
                                             '(' || r_database_tables_items_qdsc.txt_item_field_precision ||
                                             ',' || r_database_tables_items_qdsc.txt_item_field_scale || ')';
                  elsif r_database_tables_items_qdsc.txt_item_field_datatype = 'VARCHAR2' then
                     p_txt_script_on_form := p_txt_script_on_form ||
                                             '(' || r_database_tables_items_qdsc.txt_item_field_maxlength || ')';
                  end if;

                  if r_database_tables_items_qdsc.txt_item_field_mandatory = 'YES' then
                     p_txt_script_on_form := p_txt_script_on_form || ' NOT NULL';
                  end if;

                  p_txt_script_on_form := p_txt_script_on_form || chr(10);
               end loop;

               p_txt_script_on_form := p_txt_script_on_form || ');' || chr(10) || '/' || chr(10) || chr(10);
            end loop;

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro FOR...LOOP 6 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

/*       if p_query_data_source_exists = TRUE then
-- ANALYZE DIFFERENCES BETWEEN BOTH MODELS
            BEGIN
               for r_blocks_and_items_no_qdsc in c_blocks_and_items_no_qdsc (p_id) loop
                  p_txt_script_on_form := p_txt_script_on_form || '-- DATABASE DATA BLOCK "' || r_blocks_and_items_no_qdsc.txt_block_name ||
                                                                  '" (TABLE: "' || r_blocks_and_items_no_qdsc.txt_block_query_data_orig_name ||
                                                                  '") HAS NO CORRESPONDING QUERY DATA SOURCE.' || chr(10);
               end loop;

               p_txt_script_on_form := p_txt_script_on_form || chr(10) ||
                                       '-- "DATABASE DATA BLOCK" COMPARED TO "QUERY DATA SOURCE":' || chr(10);

               for r_blocks_items_compare_qdsc in c_blocks_items_compare_qdsc (p_id) loop
                  BEGIN
                     select mlfbi.txt_block_query_data_orig_name,
                            mlfbi.txt_item_field_db_col_name,
                            mlfbi.txt_item_field_datatype,
                            nvl (mlfbi.txt_item_field_maxlength, 0) as txt_item_field_maxlength,
                            nvl (mlfbi.txt_item_field_precision, 0) as txt_item_field_precision,
                            nvl (mlfbi.txt_item_field_scale,     0) as txt_item_field_scale,
                            mlfbi.txt_item_field_mandatory
                       into p_m_load_form_blocks_items.txt_block_query_data_orig_name,
                            p_m_load_form_blocks_items.txt_item_field_db_col_name,
                            p_m_load_form_blocks_items.txt_item_field_datatype,
                            p_m_load_form_blocks_items.txt_item_field_maxlength,
                            p_m_load_form_blocks_items.txt_item_field_precision,
                            p_m_load_form_blocks_items.txt_item_field_scale,
                            p_m_load_form_blocks_items.txt_item_field_mandatory
                       from m_load_form_blocks_items mlfbi
                      where mlfbi.id_form                        =  p_id
                        and mlfbi.txt_data_origin                =  'QUERY DATA SOURCE COLUMNS'
                        and mlfbi.txt_block_query_data_orig_type =  'TABLE'
                        and mlfbi.txt_block_name                 is not NULL
                        and mlfbi.txt_item_name                  is not NULL
                        and mlfbi.txt_block_query_data_orig_name is not NULL
                        and mlfbi.txt_block_query_data_orig_name =  r_blocks_items_compare_qdsc.txt_block_query_data_orig_name
                        and mlfbi.txt_item_name                  =  r_blocks_items_compare_qdsc.txt_item_field_db_col_name;

                     if r_blocks_items_compare_qdsc.txt_item_field_datatype != p_m_load_form_blocks_items.txt_item_field_datatype then
                        p_txt_script_on_form := p_txt_script_on_form || '-- DIFFERENT DATA TYPES: TABLE.COLUMN = '
                                                                     || r_blocks_items_compare_qdsc.txt_block_query_data_orig_name || '.'
                                                                     || r_blocks_items_compare_qdsc.txt_item_field_db_col_name
                                                                     || '; DATABASE DATA BLOCK = "' || r_blocks_items_compare_qdsc.txt_item_field_datatype
                                                                     || '"; QUERY DATA SOURCE = "' || p_m_load_form_blocks_items.txt_item_field_datatype
                                                                     || '"' || chr(10);
                     end if;

                     if r_blocks_items_compare_qdsc.txt_item_field_maxlength != p_m_load_form_blocks_items.txt_item_field_maxlength then
                        p_txt_script_on_form := p_txt_script_on_form || '-- DIFFERENT MAX LENGTH: TABLE.COLUMN = '
                                                                     || r_blocks_items_compare_qdsc.txt_block_query_data_orig_name || '.'
                                                                     || r_blocks_items_compare_qdsc.txt_item_field_db_col_name
                                                                     || '; DATABASE DATA BLOCK = "' || r_blocks_items_compare_qdsc.txt_item_field_maxlength
                                                                     || '"; QUERY DATA SOURCE = "' || p_m_load_form_blocks_items.txt_item_field_maxlength
                                                                     || '"' || chr(10);
                     end if;

                     if r_blocks_items_compare_qdsc.txt_item_field_precision != p_m_load_form_blocks_items.txt_item_field_precision then
                        p_txt_script_on_form := p_txt_script_on_form || '-- DIFFERENT PRECISION: TABLE.COLUMN = '
                                                                     || r_blocks_items_compare_qdsc.txt_block_query_data_orig_name || '.'
                                                                     || r_blocks_items_compare_qdsc.txt_item_field_db_col_name
                                                                     || '; DATABASE DATA BLOCK = "' || r_blocks_items_compare_qdsc.txt_item_field_precision
                                                                     || '"; QUERY DATA SOURCE = "' || p_m_load_form_blocks_items.txt_item_field_precision
                                                                     || '"' || chr(10);
                     end if;

                     if r_blocks_items_compare_qdsc.txt_item_field_scale != p_m_load_form_blocks_items.txt_item_field_scale then
                        p_txt_script_on_form := p_txt_script_on_form || '-- DIFFERENT SCALE: TABLE.COLUMN = '
                                                                     || r_blocks_items_compare_qdsc.txt_block_query_data_orig_name || '.'
                                                                     || r_blocks_items_compare_qdsc.txt_item_field_db_col_name
                                                                     || '; DATABASE DATA BLOCK = "' || r_blocks_items_compare_qdsc.txt_item_field_scale
                                                                     || '"; QUERY DATA SOURCE = "' || p_m_load_form_blocks_items.txt_item_field_scale
                                                                     || '"' || chr(10);
                     end if;

                     if r_blocks_items_compare_qdsc.txt_item_field_mandatory != p_m_load_form_blocks_items.txt_item_field_mandatory then
                        p_txt_script_on_form := p_txt_script_on_form || '-- DIFFERENT YES/NO MANDATORY: TABLE.COLUMN = '
                                                                     || r_blocks_items_compare_qdsc.txt_block_query_data_orig_name || '.'
                                                                     || r_blocks_items_compare_qdsc.txt_item_field_db_col_name
                                                                     || '; DATABASE DATA BLOCK = "' || r_blocks_items_compare_qdsc.txt_item_field_mandatory
                                                                     || '"; QUERY DATA SOURCE = "' || p_m_load_form_blocks_items.txt_item_field_mandatory
                                                                     || '"' || chr(10);
                     end if;

                  EXCEPTION
                     when no_data_found then
                        p_txt_script_on_form := p_txt_script_on_form || '-- NO CORRESPONDENCE: TABLE.COLUMN = '
                                                                     || r_blocks_items_compare_qdsc.txt_block_query_data_orig_name || '.'
                                                                     || r_blocks_items_compare_qdsc.txt_item_field_db_col_name || chr(10);
                     when others then
                        p_msg_retorno := 'Erro FOR...LOOP 7.2 (' || r_blocks_items_compare_qdsc.txt_block_query_data_orig_name || '.'
                                                                 || r_blocks_items_compare_qdsc.txt_item_field_db_col_name
                                                                 || ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                        return FALSE;
                  END;
               end loop;

               for r_query_data_source_columns in c_query_data_source_columns (p_id) loop
                  BEGIN
                     select 1
                       into p_existe
                       from m_load_form_blocks_items mlfbi
                      where mlfbi.id_form                         = p_id
                        and mlfbi.txt_data_origin                 = 'BLOCKS AND ITEMS'
                        and mlfbi.txt_block_database_data_block   = 'YES'
                        and mlfbi.txt_block_query_data_orig_type  = 'TABLE'
                        and mlfbi.txt_block_query_data_orig_name  = r_query_data_source_columns.txt_block_query_data_orig_name
                        and mlfbi.txt_item_name                  is NULL;

                  EXCEPTION
                     when no_data_found then
                        p_txt_script_on_form := p_txt_script_on_form || '-- QUERY DATA SOURCE -> DATABASE DATA BLOCK: TABLE "'
                                                                     || r_query_data_source_columns.txt_block_query_data_orig_name
                                                                     || '": NO CORRESPONDENCE' || chr(10);
                     when others then
                        p_msg_retorno := 'Erro FOR...LOOP 7.3 (' || r_query_data_source_columns.txt_block_query_data_orig_name ||
                                         ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                        return FALSE;
                  END;

                  if   r_query_data_source_columns.txt_block_query_data_orig_name is not NULL
                   and r_query_data_source_columns.txt_item_name                  is not NULL then
                     BEGIN
                        select 1
                          into p_existe
                          from m_load_form_blocks_items mlfbi
                         where mlfbi.id_form                         = p_id
                           and mlfbi.txt_data_origin                 = 'BLOCKS AND ITEMS'
                           and mlfbi.txt_block_database_data_block   = 'YES'
                           and mlfbi.txt_item_field_database         = 'YES'
                           and mlfbi.txt_block_query_data_orig_type  = 'TABLE'
                           and mlfbi.txt_block_query_data_orig_name  = r_query_data_source_columns.txt_block_query_data_orig_name
                           and mlfbi.txt_item_field_db_col_name      = r_query_data_source_columns.txt_item_name
                           and mlfbi.txt_item_field_db_col_name     is not NULL;

                     EXCEPTION
                        when no_data_found then
                           p_txt_script_on_form := p_txt_script_on_form || '-- QUERY DATA SOURCE -> DATABASE DATA BLOCK: TABLE.COLUMN "'
                                                                        || r_query_data_source_columns.txt_block_query_data_orig_name || '.'
                                                                        || r_query_data_source_columns.txt_item_name
                                                                        || '": NO CORRESPONDENCE' || chr(10);
                        when others then
                           p_msg_retorno := 'Erro FOR...LOOP 7.4 (' || r_query_data_source_columns.txt_block_query_data_orig_name || '.'
                                                                    || r_query_data_source_columns.txt_item_name
                                                                    || ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                           return FALSE;
                     END;
                  end if;
               end loop;

            EXCEPTION
               when others then
                  p_msg_retorno := 'Erro FOR...LOOP 7 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                  return FALSE;
            END;
         end if;
*/

-- SAVE CONTENTS INTO TABLE
         BEGIN
            p_txt_script_on_form_b := PKG_IMPORT_FORM.fu_convert_clob_to_blob_b (p_txt_script_on_form);

            update m_load_form mlf
               set mlf.txt_script_on_form   = p_txt_script_on_form,
                   mlf.txt_script_on_form_b = p_txt_script_on_form_b,
                   mlf.txt_script_on_form_f = p_txt_form_name || PKG_IMPORT_FORM.p_txt_script_on_form_s
             where mlf.id                   = p_id;

            DBMS_LOB.freetemporary (p_txt_script_on_form);

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro UPDATE MLF 3 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_create_alter_table_cols_b;

-- fu_convert_clob_to_blob_b
   FUNCTION fu_convert_clob_to_blob_b (p_clob_content clob) RETURN blob IS
      p_blob_result blob;
      o1            integer;
      o2            integer;
      c             integer;
      w             integer;

   BEGIN
      o1 := 1;
      o2 := 1;
      c  := 0;
      w  := 0;

      DBMS_LOB.createtemporary (p_blob_result, TRUE);
      DBMS_LOB.converttoblob (p_blob_result, p_clob_content, length (p_clob_content), o1, o2, 0, c, w);

      return p_blob_result;

   EXCEPTION
      when others then
         raise_application_error (-20000, 'Erro fu_convert_clob_to_blob_b (' || substr (p_clob_content, 1, 50) || '): ' || to_char (sqlcode) || ' - ' || sqlerrm);
   END fu_convert_clob_to_blob_b;

-- fu_ret_clob_sql_query_no_com_b
   FUNCTION fu_ret_clob_sql_query_no_com_b (p_id_form                       M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE,
                                            p_txt_record_group_name         M_LOAD_FORM_RECORD_GROUPS.txt_record_group_name%TYPE,
                                            p_clob_sql_query_no_comm IN OUT M_LOAD_FORM_RECORD_GROUPS.clob_sql_query_no_comm%TYPE,
                                            p_msg_retorno            IN OUT varchar2)
                                            RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_clob_sql_query_no_com_b (' || p_id_form || ', ' || p_txt_record_group_name || '): ';

   BEGIN
      if    p_id_form is NULL then
         p_msg_retorno := 'Error ' || p_prc_name || 'form ID must be informed.';
         return FALSE;
      elsif trim (p_txt_record_group_name) is NULL then
         p_msg_retorno := 'Error ' || p_prc_name || 'record group name must be informed.';
         return FALSE;
      else
         BEGIN
            select trim (mlfrg.clob_sql_query_no_comm) as clob_sql_query_no_comm
              into p_clob_sql_query_no_comm
              from m_load_form_record_groups mlfrg
             where mlfrg.id_form               = p_id_form
               and mlfrg.txt_record_group_name = p_txt_record_group_name
               and rownum                      = 1
               and instr (mlfrg.clob_sql_query, ':') > 0;

         EXCEPTION
            when no_data_found then
               BEGIN
                  select trim (mlfrg.clob_sql_query_no_comm) as clob_sql_query_no_comm
                    into p_clob_sql_query_no_comm
                    from m_load_form_record_groups mlfrg
                   where mlfrg.id_form               = p_id_form
                     and mlfrg.txt_record_group_name = p_txt_record_group_name
                     and rownum                      = 1;

               EXCEPTION
                  when no_data_found then
                     p_clob_sql_query_no_comm := empty_clob();
                  when others then
                     p_msg_retorno := 'Error SELECT MLFRG (2) CLOB_SQL_QUERY_NO_COMM at ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                     return FALSE;
               END;
            when others then
               p_msg_retorno := 'Error SELECT MLFRG (1) CLOB_SQL_QUERY_NO_COMM at ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_clob_sql_query_no_com_b;

-- fu_ret_clob_sql_query_no_com_c
   FUNCTION fu_ret_clob_sql_query_no_com_c (p_id_form               M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE,
                                            p_txt_record_group_name M_LOAD_FORM_RECORD_GROUPS.txt_record_group_name%TYPE)
                                            RETURN M_LOAD_FORM_RECORD_GROUPS.clob_sql_query_no_comm%TYPE IS
      p_clob_sql_query_no_comm M_LOAD_FORM_RECORD_GROUPS.clob_sql_query_no_comm%TYPE := empty_clob();
      p_retorno     boolean        := NULL;
      p_prc_name    varchar2(1000) := p_pck_name || 'fu_ret_clob_sql_query_no_com_c (' || p_id_form || ', ' || p_txt_record_group_name || '): ';
      p_msg_retorno varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_clob_sql_query_no_com_b (p_id_form,
                                                                   p_txt_record_group_name,
                                                                   p_clob_sql_query_no_comm,
                                                                   p_msg_retorno);

      if p_retorno = TRUE then
         return p_clob_sql_query_no_comm;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_clob_sql_query_no_com_c;

-- fu_ret_clob_sql_dblck_no_com_b
   FUNCTION fu_ret_clob_sql_dblck_no_com_b (p_id_form                             M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE,
                                            p_txt_block_name                      M_LOAD_FORM_BLOCKS_ITEMS.txt_block_name%TYPE,
                                            p_txt_block_query_data_orig_cl IN OUT M_LOAD_FORM_BLOCKS_ITEMS.txt_block_query_data_orig_clob%TYPE,
                                            p_msg_retorno                  IN OUT varchar2)
                                            RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_clob_sql_dblck_no_com_b (' || p_id_form || ', ' || p_txt_block_name || '): ';

   BEGIN
      if    p_id_form is NULL then
         p_msg_retorno := 'Error ' || p_prc_name || 'form ID must be informed.';
         return FALSE;
      elsif trim (p_txt_block_name) is NULL then
         p_msg_retorno := 'Error ' || p_prc_name || 'block name name must be informed.';
         return FALSE;
      else
         BEGIN
            select mlfbi.txt_block_query_data_orig_clob -- mlfbi.txt_block_where_clause, mlfbi.txt_block_order_by
              into p_txt_block_query_data_orig_cl
              from m_load_form_blocks_items mlfbi
             where mlfbi.id_form                        =  p_id_form
               and mlfbi.txt_block_name                 =  p_txt_block_name
               and mlfbi.txt_item_name                  is NULL
               and mlfbi.txt_disposable_data_block       = 'N'
               and mlfbi.txt_block_query_data_orig_type  = 'FROM_WHERE_CLAUSE'
               and mlfbi.txt_block_query_data_orig_name is NULL
               and mlfbi.txt_block_query_data_orig_clob is not NULL;

         EXCEPTION
            when no_data_found then
               p_txt_block_query_data_orig_cl := empty_clob();
            when others then
               p_msg_retorno := 'Error SELECT MLFBI FWC at ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_clob_sql_dblck_no_com_b;

-- fu_ret_clob_sql_dblck_no_com_c
   FUNCTION fu_ret_clob_sql_dblck_no_com_c (p_id_form        M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE,
                                            p_txt_block_name M_LOAD_FORM_BLOCKS_ITEMS.txt_block_name%TYPE)
                                            RETURN M_LOAD_FORM_BLOCKS_ITEMS.txt_block_query_data_orig_clob%TYPE IS
      p_txt_block_query_data_orig_cl M_LOAD_FORM_BLOCKS_ITEMS.txt_block_query_data_orig_clob%TYPE := empty_clob();
      p_retorno     boolean        := NULL;
      p_prc_name    varchar2(1000) := p_pck_name || 'fu_ret_clob_sql_dblck_no_com_c (' || p_id_form || ', ' || p_txt_block_name || '): ';
      p_msg_retorno varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_clob_sql_dblck_no_com_b (p_id_form,
                                                                   p_txt_block_name,
                                                                   p_txt_block_query_data_orig_cl,
                                                                   p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_block_query_data_orig_cl;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_clob_sql_dblck_no_com_c;

-- fu_ret_rpad_variable_i
   FUNCTION fu_ret_rpad_variable_i (p_id_form           M_LOAD_FORM_GLOB_SYST_PARM.id_form%TYPE,
                                    p_txt_variable_type M_LOAD_FORM_GLOB_SYST_PARM.txt_variable_type%TYPE)
                                    RETURN integer IS
      p_max_len_variable_name integer := NULL;

   BEGIN
      select max (length (replace (mlfgsp.txt_variable_name,
                                   ':' || p_txt_variable_type || '.' || mlfgsp.txt_variable_name,
                                   mlfgsp.txt_variable_name))) as max_len_variable_name
        into p_max_len_variable_name
        from m_load_form_glob_syst_parm mlfgsp
       where mlfgsp.id_form           = p_id_form
         and mlfgsp.txt_variable_type = p_txt_variable_type;

      return nvl (p_max_len_variable_name, PKG_IMPORT_FORM.p_oracle_objects_size);

   EXCEPTION
      when others then
         return PKG_IMPORT_FORM.p_oracle_objects_size;
   END fu_ret_rpad_variable_i;

-- fu_retrieve_prog_unit_header_b
   FUNCTION fu_retrieve_prog_unit_header_b (p_clob_plsql_contents        clob,
                                            p_program_unit_header IN OUT clob,
                                            p_msg_retorno         IN OUT varchar2)
                                            RETURN boolean IS
      p_reading_program_unit_header boolean        := TRUE;
      p_clob_plsql_contents_c       clob           := empty_clob();
      p_instr_chr_10                integer        := NULL;
      p_line_analysis               varchar2(4000) := NULL;
      p_prc_name                    varchar2(4000) := p_pck_name || 'fu_retrieve_prog_unit_header_b: ';

   BEGIN
      p_clob_plsql_contents_c := p_clob_plsql_contents;
      p_program_unit_header   := empty_clob();

      loop
         p_instr_chr_10          := instr (p_clob_plsql_contents_c, chr(10));
         exit when p_instr_chr_10 = 0; -- EXITS LOOP WHEN NO NEW LINES ARE FOUND (NO MORE PL/SQL CONTENTS)

         p_line_analysis         := translate (substr (p_clob_plsql_contents_c, 1, p_instr_chr_10), chr(9) || chr(10), '  ');
         p_clob_plsql_contents_c := substr (p_clob_plsql_contents_c, p_instr_chr_10 + 1);

         if trim (p_line_analysis) is not NULL then
            p_program_unit_header := p_program_unit_header || p_line_analysis || chr(10);
         end if;

-- JUMPS PROCEDURE/FUNCTION HEADER
         if p_reading_program_unit_header = TRUE then
            if  instr (upper (p_line_analysis), ' IS ') > 0
             or substr (trim (upper (p_line_analysis)), length (trim (upper (p_line_analysis))) - 2) in (' IS', ')IS')
             or trim (translate (upper (p_line_analysis), chr(9) || chr(10), '  ')) = 'IS' then
               p_reading_program_unit_header := FALSE;

               if    instr (upper (p_line_analysis), ' IS ') > 0 then
                  p_program_unit_header := regexp_replace (p_program_unit_header, ' IS ', ';', 1, 0, 'i');
               elsif substr (trim (upper (p_line_analysis)), length (trim (upper (p_line_analysis))) - 2) = ' IS' then
                  p_program_unit_header := regexp_replace (p_program_unit_header, ' IS', ';', 1, 0, 'i');
               elsif substr (trim (upper (p_line_analysis)), length (trim (upper (p_line_analysis))) - 2) = ')IS' then
                  p_program_unit_header := regexp_replace (p_program_unit_header, '[)]IS', ');', 1, 0, 'i');
               elsif trim (translate (upper (p_line_analysis), chr(9) || chr(10), '  ')) = 'IS' then
                  p_program_unit_header := trim (p_program_unit_header) || ';';
               end if;

               p_program_unit_header := trim (substr (p_program_unit_header, 1, instr (p_program_unit_header, ';')));

               return TRUE;
            end if;
         end if;
      end loop;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_retrieve_prog_unit_header_b;

-- fu_retrieve_prog_unit_header_c
   FUNCTION fu_retrieve_prog_unit_header_c (p_clob_plsql_contents clob)
                                            RETURN clob IS
      p_retorno             boolean        := NULL;
      p_program_unit_header clob           := empty_clob();
      p_msg_retorno         varchar2(4000) := NULL;
      p_prc_name            varchar2(4000) := p_pck_name || 'fu_retrieve_prog_unit_header_c: ';

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_retrieve_prog_unit_header_b (p_clob_plsql_contents,
                                                                   p_program_unit_header,
                                                                   p_msg_retorno);

      if p_retorno = TRUE then
         return p_program_unit_header;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_retrieve_prog_unit_header_c;

-- fu_ret_prog_unit_no_header_b
   FUNCTION fu_ret_prog_unit_no_header_b (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                          p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                          p_clob_plsql_contents                M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE,
                                          p_clob_plsql_contents_c       IN OUT M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE,
                                          p_msg_retorno                 IN OUT varchar2)
                                          RETURN boolean IS
      p_reading_program_unit_header boolean        := TRUE;
      p_instr_chr_10                integer        := NULL;
      p_prc_name                    varchar2(4000) := p_pck_name || 'fu_ret_prog_unit_no_header_b (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';
      p_line_analysis               varchar2(4000) := NULL;

   BEGIN
      if    p_id_form is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
         return FALSE;
      elsif p_txt_generated_function_name is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'a função deve ser informada.';
         return FALSE;
      elsif p_clob_plsql_contents = empty_clob() then
         p_msg_retorno := 'Erro ' || p_prc_name || 'CLOB vazio.';
         return FALSE;
      else
         p_clob_plsql_contents_c := p_clob_plsql_contents;

         loop
            p_instr_chr_10          := instr (p_clob_plsql_contents_c, chr(10));
            exit when p_reading_program_unit_header = FALSE;

            p_line_analysis         := translate (substr (p_clob_plsql_contents_c, 1, p_instr_chr_10), chr(9) || chr(10), '  ');
            p_clob_plsql_contents_c := substr (p_clob_plsql_contents_c, p_instr_chr_10 + 1);

            if p_reading_program_unit_header = TRUE then
               if  instr (upper (p_line_analysis), ' IS ') > 0
                or substr (trim (upper (p_line_analysis)), length (trim (upper (p_line_analysis))) - 2) in (' IS', ')IS')
                or trim (translate (upper (p_line_analysis), chr(9) || chr(10), '  ')) = 'IS' then
                  if    instr (upper (p_line_analysis), ' IS ') > 0 then
                     p_line_analysis := trim (substr (p_line_analysis, instr (upper (p_line_analysis), ' IS ') + length (' IS ')));
                  else
                     p_line_analysis := NULL;
                  end if;

                  p_reading_program_unit_header := FALSE;
                  p_clob_plsql_contents_c       := p_line_analysis || p_clob_plsql_contents_c;
               end if;
            end if;
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_prog_unit_no_header_b;

-- fu_ret_prog_unit_no_header_c
   FUNCTION fu_ret_prog_unit_no_header_c (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                          p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                          p_analyze_clob_with_comments  boolean default TRUE)
                                          RETURN M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE IS
      p_clob_plsql_contents         M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE := empty_clob();
      p_clob_plsql_contents_c       M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE := empty_clob();
      p_clob_plsql_contents_edit    M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE := empty_clob();
      p_clob_plsql_contents_no_comm M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE := empty_clob();
      p_retorno     boolean        := NULL;
      p_msg_retorno varchar2(4000) := NULL;
      p_prc_name    varchar2(4000) := p_pck_name || 'fu_ret_prog_unit_no_header_c (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';

   BEGIN
      BEGIN
         select mlfpc.clob_plsql_contents,
                mlfpc.clob_plsql_contents_no_comm
           into p_clob_plsql_contents,
                p_clob_plsql_contents_no_comm
           from m_load_form_plsql_contents mlfpc
          where mlfpc.id_form = p_id_form
            and ((mlfpc.txt_generated_function_name is     NULL and mlfpc.txt_plsql_object_name       = trim (upper (p_txt_generated_function_name)))
              or (mlfpc.txt_generated_function_name is not NULL and mlfpc.txt_generated_function_name = trim (upper (p_txt_generated_function_name))));

      EXCEPTION
         when no_data_found then
            p_clob_plsql_contents         := empty_clob();
            p_clob_plsql_contents_no_comm := empty_clob();
         when others then
            return 'Erro SELECT MLFPC 7 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
      END;

      if p_analyze_clob_with_comments = TRUE then
         p_clob_plsql_contents_edit := p_clob_plsql_contents;
      else
         p_clob_plsql_contents_edit := p_clob_plsql_contents_no_comm;
      end if;

      if p_clob_plsql_contents_edit = empty_clob() then
         return NULL;
      else
         p_clob_plsql_contents_edit := PKG_IMPORT_FORM.fu_chg_item_to_block_item_b (p_id_form,                     -- p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE
                                                                                    p_txt_generated_function_name, -- p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE
                                                                                    p_analyze_clob_with_comments); -- p_analyze_clob_with_comments  boolean default TRUE

         p_retorno := PKG_IMPORT_FORM.fu_chg_plsql_blocks_to_parms_b (p_id_form, p_txt_generated_function_name, p_clob_plsql_contents_edit, p_msg_retorno);

         p_retorno := PKG_IMPORT_FORM.fu_ret_prog_unit_no_header_b (p_id_form,
                                                                    p_txt_generated_function_name,
                                                                    p_clob_plsql_contents_edit,
                                                                    p_clob_plsql_contents_c,
                                                                    p_msg_retorno);

         if p_retorno = TRUE then
            return p_clob_plsql_contents_c;
         else
            return p_msg_retorno;
         end if;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_prog_unit_no_header_c;

-- fu_ret_program_unit_header_p_v
   FUNCTION fu_ret_program_unit_header_p_v (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                            RETURN varchar2 IS
      p_clob_plsql_contents_no_comm M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents_no_comm%TYPE := NULL;
      p_retorno             boolean        := NULL;
      p_prc_name            varchar2(1000) := p_pck_name || 'fu_ret_program_unit_header_p_v (' || p_id_form || ',' || p_txt_generated_function_name || '): ';
      p_msg_retorno         varchar2(4000) := NULL;
      p_program_unit_header varchar2(4000) := NULL;

   BEGIN
      if    p_id_form is NULL then
         return 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
      elsif p_txt_generated_function_name is NULL then
         return 'Erro ' || p_prc_name || 'a função deve ser informada.';
      else
         BEGIN
            select mlfpc.clob_plsql_contents_no_comm
              into p_clob_plsql_contents_no_comm
              from m_load_form_plsql_contents mlfpc
             where mlfpc.id_form = p_id_form
               and ((mlfpc.txt_generated_function_name is     NULL and mlfpc.txt_plsql_object_name       = trim (upper (p_txt_generated_function_name)))
                 or (mlfpc.txt_generated_function_name is not NULL and mlfpc.txt_generated_function_name = trim (upper (p_txt_generated_function_name))));

         EXCEPTION
            when no_data_found then
               p_clob_plsql_contents_no_comm := empty_clob();
            when others then
               return 'Erro SELECT MLFPC 3 CLOB em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         END;

         if p_clob_plsql_contents_no_comm = empty_clob() then
            return NULL;
         else
            p_retorno := PKG_IMPORT_FORM.fu_retrieve_prog_unit_header_b (p_clob_plsql_contents_no_comm,
                                                                         p_program_unit_header,
                                                                         p_msg_retorno);

            if p_retorno = TRUE then
               return p_program_unit_header;
            else
               return p_msg_retorno;
            end if;
         end if;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_program_unit_header_p_v;

-- fu_ret_function_type_return_v
   FUNCTION fu_ret_function_type_return_v (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                           p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                           RETURN varchar2 IS
      p_instr_chr_10        integer        := NULL;
      p_prc_name            varchar2(1000) := p_pck_name || 'fu_ret_function_type_return_v (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';
      p_line_analysis       varchar2(4000) := NULL;
      p_program_unit_header varchar2(4000) := NULL;
      p_return_type         varchar2(4000) := NULL;

   BEGIN
      if    p_id_form is NULL then
         return 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
      elsif p_txt_generated_function_name is NULL then
         return 'Erro ' || p_prc_name || 'a função deve ser informada.';
      else
         p_program_unit_header := trim (upper (PKG_IMPORT_FORM.fu_ret_program_unit_header_p_v (p_id_form, p_txt_generated_function_name)));

         if p_program_unit_header is not NULL then
            if trim (upper (substr (p_program_unit_header, 1, instr (p_program_unit_header, ' ')))) = 'FUNCTION' then
               loop
                  p_instr_chr_10 := instr (p_program_unit_header, chr(10));

                  if p_instr_chr_10 = 0 then
                     p_line_analysis       := p_program_unit_header;
                  else
                     p_line_analysis       := trim (translate (substr (p_program_unit_header, 1, p_instr_chr_10), chr(9) || chr(10), '  '));
                     p_program_unit_header := trim (substr (p_program_unit_header, p_instr_chr_10 + 1));
                  end if;

                  if    p_program_unit_header is NULL then
                     p_return_type := trim (replace (substr (p_line_analysis, instr (p_line_analysis, 'RETURN ') + length ('RETURN ')), ';', ' '));
                     exit;
                  elsif (p_line_analysis       is not NULL and instr (p_line_analysis,       'RETURN') > 0)
                     or (p_program_unit_header is not NULL and instr (p_program_unit_header, 'RETURN') > 0) then
                     if    instr (p_line_analysis, ')RETURN') > 0 then
                        p_return_type := trim (replace (substr (p_line_analysis, instr (p_line_analysis, ')RETURN ') + length (')RETURN ')), ';', ' '));
                        exit;
                     elsif instr (p_line_analysis, ' RETURN ') > 0 then
                        p_return_type := trim (replace (substr (p_line_analysis, instr (p_line_analysis, ' RETURN ') + length (' RETURN ')), ';', ' '));
                        exit;
                     elsif p_line_analysis = 'RETURN' then
                        p_return_type := trim (replace (p_program_unit_header, ';', ' '));
                        exit;
                     elsif trim (substr (p_program_unit_header, 1, instr (p_program_unit_header, 'RETURN') + length ('RETURN'))) = 'RETURN' then
                        p_return_type := trim (translate (substr (p_program_unit_header, instr (p_program_unit_header, 'RETURN') + length ('RETURN')), ';', ' '));
                        exit;
                     elsif trim (substr (trim (substr (p_program_unit_header, instr (p_program_unit_header, ')') + length (')'))),
                                               1,
                                               instr (trim (substr (p_program_unit_header, instr (p_program_unit_header, ')') + length (')'))), ' ') - 1)) = 'RETURN' then
                        p_return_type := trim (replace (substr (trim (substr (p_program_unit_header, instr (p_program_unit_header, ')') + 1)),
                                                                instr (trim (substr (p_program_unit_header, instr (p_program_unit_header, ')') + 1)), ' ')), ';', ' '));
                        exit;
                     end if;
                  end if;

                  exit when p_instr_chr_10 = 0; -- EXITS LOOP WHEN NO NEW LINES ARE FOUND (NO MORE PL/SQL CONTENTS)
               end loop;
            else
               p_return_type := NULL;
            end if;
         end if;
      end if;

      return p_return_type;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_function_type_return_v;

-- fu_ret_prg_unit_orig_param_l_b
   FUNCTION fu_ret_prg_unit_orig_param_l_b (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                            p_clob_plsql_contents                M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE default empty_clob(),
                                            p_original_parameter_list     IN OUT varchar2,
                                            p_msg_retorno                 IN OUT varchar2)
                                            RETURN boolean IS
      p_program_unit_header clob           := empty_clob();
      p_prc_name            varchar2(1000) := p_pck_name || 'fu_ret_prg_unit_orig_param_l_b (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';

   BEGIN
      if (p_id_form is not NULL and p_txt_generated_function_name is not NULL) or (p_clob_plsql_contents != empty_clob()) then
         if    p_id_form is not NULL and p_txt_generated_function_name is not NULL then
            p_program_unit_header := PKG_IMPORT_FORM.fu_ret_program_unit_header_p_v (p_id_form, p_txt_generated_function_name);
         elsif p_clob_plsql_contents != empty_clob() then
            p_program_unit_header := PKG_IMPORT_FORM.fu_retrieve_prog_unit_header_c (p_clob_plsql_contents);
         end if;

         if p_program_unit_header is not NULL and p_program_unit_header != empty_clob() and instr (p_program_unit_header, '(') > 0 then -- HAS PARAMETERS
            p_original_parameter_list := trim (translate (p_program_unit_header, chr(9) || chr(10), '  '));
            p_original_parameter_list := trim (substr (p_original_parameter_list, 1, instr (p_original_parameter_list, ')') - 1)); -- REMOVES RETURN (ANY)
            p_original_parameter_list := trim (substr (p_original_parameter_list,    instr (p_original_parameter_list, ' ')));     -- REMOVES PROCEDURE, FUNCTION
            p_original_parameter_list := trim (substr (p_original_parameter_list,    instr (p_original_parameter_list, '(') + 1)); -- REMOVES PROGRAM UNIT NAME

            loop
               p_original_parameter_list := trim (replace (p_original_parameter_list, '  ', ' '));
               exit when instr (p_original_parameter_list, '  ') = 0 or trim (p_original_parameter_list) is NULL;
            end loop;

            p_original_parameter_list := trim (replace (p_original_parameter_list, ' ,', ','));

            p_original_parameter_list := regexp_replace (p_original_parameter_list, ' date',   ' date',       1, 0, 'i');
            p_original_parameter_list := regexp_replace (p_original_parameter_list, ' in ',      ' IN ',      1, 0, 'i');
            p_original_parameter_list := regexp_replace (p_original_parameter_list, ' number',   ' number',   1, 0, 'i');
            p_original_parameter_list := regexp_replace (p_original_parameter_list, ' out ',     ' OUT ',     1, 0, 'i');
            p_original_parameter_list := regexp_replace (p_original_parameter_list, '%type',     '%TYPE',     1, 0, 'i');
            p_original_parameter_list := regexp_replace (p_original_parameter_list, ' varchar2', ' varchar2', 1, 0, 'i');
         end if;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_prg_unit_orig_param_l_b;

-- fu_ret_prg_unit_orig_param_l_v
   FUNCTION fu_ret_prg_unit_orig_param_l_v (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                            p_clob_plsql_contents         M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE default empty_clob())
                                            RETURN varchar2 IS
      p_retorno                 boolean        := NULL;
      p_prc_name                varchar2(1000) := p_pck_name || 'fu_ret_prg_unit_orig_param_l_b (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';
      p_msg_retorno             varchar2(4000) := NULL;
      p_original_parameter_list varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_prg_unit_orig_param_l_b (p_id_form, p_txt_generated_function_name, p_clob_plsql_contents, p_original_parameter_list, p_msg_retorno);

      if p_retorno = TRUE then
         return p_original_parameter_list;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_prg_unit_orig_param_l_v;

-- fu_ret_prg_unit_hdr_all_parm_c
   FUNCTION fu_ret_prg_unit_hdr_all_parm_c (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                            RETURN clob IS
      p_m_load_form_plsql_contents m_load_form_plsql_contents%ROWTYPE := NULL;
      p_program_unit_params clob           := empty_clob();
      p_prc_name            varchar2(1000) := p_pck_name || 'fu_ret_prg_unit_hdr_all_parm_c (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';

   BEGIN
      if p_id_form is not NULL and p_txt_generated_function_name is not NULL then
         BEGIN
            select mlfpc.*
              into p_m_load_form_plsql_contents
              from m_load_form_plsql_contents mlfpc
             where mlfpc.id_form = p_id_form
               and ((mlfpc.txt_generated_function_name is     NULL and mlfpc.txt_plsql_object_name       = trim (upper (p_txt_generated_function_name)))
                 or (mlfpc.txt_generated_function_name is not NULL and mlfpc.txt_generated_function_name = trim (upper (p_txt_generated_function_name))));

         EXCEPTION
            when no_data_found then
               return NULL;
            when others then
               return 'Erro SELECT MLFPC 5 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         END;

         if p_m_load_form_plsql_contents.txt_plsql_program_unit_type in ('FUNCTION', 'PROCEDURE') then
            p_program_unit_params := trim (PKG_IMPORT_FORM.fu_ret_plsql_contents_params_c (p_m_load_form_plsql_contents.id_form, p_m_load_form_plsql_contents.txt_plsql_object_name));

            if p_program_unit_params is not NULL and substr (p_program_unit_params, length (p_program_unit_params)) != chr(10) then
               p_program_unit_params := trim (p_program_unit_params) || chr(10) || PKG_IMPORT_FORM.p_indent;
            end if;
         end if;
      end if;

      return p_program_unit_params;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_prg_unit_hdr_all_parm_c;

-- fu_chg_item_to_block_item_b
   FUNCTION fu_chg_item_to_block_item_b (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                         p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                         p_analyze_clob_with_comments  boolean default TRUE)
                                         RETURN clob IS
      cursor c_m_list_blocks_items (p_id_form M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE) is
         select mlfbi.txt_block_name,
                mlfbi.txt_item_name
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form          = p_id_form
            and mlfbi.txt_data_origin  = 'BLOCKS AND ITEMS'
            and mlfbi.txt_item_name   is not NULL;

      r_m_list_blocks_items c_m_list_blocks_items%ROWTYPE := NULL;
      p_clob                        M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE         := empty_clob();
      p_clob_plsql_contents         M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE         := empty_clob();
      p_clob_plsql_contents_no_comm M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents_no_comm%TYPE := empty_clob();
      i              integer        := NULL;
      p_pattern_char varchar2(1)    := NULL;
      p_prc_name     varchar2(1000) := p_pck_name || 'fu_chg_item_to_block_item_b (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';

   BEGIN
      if p_id_form is not NULL and p_txt_generated_function_name is not NULL then
         BEGIN
            select mlfpc.clob_plsql_contents,
                   mlfpc.clob_plsql_contents_no_comm
              into p_clob_plsql_contents,
                   p_clob_plsql_contents_no_comm
              from m_load_form_plsql_contents mlfpc
             where mlfpc.id_form = p_id_form
               and ((mlfpc.txt_plsql_source  = 'PROGRAM UNIT' and mlfpc.txt_plsql_object_name       = p_txt_generated_function_name)
                or  (mlfpc.txt_plsql_source != 'PROGRAM UNIT' and mlfpc.txt_generated_function_name = p_txt_generated_function_name));

            if p_analyze_clob_with_comments = TRUE then
               p_clob := p_clob_plsql_contents;
            else
               p_clob := p_clob_plsql_contents_no_comm;
            end if;

         EXCEPTION
            when others then
               return 'Erro SELECT MLFPC 4 CLOB em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         END;

         p_clob := PKG_IMPORT_FORM.fu_chg_item_to_block_item_c (p_id_form, p_clob);
      end if;

      return p_clob;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_chg_item_to_block_item_b;

-- fu_chg_item_to_block_item_c
   FUNCTION fu_chg_item_to_block_item_c (p_id_form             M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                         p_clob_plsql_contents M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE)
                                         RETURN M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE IS
      cursor c_m_list_blocks_items (p_id_form M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE) is
         select mlfbi.*
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form          = p_id_form
            and mlfbi.txt_data_origin  = 'BLOCKS AND ITEMS'
            and mlfbi.txt_item_name   is not NULL;

      r_m_list_blocks_items c_m_list_blocks_items%ROWTYPE := NULL;
      p_clob_plsql_contents_e M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE := empty_clob();
      i              integer        := NULL;
      p_pattern_char varchar2(1)    := NULL;
      p_prc_name     varchar2(1000) := p_pck_name || 'fu_chg_item_to_block_item_c (' || p_id_form || '): ';

   BEGIN
      if p_clob_plsql_contents != empty_clob() then
         p_clob_plsql_contents_e := p_clob_plsql_contents;

         for i in 1..length (PKG_IMPORT_FORM.p_pattern) loop
            p_pattern_char := substr (PKG_IMPORT_FORM.p_pattern, i, 1);

            for r_m_list_blocks_items in c_m_list_blocks_items (p_id_form) loop
               if instr (upper (p_clob_plsql_contents_e), ':' || r_m_list_blocks_items.txt_item_name || p_pattern_char) > 0 then
                  p_clob_plsql_contents_e := regexp_replace (p_clob_plsql_contents_e,
                                                             ':' || r_m_list_blocks_items.txt_item_name || '[' || p_pattern_char || ']',
                                                             r_m_list_blocks_items.txt_block_item_name || p_pattern_char,
                                                             1,
                                                             0,
                                                             'i');
               end if;
            end loop;
         end loop;
      end if;

      return p_clob_plsql_contents_e;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_chg_item_to_block_item_c;

-- fu_ret_rec_grp_function_parm_v
   FUNCTION fu_ret_rec_grp_function_parm_v (p_id_form               M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE,
                                            p_txt_record_group_name M_LOAD_FORM_RECORD_GROUPS.txt_record_group_name%TYPE,
                                            p_txt_origin            varchar2)
                                            RETURN varchar2 IS
      cursor c_record_group_cols (p_id_form               M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE,
                                  p_txt_record_group_name M_LOAD_FORM_RECORD_GROUPS.txt_record_group_name%TYPE,
                                  p_txt_origin            varchar2) is
         select mlfrg.txt_record_group_col_name
           from m_load_form_record_groups mlfrg
          where mlfrg.id_form               = p_id_form
            and mlfrg.txt_record_group_name = p_txt_record_group_name
            and p_txt_origin                = 'RECGRP'
          union
         select mlfbi.txt_item_name
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form                        =  p_id_form
            and mlfbi.txt_block_name                 =  p_txt_record_group_name
            and mlfbi.txt_item_name                  is not NULL
            and mlfbi.txt_disposable_data_block      =  'N'
            and mlfbi.txt_block_query_data_orig_name is NULL
            and p_txt_origin                         =  'SQLBLK'
          order by 1;

      cursor c_m_load_form_glob_syst_parm (p_id_form M_LOAD_FORM_GLOB_SYST_PARM.id_form%TYPE) is
         select mlfgsp.*
           from m_load_form_glob_syst_parm mlfgsp
          where mlfgsp.id_form = p_id_form;

      cursor c_m_load_form_blocks_items (p_id_form M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE) is
         select mlfbi.*
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form         =  p_id_form
            and mlfbi.txt_data_origin =  'BLOCKS AND ITEMS'
            and mlfbi.txt_block_name  is not NULL
            and mlfbi.txt_item_name   is not NULL;

      r_m_load_form_blocks_items   c_m_load_form_blocks_items%ROWTYPE   := NULL;
      r_m_load_form_glob_syst_parm c_m_load_form_glob_syst_parm%ROWTYPE := NULL;
      r_record_group_cols          c_record_group_cols%ROWTYPE          := NULL;
      p_clob_sql_query_edit        M_LOAD_FORM_RECORD_GROUPS.clob_sql_query%TYPE         := empty_clob();
      p_clob_sql_query_no_comm     M_LOAD_FORM_RECORD_GROUPS.clob_sql_query_no_comm%TYPE := empty_clob();
      p_count_record_group_cols    integer        := NULL;
      p_instr_chr_10               integer        := NULL;
      p_pattern_char               varchar2(1)    := NULL;
      p_function_parameter_name    varchar2(100)  := NULL;
      p_function_sysrefcursor      varchar2(100)  := PKG_IMPORT_FORM.fu_ret_function_name_sys_ref_v (p_txt_record_group_name);
      p_prc_name                   varchar2(1000) := p_pck_name || 'fu_ret_rec_grp_function_parm_v (' || p_id_form || ', ' || p_txt_record_group_name || '): ';
      p_line_analysis              varchar2(4000) := NULL;
      p_parameter_list             varchar2(4000) := NULL;
      p_rec_grp_function_parm      varchar2(4000) := NULL;

   BEGIN
      p_count_record_group_cols := 0;

-- ADD COLUMNS FROM RECORD GROUPS - TXT_RECORD_GROUP_COL_NAME
      for r_record_group_cols in c_record_group_cols (p_id_form, p_txt_record_group_name, p_txt_origin) loop
         p_count_record_group_cols := p_count_record_group_cols + 1;
         p_function_parameter_name := PKG_IMPORT_FORM.fu_ret_parameter_name_v (r_record_group_cols.txt_record_group_col_name);

         if p_count_record_group_cols = 1 then
            p_rec_grp_function_parm := p_rec_grp_function_parm || ' || ' || p_function_parameter_name || chr(10);
         else
            p_rec_grp_function_parm := p_rec_grp_function_parm || lpad (' || '', '' || ',
                                                                        length (p_indent
                                                                                || p_indent
                                                                                || p_prc_name_v
                                                                                || ' varchar2(4000) := '
                                                                                || p_pck_name_v
                                                                                || ' || '''
                                                                                || p_function_sysrefcursor
                                                                                || ' ('''
                                                                                || '    '),
                                                                        ' ')
                                                               || p_function_parameter_name || chr(10);
         end if;
      end loop;

      if    p_txt_origin = 'RECGRP' then
         p_clob_sql_query_no_comm := PKG_IMPORT_FORM.fu_ret_clob_sql_query_no_com_c (p_id_form, p_txt_record_group_name);
      elsif p_txt_origin = 'SQLBLK' then
         p_clob_sql_query_no_comm := PKG_IMPORT_FORM.fu_ret_clob_sql_dblck_no_com_c (p_id_form, p_txt_record_group_name);
      end if;

      if p_clob_sql_query_no_comm != empty_clob() then
         p_clob_sql_query_edit := p_clob_sql_query_no_comm;

         loop
            p_instr_chr_10           := instr (p_clob_sql_query_edit, chr(10));
            exit when p_instr_chr_10 = 0; -- EXITS LOOP WHEN NO NEW LINES ARE FOUND (NO MORE PL/SQL CONTENTS)

            p_line_analysis       := rtrim (translate (substr (p_clob_sql_query_edit, 1, p_instr_chr_10), chr(9) || chr(10), '  '));
            p_clob_sql_query_edit := substr (p_clob_sql_query_edit, p_instr_chr_10 + 1);

            if trim (p_line_analysis) is not NULL then
               for i in 1..length (PKG_IMPORT_FORM.p_pattern) loop
                  p_pattern_char := substr (PKG_IMPORT_FORM.p_pattern, i, 1);

-- Detect :GLOBAL.item, :SYSTEM.item and :PARAMETER.item
                  for r_m_load_form_glob_syst_parm in c_m_load_form_glob_syst_parm (p_id_form) loop
                     if  instr (upper (p_line_analysis || p_pattern_char), r_m_load_form_glob_syst_parm.txt_variable_name || p_pattern_char) > 0
                      or instr (upper (p_line_analysis), r_m_load_form_glob_syst_parm.txt_variable_name || p_pattern_char) > 0 then
-- AVOID PARAMETER DUPLICATION
                        if  (upper (p_parameter_list) not like ';%' || upper (r_m_load_form_glob_syst_parm.txt_variable_parameter_name) || '%;' and p_parameter_list is not NULL)
                         or p_parameter_list is NULL then
                           p_parameter_list        := nvl (p_parameter_list, ';') || upper (r_m_load_form_glob_syst_parm.txt_variable_parameter_name) || ';';
                           p_rec_grp_function_parm := p_rec_grp_function_parm || lpad (' || '', '' || ',
                                                                                       length (p_indent
                                                                                               || p_indent
                                                                                               || p_prc_name_v
                                                                                               || ' varchar2(4000) := '
                                                                                               || p_pck_name_v
                                                                                               || ' || '''
                                                                                               || p_function_sysrefcursor
                                                                                               || ' ('''
                                                                                               || '    '),
                                                                                       ' ')
                                                                              || r_m_load_form_glob_syst_parm.txt_variable_parameter_name || chr(10);
                        end if;
                     end if;
                  end loop;

-- Detect :BLOCK.item
                  for r_m_load_form_blocks_items in c_m_load_form_blocks_items (p_id_form) loop
                     if  instr (upper (p_line_analysis || p_pattern_char), r_m_load_form_blocks_items.txt_block_item_name || p_pattern_char) > 0
                      or instr (upper (p_line_analysis), r_m_load_form_blocks_items.txt_block_item_name || p_pattern_char) > 0 then

-- AVOID PARAMETER DUPLICATION
                        if  (upper (p_parameter_list) not like ';%' || upper (r_m_load_form_blocks_items.txt_variable_parameter_name) || '%;' and p_parameter_list is not NULL)
                         or p_parameter_list is NULL then
                           p_parameter_list        := nvl (p_parameter_list, ';') || upper (r_m_load_form_blocks_items.txt_variable_parameter_name) || ';';
                           p_rec_grp_function_parm := p_rec_grp_function_parm || lpad (' || '', '' || ',
                                                                                       length (p_indent
                                                                                               || p_indent
                                                                                               || p_prc_name_v
                                                                                               || ' varchar2(4000) := '
                                                                                               || p_pck_name_v
                                                                                               || ' || '''
                                                                                               || p_function_sysrefcursor
                                                                                               || ' ('''
                                                                                               || '    '),
                                                                                       ' ')
                                                                              || r_m_load_form_blocks_items.txt_variable_parameter_name || chr(10);
                        end if;
                     end if;
                  end loop;
               end loop;
            end if;
         end loop;
      end if;

      return p_rec_grp_function_parm;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_rec_grp_function_parm_v;

-- fu_collect_block_items_b
   FUNCTION fu_collect_block_items_b (p_id_form             M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                      p_clob_plsql_contents M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE,
                                      p_parameter_list      IN OUT clob,
                                      p_msg_retorno         IN OUT varchar2)
                                      RETURN boolean IS
      cursor c_m_load_form_blocks_items (p_id_form M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE) is
         select mlfbi.*
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form         =  p_id_form
            and mlfbi.txt_data_origin =  'BLOCKS AND ITEMS'
            and mlfbi.txt_block_name  is not NULL
            and mlfbi.txt_item_name   is not NULL;

      r_m_load_form_blocks_items c_m_load_form_blocks_items%ROWTYPE := NULL;
      i                          integer        := NULL;
      p_pattern_char             varchar2(1)    := NULL;
      p_prc_name                 varchar2(1000) := p_pck_name || 'fu_collect_block_items_b (' || p_id_form || '): ';

   BEGIN
      if p_id_form is not NULL and p_clob_plsql_contents != empty_clob() then
         p_parameter_list := p_parameter_list || ';';

         for i in 1..length (PKG_IMPORT_FORM.p_pattern) loop
            p_pattern_char := substr (PKG_IMPORT_FORM.p_pattern, i, 1);

-- Collect all references to :BLOCK.item and list them on p_parameter_list
            for r_m_load_form_blocks_items in c_m_load_form_blocks_items (p_id_form) loop -- Detect :BLOCK.item
               if instr (upper (p_clob_plsql_contents), r_m_load_form_blocks_items.txt_block_item_name || p_pattern_char) > 0 then
                  if  (upper (p_parameter_list) not like ';%' || upper (r_m_load_form_blocks_items.txt_block_item_name) || '%;' and p_parameter_list != empty_clob())
                   or p_parameter_list = empty_clob() then -- AVOID PARAMETER DUPLICATION
                     p_parameter_list := p_parameter_list || upper (r_m_load_form_blocks_items.txt_block_item_name) || ';';
                  end if;
               end if;
            end loop;
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_collect_block_items_b;

-- fu_collect_block_items_c
   FUNCTION fu_collect_block_items_c (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                      p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                      RETURN clob IS
      p_clob_plsql_contents_no_comm M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents_no_comm%TYPE := empty_clob();
      p_retorno        boolean        := NULL;
      p_parameter_list clob           := empty_clob();
      p_prc_name       varchar2(1000) := p_pck_name || 'fu_collect_block_items_c (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';
      p_msg_retorno    varchar2(4000) := NULL;

   BEGIN
      if p_id_form is not NULL and p_txt_generated_function_name is not NULL then
         BEGIN
            select mlfpc.clob_plsql_contents_no_comm
              into p_clob_plsql_contents_no_comm
              from m_load_form_plsql_contents mlfpc
             where mlfpc.id_form                     = p_id_form
               and mlfpc.txt_generated_function_name = p_txt_generated_function_name;

         EXCEPTION
            when no_data_found then
               p_clob_plsql_contents_no_comm := empty_clob();
            when others then
               return 'Erro SELECT MLFPC 8 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         END;

         if p_clob_plsql_contents_no_comm != empty_clob() then
            p_retorno := PKG_IMPORT_FORM.fu_collect_block_items_b (p_id_form, p_clob_plsql_contents_no_comm, p_parameter_list, p_msg_retorno);

            if p_retorno = TRUE then
               return p_parameter_list;
            else
               return p_msg_retorno;
            end if;
         end if;
      end if;

      return p_parameter_list;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_collect_block_items_c;

-- fu_collect_glob_syst_param_b
   FUNCTION fu_collect_glob_syst_param_b (p_id_form             M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                          p_clob_plsql_contents M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE,
                                          p_parameter_list      IN OUT clob,
                                          p_msg_retorno         IN OUT varchar2)
                                          RETURN boolean IS
      cursor c_m_load_form_glob_syst_parm (p_id_form M_LOAD_FORM_GLOB_SYST_PARM.id_form%TYPE) is
         select mlfgsp.*
           from m_load_form_glob_syst_parm mlfgsp
          where mlfgsp.id_form = p_id_form
          order by mlfgsp.id_form,
                   mlfgsp.txt_variable_type,
                   mlfgsp.txt_variable_name;

      r_m_load_form_glob_syst_parm c_m_load_form_glob_syst_parm%ROWTYPE := NULL;
      i                            integer        := NULL;
      p_pattern_char               varchar2(1)    := NULL;
      p_prc_name                   varchar2(1000) := p_pck_name || 'fu_collect_glob_syst_param_b (' || p_id_form || '): ';

   BEGIN
      if p_id_form is not NULL and p_clob_plsql_contents != empty_clob() then
         p_parameter_list := p_parameter_list || ';';

         for i in 1..length (PKG_IMPORT_FORM.p_pattern) loop

-- Collect all references to :GLOBAL.item, :SYSTEM.item and :PARAMETER.item and list them on p_parameter_list
            for r_m_load_form_glob_syst_parm in c_m_load_form_glob_syst_parm (p_id_form) loop -- Detect :GLOBAL.item, :SYSTEM.item and :PARAMETER.item
               if instr (upper (p_clob_plsql_contents), r_m_load_form_glob_syst_parm.txt_variable_name || p_pattern_char) > 0 then
                  if  (upper (p_parameter_list) not like ';%' || upper (r_m_load_form_glob_syst_parm.txt_variable_name) || '%;' and p_parameter_list != empty_clob())
                   or p_parameter_list = empty_clob() then -- AVOID PARAMETER DUPLICATION
                     p_parameter_list := p_parameter_list || upper (r_m_load_form_glob_syst_parm.txt_variable_name) || ';';
                  end if;
               end if;
            end loop;
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_collect_glob_syst_param_b;

-- fu_collect_glob_syst_param_c
   FUNCTION fu_collect_glob_syst_param_c (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                          p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                          RETURN clob IS
      p_clob_plsql_contents_no_comm M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents_no_comm%TYPE := empty_clob();
      p_retorno        boolean        := NULL;
      p_parameter_list clob           := empty_clob();
      p_prc_name       varchar2(1000) := p_pck_name || 'fu_collect_glob_syst_param_c (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';
      p_msg_retorno    varchar2(4000) := NULL;

   BEGIN
      if p_id_form is not NULL and p_txt_generated_function_name is not NULL then
         BEGIN
            select mlfpc.clob_plsql_contents_no_comm
              into p_clob_plsql_contents_no_comm
              from m_load_form_plsql_contents mlfpc
             where mlfpc.id_form                     = p_id_form
               and mlfpc.txt_generated_function_name = p_txt_generated_function_name;

         EXCEPTION
            when no_data_found then
               p_clob_plsql_contents_no_comm := empty_clob();
            when others then
               return 'Erro SELECT MLFPC 9 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         END;

         if p_clob_plsql_contents_no_comm != empty_clob() then
            p_retorno := PKG_IMPORT_FORM.fu_collect_glob_syst_param_b (p_id_form, p_clob_plsql_contents_no_comm, p_parameter_list, p_msg_retorno);

            if p_retorno = TRUE then
               return p_parameter_list;
            else
               return p_msg_retorno;
            end if;
         end if;
      end if;

      return p_parameter_list;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_collect_glob_syst_param_c;

-- fu_ret_header_parameters_com_b
   FUNCTION fu_ret_header_parameters_com_b (p_clob_plsql_contents        M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE,
                                            p_parameter_list      IN OUT varchar2,
                                            p_msg_retorno         IN OUT varchar2)
                                            RETURN boolean IS
      p_clob_plsql_contents_e M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE := empty_clob();
      p_parameter_declaration varchar2(1000) := NULL;
      p_prc_name              varchar2(4000) := p_pck_name || 'fu_ret_header_parameters_com_b: ';

   BEGIN
      if p_clob_plsql_contents = empty_clob() or instr (p_clob_plsql_contents, '(') = 0 then
         p_parameter_list := NULL;
      else
         p_clob_plsql_contents_e := p_clob_plsql_contents;
         p_clob_plsql_contents_e := trim (substr (p_clob_plsql_contents_e,    instr (p_clob_plsql_contents_e, '(') + 1));
         p_clob_plsql_contents_e := trim (substr (p_clob_plsql_contents_e, 1, instr (p_clob_plsql_contents_e, ')') - 1));
         p_clob_plsql_contents_e := trim (translate (upper (p_clob_plsql_contents_e), chr(9) || chr(10), '  '));

         if instr (p_clob_plsql_contents_e, ',') = 0 then
            p_parameter_list := ';' || trim (substr (p_clob_plsql_contents_e, 1, instr (p_clob_plsql_contents_e, ' '))) || ';';
         else
            loop
               p_parameter_declaration := trim (substr (p_clob_plsql_contents_e, 1, instr (p_clob_plsql_contents_e, ',') - 1));
               p_parameter_declaration := trim (substr (p_parameter_declaration, 1, instr (p_parameter_declaration, ' ')));
               p_clob_plsql_contents_e := trim (substr (p_clob_plsql_contents_e,    instr (p_clob_plsql_contents_e, ',') + 1));
               p_parameter_list        := nvl (p_parameter_list, ';') || p_parameter_declaration || ';';

               exit when instr (p_clob_plsql_contents_e, ',') = 0;
            end loop;

            p_parameter_list := p_parameter_list || trim (substr (p_clob_plsql_contents_e, 1, instr (p_clob_plsql_contents_e, ' '))) || ';';
         end if;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro (p_parameter_list = "' || p_parameter_list || '") ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_header_parameters_com_b;

-- fu_collect_original_params_b
   FUNCTION fu_collect_original_params_b (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                          p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                          p_parameter_list              IN OUT varchar2,
                                          p_msg_retorno                 IN OUT varchar2)
                                          RETURN boolean IS
      p_clob_plsql_contents_no_comm M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents_no_comm%TYPE := empty_clob();
      p_retorno                     boolean        := NULL;
      p_program_unit_header         clob           := empty_clob();
      p_prc_name                    varchar2(4000) := p_pck_name || 'fu_collect_original_params_b (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';

   BEGIN
      if p_id_form is not NULL and p_txt_generated_function_name is not NULL then
         BEGIN
            select mlfpc.clob_plsql_contents_no_comm
              into p_clob_plsql_contents_no_comm
              from m_load_form_plsql_contents mlfpc
             where mlfpc.id_form = p_id_form
               and ((mlfpc.txt_generated_function_name is     NULL and mlfpc.txt_plsql_object_name       = trim (upper (p_txt_generated_function_name)))
                 or (mlfpc.txt_generated_function_name is not NULL and mlfpc.txt_generated_function_name = trim (upper (p_txt_generated_function_name))));

         EXCEPTION
            when no_data_found then
               p_clob_plsql_contents_no_comm := empty_clob();
            when others then
               p_msg_retorno := 'Erro SELECT MLFPC 10 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

         if p_clob_plsql_contents_no_comm != empty_clob() then
            p_program_unit_header := PKG_IMPORT_FORM.fu_retrieve_prog_unit_header_c (p_clob_plsql_contents_no_comm);

            if p_program_unit_header != empty_clob() and instr (p_program_unit_header, '(') > 0 then
               p_retorno := PKG_IMPORT_FORM.fu_ret_header_parameters_com_b (p_program_unit_header, p_parameter_list, p_msg_retorno);

               if p_retorno != TRUE then
                  p_msg_retorno := 'Erro P_RETORNO em ' || p_prc_name || p_msg_retorno;
                  return FALSE;
               end if;
            end if;
         end if;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_collect_original_params_b;

-- fu_collect_original_params_v
   FUNCTION fu_collect_original_params_v (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                          p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                          RETURN varchar2 IS
      p_retorno        boolean        := NULL;
      p_prc_name       varchar2(4000) := p_pck_name || 'fu_collect_original_params_v (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';
      p_parameter_list varchar2(4000) := NULL;
      p_msg_retorno    varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_collect_original_params_b (p_id_form, p_txt_generated_function_name, p_parameter_list, p_msg_retorno);

      if p_retorno = TRUE then
         return p_parameter_list;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_collect_original_params_v;

-- fu_ret_plsql_contents_params_b
   FUNCTION fu_ret_plsql_contents_params_b (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                            p_plsql_object_parameters     IN OUT clob,
                                            p_msg_retorno                 IN OUT varchar2)
                                            RETURN boolean IS
      cursor c_m_load_form_blocks_items (p_id_form         M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE,
                                         p_block_item_name varchar2) is
         select mlfbi.*
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form                     =  p_id_form
            and mlfbi.txt_block_item_name         =  p_block_item_name
            and mlfbi.txt_item_name               is not NULL
            and mlfbi.txt_variable_parameter_name is not NULL;

      cursor c_m_load_form_glob_syst_parm (p_id_form           M_LOAD_FORM_GLOB_SYST_PARM.id_form%TYPE,
                                           p_txt_variable_name M_LOAD_FORM_GLOB_SYST_PARM.txt_variable_name%TYPE) is
         select mlfgsp.*
           from m_load_form_glob_syst_parm mlfgsp
          where mlfgsp.id_form           = p_id_form
            and mlfgsp.txt_variable_name = p_txt_variable_name;

      cursor c_m_load_form_plsql_params is
         select mlfpc.id_form,
                nvl (mlfpc.txt_plsql_program_unit_type, 'FUNCTION') as txt_plsql_program_unit_type,
                nvl (mlfpc.txt_generated_function_name, mlfpc.txt_plsql_object_name) as txt_generated_function_name,
                mlfpp.txt_block_item_gsp_variable,
                mlfpp.txt_variable_type
           from m_load_form_plsql_contents mlfpc,
                m_load_form_plsql_params   mlfpp
          where mlfpc.id_form = p_id_form
            and mlfpc.id_form = mlfpp.id_form
            and mlfpc.id      = mlfpp.id_plsql_contents
            and ((mlfpc.txt_generated_function_name is     NULL and mlfpc.txt_plsql_object_name       = trim (upper (p_txt_generated_function_name)))
              or (mlfpc.txt_generated_function_name is not NULL and mlfpc.txt_generated_function_name = trim (upper (p_txt_generated_function_name))));

         cursor c_m_load_form_plsql_params_dec (p_id_form           M_LOAD_FORM_GLOB_SYST_PARM.id_form%TYPE,
                                                p_txt_variable_name M_LOAD_FORM_GLOB_SYST_PARM.txt_variable_name%TYPE) is
            select mlfpp.*
              from m_load_form_plsql_contents mlfpc,
                   m_load_form_plsql_params   mlfpp
             where mlfpc.id_form                     = p_id_form
               and ((mlfpc.txt_generated_function_name is     NULL and mlfpc.txt_plsql_object_name       = trim (upper (p_txt_generated_function_name)))
                 or (mlfpc.txt_generated_function_name is not NULL and mlfpc.txt_generated_function_name = trim (upper (p_txt_generated_function_name))))
               and mlfpc.id_form                     = mlfpp.id_form
               and mlfpc.id                          = mlfpp.id_plsql_contents
               and mlfpp.txt_block_item_gsp_variable = p_txt_variable_name
               and mlfpp.txt_variable_type           = 'DECLARATION'
               and instr (mlfpp.txt_block_item_gsp_variable, ':') = 0;

      r_m_load_form_plsql_params_dec c_m_load_form_plsql_params_dec%ROWTYPE := NULL;
      r_m_load_form_blocks_items     c_m_load_form_blocks_items%ROWTYPE     := NULL;
      r_m_load_form_glob_syst_parm   c_m_load_form_glob_syst_parm%ROWTYPE   := NULL;
      r_m_load_form_plsql_params     c_m_load_form_plsql_params%ROWTYPE     := NULL;
      p_m_load_form_blocks_items     m_load_form_blocks_items%ROWTYPE       := NULL;
      p_m_load_form_glob_syst_parm   m_load_form_glob_syst_parm%ROWTYPE     := NULL;
      p_txt_plsql_program_unit_type  M_LOAD_FORM_PLSQL_CONTENTS.txt_plsql_program_unit_type%TYPE := NULL;
      p_retorno                      boolean        := NULL;
      i                              integer        := NULL;
      p_length_param                 integer        := NULL;
      p_parameter_count              integer        := 0;
      p_pattern_char                 varchar2(1)    := NULL;
      p_parameter_list_item          varchar2(100)  := NULL;
      p_prc_name                     varchar2(1000) := p_pck_name || 'fu_ret_plsql_contents_params_b (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';
      p_parameter_list               varchar2(4000) := NULL;

   BEGIN
      p_plsql_object_parameters := empty_clob();

      if    p_id_form is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
         return FALSE;
      elsif p_txt_generated_function_name is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o nome da função deve ser informado.';
         return FALSE;
      else
         BEGIN
            select nvl (mlfpc.txt_plsql_program_unit_type, 'FUNCTION') as txt_plsql_program_unit_type
              into p_txt_plsql_program_unit_type
              from m_load_form_plsql_contents mlfpc
             where mlfpc.id_form = p_id_form
               and ((mlfpc.txt_generated_function_name is     NULL and mlfpc.txt_plsql_object_name       = trim (upper (p_txt_generated_function_name)))
                 or (mlfpc.txt_generated_function_name is not NULL and mlfpc.txt_generated_function_name = trim (upper (p_txt_generated_function_name))));

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro SELECT MLFPC 6 UNIT TYPE em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

         p_length_param := PKG_IMPORT_FORM.fu_ret_max_length_param_i (p_id_form, p_txt_generated_function_name);

         for r_m_load_form_plsql_params in c_m_load_form_plsql_params loop
            if    r_m_load_form_plsql_params.txt_variable_type in ('GLOBAL', 'PARAMETER', 'SYSTEM') then
               for r_m_load_form_glob_syst_parm in c_m_load_form_glob_syst_parm (r_m_load_form_plsql_params.id_form, r_m_load_form_plsql_params.txt_block_item_gsp_variable) loop
                  p_parameter_count := p_parameter_count + 1;

                  if p_parameter_count > 1 then
                     p_plsql_object_parameters := p_plsql_object_parameters || lpad (', ',
                                                                                     length (PKG_IMPORT_FORM.p_indent
                                                                                             || r_m_load_form_plsql_params.txt_plsql_program_unit_type
                                                                                             || ' '
                                                                                             || r_m_load_form_plsql_params.txt_generated_function_name
                                                                                             || ' ('),
                                                                               ' ');
                  end if;

                  p_plsql_object_parameters := p_plsql_object_parameters || rpad (r_m_load_form_glob_syst_parm.txt_variable_parameter_name, p_length_param, ' ')
                                                                         || ' IN OUT '
                                                                         || lower (r_m_load_form_glob_syst_parm.txt_variable_data_type); -- || ' default ';

--                if r_m_load_form_plsql_params.txt_variable_type = 'PARAMETER' then
--                   p_plsql_object_parameters := p_plsql_object_parameters || lower (replace (r_m_load_form_glob_syst_parm.txt_variable_name, ':PARAMETER.', ''));
--                else
--                   p_plsql_object_parameters := p_plsql_object_parameters || 'NULL';
--                end if;

                  p_plsql_object_parameters := p_plsql_object_parameters || ' -- ' || r_m_load_form_glob_syst_parm.txt_variable_name || chr(10);
               end loop;
            elsif r_m_load_form_plsql_params.txt_variable_type = 'DECLARATION' then
               for r_m_load_form_plsql_params_dec in c_m_load_form_plsql_params_dec (r_m_load_form_plsql_params.id_form, r_m_load_form_plsql_params.txt_block_item_gsp_variable) loop
                  p_parameter_count := p_parameter_count + 1;

                  if p_parameter_count > 1 then
                     p_plsql_object_parameters := p_plsql_object_parameters || lpad (', ',
                                                                                     length (PKG_IMPORT_FORM.p_indent
                                                                                             || r_m_load_form_plsql_params.txt_plsql_program_unit_type
                                                                                             || ' '
                                                                                             || r_m_load_form_plsql_params.txt_generated_function_name
                                                                                             || ' ('),
                                                                               ' ');
                  end if;

                  p_plsql_object_parameters := p_plsql_object_parameters || rpad (lower (r_m_load_form_plsql_params_dec.txt_block_item_gsp_variable), p_length_param, ' ')
                                                                         || ' '
                                                                         || r_m_load_form_plsql_params_dec.txt_variable_declaration || chr(10);
               end loop;
            else
               for r_m_load_form_blocks_items in c_m_load_form_blocks_items (r_m_load_form_plsql_params.id_form, r_m_load_form_plsql_params.txt_block_item_gsp_variable) loop
                  p_parameter_count := p_parameter_count + 1;

                  if p_parameter_count > 1 then
                     p_plsql_object_parameters := p_plsql_object_parameters || lpad (', ',
                                                                                     length (PKG_IMPORT_FORM.p_indent
                                                                                             || r_m_load_form_plsql_params.txt_plsql_program_unit_type
                                                                                             || ' '
                                                                                             || r_m_load_form_plsql_params.txt_generated_function_name
                                                                                             || ' ('),
                                                                               ' ');
                  end if;

                  p_plsql_object_parameters := p_plsql_object_parameters || rpad (r_m_load_form_blocks_items.txt_variable_parameter_name, p_length_param, ' ') || ' IN OUT ';

                  if   r_m_load_form_blocks_items.txt_block_database_data_block  =  'YES'
                   and r_m_load_form_blocks_items.txt_block_query_data_orig_type =  'TABLE'
                   and r_m_load_form_blocks_items.txt_block_query_data_orig_name is not NULL
                   and r_m_load_form_blocks_items.txt_item_field_database        =  'YES'
                   and r_m_load_form_blocks_items.txt_item_field_db_col_name     is not NULL then
                     p_plsql_object_parameters := p_plsql_object_parameters || r_m_load_form_blocks_items.txt_block_query_data_orig_name || '.'
                                                                            || lower (r_m_load_form_blocks_items.txt_item_field_db_col_name) || '%TYPE';
                  else
                     p_plsql_object_parameters := p_plsql_object_parameters || lower (r_m_load_form_blocks_items.txt_item_field_datatype);
                  end if;

                  p_plsql_object_parameters := p_plsql_object_parameters -- || ' default NULL'
                                                                         || ' -- :' || r_m_load_form_blocks_items.txt_block_name ||
                                                                                '.' || r_m_load_form_blocks_items.txt_item_name
                                                                         || chr(10);
               end loop;
            end if;
         end loop;

         if p_parameter_count >= 1 then
            p_plsql_object_parameters := p_plsql_object_parameters || lpad (', ',
                                                                            length (PKG_IMPORT_FORM.p_indent
                                                                                    || p_txt_plsql_program_unit_type
                                                                                    || ' '
                                                                                    || p_txt_generated_function_name
                                                                                    || ' ('),
                                                                            ' ');
         end if;

-- Parâmetro padrão para todas as funções, pois retorna a mensagem vinda das rotinas PL/SQL
         p_plsql_object_parameters := p_plsql_object_parameters || rpad (p_msg_retorno_v, p_length_param, ' ') || ' IN OUT varchar2' || chr(10);
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_plsql_contents_params_b;

-- fu_ret_plsql_contents_params_c
   FUNCTION fu_ret_plsql_contents_params_c (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE default NULL)
                                            RETURN clob IS
      p_clob_plsql_contents_no_comm M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents_no_comm%TYPE := empty_clob();
      p_retorno                 boolean        := NULL;
      p_plsql_object_parameters clob           := empty_clob();
      p_prc_name                varchar2(1000) := p_pck_name || 'fu_ret_plsql_contents_params_c (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';
      p_msg_retorno             varchar2(4000) := NULL;

   BEGIN
      if    p_id_form is NULL then
         return 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
      elsif p_txt_generated_function_name is NULL then
         return 'Erro ' || p_prc_name || 'o nome gerado para a trigger PL/SQL ou o nome da program unit deve ser informado.';
      else
         p_retorno := PKG_IMPORT_FORM.fu_ret_plsql_contents_params_b (p_id_form,
                                                                      p_txt_generated_function_name,
                                                                      p_plsql_object_parameters,
                                                                      p_msg_retorno);

         if p_retorno = TRUE then
            if p_plsql_object_parameters = empty_clob() then
               return NULL;
            else
               return p_plsql_object_parameters;
            end if;
         else
            return p_msg_retorno;
         end if;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_plsql_contents_params_c;

-- fu_chg_plsql_blocks_to_parms_b
   FUNCTION fu_chg_plsql_blocks_to_parms_b (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                            p_clob_plsql_contents         IN OUT M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE,
                                            p_msg_retorno                 IN OUT varchar2)
                                            RETURN boolean IS
      cursor c_m_load_form_blocks_items (p_id_form M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE) is
         select mlfbi.*
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form         = p_id_form
            and mlfbi.txt_data_origin = 'BLOCKS AND ITEMS'
            and mlfbi.txt_block_name  is not NULL
            and mlfbi.txt_item_name   is not NULL;

      cursor c_m_load_form_glob_syst_parm (p_id_form M_LOAD_FORM_GLOB_SYST_PARM.id_form%TYPE) is
         select mlfgsp.*
           from m_load_form_glob_syst_parm mlfgsp
          where mlfgsp.id_form = nvl (p_id_form, mlfgsp.id_form)
          order by mlfgsp.id_form,
                   mlfgsp.txt_variable_type,
                   mlfgsp.txt_variable_name;

      r_m_load_form_glob_syst_parm c_m_load_form_glob_syst_parm%ROWTYPE := NULL;
      r_m_load_form_blocks_items   c_m_load_form_blocks_items%ROWTYPE   := NULL;
      i                            integer        := NULL;
      p_pattern_char               varchar2(1)    := NULL;
      p_prc_name                   varchar2(1000) := p_pck_name || 'fu_chg_plsql_blocks_to_parms_b (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';

   BEGIN
      if    p_id_form is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
         return FALSE;
      elsif p_txt_generated_function_name is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o nome da função deve ser informado.';
         return FALSE;
      elsif p_clob_plsql_contents = empty_clob() then
         p_msg_retorno := 'Erro ' || p_prc_name || 'CLOB vazio.';
         return FALSE;
      else
         for i in 1..length (PKG_IMPORT_FORM.p_pattern) loop
            p_pattern_char := substr (PKG_IMPORT_FORM.p_pattern, i, 1);

            for r_m_load_form_blocks_items in c_m_load_form_blocks_items (p_id_form) loop -- Detect :BLOCK.item
               if instr (upper (p_clob_plsql_contents), r_m_load_form_blocks_items.txt_block_item_name || p_pattern_char) > 0 then
                  p_clob_plsql_contents := regexp_replace (p_clob_plsql_contents,
                                                           replace (r_m_load_form_blocks_items.txt_block_item_name || '[' || p_pattern_char || ']', '$', '\$'),
                                                           r_m_load_form_blocks_items.txt_variable_parameter_name || p_pattern_char,
                                                           1,
                                                           0,
                                                           'i');
               end if;
            end loop;

            for r_m_load_form_glob_syst_parm in c_m_load_form_glob_syst_parm (p_id_form) loop -- Detect :GLOBAL.item, :SYSTEM.item and :PARAMETER.item
               if instr (upper (p_clob_plsql_contents), r_m_load_form_glob_syst_parm.txt_variable_name || p_pattern_char) > 0 then
                  p_clob_plsql_contents := regexp_replace (p_clob_plsql_contents,
                                                           replace (r_m_load_form_glob_syst_parm.txt_variable_name, '$', '\$') || '[' || p_pattern_char || ']',
                                                           r_m_load_form_glob_syst_parm.txt_variable_parameter_name || p_pattern_char,
                                                           1,
                                                           0,
                                                           'i');
               end if;
            end loop;
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_chg_plsql_blocks_to_parms_b;

-- fu_chg_plsql_blocks_to_parms_c
   FUNCTION fu_chg_plsql_blocks_to_parms_c (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                            p_analyze_clob_with_comments  boolean default TRUE)
                                            RETURN M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents_no_comm%TYPE IS
      p_clob_plsql_contents         M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE         := empty_clob();
      p_clob_plsql_contents_edit    M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE         := empty_clob();
      p_clob_plsql_contents_no_comm M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents_no_comm%TYPE := empty_clob();
      p_retorno     boolean        := NULL;
      p_prc_name    varchar2(1000) := p_pck_name || 'fu_chg_plsql_blocks_to_parms_c (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';
      p_msg_retorno varchar2(4000) := NULL;

   BEGIN
      BEGIN
         select mlfpc.clob_plsql_contents,
                mlfpc.clob_plsql_contents_no_comm
           into p_clob_plsql_contents,
                p_clob_plsql_contents_no_comm
           from m_load_form_plsql_contents mlfpc
          where mlfpc.id_form = p_id_form
            and ((mlfpc.txt_generated_function_name is     NULL and mlfpc.txt_plsql_object_name       = trim (upper (p_txt_generated_function_name)))
              or (mlfpc.txt_generated_function_name is not NULL and mlfpc.txt_generated_function_name = trim (upper (p_txt_generated_function_name))));

      EXCEPTION
         when no_data_found then
            p_clob_plsql_contents         := empty_clob();
            p_clob_plsql_contents_no_comm := empty_clob();
         when others then
            return 'Erro SELECT MLFPC 2 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
      END;

      if p_analyze_clob_with_comments = TRUE then
         p_clob_plsql_contents_edit := p_clob_plsql_contents;
      else
         p_clob_plsql_contents_edit := p_clob_plsql_contents_no_comm;
      end if;

      if p_clob_plsql_contents_edit = empty_clob() then
         return NULL;
      else
         p_clob_plsql_contents_edit := PKG_IMPORT_FORM.fu_chg_item_to_block_item_b (p_id_form,                     -- p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE
                                                                                    p_txt_generated_function_name, -- p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE
                                                                                    p_analyze_clob_with_comments); -- p_analyze_clob_with_comments  boolean default TRUE

         p_retorno := PKG_IMPORT_FORM.fu_chg_plsql_blocks_to_parms_b (p_id_form, p_txt_generated_function_name, p_clob_plsql_contents_edit, p_msg_retorno);

         if p_retorno = TRUE then
            return p_clob_plsql_contents_edit;
         else
            return p_msg_retorno;
         end if;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_chg_plsql_blocks_to_parms_c;

-- fu_ret_line_disposable_plsql_b
   FUNCTION fu_ret_line_disposable_plsql_b (p_line_analysis        varchar2,
                                            p_msg_retorno   IN OUT varchar2)
                                            RETURN boolean IS
      p_prc_name varchar2(4000) := p_pck_name || 'fu_ret_line_disposable_plsql_b (' || p_line_analysis || '): ';

      cursor c_m_disposable_contents is
         select mdc.*
           from m_disposable_contents mdc
          where mdc.id_disposable_text_type = PKG_M_LOAD_FORM_DISPOS_TXT_TYP.fu_ret_disposable_text_type_i ('ORACLE FORMS PL/SQL ROUTINE');

      r_m_disposable_contents c_m_disposable_contents%ROWTYPE := NULL;

   BEGIN
      for r_m_disposable_contents in c_m_disposable_contents loop
         if r_m_disposable_contents.txt_disposable_text_is_package = 'N' then
            if r_m_disposable_contents.txt_disposable_text_has_params in ('B', 'N') then
               if p_line_analysis = r_m_disposable_contents.txt_disposable_text then
                  return TRUE; -- LINE HAS ONLY DISPOSABLE ORACLE FORMS PL/SQL ROUTINES
               elsif trim (substr (p_line_analysis, 1, instr (p_line_analysis, ' '))) = 'END'
                 and trim (substr (p_line_analysis, 1, instr (p_line_analysis, ' '))) = r_m_disposable_contents.txt_disposable_text then
                  return TRUE; -- LINE HAS ONLY DISPOSABLE ORACLE FORMS PL/SQL ROUTINES
               end if;
            end if;

            if r_m_disposable_contents.txt_disposable_text_has_params in ('B', 'Y') then
               if trim (substr (p_line_analysis, 1, instr (p_line_analysis, '(') - 1)) = r_m_disposable_contents.txt_disposable_text then
                  return TRUE; -- LINE HAS ONLY DISPOSABLE ORACLE FORMS PL/SQL ROUTINES
               end if;
            end if;
         end if;

         if r_m_disposable_contents.txt_disposable_text_is_package = 'Y' then
            if trim (substr (p_line_analysis, 1, instr (p_line_analysis, '.') - 1)) = r_m_disposable_contents.txt_disposable_text then
               return TRUE; -- LINE HAS ONLY DISPOSABLE ORACLE FORMS PL/SQL ROUTINES
            end if;
         end if;
      end loop;

-- LINE IS NOT DISPOSABLE UNDER PL/SQL SETTINGS; NO ERROR
      p_msg_retorno := NULL;
      return FALSE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_line_disposable_plsql_b;

-- fu_ret_line_disposable_custm_b
   FUNCTION fu_ret_line_disposable_custm_b (p_line_analysis        varchar2,
                                            p_msg_retorno   IN OUT varchar2)
                                            RETURN boolean IS
      p_prc_name varchar2(4000) := p_pck_name || 'fu_ret_line_disposable_custm_b (' || p_line_analysis || '): ';

      cursor c_m_load_form_custom_disposa is
         select mlfcd.*
           from m_load_form_custom_disposa mlfcd
          where mlfcd.id_disposable_text_type = PKG_M_LOAD_FORM_DISPOS_TXT_TYP.fu_ret_disposable_text_type_i ('CUSTOM')
          order by mlfcd.id;

      r_m_load_form_custom_disposa c_m_load_form_custom_disposa%ROWTYPE := NULL;

   BEGIN
      for r_m_load_form_custom_disposa in c_m_load_form_custom_disposa loop
         if    r_m_load_form_custom_disposa.txt_disposable_text_has_params = 'N' and r_m_load_form_custom_disposa.txt_disposable_text_is_package = 'N' then
            if p_line_analysis = r_m_load_form_custom_disposa.txt_custom_disposable_text then
               return TRUE; -- LINE IS DISPOSABLE UNDER CUSTOM SETTINGS
            end if;
         elsif r_m_load_form_custom_disposa.txt_disposable_text_has_params = 'Y' and r_m_load_form_custom_disposa.txt_disposable_text_is_package = 'N' then
            if trim (substr (p_line_analysis, 1, instr (p_line_analysis, '(') - 1)) = r_m_load_form_custom_disposa.txt_custom_disposable_text then
               return TRUE; -- LINE IS DISPOSABLE UNDER CUSTOM SETTINGS
            end if;
         elsif r_m_load_form_custom_disposa.txt_disposable_text_has_params = 'N' and r_m_load_form_custom_disposa.txt_disposable_text_is_package = 'Y' then
            if trim (substr (p_line_analysis, 1, instr (p_line_analysis, '.') - 1)) = r_m_load_form_custom_disposa.txt_custom_disposable_text then
               return TRUE; -- LINE IS DISPOSABLE UNDER CUSTOM SETTINGS
            end if;
         elsif r_m_load_form_custom_disposa.txt_disposable_text_has_params = 'Y' and r_m_load_form_custom_disposa.txt_disposable_text_is_package = 'Y' then
            if trim (substr (p_line_analysis, 1, instr (p_line_analysis, '.') - 1)) = r_m_load_form_custom_disposa.txt_custom_disposable_text then
               return TRUE; -- LINE IS DISPOSABLE UNDER CUSTOM SETTINGS
            end if;
         end if;
      end loop;

-- LINE IS NOT DISPOSABLE UNDER CUSTOM SETTINGS; NO ERROR
      p_msg_retorno := NULL;
      return FALSE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_line_disposable_custm_b;

-- fu_discard_prg_marked_custom_b
   FUNCTION fu_discard_prg_marked_custom_b (p_id_form            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_msg_retorno IN OUT varchar2)
                                            RETURN boolean IS
      cursor c_m_load_form_plsql_contents_p (p_id_form M_LOAD_FORM_GLOB_SYST_PARM.id_form%TYPE) is
         select mlfpc.*
           from m_load_form_plsql_contents mlfpc
          where mlfpc.id_form                      = p_id_form
            and mlfpc.txt_generated_function_name is NULL -- PROGRAM UNITS
            and mlfpc.txt_disposable_routine       = 'N'
          order by mlfpc.id;

      cursor c_m_load_form_custom_disposa (p_id_disposable_text_type M_LOAD_FORM_CUSTOM_DISPOSA.id_disposable_text_type%TYPE) is
         select mlfcd.*
           from m_load_form_custom_disposa mlfcd
          where mlfcd.id_disposable_text_type = nvl (p_id_disposable_text_type, mlfcd.id_disposable_text_type)
          order by mlfcd.id;

      r_m_load_form_plsql_contents_p c_m_load_form_plsql_contents_p%ROWTYPE := NULL;
      r_m_load_form_custom_disposa   c_m_load_form_custom_disposa%ROWTYPE   := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_discard_prg_marked_custom_b (' || p_id_form || '): ';

   BEGIN
      if p_id_form is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
         return FALSE;
      else
-- DISCARD ALL PROCEDURES/FUNCTIONS/PACKAGES THAT WERE MARKED AS DISPOSABLE IN CUSTOM CONFIGURATIONS
         for r_m_load_form_plsql_contents_p in c_m_load_form_plsql_contents_p (p_id_form) loop
            for r_m_load_form_custom_disposa in c_m_load_form_custom_disposa (PKG_M_LOAD_FORM_DISPOS_TXT_TYP.fu_ret_disposable_text_type_i ('CUSTOM')) loop
               if r_m_load_form_plsql_contents_p.txt_plsql_source = 'PROGRAM UNIT' and r_m_load_form_plsql_contents_p.txt_plsql_object_name = r_m_load_form_custom_disposa.txt_custom_disposable_text then
                  BEGIN
                     update m_load_form_plsql_contents mlfpc
                        set mlfpc.txt_disposable_routine       = 'Y',
                            mlfpc.txt_disposable_reason        = PKG_M_LOAD_FORM_PLSQL_DISC_RSN.fu_ret_discard_reason_key_v ('CUSTPRGUNT')
                      where mlfpc.id_form                      = p_id_form
                        and mlfpc.txt_generated_function_name is NULL
                        and mlfpc.txt_plsql_source             = r_m_load_form_plsql_contents_p.txt_plsql_source
                        and mlfpc.txt_plsql_object_name        = r_m_load_form_plsql_contents_p.txt_plsql_object_name;

                  EXCEPTION
                     when others then
                        p_msg_retorno := 'Erro UPDATE MLFPC 1 (' || r_m_load_form_plsql_contents_p.txt_plsql_source      ||
                                                            ', ' || r_m_load_form_plsql_contents_p.txt_plsql_object_name ||
                                                         ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                        return FALSE;
                  END;

                  commit;
               end if;
            end loop;
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_discard_prg_marked_custom_b;

-- fu_discard_invalid_trg_name_b
   FUNCTION fu_discard_invalid_trg_name_b (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                           p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                           p_msg_retorno                 IN OUT varchar2)
                                           RETURN boolean IS
      p_existe   integer        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_discard_invalid_trg_name_b (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';

   BEGIN
      if p_id_form is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
         return FALSE;
      elsif p_txt_generated_function_name is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o nome da program unit deve ser informado.';
         return FALSE;
      else
         BEGIN
            select 1
              into p_existe
              from m_disposable_contents      mdc,
                   m_load_form_plsql_contents mlfpc
             where mlfpc.id_form                     = p_id_form
               and mlfpc.txt_generated_function_name = trim (upper (p_txt_generated_function_name))
               and mlfpc.txt_disposable_routine      = 'N'
               and mlfpc.txt_plsql_object_name       = mdc.txt_disposable_text
               and mdc.id_disposable_text_type       = PKG_M_LOAD_FORM_DISPOS_TXT_TYP.fu_ret_disposable_text_type_i ('ORACLE FORMS TRIGGER');

         EXCEPTION
            when no_data_found then
               BEGIN
                  update m_load_form_plsql_contents mlfpc
                     set mlfpc.txt_disposable_routine      = 'Y',
                         mlfpc.txt_disposable_reason       = PKG_M_LOAD_FORM_PLSQL_DISC_RSN.fu_ret_discard_reason_key_v ('INVTRGNAME')
                   where mlfpc.id_form                     = p_id_form
                     and mlfpc.txt_generated_function_name = trim (upper (p_txt_generated_function_name));

               EXCEPTION
                  when others then
                     p_msg_retorno := 'Erro UPDATE MLFPC 8 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                     return FALSE;
               END;

               commit;
               p_msg_retorno := NULL;
               return FALSE;
            when others then
               p_msg_retorno := 'Erro SELECT MDC/MLFPC em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_discard_invalid_trg_name_b;

-- fu_discard_invalid_trg_name_v
   FUNCTION fu_discard_invalid_trg_name_v (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                           p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                           RETURN varchar2 IS
      p_retorno     boolean        := NULL;
      p_prc_name    varchar2(1000) := p_pck_name || 'fu_discard_invalid_trg_name_v (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';
      p_msg_retorno varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_discard_invalid_trg_name_b (p_id_form, p_txt_generated_function_name, p_msg_retorno);

      if    p_retorno = TRUE then
         return 'Y';
      elsif p_retorno = FALSE and p_msg_retorno is NULL then
         return 'N';
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_discard_invalid_trg_name_v;

-- fu_discard_prg_unit_per_line_b
   FUNCTION fu_discard_prg_unit_per_line_b (p_id_form                    M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_clob_plsql_contents        M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE,
                                            p_msg_retorno         IN OUT varchar2)
                                            RETURN boolean IS
      p_clob_plsql_contents_e       M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE := empty_clob();
      p_reading_program_unit_header boolean        := FALSE;
      p_retorno                     boolean        := NULL;
      p_count_lines                 integer        := NULL;
      p_count_lines_disposable      integer        := NULL;
      p_instr_chr_10                integer        := NULL;
      p_prc_name                    varchar2(1000) := p_pck_name || 'fu_discard_prg_unit_per_line_b (' || p_id_form || '): ';
      p_line_analysis               varchar2(4000) := NULL;

   BEGIN
      if    p_id_form is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
         return FALSE;
      elsif p_clob_plsql_contents = empty_clob() then
         p_msg_retorno := 'Erro ' || p_prc_name || 'CLOB vazio.';
         return FALSE;
      else
         p_count_lines                 := 0;
         p_count_lines_disposable      := 0;
         p_clob_plsql_contents_e       := p_clob_plsql_contents;
         p_reading_program_unit_header := TRUE;

         loop
            p_instr_chr_10        := instr (p_clob_plsql_contents_e, chr(10));
            exit when p_instr_chr_10 = 0; -- EXITS LOOP WHEN NO NEW LINES ARE FOUND (NO MORE PL/SQL CONTENTS)

            p_line_analysis       := trim (translate (upper (substr (p_clob_plsql_contents_e, 1, p_instr_chr_10)), chr(9) || chr(10), '  '));
            p_clob_plsql_contents_e := substr (p_clob_plsql_contents_e, p_instr_chr_10 + 1);

            if p_reading_program_unit_header = FALSE then -- COUNTS DISPOSABLE LINES AFTER PROGRAM UNIT HEADER
               p_count_lines := p_count_lines + 1;

               if p_line_analysis is NULL then
                  p_count_lines_disposable := p_count_lines_disposable + 1;
               else
                  if substr (p_line_analysis, length (p_line_analysis), 1) = ';' then
                     p_line_analysis := trim (substr (p_line_analysis, 1, length (p_line_analysis) - 1));
                  end if;

                  p_retorno := PKG_IMPORT_FORM.fu_ret_line_disposable_plsql_b (p_line_analysis, p_msg_retorno);

                  if    p_retorno = TRUE then
                     p_count_lines_disposable := p_count_lines_disposable + 1;
                  else
                     if p_msg_retorno is not NULL then
                        p_msg_retorno := 'Erro P_RETORNO FU_RET_LINE_DISPOSABLE_PLSQL_B em ' || p_prc_name || p_msg_retorno;
                        return FALSE;
                     end if;
                  end if;

                  p_retorno := PKG_IMPORT_FORM.fu_ret_line_disposable_custm_b (p_line_analysis, p_msg_retorno);

                  if    p_retorno = TRUE then
                     p_count_lines_disposable := p_count_lines_disposable + 1;
                  else
                     if p_msg_retorno is not NULL then
                        p_msg_retorno := 'Erro P_RETORNO FU_RET_LINE_DISPOSABLE_CUSTM_B em ' || p_prc_name || p_msg_retorno;
                        return FALSE;
                     end if;
                  end if;
               end if;
            end if;

-- JUMPS PROCEDURE/FUNCTION HEADER
            if p_reading_program_unit_header = TRUE then
               if  instr (p_line_analysis, ' IS ') > 0
                or substr (p_line_analysis, length (p_line_analysis) - 2) in (' IS', ')IS')
                or trim (translate (upper (p_line_analysis), chr(9) || chr(10), '  ')) = 'IS' then
                  p_reading_program_unit_header := FALSE;
               end if;
            end if;
         end loop;

         if p_count_lines = p_count_lines_disposable then
            return TRUE;
         else
            return FALSE;
         end if;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_discard_prg_unit_per_line_b;

-- fu_unit_per_line_disposable_b
   FUNCTION fu_unit_per_line_disposable_b (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                           p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                           p_msg_retorno                 IN OUT varchar2)
                                           RETURN boolean IS
      p_clob_plsql_contents_no_comm M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents_no_comm%TYPE := empty_clob();
      p_retorno  boolean        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_unit_per_line_disposable_b (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';

   BEGIN
      if p_id_form is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
         return FALSE;
      elsif p_txt_generated_function_name is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o nome da program unit deve ser informado.';
         return FALSE;
      else
         BEGIN
            select mlfpc.clob_plsql_contents_no_comm
              into p_clob_plsql_contents_no_comm
              from m_load_form_plsql_contents mlfpc
             where mlfpc.id_form = p_id_form
               and ((mlfpc.txt_generated_function_name is     NULL and mlfpc.txt_plsql_object_name       = trim (upper (p_txt_generated_function_name)))
                 or (mlfpc.txt_generated_function_name is not NULL and mlfpc.txt_generated_function_name = trim (upper (p_txt_generated_function_name))));

         EXCEPTION
            when no_data_found then
               p_msg_retorno := 'Erro ' || p_prc_name || 'a program unit informada não existe.';
               return FALSE;
            when others then
               p_msg_retorno := 'Erro SELECT MLFPC 10 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

         p_retorno := PKG_IMPORT_FORM.fu_discard_prg_unit_per_line_b (p_id_form, p_clob_plsql_contents_no_comm, p_msg_retorno);

         if p_retorno = TRUE then
            return TRUE;
         else
            return p_retorno;
         end if;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_unit_per_line_disposable_b;

-- fu_unit_per_line_disposable_v
   FUNCTION fu_unit_per_line_disposable_v (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                           p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                           RETURN varchar2 IS
      p_retorno     boolean        := NULL;
      p_prc_name    varchar2(1000) := p_pck_name || 'fu_unit_per_line_disposable_v (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';
      p_msg_retorno varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_unit_per_line_disposable_b (p_id_form, p_txt_generated_function_name, p_msg_retorno);

      if    p_retorno = TRUE then
         return 'YES';
      elsif p_retorno = FALSE and p_msg_retorno is NULL then
         return 'NO';
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_unit_per_line_disposable_v;

-- fu_discard_data_blocks_b
   FUNCTION fu_discard_data_blocks_b (p_id_form            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                      p_msg_retorno IN OUT varchar2)
                                      RETURN boolean IS
      cursor c_m_load_form_custom_disposa is
         select mlfcd.*
           from m_load_form_custom_disposa mlfcd
          where mlfcd.txt_custom_disposable_text is not NULL
            and mlfcd.id_disposable_text_type     = PKG_M_LOAD_FORM_DISPOS_TXT_TYP.fu_ret_disposable_text_type_i ('ORACLE FORMS DATA BLOCK');

      r_m_load_form_custom_disposa c_m_load_form_custom_disposa%ROWTYPE := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_discard_data_blocks_b (' || p_id_form || '): ';

   BEGIN
      if p_id_form is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
         return FALSE;
      else
         for r_m_load_form_custom_disposa in c_m_load_form_custom_disposa loop
            BEGIN
               update m_load_form_blocks_items mlfbi
                  set mlfbi.txt_disposable_data_block = 'Y'
                where mlfbi.id_form                   = p_id_form
                  and mlfbi.txt_block_name            = r_m_load_form_custom_disposa.txt_custom_disposable_text;

            EXCEPTION
               when others then
                  p_msg_retorno := 'Erro UPDATE MLFBI (' || r_m_load_form_custom_disposa.txt_custom_disposable_text ||
                                                 ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                  return FALSE;
            END;

            commit;
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_discard_data_blocks_b;

-- fu_discard_prg_identify_line_b
   FUNCTION fu_discard_prg_identify_line_b (p_id_form            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_msg_retorno IN OUT varchar2)
                                            RETURN boolean IS
       cursor c_m_load_form_plsql_contents_p (p_id_form M_LOAD_FORM_GLOB_SYST_PARM.id_form%TYPE) is
         select mlfpc.*
           from m_load_form_plsql_contents mlfpc
          where mlfpc.id_form                      = p_id_form
            and mlfpc.txt_generated_function_name is NULL -- PROGRAM UNITS
            and mlfpc.txt_disposable_routine       = 'N'
          order by mlfpc.id;

      r_m_load_form_plsql_contents_p c_m_load_form_plsql_contents_p%ROWTYPE := NULL;
      p_txt_disposable_text_has_para M_LOAD_FORM_CUSTOM_DISPOSA.txt_disposable_text_has_params%TYPE := NULL;
      p_txt_disposable_text_is_packa M_LOAD_FORM_CUSTOM_DISPOSA.txt_disposable_text_is_package%TYPE := NULL;
      p_retorno      boolean        := NULL;
      p_prg_unit_hdr clob           := empty_clob();
      p_prc_name     varchar2(1000) := p_pck_name || 'fu_discard_prg_identify_line_b (' || p_id_form || '): ';

   BEGIN
      if p_id_form is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
         return FALSE;
      else
-- PERFORMS A LINE-BY-LINE READ OF EACH PROCEDURE/FUNCTION AND IDENTIFY DISPOSABLE ROUTINES.
         for r_m_load_form_plsql_contents_p in c_m_load_form_plsql_contents_p (p_id_form) loop
            p_retorno := PKG_IMPORT_FORM.fu_discard_prg_unit_per_line_b (r_m_load_form_plsql_contents_p.id_form,
                                                                         r_m_load_form_plsql_contents_p.clob_plsql_contents_no_comm,
                                                                         p_msg_retorno);

            if p_retorno = TRUE then
               BEGIN
                  update m_load_form_plsql_contents mlfpc
                     set mlfpc.txt_disposable_routine = 'Y',
                         mlfpc.txt_disposable_reason  = PKG_M_LOAD_FORM_PLSQL_DISC_RSN.fu_ret_discard_reason_key_v ('ALLINEDETE')
                   where mlfpc.id_form                = r_m_load_form_plsql_contents_p.id_form
                     and mlfpc.id_rownum              = r_m_load_form_plsql_contents_p.id_rownum;

               EXCEPTION
                  when others then
                     p_msg_retorno := 'Erro UPDATE MLFPC 7 (' || r_m_load_form_plsql_contents_p.id_form   ||
                                                         ', ' || r_m_load_form_plsql_contents_p.id_rownum ||
                                                      ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                     return FALSE;
               END;

               p_prg_unit_hdr := PKG_IMPORT_FORM.fu_retrieve_prog_unit_header_c (r_m_load_form_plsql_contents_p.clob_plsql_contents_no_comm);

               if instr (p_prg_unit_hdr, '(') = 0 then
                  p_txt_disposable_text_has_para := 'N';
               else
                  p_txt_disposable_text_has_para := 'S';
               end if;

               if r_m_load_form_plsql_contents_p.txt_plsql_program_unit_type in ('PACKAGE_BODY', 'PACKAGE_SPEC') then
                  p_txt_disposable_text_is_packa := 'S';
               else
                  p_txt_disposable_text_is_packa := 'N';
               end if;

               BEGIN
                  insert into m_load_form_custom_disposa (txt_custom_disposable_text,
                                                          id_disposable_text_type,
                                                          txt_disposable_text_has_params,
                                                          txt_disposable_text_is_package,
                                                          txt_disposable_text_detected)
                                                  values (nvl (r_m_load_form_plsql_contents_p.txt_generated_function_name,
                                                               r_m_load_form_plsql_contents_p.txt_plsql_object_name),
                                                          PKG_M_LOAD_FORM_DISPOS_TXT_TYP.fu_ret_disposable_text_type_i ('CUSTOM'),
                                                          p_txt_disposable_text_has_para,
                                                          p_txt_disposable_text_is_packa,
                                                          'Y');

               EXCEPTION
                  when others then
                     p_msg_retorno := 'Erro INSERT MLFCD CUSTOM (' || nvl (r_m_load_form_plsql_contents_p.txt_generated_function_name,
                                                                           r_m_load_form_plsql_contents_p.txt_plsql_object_name) ||
                                                           ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                     return FALSE;
               END;

               commit;
            elsif p_retorno = FALSE and p_msg_retorno is not NULL then
               p_msg_retorno := 'Erro P_RETORNO (' || r_m_load_form_plsql_contents_p.id_form   ||
                                              ', ' || r_m_load_form_plsql_contents_p.id_rownum ||
                                           ') em ' || p_prc_name || p_msg_retorno;
               return p_retorno;
            end if;
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_discard_prg_identify_line_b;

-- fu_discard_prg_plsql_trigger_b
   FUNCTION fu_discard_prg_plsql_trigger_b (p_id_form M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                            p_msg_retorno IN OUT varchar2)
                                            RETURN boolean IS
      cursor c_m_disposable_contents (p_id_disposable_text_type M_DISPOSABLE_CONTENTS.id_disposable_text_type%TYPE) is
         select mdc.txt_disposable_text,
                mdc.txt_disposable_text_has_params,
                mdc.txt_disposable_text_is_package,
                mdftl.txt_disposa_trg_on_form_level,
                mdftl.txt_disposa_trg_on_block_level,
                mdftl.txt_disposa_trg_on_item_level
           from m_disposable_contents     mdc,
                m_disposable_form_trg_lvl mdftl
          where mdftl.id_disposable_form_trg (+) = mdc.id
            and mdc.id_disposable_text_type      = p_id_disposable_text_type;

      cursor c_m_load_form_dispos_txt_typ is
         select mlfdtt.*
           from m_load_form_dispos_txt_typ mlfdtt
          order by mlfdtt.txt_disposable_text_type;

      cursor c_m_load_form_plsql_contents (p_id_form M_LOAD_FORM_GLOB_SYST_PARM.id_form%TYPE) is
         select mlfpc.*
           from m_load_form_plsql_contents mlfpc
          where mlfpc.id_form                      = p_id_form
            and mlfpc.txt_generated_function_name is not NULL
            and mlfpc.txt_disposable_routine       = 'N'
          order by mlfpc.id;

      cursor c_txt_generated_function_names (p_id_form M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE) is
         select mlfpc.txt_generated_function_name
           from m_load_form_plsql_contents mlfpc
          where mlfpc.id_form                      = p_id_form
            and mlfpc.txt_disposable_routine       = 'N'
            and mlfpc.txt_generated_function_name is not NULL;

      r_txt_generated_function_names c_txt_generated_function_names%ROWTYPE := NULL;
      r_m_disposable_contents        c_m_disposable_contents%ROWTYPE      := NULL;
      r_m_load_form_dispos_txt_typ   c_m_load_form_dispos_txt_typ%ROWTYPE := NULL;
      r_m_load_form_plsql_contents   c_m_load_form_plsql_contents%ROWTYPE := NULL;
      p_clob_plsql_contents          M_LOAD_FORM_PLSQL_CONTENTS.clob_plsql_contents%TYPE := empty_clob();
      p_retorno                      boolean        := NULL;
      p_count_lines                  integer        := NULL;
      p_count_lines_disposable       integer        := NULL;
      p_instr_chr_10                 integer        := NULL;
      p_prc_name                     varchar2(1000) := p_pck_name || 'fu_discard_prg_plsql_trigger_b (' || p_id_form || '): ';
      p_line_analysis                varchar2(4000) := NULL;

   BEGIN
      if p_id_form is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
         return FALSE;
      else
-- PERFORMS A LINE-BY-LINE READ OF EACH PL/SQL TRIGGER AND IDENTIFY DISPOSABLE ROUTINES.
         for r_m_load_form_plsql_contents in c_m_load_form_plsql_contents (p_id_form) loop
            p_count_lines            := 0;
            p_count_lines_disposable := 0;
            p_clob_plsql_contents    := r_m_load_form_plsql_contents.clob_plsql_contents_no_comm;

            loop
               p_instr_chr_10        := instr (p_clob_plsql_contents, chr(10));
               exit when p_instr_chr_10 = 0; -- EXITS LOOP WHEN NO NEW LINES ARE FOUND (NO MORE PL/SQL CONTENTS)

               p_line_analysis       := trim (translate (upper (substr (p_clob_plsql_contents, 1, p_instr_chr_10)), chr(9) || chr(10), '  '));
               p_clob_plsql_contents := substr (p_clob_plsql_contents, p_instr_chr_10 + 1);
               p_count_lines         := p_count_lines + 1;

               if p_line_analysis is NULL then
                  p_count_lines_disposable := p_count_lines_disposable + 1;
               else
                  if substr (p_line_analysis, length (p_line_analysis), 1) = ';' then
                     p_line_analysis := trim (substr (p_line_analysis, 1, length (p_line_analysis) - 1));
                  end if;

                  for r_m_load_form_dispos_txt_typ in c_m_load_form_dispos_txt_typ loop
                     for r_m_disposable_contents in c_m_disposable_contents (r_m_load_form_dispos_txt_typ.id) loop
                        if    r_m_load_form_dispos_txt_typ.txt_disposable_text_type = 'ORACLE FORMS PROGRAM UNIT' then
                           BEGIN -- DISCARD ALL PROCEDURES/FUNCTIONS/PACKAGES THAT WERE MARKED AS DISPOSABLE IN CUSTOM CONFIGURATIONS
                              update m_load_form_plsql_contents mlfpc
                                 set mlfpc.txt_disposable_routine       = 'Y',
                                     mlfpc.txt_disposable_reason        = PKG_M_LOAD_FORM_PLSQL_DISC_RSN.fu_ret_discard_reason_key_v ('CUSTPRGUNT')
                               where mlfpc.id_form                      = p_id_form
                                 and mlfpc.txt_generated_function_name is NULL
                                 and mlfpc.txt_plsql_source             = 'PROGRAM UNIT'
                                 and mlfpc.txt_plsql_object_name        = r_m_disposable_contents.txt_disposable_text;

                           EXCEPTION
                              when others then
                                 p_msg_retorno := 'Erro UPDATE MLFPC 2 (' || r_m_disposable_contents.txt_disposable_text ||
                                                                  ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                                 return FALSE;
                           END;

                           commit;
                        elsif r_m_load_form_dispos_txt_typ.txt_disposable_text_type = 'ORACLE FORMS TRIGGER' then
                           if  r_m_disposable_contents.txt_disposa_trg_on_form_level = 'Y' then
                              BEGIN -- DISCARD ALL FORM TRIGGERS THAT WERE MARKED AS DISPOSABLE IN CUSTOM CONFIGURATIONS
                                 update m_load_form_plsql_contents mlfpc
                                    set mlfpc.txt_disposable_routine       = 'Y',
                                        mlfpc.txt_disposable_reason        = PKG_M_LOAD_FORM_PLSQL_DISC_RSN.fu_ret_discard_reason_key_v ('CUSTFRMTRG')
                                  where mlfpc.id_form                      = p_id_form
                                    and mlfpc.txt_generated_function_name is not NULL
                                    and mlfpc.txt_plsql_source             = 'FORM TRIGGER'
                                    and mlfpc.txt_plsql_object_name        = r_m_disposable_contents.txt_disposable_text;

                              EXCEPTION
                                 when others then
                                    p_msg_retorno := 'Erro UPDATE MLFPC 3 (' || r_m_disposable_contents.txt_disposable_text ||
                                                                     ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                                    return FALSE;
                              END;

                              commit;
                           end if;

                           if r_m_disposable_contents.txt_disposa_trg_on_block_level = 'Y' then
                              BEGIN -- DISCARD ALL BLOCK TRIGGERS THAT WERE MARKED AS DISPOSABLE IN CUSTOM CONFIGURATIONS
                                 update m_load_form_plsql_contents mlfpc
                                    set mlfpc.txt_disposable_routine       = 'Y',
                                        mlfpc.txt_disposable_reason        = PKG_M_LOAD_FORM_PLSQL_DISC_RSN.fu_ret_discard_reason_key_v ('CUSTBLKTRG')
                                  where mlfpc.id_form                      = p_id_form
                                    and mlfpc.txt_generated_function_name is not NULL
                                    and mlfpc.txt_plsql_source             = 'BLOCK TRIGGER'
                                    and mlfpc.txt_plsql_object_name        = r_m_disposable_contents.txt_disposable_text;

                              EXCEPTION
                                 when others then
                                    p_msg_retorno := 'Erro UPDATE MLFPC 4 (' || r_m_disposable_contents.txt_disposable_text ||
                                                                     ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                                    return FALSE;
                              END;

                              commit;
                           end if;

                           if r_m_disposable_contents.txt_disposa_trg_on_item_level = 'Y' then
                              BEGIN -- DISCARD ALL BLOCK.ITEM TRIGGERS THAT WERE MARKED AS DISPOSABLE IN CUSTOM CONFIGURATIONS
                                 update m_load_form_plsql_contents mlfpc
                                    set mlfpc.txt_disposable_routine       = 'Y',
                                        mlfpc.txt_disposable_reason        = PKG_M_LOAD_FORM_PLSQL_DISC_RSN.fu_ret_discard_reason_key_v ('CUSTITMTRG')
                                  where mlfpc.id_form                      = p_id_form
                                    and mlfpc.txt_generated_function_name is not NULL
                                    and mlfpc.txt_plsql_source             = 'BLOCK.ITEM TRIGGER'
                                    and mlfpc.txt_plsql_object_name        = r_m_disposable_contents.txt_disposable_text;

                              EXCEPTION
                                 when others then
                                    p_msg_retorno := 'Erro UPDATE MLFPC 5 (' || r_m_disposable_contents.txt_disposable_text ||
                                                                     ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                                    return FALSE;
                              END;

                              commit;
                           end if;
                        end if;
                     end loop;

                     if r_m_load_form_dispos_txt_typ.txt_disposable_text_type = 'ORACLE FORMS PL/SQL ROUTINE' then
                        p_retorno := PKG_IMPORT_FORM.fu_ret_line_disposable_plsql_b (p_line_analysis, p_msg_retorno);

                        if    p_retorno = TRUE then
                           p_count_lines_disposable := p_count_lines_disposable + 1;
                           exit;
                        else
                           if p_msg_retorno is not NULL then
                              p_msg_retorno := 'Erro P_RETORNO FU_RET_LINE_DISPOSABLE_PLSQL_B em ' || p_prc_name || p_msg_retorno;
                              return FALSE;
                           end if;
                        end if;
                     end if;

                     if r_m_load_form_dispos_txt_typ.txt_disposable_text_type = 'CUSTOM' then
                        p_retorno := PKG_IMPORT_FORM.fu_ret_line_disposable_custm_b (p_line_analysis, p_msg_retorno);

                        if    p_retorno = TRUE then
                           p_count_lines_disposable := p_count_lines_disposable + 1;
                           exit;
                        else
                           if p_msg_retorno is not NULL then
                              p_msg_retorno := 'Erro P_RETORNO FU_RET_LINE_DISPOSABLE_CUSTM_B em ' || p_prc_name || p_msg_retorno;
                              return FALSE;
                           end if;
                        end if;
                     end if;
                  end loop;
               end if;
            end loop;

            if p_count_lines = p_count_lines_disposable then
               BEGIN
                  update m_load_form_plsql_contents mlfpc
                     set mlfpc.txt_disposable_routine = 'Y',
                         mlfpc.txt_disposable_reason  = PKG_M_LOAD_FORM_PLSQL_DISC_RSN.fu_ret_discard_reason_key_v ('ALLINEDISP')
                   where mlfpc.id_form                = r_m_load_form_plsql_contents.id_form
                     and mlfpc.id_rownum              = r_m_load_form_plsql_contents.id_rownum;

               EXCEPTION
                  when others then
                     p_msg_retorno := 'Erro UPDATE MLFPC 6 (' || r_m_load_form_plsql_contents.id_form   ||
                                                         ', ' || r_m_load_form_plsql_contents.id_rownum ||
                                                      ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                     return FALSE;
               END;

               commit;
            end if;
         end loop;

         if p_discard_invalid_trigger_name = TRUE then
            for r_txt_generated_function_names in c_txt_generated_function_names (p_id_form) loop
               p_retorno := PKG_IMPORT_FORM.fu_discard_invalid_trg_name_b (p_id_form, r_txt_generated_function_names.txt_generated_function_name, p_msg_retorno);

               if p_retorno != TRUE and p_msg_retorno is not NULL then
                  return p_retorno;
               end if;
            end loop;
         end if;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_discard_prg_plsql_trigger_b;

-- fu_ret_max_length_param_b
   FUNCTION fu_ret_max_length_param_b (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                       p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                       p_length_param                IN OUT integer,
                                       p_msg_retorno                 IN OUT varchar2)
                                       RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_max_length_param_b (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';

   BEGIN
      if p_id_form is not NULL and p_txt_generated_function_name is not NULL then
         BEGIN
            select nvl (greatest (max (length (case
                                                  when txt_variable_type in ('GLOBAL', 'PARAMETER', 'SYSTEM') then
                                                     (select mlfgsp.txt_variable_parameter_name
                                                        from m_load_form_glob_syst_parm mlfgsp
                                                       where mlfgsp.id_form           = t.id_form
                                                         and mlfgsp.txt_variable_name = t.txt_block_item_gsp_variable)
                                                  when txt_variable_type = 'DECLARATION' then
                                                     (select mlfpp.txt_block_item_gsp_variable
                                                        from m_load_form_plsql_params mlfpp
                                                       where mlfpp.id_form                     = t.id_form
                                                         and mlfpp.id_plsql_contents           = t.mlfpc_id_plsql_contents
                                                         and mlfpp.txt_block_item_gsp_variable = t.txt_block_item_gsp_variable
                                                         and mlfpp.txt_variable_type           = 'DECLARATION')
                                                  else
                                                     (select mlfbi.txt_variable_parameter_name
                                                        from m_load_form_blocks_items mlfbi
                                                       where mlfbi.id_form                     =  t.id_form
                                                         and mlfbi.txt_variable_parameter_name is not NULL
                                                         and mlfbi.txt_item_name               is not NULL
                                                         and mlfbi.txt_block_item_name         =  t.txt_block_item_gsp_variable)
                                               end)),
                                  length (PKG_IMPORT_FORM.p_msg_retorno_v)),
                        length (PKG_IMPORT_FORM.p_msg_retorno_v)) as txt_variable_parameter_name
              into p_length_param
              from (select mlfpc.id_form,
                           mlfpc.id as mlfpc_id_plsql_contents,
                           mlfpp.txt_block_item_gsp_variable,
                           mlfpp.txt_variable_type
                      from m_load_form_plsql_contents mlfpc,
                           m_load_form_plsql_params   mlfpp
                     where mlfpc.id_form = p_id_form
                       and ((mlfpc.txt_generated_function_name is     NULL and mlfpc.txt_plsql_object_name       = trim (upper (p_txt_generated_function_name)))
                         or (mlfpc.txt_generated_function_name is not NULL and mlfpc.txt_generated_function_name = trim (upper (p_txt_generated_function_name))))
                       and mlfpc.id_form = mlfpp.id_form
                       and mlfpc.id      = mlfpp.id_plsql_contents) t;

         EXCEPTION
            when no_data_found then
               p_length_param := PKG_IMPORT_FORM.p_oracle_objects_size;
            when others then
               p_msg_retorno  := 'Erro SELECT GREATEST em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_max_length_param_b;

-- fu_ret_max_length_param_i
   FUNCTION fu_ret_max_length_param_i (p_id_form                     M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                       p_txt_generated_function_name M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                       RETURN integer IS
      p_retorno      boolean        := NULL;
      p_length_param integer        := NULL;
      p_prc_name     varchar2(1000) := p_pck_name || 'fu_ret_max_length_param_i (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';
      p_msg_retorno  varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_max_length_param_b (p_id_form, p_txt_generated_function_name, p_length_param, p_msg_retorno);

      if p_retorno = TRUE then
         return p_length_param;
      else
         return PKG_IMPORT_FORM.p_oracle_objects_size;
      end if;

   EXCEPTION
      when others then
         return PKG_IMPORT_FORM.p_oracle_objects_size;
   END fu_ret_max_length_param_i;

-- fu_create_oracle_apex_calls_b
   FUNCTION fu_create_oracle_apex_calls_b (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                           p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE,
                                           p_txt_oracle_apex_plsql_calls IN OUT M_LOAD_FORM.txt_oracle_apex_plsql_calls%TYPE,
                                           p_msg_retorno                 IN OUT varchar2)
                                           RETURN boolean IS
      cursor c_plsql_unit_parameters is
         select t.id_form,
                t.id_plsql_contents,
                t.txt_block_item_gsp_variable,
                t.txt_variable_type,
                case
                   when txt_variable_type in ('GLOBAL', 'PARAMETER', 'SYSTEM') then
                      (select mlfgsp.txt_variable_parameter_name
                         from m_load_form_glob_syst_parm mlfgsp
                        where mlfgsp.id_form           = t.id_form
                          and mlfgsp.txt_variable_name = t.txt_block_item_gsp_variable)
                   when txt_variable_type = 'DECLARATION' then lower (t.txt_block_item_gsp_variable)
                   else
                      (select mlfbi.txt_variable_parameter_name
                         from m_load_form_blocks_items mlfbi
                        where mlfbi.id_form                     =  t.id_form
                          and mlfbi.txt_item_name               is not NULL
                          and mlfbi.txt_variable_parameter_name is not NULL
                          and mlfbi.txt_block_item_name         =  t.txt_block_item_gsp_variable)
                end as txt_variable_parameter_name
           from (select mlfpp.id_form,
                        mlfpp.id_plsql_contents,
                        mlfpp.txt_block_item_gsp_variable,
                        mlfpp.txt_variable_type
                   from m_load_form_plsql_contents mlfpc,
                        m_load_form_plsql_params   mlfpp
                  where mlfpc.id_form = p_id_form
                    and mlfpc.id_form = mlfpp.id_form
                    and mlfpc.id      = mlfpp.id_plsql_contents
                    and ((mlfpc.txt_generated_function_name is     NULL and mlfpc.txt_plsql_object_name       = trim (upper (p_txt_generated_function_name)))
                      or (mlfpc.txt_generated_function_name is not NULL and mlfpc.txt_generated_function_name = trim (upper (p_txt_generated_function_name))))) t;

      r_plsql_unit_parameters      c_plsql_unit_parameters%ROWTYPE    := NULL;
      p_m_load_form_glob_syst_parm m_load_form_glob_syst_parm%ROWTYPE := NULL;
      p_m_load_form_blocks_items   m_load_form_blocks_items%ROWTYPE   := NULL;
      p_m_load_form_plsql_params   m_load_form_plsql_params%ROWTYPE   := NULL;
      p_count        integer        := 0;
      p_length_param integer        := NULL;
      p_package_name varchar2(100)  := upper (trim (PKG_IMPORT_FORM.p_package_prefix) || PKG_IMPORT_FORM.fu_obter_nome_form_v (p_id_form));
      p_prc_name     varchar2(1000) := p_pck_name || 'fu_create_oracle_apex_calls_b (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';

   BEGIN
      if p_id_form is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
         return FALSE;
      elsif trim (p_txt_generated_function_name) is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o nome da rotina deve ser informado.';
         return FALSE;
      else
         p_txt_oracle_apex_plsql_calls := p_txt_oracle_apex_plsql_calls ||
                                          '-- CALL: ' || p_package_name || '.' || p_txt_generated_function_name || chr(10) ||
                                            'DECLARE' || chr(10) ||
                                             p_indent || p_retorno_v || ' boolean := NULL;' || chr(10) ||
                                             p_indent || p_prc_name_v || ' varchar2(100) := ''' || lower (p_txt_generated_function_name) || ': '';' || chr(10) ||
                                             p_indent || p_msg_retorno_v || ' varchar2(4000) := NULL;' || chr(10) || chr(10) ||
                                             'BEGIN' || chr(10) ||
                                             p_indent || p_retorno_v || ' := ' || p_package_name || '.' || lower (p_txt_generated_function_name) || ' (';

         p_length_param := PKG_IMPORT_FORM.fu_ret_max_length_param_i (p_id_form, p_txt_generated_function_name);

         for r_plsql_unit_parameters in c_plsql_unit_parameters loop
             if   r_plsql_unit_parameters.txt_variable_type in ('GLOBAL', 'PARAMETER', 'SYSTEM') then
               BEGIN
                  select mlfgsp.*
                    into p_m_load_form_glob_syst_parm
                    from m_load_form_glob_syst_parm mlfgsp
                   where mlfgsp.id_form           = p_id_form
                     and mlfgsp.txt_variable_name = r_plsql_unit_parameters.txt_block_item_gsp_variable;

               EXCEPTION
                  when others then
                     p_msg_retorno := 'Erro SELECT MLFGSP (' || r_plsql_unit_parameters.txt_block_item_gsp_variable ||
                                                     ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                     return FALSE;
               END;
            elsif r_plsql_unit_parameters.txt_variable_type = 'DECLARATION' then
               BEGIN
                  select mlfpp.*
                    into p_m_load_form_plsql_params
                    from m_load_form_plsql_params mlfpp
                   where mlfpp.id_form                     = p_id_form
                     and mlfpp.id_plsql_contents           = r_plsql_unit_parameters.id_plsql_contents
                     and mlfpp.txt_block_item_gsp_variable = r_plsql_unit_parameters.txt_block_item_gsp_variable;

               EXCEPTION
                  when others then
                     p_msg_retorno := 'Erro SELECT MLFPP 2 (' || r_plsql_unit_parameters.txt_block_item_gsp_variable ||
                                                      ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                     return FALSE;
               END;
            else
               BEGIN
                  select mlfbi.*
                    into p_m_load_form_blocks_items
                    from m_load_form_blocks_items mlfbi
                   where mlfbi.id_form             = p_id_form
                     and mlfbi.txt_block_item_name = r_plsql_unit_parameters.txt_block_item_gsp_variable
                     and mlfbi.txt_data_origin     = 'BLOCKS AND ITEMS';

               EXCEPTION
                  when others then
                     p_msg_retorno := 'Erro SELECT MLFBI 4 (' || r_plsql_unit_parameters.txt_block_item_gsp_variable ||
                                                      ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                     return FALSE;
               END;
            end if;

            p_count                       := p_count + 1;

            if p_count > 1 then
               p_txt_oracle_apex_plsql_calls := p_txt_oracle_apex_plsql_calls || lpad (', ',
                                                                                       length (p_indent
                                                                                               || p_retorno_v
                                                                                               || ' := '
                                                                                               || p_package_name
                                                                                               || '.'
                                                                                               || lower (p_txt_generated_function_name)
                                                                                               || ' ('),
                                                                                       ' ');
            end if;

            p_txt_oracle_apex_plsql_calls := p_txt_oracle_apex_plsql_calls || rpad (r_plsql_unit_parameters.txt_variable_parameter_name || ' => ',
                                                                              p_length_param + length (' => '), ' ')
                                                                           || PKG_IMPORT_FORM.p_oracle_apex_prefix || 'ORACLE_APEX_PAGE_FIELD -- ';

            if    r_plsql_unit_parameters.txt_variable_type in ('GLOBAL', 'PARAMETER', 'SYSTEM') then
               p_txt_oracle_apex_plsql_calls := p_txt_oracle_apex_plsql_calls || p_m_load_form_glob_syst_parm.txt_variable_name;
            elsif r_plsql_unit_parameters.txt_variable_type = 'DECLARATION' then
               p_txt_oracle_apex_plsql_calls := p_txt_oracle_apex_plsql_calls || p_m_load_form_plsql_params.txt_block_item_gsp_variable;
            else
               p_txt_oracle_apex_plsql_calls := p_txt_oracle_apex_plsql_calls || p_m_load_form_blocks_items.txt_block_item_name;
            end if;

            p_txt_oracle_apex_plsql_calls := p_txt_oracle_apex_plsql_calls || chr(10);
         end loop;

         if p_count >= 1 then
            p_txt_oracle_apex_plsql_calls := p_txt_oracle_apex_plsql_calls || lpad (', ',
                                                                                    length (p_indent
                                                                                            || p_retorno_v
                                                                                            || ' := '
                                                                                            || p_package_name
                                                                                            || '.'
                                                                                            || lower (p_txt_generated_function_name)
                                                                                            || ' ('),
                                                                                    ' ');
         end if;

         p_txt_oracle_apex_plsql_calls := p_txt_oracle_apex_plsql_calls ||
                                          rpad (p_msg_retorno_v || ' => ', p_length_param + length (' => '), ' ') ||
                                          p_msg_retorno_v ||
                                          ');' || chr(10) || chr(10) ||
                                          p_indent || 'if ' || p_retorno_v || ' != TRUE then' || chr(10) ||
                                          p_indent || p_indent || 'APEX_ERROR.add_error (p_message => ' || p_msg_retorno_v ||
                                                                             ', p_display_location => ''INLINE_IN_NOTIFICATION'');' || chr(10) ||
                                          p_indent || 'end if;' || chr(10) ||
                                          chr(10) ||
                                          'EXCEPTION' || chr(10) ||
                                          p_indent || 'when others then' || chr(10) ||
                                          p_indent || p_indent || 'APEX_ERROR.add_error (p_message => ''' || p_error_text_v ||
                                                                  ' '' || ' || p_prc_name_v || ' || ' ||
                                                                  'to_char (sqlcode) || '' - '' || sqlerrm, p_display_location => ''INLINE_IN_NOTIFICATION'');' ||
                                          chr(10) ||
                                          'END;' || chr(10) || chr(10);
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_create_oracle_apex_calls_b;

-- fu_create_oracle_apex_calls_c
   FUNCTION fu_create_oracle_apex_calls_c (p_id_form                            M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE,
                                           p_txt_generated_function_name        M_LOAD_FORM_PLSQL_CONTENTS.txt_generated_function_name%TYPE)
                                           RETURN M_LOAD_FORM.txt_oracle_apex_plsql_calls%TYPE IS
      p_txt_oracle_apex_plsql_calls M_LOAD_FORM.txt_oracle_apex_plsql_calls%TYPE := empty_clob();
      p_retorno     boolean        := NULL;
      p_prc_name    varchar2(1000) := p_pck_name || 'fu_create_oracle_apex_calls_c (' || p_id_form || ', ' || p_txt_generated_function_name || '): ';
      p_msg_retorno varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_create_oracle_apex_calls_b (p_id_form, p_txt_generated_function_name, p_txt_oracle_apex_plsql_calls, p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_oracle_apex_plsql_calls;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_create_oracle_apex_calls_c;

-- fu_generate_oracle_apex_call_c
   FUNCTION fu_generate_oracle_apex_call_c (p_id_form M_LOAD_FORM.id%TYPE)
                                            RETURN M_LOAD_FORM.txt_oracle_apex_plsql_calls%TYPE IS
      cursor c_m_load_form_plsql_contents is
         select mlfpc.*
           from m_load_form_plsql_contents mlfpc
          where mlfpc.id_form                = p_id_form
            and mlfpc.txt_disposable_routine = 'N';

      r_m_load_form_plsql_contents c_m_load_form_plsql_contents%ROWTYPE := NULL;
      p_txt_oracle_apex_plsql_calls M_LOAD_FORM.txt_oracle_apex_plsql_calls%TYPE := empty_clob();
      p_retorno  boolean        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_generate_oracle_apex_call_c (' || p_id_form || '): ';

   BEGIN
      if p_id_form is not NULL then
         for r_m_load_form_plsql_contents in c_m_load_form_plsql_contents loop
            p_txt_oracle_apex_plsql_calls := p_txt_oracle_apex_plsql_calls
                                             || PKG_IMPORT_FORM.fu_create_oracle_apex_calls_c (p_id_form,
                                                                                               nvl (r_m_load_form_plsql_contents.txt_generated_function_name,
                                                                                                    r_m_load_form_plsql_contents.txt_plsql_object_name));
         end loop;
      end if;

      return p_txt_oracle_apex_plsql_calls;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_generate_oracle_apex_call_c;

-- fu_generate_disposa_routines_c
   FUNCTION fu_generate_disposa_routines_c (p_id_form M_LOAD_FORM.id%TYPE)
                                            RETURN M_LOAD_FORM.txt_disposed_content%TYPE IS
      cursor c_m_load_form_plsql_disc_rsn is
         select mlfpdr.txt_plsql_discard_reason,
                mlfpdr.txt_plsql_discard_reason_means
           from m_load_form_plsql_disc_rsn mlfpdr;

      cursor c_plsql_disposable_contents is
         select mlfpc.*
           from m_load_form_plsql_contents mlfpc
          where mlfpc.id_form                = p_id_form
            and mlfpc.txt_disposable_routine = 'Y'
          order by mlfpc.id;

      r_m_load_form_plsql_disc_rsn c_m_load_form_plsql_disc_rsn%ROWTYPE := NULL;
      r_plsql_disposable_contents  c_plsql_disposable_contents%ROWTYPE  := NULL;
      p_txt_disposed_content M_LOAD_FORM.txt_disposed_content%TYPE := NULL;
      p_prc_name    varchar2(1000) := p_pck_name || 'fu_generate_disposa_routines_c (' || p_id_form || '): ';
      p_msg_retorno varchar2(4000) := NULL;

   BEGIN
      if p_id_form is NULL then
         return 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
      else
         for r_m_load_form_plsql_disc_rsn in c_m_load_form_plsql_disc_rsn loop
            p_txt_disposed_content := p_txt_disposed_content || r_m_load_form_plsql_disc_rsn.txt_plsql_discard_reason       ||
                                                        ': ' || r_m_load_form_plsql_disc_rsn.txt_plsql_discard_reason_means || chr(10);
         end loop;

         p_txt_disposed_content := p_txt_disposed_content || chr(10);

         for r_plsql_disposable_contents in c_plsql_disposable_contents loop
            p_txt_disposed_content := p_txt_disposed_content || '-- ' || r_plsql_disposable_contents.txt_generated_function_name || chr(10) ||
                                      '-- SOURCE: "' || r_plsql_disposable_contents.txt_plsql_source || '" ';

            if    r_plsql_disposable_contents.txt_plsql_source = 'FORM TRIGGER' then
               p_txt_disposed_content := p_txt_disposed_content || r_plsql_disposable_contents.txt_plsql_object_name;
            elsif r_plsql_disposable_contents.txt_plsql_source = 'BLOCK TRIGGER' then
               p_txt_disposed_content := p_txt_disposed_content || r_plsql_disposable_contents.txt_block_source ||
                                         '.' || r_plsql_disposable_contents.txt_plsql_object_name;
            elsif r_plsql_disposable_contents.txt_plsql_source = 'BLOCK.ITEM TRIGGER' then
               p_txt_disposed_content := p_txt_disposed_content || r_plsql_disposable_contents.txt_block_source ||
                                         '.' || r_plsql_disposable_contents.txt_block_item_source ||
                                         '.' || r_plsql_disposable_contents.txt_plsql_object_name;
            elsif r_plsql_disposable_contents.txt_plsql_source = 'PROGRAM UNIT' then
               p_txt_disposed_content := p_txt_disposed_content || r_plsql_disposable_contents.txt_plsql_object_name;
            end if;

            p_txt_disposed_content := p_txt_disposed_content || chr(10) || '-- REASON: ' || r_plsql_disposable_contents.txt_disposable_reason || chr(10)
                                                             || r_plsql_disposable_contents.clob_plsql_contents || chr(10);
         end loop;
      end if;

      return p_txt_disposed_content;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_generate_disposa_routines_c;

-- fu_generate_disposa_routines_b
   FUNCTION fu_generate_disposa_routines_b (p_id_form                     M_LOAD_FORM.id%TYPE,
                                            p_txt_disposed_content IN OUT M_LOAD_FORM.txt_disposed_content%TYPE,
                                            p_msg_retorno          IN OUT varchar2)
                                            RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_generate_disposa_routines_b (' || p_id_form || '): ';

   BEGIN
      if p_id_form is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do form deve ser informado.';
         return FALSE;
      else
         p_txt_disposed_content := PKG_IMPORT_FORM.fu_generate_disposa_routines_c (p_id_form);
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_generate_disposa_routines_b;

-- fu_ret_txt_record_groups_spc_b
   FUNCTION fu_ret_txt_record_groups_spc_b (p_id_form                 M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE,
                                            p_txt_record_group IN OUT clob,
                                            p_msg_retorno      IN OUT varchar2)
                                            RETURN boolean IS
      cursor c_record_groups (p_id_form M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE) is
         select distinct
                'RECGRP' as txt_origin,
                mlfrg.txt_record_group_name
           from m_load_form_record_groups mlfrg
          where mlfrg.id_form = p_id_form
          union
         select distinct
                'SQLBLK' as txt_origin,
                mlfbi.txt_block_name as txt_record_group_name
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form                        =  p_id_form
            and mlfbi.txt_item_name                  is     NULL
            and mlfbi.txt_disposable_data_block      =  'N'
            and mlfbi.txt_block_query_data_orig_type =  'FROM_WHERE_CLAUSE'
            and mlfbi.txt_block_query_data_orig_name is     NULL
            and mlfbi.txt_block_query_data_orig_clob is not NULL
          order by 1, 2;

      cursor c_record_group_cols (p_id_form               M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE,
                                  p_txt_record_group_name M_LOAD_FORM_RECORD_GROUPS.txt_record_group_name%TYPE,
                                  p_txt_origin            varchar2) is
         select mlfrg.id,
                mlfrg.txt_record_group_col_name,
                mlfrg.txt_record_group_col_datatype,
                mlfrg.txt_record_group_col_maxsize
           from m_load_form_record_groups mlfrg
          where mlfrg.id_form               = p_id_form
            and mlfrg.txt_record_group_name = p_txt_record_group_name
            and p_txt_origin                = 'RECGRP'
          union
         select mlfbi.id,
                mlfbi.txt_item_name            as txt_record_group_col_name,
                mlfbi.txt_item_field_datatype  as txt_record_group_col_datatype,
                mlfbi.txt_item_field_maxlength as txt_record_group_col_maxsize
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form        =  p_id_form
            and mlfbi.txt_block_name =  p_txt_record_group_name
            and mlfbi.txt_item_name  is not NULL
            and p_txt_origin         =  'SQLBLK'
          order by 1;

      cursor c_record_groups_static (p_id_form M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE) is
         select distinct
                'RADGRP' as txt_origin,
                mlfsv.txt_block_name || '.' || mlfsv.txt_block_item_name as txt_record_group_name
           from m_load_form_static_values mlfsv
          where mlfsv.id_form                    =  p_id_form
            and mlfsv.txt_static_data_origin     =  'BLOCK ITEM STATIC CONTENTS'
            and mlfsv.txt_block_name             is not NULL
            and mlfsv.txt_block_item_name        is not NULL
            and mlfsv.txt_block_item_radbut_name is not NULL
          union
         select distinct
                'LSTVAL' as txt_origin,
                mlfsv.txt_block_name || '.' || mlfsv.txt_block_item_name as txt_record_group_name
           from m_load_form_static_values mlfsv
          where mlfsv.id_form                        =  p_id_form
            and mlfsv.txt_static_data_origin         =  'BLOCK ITEM STATIC CONTENTS'
            and mlfsv.txt_block_name                 is not NULL
            and mlfsv.txt_block_item_name            is not NULL
            and mlfsv.txt_block_item_radbut_name     is     NULL
            and mlfsv.txt_recorg_group_col_val_lst_n is not NULL
            and mlfsv.txt_recorg_group_col_val_lst_v is not NULL
          union
         select distinct
                'STARGV' as txt_origin,
                mlfsv.txt_record_group_name
           from m_load_form_static_values mlfsv
          where mlfsv.id_form                        =  p_id_form
            and mlfsv.txt_static_data_origin         =  'STATIC RECORD GROUP VALUES'
            and mlfsv.txt_block_name                 is     NULL
            and mlfsv.txt_block_item_name            is     NULL
            and mlfsv.txt_block_item_radbut_name     is     NULL
            and mlfsv.txt_recorg_group_col_val_lst_n is not NULL
            and mlfsv.txt_recorg_group_col_val_lst_v is not NULL
          order by 1, 2;

      r_record_groups              c_record_groups%ROWTYPE        := NULL;
      r_record_group_cols          c_record_group_cols%ROWTYPE    := NULL;
      r_record_groups_static       c_record_groups_static%ROWTYPE := NULL;
      p_count_record_group_cols    integer        := NULL;
      p_function_parameter_name    varchar2(100)  := NULL;
      p_function_pipelined         varchar2(100)  := NULL;
      p_function_sysrefcursor      varchar2(100)  := NULL;
      p_package_name               varchar2(100)  := NULL;
      p_piperow_variable_name      varchar2(100)  := NULL;
      p_record_group_name          varchar2(100)  := NULL;
      p_sysrefcursor_variable_name varchar2(100)  := NULL;
      p_table_of_record_group_name varchar2(100)  := NULL;
      p_prc_name                   varchar2(1000) := p_pck_name || 'fu_ret_txt_record_groups_spc_b (' || p_id_form || '):';
      p_txt_form_name              varchar2(1000) := PKG_IMPORT_FORM.fu_obter_nome_form_v (p_id_form);
      p_ret_rec_grp_based_params_v varchar2(4000) := NULL;

   BEGIN
      if p_id_form is not NULL then
         p_package_name     := lower (trim (PKG_IMPORT_FORM.p_package_prefix) || p_txt_form_name);
         p_txt_record_group := '-- RECORD GROUPS ARE RECREATED AS PIPELINED FUNCTIONS SO THEY CAN BE REUSED.' || chr(10);

-- STATIC
         for r_record_groups_static in c_record_groups_static (p_id_form) loop
            p_count_record_group_cols    := 0;
            p_record_group_name          := PKG_IMPORT_FORM.fu_ret_record_group_name_v (r_record_groups_static.txt_record_group_name);
            p_table_of_record_group_name := PKG_IMPORT_FORM.fu_ret_table_rec_group_name_v (r_record_groups_static.txt_record_group_name);
            p_function_sysrefcursor      := PKG_IMPORT_FORM.fu_ret_function_name_sys_ref_v (r_record_groups_static.txt_record_group_name);
            p_function_pipelined         := PKG_IMPORT_FORM.fu_ret_function_name_pipelin_v (r_record_groups_static.txt_record_group_name);
            p_sysrefcursor_variable_name := PKG_IMPORT_FORM.fu_sys_refcursor_variable_v (r_record_groups_static.txt_record_group_name);
            p_piperow_variable_name      := PKG_IMPORT_FORM.fu_ret_piperow_variable_v (r_record_groups_static.txt_record_group_name);

            p_txt_record_group := p_txt_record_group || '-- SOURCE: ';

            if    r_record_groups_static.txt_origin = 'RECGRP' then
               p_txt_record_group := p_txt_record_group || 'RECORD GROUP';
            elsif r_record_groups_static.txt_origin = 'SQLBLK' then
               p_txt_record_group := p_txt_record_group || 'SQL DATA BLOCK';
            elsif r_record_groups_static.txt_origin = 'RADGRP' then
               p_txt_record_group := p_txt_record_group || 'RADIO GROUP';
            elsif r_record_groups_static.txt_origin = 'LSTVAL' then
               p_txt_record_group := p_txt_record_group || 'LIST OF VALUES';
            elsif r_record_groups_static.txt_origin = 'STARGV' then
               p_txt_record_group := p_txt_record_group || 'STATIC RECORD GROUP VALUES';
            end if;

            p_txt_record_group := p_txt_record_group || ' "' || upper (r_record_groups_static.txt_record_group_name) || '"' || chr(10)
                                                     || chr(10) || p_indent || 'type ' || p_record_group_name || ' is record (';

            if r_record_groups_static.txt_origin in ('RADGRP', 'LSTVAL', 'STARGV') then
               p_txt_record_group := p_txt_record_group || rpad (lower ('display_value'), PKG_IMPORT_FORM.p_oracle_objects_size, ' ') || ' varchar2(4000)' || chr(10)
                                                        || p_indent ||
                                                           lpad (' ',
                                                                 length ('type ' || p_record_group_name || ' is record (') - length (', '),
                                                                 ' ')
                                                        || ', ' || rpad (lower ('return_value'), PKG_IMPORT_FORM.p_oracle_objects_size, ' ') || ' varchar2(4000)';
            end if;

            p_txt_record_group := p_txt_record_group || ');' || chr(10) || chr(10) ||
                                  p_indent ||
                                  'type ' || p_table_of_record_group_name ||
                                  ' is table of ' || p_record_group_name ||
                                  ';' || chr(10) || chr(10) ||
                                  '-- ' || p_function_sysrefcursor || chr(10) ||
                                  p_indent || 'FUNCTION ' || p_function_sysrefcursor || ' (';

            if r_record_groups_static.txt_origin in ('RADGRP', 'LSTVAL', 'STARGV') then
               p_txt_record_group := p_txt_record_group || rpad ('p_display_value', p_oracle_objects_size, ' ') || ' varchar2 default NULL' || chr(10) ||
                                                           lpad (', ',
                                                              length (p_indent
                                                                      || 'FUNCTION '
                                                                      || p_function_sysrefcursor
                                                                      || ' ('),
                                                              ' ') || rpad ('p_return_value', p_oracle_objects_size, ' ') || ' varchar2 default NULL' || chr(10);
            end if;

            p_txt_record_group := p_txt_record_group ||
                                  lpad (', ',
                                        length (p_indent
                                                || 'FUNCTION '
                                                || p_function_sysrefcursor
                                                || ' ('),
                                        ' ') || rpad (p_retorno_v, p_oracle_objects_size, ' ') || ' IN OUT boolean' || chr(10) ||
                                  lpad (', ',
                                        length (p_indent
                                                || 'FUNCTION '
                                                || p_function_sysrefcursor
                                                || ' ('),
                                        ' ') || rpad (p_msg_retorno_v, p_oracle_objects_size, ' ') || ' IN OUT varchar2)' || chr(10) ||
                                  lpad (' ',
                                        length (p_indent
                                                || 'FUNCTION '
                                                || p_function_sysrefcursor
                                                || ' ('),
                                        ' ') || 'RETURN sys_refcursor;' || chr(10) || chr(10) ||
                                  '-- select * from table (' || p_package_name || '.' || p_function_pipelined || ')' || chr(10) ||
                                  '-- ' || p_function_pipelined || chr(10) ||
                                  p_indent || 'FUNCTION ' || p_function_pipelined || ' (';

            if r_record_groups_static.txt_origin in ('RADGRP', 'LSTVAL', 'STARGV') then
               p_txt_record_group := p_txt_record_group || rpad ('p_display_value', p_oracle_objects_size, ' ') || ' varchar2 default NULL' || chr(10) ||
                                                           lpad (', ',
                                                              length (p_indent
                                                                      || 'FUNCTION '
                                                                      || p_function_sysrefcursor
                                                                      || ' ('),
                                                              ' ') || rpad ('p_return_value', p_oracle_objects_size, ' ') || ' varchar2 default NULL' || chr(10);
            end if;

            p_txt_record_group := p_txt_record_group ||
                                  lpad (' ',
                                        length (p_indent
                                                || 'FUNCTION '
                                                || p_function_pipelined),
                                        ' ') ||
                                  ') RETURN ' || p_table_of_record_group_name || ' PIPELINED;' || chr(10) || chr(10);
         end loop;

-- DYNAMIC
         for r_record_groups in c_record_groups (p_id_form) loop
            p_count_record_group_cols    := 0;
            p_record_group_name          := PKG_IMPORT_FORM.fu_ret_record_group_name_v (r_record_groups.txt_record_group_name);
            p_table_of_record_group_name := PKG_IMPORT_FORM.fu_ret_table_rec_group_name_v (r_record_groups.txt_record_group_name);
            p_function_sysrefcursor      := PKG_IMPORT_FORM.fu_ret_function_name_sys_ref_v (r_record_groups.txt_record_group_name);
            p_function_pipelined         := PKG_IMPORT_FORM.fu_ret_function_name_pipelin_v (r_record_groups.txt_record_group_name);
            p_sysrefcursor_variable_name := PKG_IMPORT_FORM.fu_sys_refcursor_variable_v (r_record_groups.txt_record_group_name);
            p_piperow_variable_name      := PKG_IMPORT_FORM.fu_ret_piperow_variable_v (r_record_groups.txt_record_group_name);

            p_txt_record_group := p_txt_record_group || '-- SOURCE: ';

            if    r_record_groups.txt_origin = 'RECGRP' then
               p_txt_record_group := p_txt_record_group || 'RECORD GROUP';
            elsif r_record_groups.txt_origin = 'SQLBLK' then
               p_txt_record_group := p_txt_record_group || 'SQL DATA BLOCK';
            elsif r_record_groups.txt_origin = 'RADGRP' then
               p_txt_record_group := p_txt_record_group || 'RADIO GROUP';
            elsif r_record_groups.txt_origin = 'LSTVAL' then
               p_txt_record_group := p_txt_record_group || 'LIST OF VALUES';
            elsif r_record_groups.txt_origin = 'STARGV' then
               p_txt_record_group := p_txt_record_group || 'STATIC RECORD GROUP VALUES';
            end if;

            p_txt_record_group := p_txt_record_group || ' "' || upper (r_record_groups.txt_record_group_name) || '"' || chr(10);

            if r_record_groups.txt_origin = 'RECGRP' then
               p_txt_record_group := p_txt_record_group || PKG_IMPORT_FORM.fu_ret_rec_group_related_lov_v (p_id_form, r_record_groups.txt_record_group_name);
            end if;

            p_txt_record_group := p_txt_record_group || chr(10) || p_indent || 'type ' || p_record_group_name || ' is record (';

            if r_record_groups.txt_origin in ('RECGRP', 'SQLBLK') then
               for r_record_group_cols in c_record_group_cols (p_id_form, r_record_groups.txt_record_group_name, r_record_groups.txt_origin) loop
                  p_count_record_group_cols := p_count_record_group_cols + 1;

                  if p_count_record_group_cols = 1 then
                     p_txt_record_group := p_txt_record_group || rpad (lower (r_record_group_cols.txt_record_group_col_name), PKG_IMPORT_FORM.p_oracle_objects_size, ' ');
                  else
                     p_txt_record_group := p_txt_record_group || p_indent ||
                                                                 lpad (' ',
                                                                       length ('type ' || p_record_group_name || ' is record (') - length (', '),
                                                                       ' ')
                                                              || ', ' || rpad (lower (r_record_group_cols.txt_record_group_col_name), PKG_IMPORT_FORM.p_oracle_objects_size, ' ');
                  end if;

                  p_txt_record_group := p_txt_record_group || ' ' || lower (r_record_group_cols.txt_record_group_col_datatype);

                  if r_record_group_cols.txt_record_group_col_datatype != 'DATE' then
                     p_txt_record_group := p_txt_record_group || '(' || r_record_group_cols.txt_record_group_col_maxsize || ')';
                  end if;

                  p_txt_record_group := p_txt_record_group || chr(10);
               end loop;
            end if;

            p_txt_record_group := p_txt_record_group || ');' || chr(10) || chr(10) ||
                                  p_indent ||
                                  'type ' || p_table_of_record_group_name ||
                                  ' is table of ' || p_record_group_name ||
                                  ';' || chr(10) || chr(10) ||
                                  '-- ' || p_function_sysrefcursor || chr(10) ||
                                  p_indent || 'FUNCTION ' || p_function_sysrefcursor || ' (';

            if r_record_groups.txt_origin in ('RECGRP', 'SQLBLK') then
               p_ret_rec_grp_based_params_v := PKG_IMPORT_FORM.fu_ret_rec_grp_based_params_v (p_id_form,
                                                                                              r_record_groups.txt_record_group_name,
                                                                                              r_record_groups.txt_origin);
            end if;

            if trim (p_ret_rec_grp_based_params_v) is not NULL then
               p_txt_record_group := p_txt_record_group || p_ret_rec_grp_based_params_v;
            end if;

            p_txt_record_group := p_txt_record_group ||
                                  lpad (', ',
                                        length (p_indent
                                                || 'FUNCTION '
                                                || p_function_sysrefcursor
                                                || ' ('),
                                        ' ') || rpad (p_retorno_v, p_oracle_objects_size, ' ') || ' IN OUT boolean' || chr(10) ||
                                  lpad (', ',
                                        length (p_indent
                                                || 'FUNCTION '
                                                || p_function_sysrefcursor
                                                || ' ('),
                                        ' ') || rpad (p_msg_retorno_v, p_oracle_objects_size, ' ') || ' IN OUT varchar2)' || chr(10) ||
                                  lpad (' ',
                                        length (p_indent
                                                || 'FUNCTION '
                                                || p_function_sysrefcursor
                                                || ' ('),
                                        ' ') || 'RETURN sys_refcursor;' || chr(10) || chr(10) ||
                                  '-- select * from table (' || p_package_name || '.' || p_function_pipelined || ')' || chr(10) ||
                                  '-- ' || p_function_pipelined || chr(10) ||
                                  p_indent || 'FUNCTION ' || p_function_pipelined || ' (';

            if r_record_groups.txt_origin in ('RECGRP', 'SQLBLK') then
               p_ret_rec_grp_based_params_v := PKG_IMPORT_FORM.fu_ret_rec_grp_based_params_v (p_id_form,
                                                                                              r_record_groups.txt_record_group_name,
                                                                                              r_record_groups.txt_origin);
            end if;

            if trim (p_ret_rec_grp_based_params_v) is not NULL then
               p_txt_record_group := p_txt_record_group || p_ret_rec_grp_based_params_v;
            end if;

            p_txt_record_group := p_txt_record_group ||
                                  lpad (' ',
                                        length (p_indent
                                                || 'FUNCTION '
                                                || p_function_pipelined),
                                        ' ') ||
                                  ') RETURN ' || p_table_of_record_group_name || ' PIPELINED;' || chr(10) || chr(10);
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Error "' || p_record_group_name || '" ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_txt_record_groups_spc_b;

-- fu_ret_txt_record_groups_spc_c
   FUNCTION fu_ret_txt_record_groups_spc_c (p_id_form M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE)
                                            RETURN clob IS
      p_retorno          boolean        := NULL;
      p_txt_record_group clob           := NULL;
      p_prc_name         varchar2(1000) := p_pck_name || 'fu_ret_txt_record_groups_spc_c (' || p_id_form || '):';
      p_msg_retorno      varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_txt_record_groups_spc_b (p_id_form, p_txt_record_group, p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_record_group;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_txt_record_groups_spc_c;

-- fu_ret_txt_record_groups_bdy_b
   FUNCTION fu_ret_txt_record_groups_bdy_b (p_id_form                 M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE,
                                            p_txt_record_group IN OUT clob,
                                            p_msg_retorno      IN OUT varchar2)
                                            RETURN boolean IS
      cursor c_record_groups_static (p_id_form M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE) is
         select distinct
                'RADGRP' as txt_origin,
                mlfsv.txt_block_name || '.' || mlfsv.txt_block_item_name as txt_record_group_name
           from m_load_form_static_values mlfsv
          where mlfsv.id_form                    =  p_id_form
            and mlfsv.txt_static_data_origin     =  'BLOCK ITEM STATIC CONTENTS'
            and mlfsv.txt_block_name             is not NULL
            and mlfsv.txt_block_item_name        is not NULL
            and mlfsv.txt_block_item_radbut_name is not NULL
          union
         select distinct
                'LSTVAL' as txt_origin,
                mlfsv.txt_block_name || '.' || mlfsv.txt_block_item_name as txt_record_group_name
           from m_load_form_static_values mlfsv
          where mlfsv.id_form                        =  p_id_form
            and mlfsv.txt_static_data_origin         =  'BLOCK ITEM STATIC CONTENTS'
            and mlfsv.txt_block_name                 is not NULL
            and mlfsv.txt_block_item_name            is not NULL
            and mlfsv.txt_block_item_radbut_name     is     NULL
            and mlfsv.txt_recorg_group_col_val_lst_n is not NULL
            and mlfsv.txt_recorg_group_col_val_lst_v is not NULL
          union
         select distinct
                'STARGV' as txt_origin,
                mlfsv.txt_record_group_name
           from m_load_form_static_values mlfsv
          where mlfsv.id_form                        =  p_id_form
            and mlfsv.txt_static_data_origin         =  'STATIC RECORD GROUP VALUES'
            and mlfsv.txt_block_name                 is     NULL
            and mlfsv.txt_block_item_name            is     NULL
            and mlfsv.txt_block_item_radbut_name     is     NULL
            and mlfsv.txt_recorg_group_col_val_lst_n is not NULL
            and mlfsv.txt_recorg_group_col_val_lst_v is not NULL
          order by 1, 2;

      cursor c_record_groups_static_cols (p_id_form               M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE,
                                          p_txt_record_group_name varchar2,
                                          p_txt_origin            varchar2) is
         select mlfsv.txt_block_item_radbut_label as txt_display_value,
                mlfsv.txt_block_item_radbut_value as txt_return_value
           from m_load_form_static_values mlfsv
          where mlfsv.id_form                    =  p_id_form
            and mlfsv.txt_block_name || '.' || mlfsv.txt_block_item_name = p_txt_record_group_name
            and p_txt_origin                     =  'RADGRP'
            and mlfsv.txt_static_data_origin     =  'BLOCK ITEM STATIC CONTENTS'
            and mlfsv.txt_block_name             is not NULL
            and mlfsv.txt_block_item_name        is not NULL
            and mlfsv.txt_block_item_radbut_name is not NULL
          union
         select mlfsv.txt_recorg_group_col_val_lst_n as txt_display_value,
                mlfsv.txt_recorg_group_col_val_lst_v as txt_return_value
           from m_load_form_static_values mlfsv
          where mlfsv.id_form                        =  p_id_form
            and mlfsv.txt_block_name || '.' || mlfsv.txt_block_item_name = p_txt_record_group_name
            and p_txt_origin                         =  'LSTVAL'
            and mlfsv.txt_static_data_origin         =  'BLOCK ITEM STATIC CONTENTS'
            and mlfsv.txt_block_name                 is not NULL
            and mlfsv.txt_block_item_name            is not NULL
            and mlfsv.txt_block_item_radbut_name     is     NULL
            and mlfsv.txt_recorg_group_col_val_lst_n is not NULL
            and mlfsv.txt_recorg_group_col_val_lst_v is not NULL
          union
         select mlfsv.txt_recorg_group_col_val_lst_n as txt_display_value,
                mlfsv.txt_recorg_group_col_val_lst_v as txt_return_value
           from m_load_form_static_values mlfsv
          where mlfsv.id_form                        =  p_id_form
            and mlfsv.txt_record_group_name          =  p_txt_record_group_name
            and p_txt_origin                         =  'STARGV'
            and mlfsv.txt_static_data_origin         =  'STATIC RECORD GROUP VALUES'
            and mlfsv.txt_block_name                 is     NULL
            and mlfsv.txt_block_item_name            is     NULL
            and mlfsv.txt_block_item_radbut_name     is     NULL
            and mlfsv.txt_recorg_group_col_val_lst_n is not NULL
            and mlfsv.txt_recorg_group_col_val_lst_v is not NULL;

      cursor c_record_groups (p_id_form M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE) is
         select distinct
                'RECGRP' as txt_origin,
                mlfrg.txt_record_group_name
           from m_load_form_record_groups mlfrg
          where mlfrg.id_form = p_id_form
          union
         select distinct
                'SQLBLK' as txt_origin,
                mlfbi.txt_block_name
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form                         = p_id_form
            and mlfbi.txt_item_name                  is NULL
            and mlfbi.txt_disposable_data_block       = 'N'
            and mlfbi.txt_block_query_data_orig_type  = 'FROM_WHERE_CLAUSE'
            and mlfbi.txt_block_query_data_orig_name is NULL
            and mlfbi.txt_block_query_data_orig_clob is not NULL
          order by 1, 2;

      cursor c_record_group_cols (p_id_form               M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE,
                                  p_txt_record_group_name M_LOAD_FORM_RECORD_GROUPS.txt_record_group_name%TYPE,
                                  p_txt_origin            varchar2) is
         select mlfrg.id,
                mlfrg.txt_record_group_col_name,
                mlfrg.txt_record_group_col_datatype,
                mlfrg.txt_record_group_col_maxsize
           from m_load_form_record_groups mlfrg
          where mlfrg.id_form               = p_id_form
            and mlfrg.txt_record_group_name = p_txt_record_group_name
            and p_txt_origin                = 'RECGRP'
          union
         select mlfbi.id,
                mlfbi.txt_item_name            as txt_record_group_col_name,
                mlfbi.txt_item_field_datatype  as txt_record_group_col_datatype,
                mlfbi.txt_item_field_maxlength as txt_record_group_col_maxsize
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form        =  p_id_form
            and mlfbi.txt_block_name =  p_txt_record_group_name
            and mlfbi.txt_item_name  is not NULL
            and p_txt_origin         =  'SQLBLK'
          order by 1;

      cursor c_m_load_form_glob_syst_parm (p_id_form           M_LOAD_FORM_GLOB_SYST_PARM.id_form%TYPE,
                                           p_txt_variable_type M_LOAD_FORM_GLOB_SYST_PARM.txt_variable_type%TYPE default NULL) is
         select mlfgsp.*
           from m_load_form_glob_syst_parm mlfgsp
          where mlfgsp.id_form           = nvl (p_id_form,           mlfgsp.id_form)
            and mlfgsp.txt_variable_type = nvl (p_txt_variable_type, mlfgsp.txt_variable_type)
          order by mlfgsp.id_form,
                   mlfgsp.txt_variable_type,
                   mlfgsp.txt_variable_name;

      cursor c_m_load_form_blocks_items (p_id_form M_LOAD_FORM_BLOCKS_ITEMS.id_form%TYPE) is
         select mlfbi.*
           from m_load_form_blocks_items mlfbi
          where mlfbi.id_form         = p_id_form
            and mlfbi.txt_data_origin = 'BLOCKS AND ITEMS'
            and mlfbi.txt_block_name  is not NULL
            and mlfbi.txt_item_name   is not NULL;

      r_m_load_form_blocks_items   c_m_load_form_blocks_items%ROWTYPE   := NULL;
      r_m_load_form_glob_syst_parm c_m_load_form_glob_syst_parm%ROWTYPE := NULL;
      r_record_groups              c_record_groups%ROWTYPE              := NULL;
      r_record_group_cols          c_record_group_cols%ROWTYPE          := NULL;
      r_record_groups_static       c_record_groups_static%ROWTYPE       := NULL;
      r_record_groups_static_cols  c_record_groups_static_cols%ROWTYPE  := NULL;
      p_clob_sql_query_no_comm     M_LOAD_FORM_RECORD_GROUPS.clob_sql_query_no_comm%TYPE := empty_clob();
      p_count_record_group_cols    integer        := NULL;
      p_pattern_char               varchar2(1)    := NULL;
      p_function_parameter_name    varchar2(100)  := NULL;
      p_function_pipelined         varchar2(100)  := NULL;
      p_function_sysrefcursor      varchar2(100)  := NULL;
      p_piperow_variable_name      varchar2(100)  := NULL;
      p_record_group_name          varchar2(100)  := NULL;
      p_sysrefcursor_variable_name varchar2(100)  := NULL;
      p_table_of_record_group_name varchar2(100)  := NULL;
      p_prc_name                   varchar2(1000) := p_pck_name || 'fu_ret_txt_record_groups_bdy_b (' || p_id_form || '):';
      p_txt_form_name              varchar2(1000) := PKG_IMPORT_FORM.fu_obter_nome_form_v (p_id_form);
	  p_parameter_list             varchar2(4000) := NULL;

   BEGIN
      p_txt_record_group := empty_clob();

      if p_id_form is not NULL then
-- STATIC
         for r_record_groups_static in c_record_groups_static (p_id_form) loop
            p_count_record_group_cols    := 0;
            p_record_group_name          := PKG_IMPORT_FORM.fu_ret_record_group_name_v (r_record_groups_static.txt_record_group_name);
            p_table_of_record_group_name := PKG_IMPORT_FORM.fu_ret_table_rec_group_name_v (r_record_groups_static.txt_record_group_name);
            p_function_sysrefcursor      := PKG_IMPORT_FORM.fu_ret_function_name_sys_ref_v (r_record_groups_static.txt_record_group_name);
            p_function_pipelined         := PKG_IMPORT_FORM.fu_ret_function_name_pipelin_v (r_record_groups_static.txt_record_group_name);
            p_sysrefcursor_variable_name := PKG_IMPORT_FORM.fu_sys_refcursor_variable_v (r_record_groups_static.txt_record_group_name);
            p_piperow_variable_name      := PKG_IMPORT_FORM.fu_ret_piperow_variable_v (r_record_groups_static.txt_record_group_name);

            p_txt_record_group           := p_txt_record_group || '-- SOURCE: ';

            if    r_record_groups_static.txt_origin = 'RECGRP' then
               p_txt_record_group := p_txt_record_group || 'RECORD GROUP';
            elsif r_record_groups_static.txt_origin = 'SQLBLK' then
               p_txt_record_group := p_txt_record_group || 'SQL DATA BLOCK';
            elsif r_record_groups_static.txt_origin = 'RADGRP' then
               p_txt_record_group := p_txt_record_group || 'RADIO GROUP';
            elsif r_record_groups_static.txt_origin = 'LSTVAL' then
               p_txt_record_group := p_txt_record_group || 'LIST OF VALUES';
            elsif r_record_groups_static.txt_origin = 'STARGV' then
               p_txt_record_group := p_txt_record_group || 'STATIC RECORD GROUP VALUES';
            end if;

            p_txt_record_group := p_txt_record_group || ' "' || upper (r_record_groups_static.txt_record_group_name) || '"' || chr(10) ||
                                  '-- ' || p_function_sysrefcursor || chr(10) ||
                                  p_indent || 'FUNCTION ' || p_function_sysrefcursor || ' (';

            if r_record_groups_static.txt_origin in ('RADGRP', 'LSTVAL', 'STARGV') then
               p_txt_record_group := p_txt_record_group || rpad ('p_display_value', p_oracle_objects_size, ' ') || ' varchar2 default NULL' || chr(10) ||
                                                           lpad (', ',
                                                              length (p_indent
                                                                      || 'FUNCTION '
                                                                      || p_function_sysrefcursor
                                                                      || ' ('),
                                                              ' ') || rpad ('p_return_value', p_oracle_objects_size, ' ') || ' varchar2 default NULL' || chr(10);
            end if;

            p_txt_record_group := p_txt_record_group || lpad (', ',
                                                              length (p_indent
                                                                      || 'FUNCTION '
                                                                      || p_function_sysrefcursor
                                                                      || ' ('),
                                                              ' ') || rpad (p_retorno_v, p_oracle_objects_size, ' ') || ' IN OUT boolean' || chr(10) ||
                                                        lpad (', ',
                                                              length (p_indent
                                                                      || 'FUNCTION '
                                                                      || p_function_sysrefcursor
                                                                      || ' ('),
                                                              ' ') || rpad (p_msg_retorno_v, p_oracle_objects_size, ' ') || ' IN OUT varchar2)' || chr(10) ||
                                                        lpad (' ',
                                                              length (p_indent
                                                                      || 'FUNCTION '
                                                                      || p_function_sysrefcursor
                                                                      || ' ('),
                                                              ' ') || 'RETURN sys_refcursor IS' || chr(10) ||
                                                        p_indent || p_indent || p_sysrefcursor_variable_name || ' sys_refcursor;' || chr(10) ||
                                                        p_indent || p_indent || p_prc_name_v || ' varchar2(4000) := ' || p_pck_name_v ||
                                                        ' || ''' || p_function_sysrefcursor || ': '';' || chr(10) || chr(10) ||
                                                        p_indent || 'BEGIN' || chr(10) ||
                                                        p_indent || p_indent || 'open ' || p_sysrefcursor_variable_name || ' for' || chr(10) ||
                                                        p_indent || p_indent || p_indent || 'select t.display_value' || chr(10) ||
                                                        p_indent || p_indent || p_indent || '     , t.return_value' || chr(10) ||
                                                        p_indent || p_indent || p_indent || '  from (' || chr(10);

            for r_record_groups_static_cols in c_record_groups_static_cols (p_id_form,
                                                                            r_record_groups_static.txt_record_group_name,
                                                                            r_record_groups_static.txt_origin) loop
               if p_count_record_group_cols > 0 then
                  p_txt_record_group := p_txt_record_group || ' union' || chr(10);
               end if;

               p_count_record_group_cols := p_count_record_group_cols + 1;
               p_txt_record_group        := p_txt_record_group ||
                                            p_indent || p_indent || p_indent || p_indent || p_indent ||
                                            '  select ''' || r_record_groups_static_cols.txt_display_value || ''' as display_value,' ||
                                                    ' ''' || r_record_groups_static_cols.txt_return_value  || ''' as return_value' ||
                                               ' from dual';
            end loop;

            p_txt_record_group := p_txt_record_group || ') t' || chr(10) ||
                                                        p_indent || p_indent || p_indent || ' where t.display_value = nvl (p_display_value, t.display_value)' || chr(10) ||
                                                        p_indent || p_indent || p_indent || '   and t.return_value  = nvl (p_return_value,  t.return_value);' || chr(10) ||
                                                        chr(10) ||
                                                        p_indent || p_indent || p_retorno_v || ' := TRUE;' || chr(10) ||
                                                        p_indent || p_indent || p_msg_retorno_v || ' := NULL;' || chr(10) ||
                                                        p_indent || p_indent || 'return ' || p_sysrefcursor_variable_name || ';' || chr(10) || chr(10) ||
                                                        p_indent || 'EXCEPTION' || chr(10) ||
                                                        p_indent || p_indent || 'when others then' || chr(10) ||
                                                        p_indent || p_indent || p_indent || p_retorno_v || ' := FALSE;' || chr(10) ||
                                                        p_indent || p_indent || p_indent || p_msg_retorno_v || ' := ''' || p_error_text_v ||
                                                        ' '' || ' || p_prc_name_v || ' || to_char (sqlcode) || '' - '' || sqlerrm;' || chr(10) ||
                                                        p_indent || p_indent || p_indent || 'return NULL;' || chr(10) ||
                                                        p_indent || 'END ' || p_function_sysrefcursor || ';' || chr(10) || chr(10) ||
                                                        '-- ' || p_function_pipelined || chr(10) ||
                                                        p_indent || 'FUNCTION ' || p_function_pipelined || ' (' ||
                                                        rpad ('p_display_value', p_oracle_objects_size, ' ') || ' varchar2 default NULL' || chr(10) ||
                                                        lpad (', ',
                                                           length (p_indent
                                                                   || 'FUNCTION '
                                                                   || p_function_sysrefcursor
                                                                   || ' ('),
                                                           ' ') || rpad ('p_return_value', p_oracle_objects_size, ' ') || ' varchar2 default NULL' || chr(10) ||
                                                        lpad (' ',
                                                              length (p_indent
                                                                      || 'FUNCTION '
                                                                      || p_function_sysrefcursor
                                                                      || ' ('),
                                                              ' ') ||
                                                        ') RETURN ' || p_table_of_record_group_name || ' PIPELINED IS' || chr(10) ||
                                                        p_indent || p_indent || p_retorno_v || ' boolean := NULL;' || chr(10) ||
                                                        p_indent || p_indent || p_msg_retorno_v || ' varchar2(4000) := NULL;' || chr(10) ||
                                                        p_indent || p_indent || p_prc_name_v || ' varchar2(4000) := ' || p_pck_name_v ||
                                                        ' || ''' || p_function_pipelined || ': '';' || chr(10) ||
                                                        p_indent || p_indent || p_sysrefcursor_variable_name || ' sys_refcursor;' || chr(10) ||
                                                        p_indent || p_indent || p_piperow_variable_name || ' ' || p_record_group_name || ';' || chr(10) || chr(10) ||
                                                        p_indent || 'BEGIN' || chr(10) ||
                                                        p_indent || p_indent || p_sysrefcursor_variable_name
                                                        || ' := ' || upper (p_package_prefix || p_txt_form_name)
                                                        || '.' || p_function_sysrefcursor || ' (' ||
                                                        'p_display_value => p_display_value' || chr(10) ||
                                                        lpad (', ',
                                                              length (p_indent
                                                                      || p_indent
                                                                      || p_sysrefcursor_variable_name
                                                                      || ' := '
                                                                      || upper (p_package_prefix || p_txt_form_name)
                                                                      || '.'
                                                                      || p_function_sysrefcursor
                                                                      || ' ('),
                                                              ' ') || 'p_return_value => p_return_value' ||
                                                        chr(10) ||
                                                        lpad (', ',
                                                              length (p_indent
                                                                      || p_indent
                                                                      || p_sysrefcursor_variable_name
                                                                      || ' := '
                                                                      || upper (p_package_prefix || p_txt_form_name)
                                                                      || '.'
                                                                      || p_function_sysrefcursor
                                                                      || ' ('),
                                                              ' ') || p_retorno_v || ' => ' || p_retorno_v || chr(10) ||
                                                        lpad (', ',
                                                              length (p_indent
                                                                      || p_indent
                                                                      || p_sysrefcursor_variable_name
                                                                      || ' := '
                                                                      || upper (p_package_prefix || p_txt_form_name)
                                                                      || '.'
                                                                      || p_function_sysrefcursor
                                                                      || ' ('),
                                                              ' ') || p_msg_retorno_v || ' => ' || p_msg_retorno_v || ');' || chr(10) || chr(10) ||
                                                        p_indent || p_indent || 'if p_return = TRUE then' || chr(10) ||
                                                        p_indent || p_indent || p_indent || 'loop' || chr(10) ||
                                                        p_indent || p_indent || p_indent || p_indent || 'BEGIN' || chr(10) ||
                                                        p_indent || p_indent || p_indent || p_indent || p_indent || 'fetch ' ||
                                                        p_sysrefcursor_variable_name || ' into ' || p_piperow_variable_name || ';' || chr(10) ||
                                                        p_indent || p_indent || p_indent || p_indent || p_indent || 'exit when ' ||
                                                        p_sysrefcursor_variable_name || '%NOTFOUND;' || chr(10) ||
                                                        p_indent || p_indent || p_indent || p_indent || p_indent || 'pipe row (' ||
                                                        p_piperow_variable_name || ');' || chr(10) || chr(10) ||
                                                        p_indent || p_indent || p_indent || p_indent || 'EXCEPTION' || chr(10) ||
                                                        p_indent || p_indent || p_indent || p_indent || p_indent || 'when no_data_needed then' || chr(10) ||
                                                        p_indent || p_indent || p_indent || p_indent || p_indent || p_indent || 'close ' ||
                                                        p_sysrefcursor_variable_name || ';' || chr(10) ||
                                                        p_indent || p_indent || p_indent || p_indent || p_indent || p_indent || 'return;' || chr(10) ||
                                                        p_indent || p_indent || p_indent || p_indent || p_indent || 'when others then' || chr(10) ||
                                                        p_indent || p_indent || p_indent || p_indent || p_indent || p_indent || 'close ' ||
                                                        p_sysrefcursor_variable_name || ';' || chr(10) ||
                                                        p_indent || p_indent || p_indent || p_indent || p_indent || p_indent ||
                                                        'raise_application_error (-20002, ''Error PIPE ROW '' || ' || p_prc_name_v ||
                                                        ' || to_char (sqlcode) || '' - '' || sqlerrm);' || chr(10) ||
                                                        p_indent || p_indent || p_indent || p_indent || 'END;' || chr(10) ||
                                                        p_indent || p_indent || p_indent || 'end loop;' || chr(10) ||
                                                        p_indent || p_indent || 'else' || chr(10) ||
                                                        p_indent || p_indent || p_indent || 'raise_application_error (-20001, ''Error ' ||
                                                        upper (p_retorno_v) || ' '' || ' || p_prc_name_v || ' || ' || p_msg_retorno_v || ');' || chr(10) ||
                                                        p_indent || p_indent || 'end if;' || chr(10) || chr(10) ||
                                                        p_indent || 'EXCEPTION' || chr(10) ||
                                                        p_indent || p_indent || 'when others then' || chr(10) ||
                                                        p_indent || p_indent || p_indent || 'raise_application_error (-20000, ''Error '' || ' ||
                                                        p_prc_name_v ||
                                                        ' || to_char (sqlcode) || '' - '' || sqlerrm);' || chr(10) ||
                                                        p_indent || 'END ' || p_function_pipelined || ';' || chr(10) || chr(10);
         end loop;

-- DYNAMIC
         for r_record_groups in c_record_groups (p_id_form) loop
            p_record_group_name          := PKG_IMPORT_FORM.fu_ret_record_group_name_v (r_record_groups.txt_record_group_name);
            p_table_of_record_group_name := PKG_IMPORT_FORM.fu_ret_table_rec_group_name_v (r_record_groups.txt_record_group_name);
            p_function_sysrefcursor      := PKG_IMPORT_FORM.fu_ret_function_name_sys_ref_v (r_record_groups.txt_record_group_name);
            p_function_pipelined         := PKG_IMPORT_FORM.fu_ret_function_name_pipelin_v (r_record_groups.txt_record_group_name);
            p_sysrefcursor_variable_name := PKG_IMPORT_FORM.fu_sys_refcursor_variable_v (r_record_groups.txt_record_group_name);
            p_piperow_variable_name      := PKG_IMPORT_FORM.fu_ret_piperow_variable_v (r_record_groups.txt_record_group_name);

            p_txt_record_group           := p_txt_record_group || '-- SOURCE: ';

            if    r_record_groups.txt_origin = 'RECGRP' then
               p_txt_record_group := p_txt_record_group || 'RECORD GROUP';
            elsif r_record_groups.txt_origin = 'SQLBLK' then
               p_txt_record_group := p_txt_record_group || 'SQL DATA BLOCK';
            elsif r_record_groups.txt_origin = 'RADGRP' then
               p_txt_record_group := p_txt_record_group || 'RADIO GROUP';
            elsif r_record_groups.txt_origin = 'LSTVAL' then
               p_txt_record_group := p_txt_record_group || 'LIST OF VALUES';
            elsif r_record_groups.txt_origin = 'STARGV' then
               p_txt_record_group := p_txt_record_group || 'STATIC RECORD GROUP VALUES';
            end if;

            p_txt_record_group           := p_txt_record_group || ' "' || upper (r_record_groups.txt_record_group_name) || '"' || chr(10) ||
                                            '-- ' || p_function_sysrefcursor || chr(10) ||
                                            p_indent || 'FUNCTION ' || p_function_sysrefcursor || ' (' ||
                                            PKG_IMPORT_FORM.fu_ret_rec_grp_based_params_v (p_id_form, r_record_groups.txt_record_group_name, r_record_groups.txt_origin) ||
                                            lpad (', ',
                                                  length (p_indent
                                                          || 'FUNCTION '
                                                          || p_function_sysrefcursor
                                                          || ' ('),
                                                  ' ') || rpad (p_retorno_v, p_oracle_objects_size, ' ') || ' IN OUT boolean' || chr(10) ||
                                            lpad (', ',
                                                  length (p_indent
                                                          || 'FUNCTION '
                                                          || p_function_sysrefcursor
                                                          || ' ('),
                                                  ' ') || rpad (p_msg_retorno_v, p_oracle_objects_size, ' ') || ' IN OUT varchar2)' || chr(10) ||
                                            lpad (' ',
                                                  length (p_indent
                                                          || 'FUNCTION '
                                                          || p_function_sysrefcursor
                                                          || ' ('),
                                                  ' ') || 'RETURN sys_refcursor IS' || chr(10) ||
                                            p_indent || p_indent || p_sysrefcursor_variable_name || ' sys_refcursor;' || chr(10) ||
                                            p_indent || p_indent || p_prc_name_v || ' varchar2(4000) := ' || p_pck_name_v ||
                                            ' || ''' || p_function_sysrefcursor || ' (''' ||
                                            PKG_IMPORT_FORM.fu_ret_rec_grp_function_parm_v (p_id_form, r_record_groups.txt_record_group_name, r_record_groups.txt_origin) ||
                                            lpad ('|| ''): '';',
                                                  length (p_indent
                                                          || p_indent
                                                          || p_prc_name_v
                                                          || ' varchar2(4000) := '
                                                          || p_pck_name_v
                                                          || ' || '''
                                                          || p_function_sysrefcursor
                                                          || ' ('''
                                                          || '  '),
                                                  ' ') || chr(10) || chr(10) ||
                                            p_indent || 'BEGIN' || chr(10) ||
                                            p_indent || p_indent || 'open ' || p_sysrefcursor_variable_name || ' for' || chr(10);

            p_count_record_group_cols    := 0;

            BEGIN
               for r_record_group_cols in c_record_group_cols (p_id_form, r_record_groups.txt_record_group_name, r_record_groups.txt_origin) loop
                  p_count_record_group_cols := p_count_record_group_cols + 1;

                  if p_count_record_group_cols = 1 then
                     p_txt_record_group := p_txt_record_group ||
                                           p_indent || p_indent || p_indent || 'select t.' || lower (r_record_group_cols.txt_record_group_col_name) || chr(10);
                  else
                     p_txt_record_group := p_txt_record_group ||
                                           p_indent || p_indent || p_indent || '     , t.' || lower (r_record_group_cols.txt_record_group_col_name || chr(10));
                  end if;
               end loop;

            EXCEPTION
               when others then
                  p_msg_retorno := 'Erro LOOP 8.1 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                  return FALSE;
            END;

            BEGIN
               if    r_record_groups.txt_origin = 'RECGRP' then
                  p_clob_sql_query_no_comm := PKG_IMPORT_FORM.fu_ret_clob_sql_query_no_com_c (p_id_form, r_record_groups.txt_record_group_name);
               elsif r_record_groups.txt_origin = 'SQLBLK' then
                  p_clob_sql_query_no_comm := PKG_IMPORT_FORM.fu_ret_clob_sql_dblck_no_com_c (p_id_form, r_record_groups.txt_record_group_name);
               end if;

               if p_clob_sql_query_no_comm != empty_clob() then
                  for i in 1..length (PKG_IMPORT_FORM.p_pattern) loop
                     p_pattern_char := substr (PKG_IMPORT_FORM.p_pattern, i, 1);

-- Detect :GLOBAL.item, :SYSTEM.item and :PARAMETER.item
                     for r_m_load_form_glob_syst_parm in c_m_load_form_glob_syst_parm (p_id_form) loop
                        if  (p_pattern_char = chr(10)
                         and instr (upper (p_clob_sql_query_no_comm) || p_pattern_char, r_m_load_form_glob_syst_parm.txt_variable_name || p_pattern_char) > 0)
                         or (instr (upper (p_clob_sql_query_no_comm), r_m_load_form_glob_syst_parm.txt_variable_name || p_pattern_char) > 0) then
                           p_clob_sql_query_no_comm := regexp_replace (p_clob_sql_query_no_comm,
                                                                       r_m_load_form_glob_syst_parm.txt_variable_name || '[' || p_pattern_char || ']',
                                                                       r_m_load_form_glob_syst_parm.txt_variable_parameter_name || p_pattern_char,
                                                                       1,
                                                                       0,
                                                                       'i');
                        end if;
                     end loop;

-- Detect :BLOCK.item
                     for r_m_load_form_blocks_items in c_m_load_form_blocks_items (p_id_form) loop
                        if  (p_pattern_char = chr(10)
                         and instr (upper (p_clob_sql_query_no_comm) || p_pattern_char, r_m_load_form_blocks_items.txt_block_item_name || p_pattern_char) > 0)
                         or (instr (upper (p_clob_sql_query_no_comm), r_m_load_form_blocks_items.txt_block_item_name || p_pattern_char) > 0) then
                           p_clob_sql_query_no_comm := regexp_replace (p_clob_sql_query_no_comm,
                                                                       r_m_load_form_blocks_items.txt_block_item_name || '[' || p_pattern_char || ']',
                                                                       r_m_load_form_blocks_items.txt_variable_parameter_name || p_pattern_char,
                                                                       1,
                                                                       0,
                                                                       'i');
                        end if;
                     end loop;
                  end loop;
               end if;

            EXCEPTION
               when others then
                  p_msg_retorno := 'Erro LOOP 8.2 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                  return FALSE;
            END;

            BEGIN
               p_txt_record_group        := p_txt_record_group || p_indent || p_indent || p_indent || '  from (' || chr(10) || p_clob_sql_query_no_comm ||
                                            chr(10) || p_indent || p_indent || p_indent || ') t' || chr(10);
               p_count_record_group_cols := 0;

               for r_record_group_cols in c_record_group_cols (p_id_form, r_record_groups.txt_record_group_name, r_record_groups.txt_origin) loop
                  p_count_record_group_cols := p_count_record_group_cols + 1;
                  p_function_parameter_name := PKG_IMPORT_FORM.fu_ret_parameter_name_v (r_record_group_cols.txt_record_group_col_name);

                  if p_count_record_group_cols = 1 then
                     p_txt_record_group := p_txt_record_group || p_indent || p_indent || p_indent ||
                                           ' where t.' || rpad (lower (r_record_group_cols.txt_record_group_col_name),
                                                                p_oracle_objects_size,
                                                                ' ') ||
                                            ' = nvl (' || p_function_parameter_name ||
                                                ', t.' || lower (r_record_group_cols.txt_record_group_col_name) || ')' || chr(10);
                  else
                     p_txt_record_group := p_txt_record_group || p_indent || p_indent || p_indent ||
                                           '   and t.' || rpad (lower (r_record_group_cols.txt_record_group_col_name),
                                                                p_oracle_objects_size,
                                                                ' ') ||
                                            ' = nvl (' || p_function_parameter_name ||
                                                ', t.' || lower (r_record_group_cols.txt_record_group_col_name) || ')' || chr(10);
                  end if;
               end loop;

            EXCEPTION
               when others then
                  p_msg_retorno := 'Erro LOOP 8.3 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                  return FALSE;
            END;

            BEGIN
               p_txt_record_group        := p_txt_record_group ||
                                            ';' || chr(10) || chr(10) ||
                                            p_indent || p_indent || p_retorno_v || ' := TRUE;' || chr(10) ||
                                            p_indent || p_indent || p_msg_retorno_v || ' := NULL;' || chr(10) ||
                                            p_indent || p_indent || 'return ' || p_sysrefcursor_variable_name || ';' || chr(10) || chr(10) ||
                                            p_indent || 'EXCEPTION' || chr(10) ||
                                            p_indent || p_indent || 'when others then' || chr(10) ||
                                            p_indent || p_indent || p_indent || p_retorno_v || ' := FALSE;' || chr(10) ||
                                            p_indent || p_indent || p_indent || p_msg_retorno_v || ' := ''' || p_error_text_v ||
                                            ' '' || ' || p_prc_name_v || ' || to_char (sqlcode) || '' - '' || sqlerrm;' || chr(10) ||
                                            p_indent || p_indent || p_indent || 'return NULL;' || chr(10) ||
                                            p_indent || 'END ' || p_function_sysrefcursor || ';' || chr(10) || chr(10) ||
                                            '-- ' || p_function_pipelined || chr(10) ||
                                            p_indent || 'FUNCTION ' || p_function_pipelined || ' (' ||
                                            PKG_IMPORT_FORM.fu_ret_rec_grp_based_params_v (p_id_form, r_record_groups.txt_record_group_name, r_record_groups.txt_origin) ||
                                            lpad (' ',
                                                  length (p_indent
                                                          || 'FUNCTION '
                                                          || p_function_pipelined),
                                                  ' ') ||
                                            ') RETURN ' || p_table_of_record_group_name || ' PIPELINED IS' || chr(10) ||
                                            p_indent || p_indent || p_retorno_v || ' boolean := NULL;' || chr(10) ||
                                            p_indent || p_indent || p_msg_retorno_v || ' varchar2(4000) := NULL;' || chr(10) ||
                                            p_indent || p_indent || p_prc_name_v || ' varchar2(4000) := ' || p_pck_name_v ||
                                            ' || ''' || p_function_pipelined || ' (''' ||
                                            PKG_IMPORT_FORM.fu_ret_rec_grp_function_parm_v (p_id_form, r_record_groups.txt_record_group_name, r_record_groups.txt_origin) ||
                                            lpad ('|| ''): '';',
                                                  length (p_indent
                                                          || p_indent
                                                          || p_prc_name_v
                                                          || ' varchar2(4000) := '
                                                          || p_pck_name_v
                                                          || ' || '''
                                                          || p_function_pipelined
                                                          || ' ('''
                                                          || '  '),
                                                  ' ') || chr(10) ||
                                            p_indent || p_indent || p_sysrefcursor_variable_name || ' sys_refcursor;' || chr(10) ||
                                            p_indent || p_indent || p_piperow_variable_name || ' ' || p_record_group_name || ';' || chr(10) || chr(10) ||
                                            p_indent || 'BEGIN' || chr(10) ||
                                            p_indent || p_indent || p_sysrefcursor_variable_name
                                            || ' := ' || upper (p_package_prefix || p_txt_form_name)
                                            || '.' || p_function_sysrefcursor || ' (';

            EXCEPTION
               when others then
                  p_msg_retorno := 'Erro LOOP 8.4 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                  return FALSE;
            END;

            BEGIN
               p_count_record_group_cols := 0;

               for r_record_group_cols in c_record_group_cols (p_id_form, r_record_groups.txt_record_group_name, r_record_groups.txt_origin) loop
                  p_count_record_group_cols := p_count_record_group_cols + 1;
                  p_function_parameter_name := PKG_IMPORT_FORM.fu_ret_parameter_name_v (r_record_group_cols.txt_record_group_col_name);

                  if p_count_record_group_cols = 1 then
                     p_txt_record_group := p_txt_record_group || p_function_parameter_name || ' => '
                                                              || p_function_parameter_name || chr(10);
                  else
                     p_txt_record_group := p_txt_record_group || lpad (', ',
                                                                       length (p_indent
                                                                               || p_indent
                                                                               || p_sysrefcursor_variable_name
                                                                               || ' := '
                                                                               || upper (p_package_prefix || p_txt_form_name)
                                                                               || '.'
                                                                               || p_function_sysrefcursor
                                                                               || ' ('),
                                                                       ' ') || p_function_parameter_name || ' => '
                                                                            || p_function_parameter_name || chr(10);
                  end if;
               end loop;

            EXCEPTION
               when others then
                  p_msg_retorno := 'Erro LOOP 8.5 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                  return FALSE;
            END;

            BEGIN
               p_clob_sql_query_no_comm := PKG_IMPORT_FORM.fu_ret_clob_sql_query_no_com_c (p_id_form, r_record_groups.txt_record_group_name);
               p_parameter_list         := NULL;

               if p_clob_sql_query_no_comm != empty_clob() then
                  for i in 1..length (PKG_IMPORT_FORM.p_pattern) loop
                     p_pattern_char := substr (PKG_IMPORT_FORM.p_pattern, i, 1);

-- Detect :GLOBAL.item, :SYSTEM.item and :PARAMETER.item
                     BEGIN
                        for r_m_load_form_glob_syst_parm in c_m_load_form_glob_syst_parm (p_id_form) loop
                           if  (p_pattern_char = chr(10)
                            and instr (upper (p_clob_sql_query_no_comm) || p_pattern_char, r_m_load_form_glob_syst_parm.txt_variable_name || p_pattern_char) > 0)
                            or (instr (upper (p_clob_sql_query_no_comm), r_m_load_form_glob_syst_parm.txt_variable_name || p_pattern_char) > 0) then
-- AVOID PARAMETER DUPLICATION
                              if  (upper (p_parameter_list) not like ';%' || upper (r_m_load_form_blocks_items.txt_variable_parameter_name) || '%;' and p_parameter_list is not NULL)
                               or p_parameter_list is NULL then
                                 p_parameter_list       := nvl (p_parameter_list, ';') || upper (r_m_load_form_blocks_items.txt_variable_parameter_name) || ';';
                                 p_count_record_group_cols := p_count_record_group_cols + 1;
                                 p_function_parameter_name := r_m_load_form_glob_syst_parm.txt_variable_parameter_name;

                                 if p_count_record_group_cols = 1 then
                                    p_txt_record_group := p_txt_record_group || p_function_parameter_name || ' => '
                                                                             || p_function_parameter_name || chr(10);
                                 else
                                    p_txt_record_group := p_txt_record_group || lpad (', ',
                                                                                      length (p_indent
                                                                                              || p_indent
                                                                                              || p_sysrefcursor_variable_name
                                                                                              || ' := '
                                                                                              || upper (p_package_prefix || p_txt_form_name)
                                                                                              || '.'
                                                                                              || p_function_sysrefcursor
                                                                                              || ' ('),
                                                                                      ' ') || p_function_parameter_name || ' => '
                                                                                           || p_function_parameter_name || chr(10);
                                 end if;
                              end if;
                           end if;
                        end loop;

                     EXCEPTION
                        when others then
                           p_msg_retorno := 'Erro LOOP 8.6.1 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                           return FALSE;
                     END;

-- Detect :BLOCK.item
                     BEGIN
                        for r_m_load_form_blocks_items in c_m_load_form_blocks_items (p_id_form) loop
                           if  (p_pattern_char = chr(10)
                            and instr (upper (p_clob_sql_query_no_comm) || p_pattern_char, r_m_load_form_blocks_items.txt_block_item_name || p_pattern_char) > 0)
                            or (instr (upper (p_clob_sql_query_no_comm), r_m_load_form_blocks_items.txt_block_item_name || p_pattern_char) > 0) then
-- AVOID PARAMETER DUPLICATION
                              if  (upper (p_parameter_list) not like ';%' || upper (r_m_load_form_blocks_items.txt_variable_parameter_name) || '%;' and p_parameter_list is not NULL)
                               or p_parameter_list is NULL then
                                 p_parameter_list       := nvl (p_parameter_list, ';') || upper (r_m_load_form_blocks_items.txt_variable_parameter_name) || ';';
                                 p_count_record_group_cols := p_count_record_group_cols + 1;
                                 p_function_parameter_name := r_m_load_form_blocks_items.txt_variable_parameter_name;

                                 if p_count_record_group_cols = 1 then
                                    p_txt_record_group := p_txt_record_group || p_function_parameter_name || ' => '
                                                                             || p_function_parameter_name || chr(10);
                                 else
                                    p_txt_record_group := p_txt_record_group || lpad (', ',
                                                                                      length (p_indent
                                                                                              || p_indent
                                                                                              || p_sysrefcursor_variable_name
                                                                                              || ' := '
                                                                                              || upper (p_package_prefix || p_txt_form_name)
                                                                                              || '.'
                                                                                              || p_function_sysrefcursor
                                                                                              || ' ('),
                                                                                      ' ') || p_function_parameter_name || ' => '
                                                                                           || p_function_parameter_name || chr(10);
                                 end if;
                              end if;
                           end if;
                        end loop;

                     EXCEPTION
                        when others then
                           p_msg_retorno := 'Erro LOOP 8.6.2 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                           return FALSE;
                     END;
                  end loop;
               end if;

            EXCEPTION
               when others then
                  p_msg_retorno := 'Erro LOOP 8.6 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                  return FALSE;
            END;

            BEGIN
               p_txt_record_group        := p_txt_record_group ||
                                            lpad (', ',
                                                  length (p_indent
                                                          || p_indent
                                                          || p_sysrefcursor_variable_name
                                                          || ' := '
                                                          || upper (p_package_prefix || p_txt_form_name)
                                                          || '.'
                                                          || p_function_sysrefcursor
                                                          || ' ('),
                                                  ' ') || p_retorno_v || ' => ' || p_retorno_v || chr(10) ||
                                            lpad (', ',
                                                  length (p_indent
                                                          || p_indent
                                                          || p_sysrefcursor_variable_name
                                                          || ' := '
                                                          || upper (p_package_prefix || p_txt_form_name)
                                                          || '.'
                                                          || p_function_sysrefcursor
                                                          || ' ('),
                                                  ' ') || p_msg_retorno_v || ' => ' || p_msg_retorno_v || ');' || chr(10) || chr(10) ||
                                            p_indent || p_indent || 'if p_return = TRUE then' || chr(10) ||
                                            p_indent || p_indent || p_indent || 'loop' || chr(10) ||
                                            p_indent || p_indent || p_indent || p_indent || 'BEGIN' || chr(10) ||
                                            p_indent || p_indent || p_indent || p_indent || p_indent || 'fetch ' ||
                                            p_sysrefcursor_variable_name || ' into ' || p_piperow_variable_name || ';' || chr(10) ||
                                            p_indent || p_indent || p_indent || p_indent || p_indent || 'exit when ' ||
                                            p_sysrefcursor_variable_name || '%NOTFOUND;' || chr(10) ||
                                            p_indent || p_indent || p_indent || p_indent || p_indent || 'pipe row (' ||
                                            p_piperow_variable_name || ');' || chr(10) || chr(10) ||
                                            p_indent || p_indent || p_indent || p_indent || 'EXCEPTION' || chr(10) ||
                                            p_indent || p_indent || p_indent || p_indent || p_indent || 'when no_data_needed then' || chr(10) ||
                                            p_indent || p_indent || p_indent || p_indent || p_indent || p_indent || 'close ' ||
                                            p_sysrefcursor_variable_name || ';' || chr(10) ||
                                            p_indent || p_indent || p_indent || p_indent || p_indent || p_indent || 'return;' || chr(10) ||
                                            p_indent || p_indent || p_indent || p_indent || p_indent || 'when others then' || chr(10) ||
                                            p_indent || p_indent || p_indent || p_indent || p_indent || p_indent || 'close ' ||
                                            p_sysrefcursor_variable_name || ';' || chr(10) ||
                                            p_indent || p_indent || p_indent || p_indent || p_indent || p_indent ||
                                            'raise_application_error (-20002, ''Error PIPE ROW '' || ' || p_prc_name_v ||
                                            ' || to_char (sqlcode) || '' - '' || sqlerrm);' || chr(10) ||
                                            p_indent || p_indent || p_indent || p_indent || 'END;' || chr(10) ||
                                            p_indent || p_indent || p_indent || 'end loop;' || chr(10) ||
                                            p_indent || p_indent || 'else' || chr(10) ||
                                            p_indent || p_indent || p_indent || 'raise_application_error (-20001, ''Error ' ||
                                            upper (p_retorno_v) || ' '' || ' || p_prc_name_v || ' || ' || p_msg_retorno_v || ');' || chr(10) ||
                                            p_indent || p_indent || 'end if;' || chr(10) || chr(10) ||
                                            p_indent || 'EXCEPTION' || chr(10) ||
                                            p_indent || p_indent || 'when others then' || chr(10) ||
                                            p_indent || p_indent || p_indent || 'raise_application_error (-20000, ''Error '' || ' ||
                                            p_prc_name_v ||
                                            ' || to_char (sqlcode) || '' - '' || sqlerrm);' || chr(10) ||
                                            p_indent || 'END ' || p_function_pipelined || ';' || chr(10) || chr(10);

            EXCEPTION
               when others then
                  p_msg_retorno := 'Erro LOOP 8.7 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                  return FALSE;
            END;
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_txt_record_groups_bdy_b;

-- fu_ret_txt_record_groups_bdy_c
   FUNCTION fu_ret_txt_record_groups_bdy_c (p_id_form M_LOAD_FORM_RECORD_GROUPS.id_form%TYPE)
                                            RETURN clob IS
      p_retorno          boolean        := NULL;
      p_txt_record_group clob           := NULL;
      p_prc_name         varchar2(1000) := p_pck_name || 'fu_ret_txt_record_groups_bdy_c (' || p_id_form || '):';
      p_msg_retorno      varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_txt_record_groups_bdy_b (p_id_form, p_txt_record_group, p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_record_group;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_txt_record_groups_bdy_c;

-- fu_ret_txt_frm_parameter_lst_c
   FUNCTION fu_ret_txt_frm_parameter_lst_c (p_id M_LOAD_FORM.id%TYPE)
                                            RETURN clob IS
      p_retorno               boolean        := NULL;
      p_txt_frm_parameter_lst clob           := empty_clob();
      p_prc_name              varchar2(1000) := p_pck_name || 'fu_ret_txt_frm_parameter_lst_c (' || p_id || '): ';
      p_msg_retorno           varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_txt_frm_parameter_lst_b (p_id, p_txt_frm_parameter_lst, p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_frm_parameter_lst;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_txt_frm_parameter_lst_c;

-- fu_ret_txt_frm_parameter_lst_b
   FUNCTION fu_ret_txt_frm_parameter_lst_b (p_id                           M_LOAD_FORM.id%TYPE,
                                            p_txt_frm_parameter_lst IN OUT clob,
                                            p_msg_retorno           IN OUT varchar2)
                                            RETURN boolean IS
      cursor c_m_load_form_glob_syst_parm (p_id_form           M_LOAD_FORM_GLOB_SYST_PARM.id_form%TYPE,
                                           p_txt_variable_type M_LOAD_FORM_GLOB_SYST_PARM.txt_variable_type%TYPE default NULL) is
         select mlfgsp.*
           from m_load_form_glob_syst_parm mlfgsp
          where mlfgsp.id_form           = nvl (p_id_form,           mlfgsp.id_form)
            and mlfgsp.txt_variable_type = nvl (p_txt_variable_type, mlfgsp.txt_variable_type)
          order by mlfgsp.id_form,
                   mlfgsp.txt_variable_type,
                   mlfgsp.txt_variable_name;

      r_m_load_form_glob_syst_parm c_m_load_form_glob_syst_parm%ROWTYPE := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_txt_frm_parameter_lst_b (' || p_id || '): ';

   BEGIN
      if p_id is not NULL then
         p_txt_frm_parameter_lst := chr(10) || '-- PARAMETERS ARE CONVERTED TO PACKAGE VARIABLES AND DECLARED WITH THEIR RESPECTIVE DATA TYPES.' || chr(10);

         for r_m_load_form_glob_syst_parm in c_m_load_form_glob_syst_parm (p_id, 'PARAMETER') loop
            p_txt_frm_parameter_lst := p_txt_frm_parameter_lst || p_indent ||
                                       replace (rpad (r_m_load_form_glob_syst_parm.txt_variable_name,
                                                      PKG_IMPORT_FORM.fu_ret_rpad_variable_i (p_id, 'PARAMETER'),
                                                      ' '), ':PARAMETER.', '') ||
                                       ' ' || lower (r_m_load_form_glob_syst_parm.txt_variable_data_type);

            if    r_m_load_form_glob_syst_parm.txt_variable_data_type in ('NUMBER') then
               p_txt_frm_parameter_lst := p_txt_frm_parameter_lst || '(' || nvl (r_m_load_form_glob_syst_parm.txt_variable_max_size, 38) || ')';
            elsif r_m_load_form_glob_syst_parm.txt_variable_data_type in ('VARCHAR2') then
               p_txt_frm_parameter_lst := p_txt_frm_parameter_lst || '(' || nvl (r_m_load_form_glob_syst_parm.txt_variable_max_size, 255) || ')';
            end if;

            if    r_m_load_form_glob_syst_parm.txt_variable_ini_value is NULL then
               p_txt_frm_parameter_lst := p_txt_frm_parameter_lst || ' := NULL;';
            elsif r_m_load_form_glob_syst_parm.txt_variable_data_type in ('NUMBER') then
               p_txt_frm_parameter_lst := p_txt_frm_parameter_lst || ' := ' || r_m_load_form_glob_syst_parm.txt_variable_ini_value || ';';
            elsif r_m_load_form_glob_syst_parm.txt_variable_data_type in ('DATE', 'VARCHAR2') then
               p_txt_frm_parameter_lst := p_txt_frm_parameter_lst || ' := ''' || r_m_load_form_glob_syst_parm.txt_variable_ini_value || ''';';
            end if;

            p_txt_frm_parameter_lst := p_txt_frm_parameter_lst || chr(10);
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_txt_frm_parameter_lst_b;

-- fu_ret_txt_frm_blk_itm_spc_c
   FUNCTION fu_ret_txt_frm_blk_itm_spc_c (p_id M_LOAD_FORM.id%TYPE)
                                          RETURN clob IS
      p_retorno             boolean        := NULL;
      p_txt_frm_blk_itm_spc clob           := empty_clob();
      p_prc_name            varchar2(1000) := p_pck_name || 'fu_ret_txt_frm_blk_itm_spc_c (' || p_id || '): ';
      p_msg_retorno         varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_txt_frm_blk_itm_spc_b (p_id, p_txt_frm_blk_itm_spc, p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_frm_blk_itm_spc;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_txt_frm_blk_itm_spc_c;

-- fu_ret_txt_frm_blk_itm_spc_b
   FUNCTION fu_ret_txt_frm_blk_itm_spc_b (p_id                         M_LOAD_FORM.id%TYPE,
                                          p_txt_frm_blk_itm_spc IN OUT clob,
                                          p_msg_retorno         IN OUT varchar2)
                                          RETURN boolean IS
      cursor c_m_load_form_plsql_contents (p_id_form M_LOAD_FORM_GLOB_SYST_PARM.id_form%TYPE) is
         select mlfpc.*
           from m_load_form_plsql_contents mlfpc
          where mlfpc.id_form                      = nvl (p_id_form, mlfpc.id_form)
            and mlfpc.txt_generated_function_name is not NULL
            and mlfpc.txt_disposable_routine       = 'N'
          order by mlfpc.id;

      r_m_load_form_plsql_contents c_m_load_form_plsql_contents%ROWTYPE := NULL;
      p_program_unit_params clob           := empty_clob();
      p_prc_name            varchar2(1000) := p_pck_name || 'fu_ret_txt_frm_blk_itm_spc_b (' || p_id || '): ';

   BEGIN
      if p_id is not NULL then
         p_txt_frm_blk_itm_spc := p_txt_frm_blk_itm_spc || '-- FORM, BLOCK AND BLOCK.ITEM TRIGGER OBJECTS ARE CONVERTED INTO BOOLEAN FUNCTIONS.' || chr(10);

         for r_m_load_form_plsql_contents in c_m_load_form_plsql_contents (p_id) loop
            p_txt_frm_blk_itm_spc := p_txt_frm_blk_itm_spc ||
                                    '-- ' || lower (r_m_load_form_plsql_contents.txt_generated_function_name) || chr(10) ||
                                    '-- SOURCE: "' || r_m_load_form_plsql_contents.txt_plsql_source || '" ';

            if    r_m_load_form_plsql_contents.txt_block_source is not NULL and r_m_load_form_plsql_contents.txt_block_item_source is NULL then
               p_txt_frm_blk_itm_spc := p_txt_frm_blk_itm_spc || r_m_load_form_plsql_contents.txt_block_source || ': ';
            elsif r_m_load_form_plsql_contents.txt_block_source is not NULL and r_m_load_form_plsql_contents.txt_block_item_source is not NULL then
               p_txt_frm_blk_itm_spc := p_txt_frm_blk_itm_spc || r_m_load_form_plsql_contents.txt_block_source || '.' ||
                                       r_m_load_form_plsql_contents.txt_block_item_source || ': ';
            end if;

            p_program_unit_params := PKG_IMPORT_FORM.fu_ret_plsql_contents_params_c (p_id, r_m_load_form_plsql_contents.txt_generated_function_name);
            p_txt_frm_blk_itm_spc := p_txt_frm_blk_itm_spc || r_m_load_form_plsql_contents.txt_plsql_object_name ||
                                     chr(10) ||
                                     p_indent || 'FUNCTION ' || lower (r_m_load_form_plsql_contents.txt_generated_function_name);

            if p_program_unit_params is not NULL then
               p_txt_frm_blk_itm_spc := p_txt_frm_blk_itm_spc || ' (' || p_program_unit_params ||
                                       PKG_IMPORT_FORM.p_indent ||
                                       lpad (')',
                                             length (p_indent || 'FUNCTION ' || lower (r_m_load_form_plsql_contents.txt_generated_function_name)),
                                             ' ');
            end if;

            p_txt_frm_blk_itm_spc := p_txt_frm_blk_itm_spc || ' RETURN boolean;' || chr(10) || chr(10);
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_txt_frm_blk_itm_spc_b;

-- fu_ret_txt_program_units_spc_c
   FUNCTION fu_ret_txt_program_units_spc_c (p_id M_LOAD_FORM.id%TYPE)
                                            RETURN clob IS
      p_retorno               boolean        := NULL;
      p_txt_program_units_spc clob           := empty_clob();
      p_prc_name              varchar2(1000) := p_pck_name || 'fu_ret_txt_program_units_spc_c (' || p_id || '): ';
      p_msg_retorno           varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_txt_program_units_spc_b (p_id, p_txt_program_units_spc, p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_program_units_spc;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_txt_program_units_spc_c;

-- fu_ret_txt_program_units_spc_b
   FUNCTION fu_ret_txt_program_units_spc_b (p_id                           M_LOAD_FORM.id%TYPE,
                                            p_txt_program_units_spc IN OUT clob,
                                            p_msg_retorno           IN OUT varchar2)
                                            RETURN boolean IS
      cursor c_m_load_form_program_unit_pks (p_id_form M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE) is
         select mlfpc.*
           from m_load_form_plsql_contents mlfpc
          where mlfpc.id_form                      = nvl (p_id_form, mlfpc.id_form)
            and mlfpc.txt_generated_function_name is NULL
            and mlfpc.txt_disposable_routine       = 'N'
            and mlfpc.txt_plsql_program_unit_type != 'PACKAGE_BODY'
          order by mlfpc.id;

      r_m_load_form_program_unit_pks c_m_load_form_program_unit_pks%ROWTYPE := NULL;
      p_program_unit_params clob           := empty_clob();
      p_prc_name            varchar2(1000) := p_pck_name || 'fu_ret_txt_program_units_spc_b (' || p_id || '): ';

   BEGIN
      if p_id is not NULL then
         p_txt_program_units_spc := p_txt_program_units_spc || '-- PROGRAM UNITS ARE REUSED.' || chr(10);

         for r_m_load_form_program_unit_pks in c_m_load_form_program_unit_pks (p_id) loop
            if r_m_load_form_program_unit_pks.txt_plsql_program_unit_type = 'PACKAGE_SPEC' then
               p_txt_program_units_spc := p_txt_program_units_spc ||
                                       '-- ' || r_m_load_form_program_unit_pks.clob_plsql_contents || chr(10);
            else
               p_txt_program_units_spc  := p_txt_program_units_spc ||
                                        '-- ' || r_m_load_form_program_unit_pks.txt_plsql_object_name || chr(10) ||
                                        PKG_IMPORT_FORM.p_indent || r_m_load_form_program_unit_pks.txt_plsql_program_unit_type || ' ' ||
                                        lower (r_m_load_form_program_unit_pks.txt_plsql_object_name);
               p_program_unit_params := PKG_IMPORT_FORM.fu_ret_prg_unit_hdr_all_parm_c (p_id, r_m_load_form_program_unit_pks.txt_plsql_object_name);

               if p_program_unit_params != empty_clob() then
                  p_txt_program_units_spc := p_txt_program_units_spc || ' (' || p_program_unit_params ||
                                          lpad ('  ',
                                                length (PKG_IMPORT_FORM.p_indent
                                                        || r_m_load_form_program_unit_pks.txt_plsql_program_unit_type
                                                        || ' '
                                                        || r_m_load_form_program_unit_pks.txt_plsql_object_name
                                                        || ' ('),
                                                ' ') ||
                                          ')';
               end if;

               if r_m_load_form_program_unit_pks.txt_plsql_program_unit_type = 'FUNCTION' then
                  p_txt_program_units_spc := p_txt_program_units_spc || ' RETURN ' ||
                                          PKG_IMPORT_FORM.fu_ret_function_type_return_v (r_m_load_form_program_unit_pks.id_form,
                                                                                         r_m_load_form_program_unit_pks.txt_plsql_object_name);
               end if;

               p_txt_program_units_spc := p_txt_program_units_spc || ';' || chr(10) || chr(10);
            end if;
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_txt_program_units_spc_b;

-- fu_ret_txt_global_variables_c
   FUNCTION fu_ret_txt_global_variables_c (p_id M_LOAD_FORM.id%TYPE)
                                           RETURN clob IS
      p_retorno              boolean        := NULL;
      p_txt_global_variables clob           := empty_clob();
      p_prc_name             varchar2(1000) := p_pck_name || 'fu_ret_txt_global_variables_c (' || p_id || '): ';
      p_msg_retorno          varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_txt_global_variables_b (p_id, p_txt_global_variables, p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_global_variables;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_txt_global_variables_c;

-- fu_ret_txt_global_variables_b
   FUNCTION fu_ret_txt_global_variables_b (p_id                          M_LOAD_FORM.id%TYPE,
                                           p_txt_global_variables IN OUT clob,
                                           p_msg_retorno          IN OUT varchar2)
                                           RETURN boolean IS
      cursor c_m_load_form_glob_syst_parm (p_id_form           M_LOAD_FORM_GLOB_SYST_PARM.id_form%TYPE,
                                           p_txt_variable_type M_LOAD_FORM_GLOB_SYST_PARM.txt_variable_type%TYPE default NULL) is
         select mlfgsp.*
           from m_load_form_glob_syst_parm mlfgsp
          where mlfgsp.id_form           = nvl (p_id_form,           mlfgsp.id_form)
            and mlfgsp.txt_variable_type = nvl (p_txt_variable_type, mlfgsp.txt_variable_type)
          order by mlfgsp.id_form,
                   mlfgsp.txt_variable_type,
                   mlfgsp.txt_variable_name;

      r_m_load_form_glob_syst_parm c_m_load_form_glob_syst_parm%ROWTYPE := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_txt_global_variables_b (' || p_id || '): ';

   BEGIN
      if p_id is not NULL then
         p_txt_global_variables := p_txt_global_variables || chr(10) ||
                                   '-- GLOBAL VARIABLES ARE DECLARED AS VARCHAR2(255).' || chr(10);

         for r_m_load_form_glob_syst_parm in c_m_load_form_glob_syst_parm (p_id, 'GLOBAL') loop
            p_txt_global_variables := p_txt_global_variables || '-- ' || rpad (r_m_load_form_glob_syst_parm.txt_variable_name,
                                                                               PKG_IMPORT_FORM.fu_ret_rpad_variable_i (p_id, 'GLOBAL'),
                                                                               ' ') ||
                                      ' varchar2(255) := NULL;' || chr(10);
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_txt_global_variables_b;

-- fu_ret_txt_system_variables_c
   FUNCTION fu_ret_txt_system_variables_c (p_id M_LOAD_FORM.id%TYPE)
                                           RETURN clob IS
      p_retorno              boolean        := NULL;
      p_txt_system_variables clob           := empty_clob();
      p_prc_name             varchar2(1000) := p_pck_name || 'fu_ret_txt_system_variables_c (' || p_id || '): ';
      p_msg_retorno          varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_txt_system_variables_b (p_id, p_txt_system_variables, p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_system_variables;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_txt_system_variables_c;

-- fu_ret_txt_system_variables_b
   FUNCTION fu_ret_txt_system_variables_b (p_id                          M_LOAD_FORM.id%TYPE,
                                           p_txt_system_variables IN OUT clob,
                                           p_msg_retorno          IN OUT varchar2)
                                           RETURN boolean IS
      cursor c_m_load_form_glob_syst_parm (p_id_form           M_LOAD_FORM_GLOB_SYST_PARM.id_form%TYPE,
                                           p_txt_variable_type M_LOAD_FORM_GLOB_SYST_PARM.txt_variable_type%TYPE default NULL) is
         select mlfgsp.*
           from m_load_form_glob_syst_parm mlfgsp
          where mlfgsp.id_form           = nvl (p_id_form,           mlfgsp.id_form)
            and mlfgsp.txt_variable_type = nvl (p_txt_variable_type, mlfgsp.txt_variable_type)
          order by mlfgsp.id_form,
                   mlfgsp.txt_variable_type,
                   mlfgsp.txt_variable_name;

      r_m_load_form_glob_syst_parm c_m_load_form_glob_syst_parm%ROWTYPE := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_txt_system_variables_b (' || p_id || '): ';

   BEGIN
      if p_id is not NULL then
         p_txt_system_variables := p_txt_system_variables || chr(10) ||
                                   '-- SYSTEM VARIABLES ARE MENTIONED IN PACKAGE SPEC FOR FUTURE REFERENCE.' || chr(10);

         for r_m_load_form_glob_syst_parm in c_m_load_form_glob_syst_parm (p_id, 'SYSTEM') loop
            p_txt_system_variables := p_txt_system_variables || '-- ' || r_m_load_form_glob_syst_parm.txt_variable_name || chr(10);
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_txt_system_variables_b;

-- fu_ret_txt_frm_blk_itm_bdy_c
   FUNCTION fu_ret_txt_frm_blk_itm_bdy_c (p_id M_LOAD_FORM.id%TYPE)
                                          RETURN clob IS
      p_retorno             boolean        := NULL;
      p_txt_frm_blk_itm_bdy clob           := empty_clob();
      p_prc_name            varchar2(1000) := p_pck_name || 'fu_ret_txt_frm_blk_itm_bdy_c (' || p_id || '): ';
      p_msg_retorno         varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_txt_frm_blk_itm_bdy_b (p_id, p_txt_frm_blk_itm_bdy, p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_frm_blk_itm_bdy;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_txt_frm_blk_itm_bdy_c;

-- fu_ret_txt_frm_blk_itm_bdy_b
   FUNCTION fu_ret_txt_frm_blk_itm_bdy_b (p_id                         M_LOAD_FORM.id%TYPE,
                                          p_txt_frm_blk_itm_bdy IN OUT clob,
                                          p_msg_retorno         IN OUT varchar2)
                                          RETURN boolean IS
      cursor c_m_load_form_plsql_contents (p_id_form M_LOAD_FORM_GLOB_SYST_PARM.id_form%TYPE) is
         select mlfpc.*
           from m_load_form_plsql_contents mlfpc
          where mlfpc.id_form                      = nvl (p_id_form, mlfpc.id_form)
            and mlfpc.txt_generated_function_name is not NULL
            and mlfpc.txt_disposable_routine       = 'N'
          order by mlfpc.id;

      r_m_load_form_plsql_contents c_m_load_form_plsql_contents%ROWTYPE := NULL;
      p_program_unit_params clob           := empty_clob();
      p_prc_name            varchar2(1000) := p_pck_name || 'fu_ret_txt_frm_blk_itm_bdy_b (' || p_id || '): ';

   BEGIN
      if p_id is not NULL then
         p_txt_frm_blk_itm_bdy := p_txt_frm_blk_itm_bdy ||
                                  '-- FORM, BLOCK AND BLOCK.ITEM TRIGGER OBJECTS ARE CONVERTED INTO BOOLEAN FUNCTIONS.' || chr(10);

         for r_m_load_form_plsql_contents in c_m_load_form_plsql_contents (p_id_form => p_id) loop
            p_txt_frm_blk_itm_bdy := p_txt_frm_blk_itm_bdy ||
                                    '-- ' || lower (r_m_load_form_plsql_contents.txt_generated_function_name) || chr(10) ||
                                    '-- SOURCE: "' || r_m_load_form_plsql_contents.txt_plsql_source || '" ';

            if    r_m_load_form_plsql_contents.txt_block_source is not NULL and r_m_load_form_plsql_contents.txt_block_item_source is NULL then
               p_txt_frm_blk_itm_bdy := p_txt_frm_blk_itm_bdy || r_m_load_form_plsql_contents.txt_block_source || ': ';
            elsif r_m_load_form_plsql_contents.txt_block_source is not NULL and r_m_load_form_plsql_contents.txt_block_item_source is not NULL then
               p_txt_frm_blk_itm_bdy := p_txt_frm_blk_itm_bdy || r_m_load_form_plsql_contents.txt_block_source || '.' ||
                                        r_m_load_form_plsql_contents.txt_block_item_source || ': ';
            end if;

            r_m_load_form_plsql_contents.clob_plsql_contents := PKG_IMPORT_FORM.fu_chg_item_to_block_item_b (p_id, r_m_load_form_plsql_contents.txt_generated_function_name)
                                                                || chr(10) || chr(10);

            p_program_unit_params := PKG_IMPORT_FORM.fu_ret_plsql_contents_params_c (p_id, r_m_load_form_plsql_contents.txt_generated_function_name);
            p_txt_frm_blk_itm_bdy := p_txt_frm_blk_itm_bdy || r_m_load_form_plsql_contents.txt_plsql_object_name ||
                                     chr(10) ||
                                     p_indent || 'FUNCTION ' || lower (r_m_load_form_plsql_contents.txt_generated_function_name);

            if p_program_unit_params is not NULL then
               p_txt_frm_blk_itm_bdy := p_txt_frm_blk_itm_bdy || ' (' || p_program_unit_params ||
                                       PKG_IMPORT_FORM.p_indent ||
                                       lpad (')',
                                             length (p_indent || 'FUNCTION ' || lower (r_m_load_form_plsql_contents.txt_generated_function_name)),
                                             ' ');
            end if;

            p_txt_frm_blk_itm_bdy := p_txt_frm_blk_itm_bdy || ' RETURN boolean IS' || chr(10) ||
                                     p_indent || p_indent || PKG_IMPORT_FORM.p_prc_name_v || ' varchar2(4000) := ' || PKG_IMPORT_FORM.p_pck_name_v ||
                                     ' || ''' || lower (r_m_load_form_plsql_contents.txt_generated_function_name) || ': '';' || chr(10) || chr(10) ||
                                     p_indent || 'BEGIN' || chr(10) ||
                                     PKG_IMPORT_FORM.fu_chg_plsql_blocks_to_parms_c (p_id, r_m_load_form_plsql_contents.txt_generated_function_name) || chr(10) ||
                                     p_indent || p_indent || 'return TRUE;' || chr(10) || chr(10) ||
                                     p_indent || 'EXCEPTION' || chr(10) ||
                                     p_indent || p_indent || 'when others then' || chr(10) ||
                                     p_indent || p_indent || p_indent || p_msg_retorno_v || ' := ''' || p_error_text_v ||
                                     ' '' || ' || p_prc_name_v || ' || to_char (sqlcode) || '' - '' || sqlerrm;' || chr(10) ||
                                     p_indent || p_indent || p_indent || 'return FALSE;' || chr(10) ||
                                     p_indent || 'END ' || lower (r_m_load_form_plsql_contents.txt_generated_function_name) || ';' || chr(10) || chr(10);
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_txt_frm_blk_itm_bdy_b;

-- fu_ret_txt_program_units_bdy_c
   FUNCTION fu_ret_txt_program_units_bdy_c (p_id M_LOAD_FORM.id%TYPE)
                                            RETURN clob IS
      p_retorno               boolean        := NULL;
      p_txt_program_units_bdy clob           := empty_clob();
      p_prc_name              varchar2(1000) := p_pck_name || 'fu_ret_txt_program_units_bdy_c (' || p_id || '): ';
      p_msg_retorno           varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_IMPORT_FORM.fu_ret_txt_program_units_bdy_b (p_id, p_txt_program_units_bdy, p_msg_retorno);

      if p_retorno = TRUE then
         return p_txt_program_units_bdy;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_txt_program_units_bdy_c;

-- fu_ret_txt_program_units_bdy_b
   FUNCTION fu_ret_txt_program_units_bdy_b (p_id                           M_LOAD_FORM.id%TYPE,
                                            p_txt_program_units_bdy IN OUT clob,
                                            p_msg_retorno           IN OUT varchar2)
                                            RETURN boolean IS
      cursor c_m_load_form_program_unit_pkb (p_id_form M_LOAD_FORM_PLSQL_CONTENTS.id_form%TYPE) is
         select mlfpc.*
           from m_load_form_plsql_contents mlfpc
          where mlfpc.id_form                      = nvl (p_id_form, mlfpc.id_form)
            and mlfpc.txt_generated_function_name is NULL
            and mlfpc.txt_disposable_routine       = 'N'
            and mlfpc.txt_plsql_program_unit_type != 'PACKAGE_SPEC'
          order by mlfpc.id;

      r_m_load_form_program_unit_pkb c_m_load_form_program_unit_pkb%ROWTYPE := NULL;
      p_program_unit_params clob           := empty_clob();
      p_prc_name            varchar2(1000) := p_pck_name || 'fu_ret_txt_program_units_bdy_b (' || p_id || '): ';

   BEGIN
      if p_id is not NULL then
         p_txt_program_units_bdy := p_txt_program_units_bdy || '-- PROGRAM UNITS ARE REUSED.' || chr(10);

         for r_m_load_form_program_unit_pkb in c_m_load_form_program_unit_pkb (p_id) loop
            if r_m_load_form_program_unit_pkb.txt_plsql_program_unit_type = 'PACKAGE_BODY' then
               p_txt_program_units_bdy := p_txt_program_units_bdy ||
                                          '-- ' || r_m_load_form_program_unit_pkb.clob_plsql_contents || chr(10);
            else
               p_txt_program_units_bdy := p_txt_program_units_bdy ||
                                          '-- ' || r_m_load_form_program_unit_pkb.txt_plsql_object_name || chr(10) ||
                                          PKG_IMPORT_FORM.p_indent || r_m_load_form_program_unit_pkb.txt_plsql_program_unit_type || ' ' ||
                                          lower (r_m_load_form_program_unit_pkb.txt_plsql_object_name);
               p_program_unit_params   := PKG_IMPORT_FORM.fu_ret_prg_unit_hdr_all_parm_c (p_id, r_m_load_form_program_unit_pkb.txt_plsql_object_name);

               if p_program_unit_params != empty_clob() then
                  p_txt_program_units_bdy := p_txt_program_units_bdy || ' (' || p_program_unit_params ||
                                          lpad ('  ',
                                                length (PKG_IMPORT_FORM.p_indent
                                                        || r_m_load_form_program_unit_pkb.txt_plsql_program_unit_type
                                                        || ' '
                                                        || r_m_load_form_program_unit_pkb.txt_plsql_object_name
                                                        || ' ('),
                                                ' ') ||
                                          ')';
               end if;

               if r_m_load_form_program_unit_pkb.txt_plsql_program_unit_type = 'FUNCTION' then
                  p_txt_program_units_bdy := p_txt_program_units_bdy || ' RETURN ' ||
                                             PKG_IMPORT_FORM.fu_ret_function_type_return_v (r_m_load_form_program_unit_pkb.id_form,
                                                                                            r_m_load_form_program_unit_pkb.txt_plsql_object_name);
               end if;

               p_txt_program_units_bdy := p_txt_program_units_bdy || ' IS' || chr(10) ||
                                          PKG_IMPORT_FORM.fu_ret_prog_unit_no_header_c (p_id, r_m_load_form_program_unit_pkb.txt_plsql_object_name) || chr(10);
            end if;
         end loop;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_txt_program_units_bdy_b;

-- fu_generate_proposed_plsql_b
   FUNCTION fu_generate_proposed_plsql_b (p_id                 M_LOAD_FORM.id%TYPE,
                                          p_msg_retorno IN OUT varchar2)
                                          RETURN boolean IS
--    p_txt_comments_form_level      M_LOAD_FORM.txt_comments%TYPE                := empty_clob();
      p_txt_disposed_content         M_LOAD_FORM.txt_disposed_content%TYPE        := empty_clob();
      p_txt_disposed_content_b       M_LOAD_FORM.txt_disposed_content_b%TYPE;
      p_txt_oracle_apex_plsql_call_b M_LOAD_FORM.txt_oracle_apex_plsql_calls_b%TYPE;
      p_txt_oracle_apex_plsql_calls  M_LOAD_FORM.txt_oracle_apex_plsql_calls%TYPE := empty_clob();
      p_txt_proposed_plsql           M_LOAD_FORM.txt_proposed_plsql%TYPE          := empty_clob();
      p_txt_proposed_plsql_b         M_LOAD_FORM.txt_proposed_plsql_b%TYPE;
      p_retorno                      boolean        := NULL;
      p_package_name                 varchar2(100)  := NULL;
      p_form_name                    varchar2(1000) := NULL;
      p_prc_name                     varchar2(1000) := p_pck_name || 'fu_generate_proposed_plsql_b (' || p_id || '): ';

   BEGIN
      if p_id is NULL then
         p_msg_retorno := 'O ID do form carregado deve ser informado.';
         return FALSE;
      else
         p_form_name := PKG_IMPORT_FORM.fu_obter_nome_form_v (p_id);

-- ANALYSIS OF DISPOSABLE CONTENTS START.
         p_retorno := PKG_IMPORT_FORM.fu_discard_data_blocks_b (p_id, p_msg_retorno);

         if p_retorno != TRUE then
            return p_retorno;
         end if;

         p_retorno := PKG_IMPORT_FORM.fu_discard_prg_identify_line_b (p_id, p_msg_retorno);

         if p_retorno != TRUE then
            return p_retorno;
         end if;

         p_retorno := PKG_IMPORT_FORM.fu_discard_prg_marked_custom_b (p_id, p_msg_retorno);

         if p_retorno != TRUE then
            return p_retorno;
         end if;

         p_retorno := PKG_IMPORT_FORM.fu_discard_prg_plsql_trigger_b (p_id, p_msg_retorno);

         if p_retorno != TRUE then
            return p_retorno;
         end if;
-- ANALYSIS OF DISPOSABLE CONTENTS END.

-- PACKAGE SPEC START.
         p_package_name       := lower (trim (PKG_IMPORT_FORM.p_package_prefix) || p_form_name);
         p_txt_proposed_plsql := p_txt_proposed_plsql ||
                                 'CREATE OR REPLACE PACKAGE ' || p_package_name || ' IS' || chr(10) ||
                                 p_indent || p_pck_name_v || ' varchar2(50) := ''' || upper (p_package_name) || '.'';' ||
                                 chr(10);

         p_txt_proposed_plsql := p_txt_proposed_plsql || PKG_IMPORT_FORM.fu_txt_comments_form_level_c (p_id);

--       p_txt_comments_form_level := PKG_IMPORT_FORM.fu_txt_comments_form_level_c (p_id);
--
--       if p_txt_comments_form_level != empty_clob() then
--          p_txt_proposed_plsql := p_txt_proposed_plsql || chr(10) || p_txt_comments_form_level || chr(10);
--       end if;

--       p_txt_proposed_plsql := p_txt_proposed_plsql || chr(10) || PKG_IMPORT_FORM.fu_ret_txt_global_variables_c (p_id);
--       p_txt_proposed_plsql := p_txt_proposed_plsql || chr(10) || PKG_IMPORT_FORM.fu_ret_txt_system_variables_c (p_id);
         p_txt_proposed_plsql := p_txt_proposed_plsql || chr(10) || PKG_IMPORT_FORM.fu_ret_txt_frm_parameter_lst_c (p_id);
         p_txt_proposed_plsql := p_txt_proposed_plsql || chr(10) || PKG_IMPORT_FORM.fu_ret_txt_record_groups_spc_c (p_id);
         p_txt_proposed_plsql := p_txt_proposed_plsql || chr(10) || PKG_IMPORT_FORM.fu_ret_txt_frm_blk_itm_spc_c (p_id);
         p_txt_proposed_plsql := p_txt_proposed_plsql || chr(10) || PKG_IMPORT_FORM.fu_ret_txt_program_units_spc_c (p_id);
         p_txt_proposed_plsql := p_txt_proposed_plsql ||
                                 'END ' || p_package_name || ';' || chr(10) ||
                                 '/' || chr(10) ||
                                 chr(10);
-- PACKAGE SPEC END.

-- PACKAGE BODY START.
         p_txt_proposed_plsql := p_txt_proposed_plsql || 'CREATE OR REPLACE PACKAGE BODY ' || p_package_name || ' IS';
         p_txt_proposed_plsql := p_txt_proposed_plsql || chr(10) || PKG_IMPORT_FORM.fu_ret_txt_record_groups_bdy_c (p_id);
         p_txt_proposed_plsql := p_txt_proposed_plsql || chr(10) || PKG_IMPORT_FORM.fu_ret_txt_frm_blk_itm_bdy_c (p_id);
         p_txt_proposed_plsql := p_txt_proposed_plsql || chr(10) || PKG_IMPORT_FORM.fu_ret_txt_program_units_bdy_c (p_id);
         p_txt_proposed_plsql := p_txt_proposed_plsql || 'END ' || p_package_name || ';' ||
                                 chr(10) || '/' ||
                                 chr(10);
-- PACKAGE BODY END.

         p_txt_disposed_content        := PKG_IMPORT_FORM.fu_generate_disposa_routines_c (p_id);
         p_txt_oracle_apex_plsql_calls := PKG_IMPORT_FORM.fu_generate_oracle_apex_call_c (p_id);

-- SAVE CONTENTS INTO TABLE
         BEGIN
            p_txt_proposed_plsql_b         := PKG_IMPORT_FORM.fu_convert_clob_to_blob_b (p_txt_proposed_plsql);
            p_txt_disposed_content_b       := PKG_IMPORT_FORM.fu_convert_clob_to_blob_b (p_txt_disposed_content);
            p_txt_oracle_apex_plsql_call_b := PKG_IMPORT_FORM.fu_convert_clob_to_blob_b (p_txt_oracle_apex_plsql_calls);

            update m_load_form mlf
               set mlf.txt_proposed_plsql_b          = p_txt_proposed_plsql_b,
                   mlf.txt_proposed_plsql            = p_txt_proposed_plsql,
                   mlf.txt_proposed_plsql_f          = p_form_name || PKG_IMPORT_FORM.p_txt_proposed_plsql_s,
                   mlf.txt_disposed_content_b        = p_txt_disposed_content_b,
                   mlf.txt_disposed_content          = p_txt_disposed_content,
                   mlf.txt_disposed_content_f        = p_form_name || PKG_IMPORT_FORM.p_txt_disposed_content_s,
                   mlf.txt_oracle_apex_plsql_calls_b = p_txt_oracle_apex_plsql_call_b,
                   mlf.txt_oracle_apex_plsql_calls   = p_txt_oracle_apex_plsql_calls,
                   mlf.txt_oracle_apex_plsql_calls_f = p_form_name || PKG_IMPORT_FORM.p_txt_oracle_apex_plsql_call_s
             where mlf.id                            = p_id;

            DBMS_LOB.freetemporary (p_txt_proposed_plsql);
            DBMS_LOB.freetemporary (p_txt_disposed_content);
            DBMS_LOB.freetemporary (p_txt_oracle_apex_plsql_calls);

         EXCEPTION
            when others then
               p_msg_retorno := 'Erro UPDATE MLF 4 em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

         commit;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_generate_proposed_plsql_b;

-- fu_clean_global_temp_tables_b
   FUNCTION fu_clean_global_temp_tables_b (p_id                 M_LOAD_FORM.id%TYPE,
                                           p_msg_retorno IN OUT varchar2)
                                           RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_clean_global_temp_tables_b (' || p_id || '): ';

   BEGIN
      delete m_load_form_blocks_items   mlfbi  where mlfbi.id_form  = nvl (p_id, mlfbi.id_form);
      delete m_load_form_static_values  mlfsv  where mlfsv.id_form  = nvl (p_id, mlfsv.id_form);
      delete m_load_form_block_relation mlfbr  where mlfbr.id_form  = nvl (p_id, mlfbr.id_form);
      delete m_load_form_plsql_contents mlfpc  where mlfpc.id_form  = nvl (p_id, mlfpc.id_form);
      delete m_load_form_plsql_params   mlfpp  where mlfpp.id_form  = nvl (p_id, mlfpp.id_form);
      delete m_load_form_record_groups  mlfrg  where mlfrg.id_form  = nvl (p_id, mlfrg.id_form);
      delete m_load_form_glob_syst_parm mlfgsp where mlfgsp.id_form = nvl (p_id, mlfgsp.id_form);
      delete m_load_form_list_values    mlflv  where mlflv.id_form  = nvl (p_id, mlflv.id_form);

      delete m_load_form_custom_disposa mlfcd;

      commit;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro DELETE MLFB em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_clean_global_temp_tables_b;

-- fu_count_txt_internal_name_p_b
   FUNCTION fu_count_txt_internal_name_p_b (p_id                 M_LOAD_FORM.id%TYPE,
                                            p_count       IN OUT integer,
                                            p_msg_retorno IN OUT varchar2)
                                            RETURN boolean IS
      p_retorno  boolean        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_count_txt_internal_name_p_b (' || p_id || '): ';

   BEGIN
      if p_id is NULL then
         p_msg_retorno := 'O ID do form carregado deve ser informado.';
         return FALSE;
      else
         p_retorno := PKG_IMPORT_FORM.fu_existe_id_form_b (p_id, p_msg_retorno);

         if p_retorno != TRUE then
            return p_retorno;
         end if;

         BEGIN
            select nvl (count (*), 0) as total
              into p_count
              from m_load_form_lines mlfl
             where mlfl.id_form = p_id
               and mlfl.txt_internal_name_p is not NULL;

         EXCEPTION
            when no_data_found then
               p_count       := 0;
            when others then
               p_msg_retorno := 'Erro SELECT COUNT MLFL em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_count_txt_internal_name_p_b;

-- fu_collect_form_data_b
   FUNCTION fu_collect_form_data_b (p_id                 M_LOAD_FORM.id%TYPE,
                                    p_msg_retorno IN OUT varchar2)
                                    RETURN boolean IS
      p_retorno                     boolean        := NULL;
      p_count_txt_internal_name_p_b integer        := NULL;
      p_existe                      integer        := NULL;
      p_prc_name                    varchar2(1000) := p_pck_name || 'fu_collect_form_data_b (' || p_id || '): ';

   BEGIN
      if p_id is NULL then
         p_msg_retorno := 'O ID do form carregado deve ser informado.';
         return FALSE;
      else
         p_retorno := PKG_IMPORT_FORM.fu_existe_id_form_b (p_id, p_msg_retorno);

         if p_retorno != TRUE then
            return p_retorno;
         end if;

         BEGIN
            select distinct 1
              into p_existe
              from m_load_form_lines mlfl
             where mlfl.id = p_id;

         EXCEPTION
            when no_data_found then
               p_retorno := PKG_IMPORT_FORM.fu_form_lines_from_clob_b (p_id, p_msg_retorno);

               if p_retorno != TRUE then
                  return p_retorno;
               end if;
            when others then
               p_msg_retorno := 'Erro SELECT 1 MLFL em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;

         p_retorno := PKG_IMPORT_FORM.fu_count_txt_internal_name_p_b (p_id, p_count_txt_internal_name_p_b, p_msg_retorno);

         if    p_retorno != TRUE then
            return p_retorno;
         elsif p_count_txt_internal_name_p_b = 0 then
            p_msg_retorno := 'File not correctly processed - unable to continue.';
            return FALSE;
         end if;

         PKG_IMPORT_FORM.p_id_language := nvl (PKG_IMPORT_FORM.fu_detect_form_language_i (p_id), 2);

         if PKG_IMPORT_FORM.p_id_language is NULL then
            p_msg_retorno := 'Language not found.';
            return FALSE;
         else
            p_retorno := PKG_IMPORT_FORM.fu_clean_global_temp_tables_b (p_id, p_msg_retorno);

            if p_retorno != TRUE then
               return p_retorno;
            end if;

            p_retorno := PKG_IMPORT_FORM.fu_ret_form_data_blocks_b (p_id, p_msg_retorno);

            if p_retorno != TRUE then
               return p_retorno;
            end if;

            p_retorno := PKG_IMPORT_FORM.fu_ret_original_name_b (p_id, p_msg_retorno);

            if p_retorno != TRUE then
               return p_retorno;
            end if;

            p_retorno := PKG_IMPORT_FORM.fu_ret_glob_syst_par_vars_b (p_id, p_msg_retorno);

            if p_retorno != TRUE then
               return p_retorno;
            end if;

            p_retorno := PKG_IMPORT_FORM.fu_ret_record_groups_b (p_id, 'SPEC', p_msg_retorno);

            if p_retorno != TRUE then
               return p_retorno;
            end if;

            PKG_IMPORT_FORM.p_plsql_count := 0;

-- FORM TRIGGERS
            p_retorno := PKG_IMPORT_FORM.fu_ret_plsql_form_triggers_b (p_id, 'SPEC', 'FORM', p_msg_retorno);

            if p_retorno != TRUE then
               return p_retorno;
            end if;

-- BLOCK TRIGGERS
            p_retorno := PKG_IMPORT_FORM.fu_ret_plsql_form_triggers_b (p_id, 'SPEC', 'BLOCK', p_msg_retorno);

            if p_retorno != TRUE then
               return p_retorno;
            end if;

-- PROGRAM UNITS
            p_retorno := PKG_IMPORT_FORM.fu_ret_plsql_program_units_b (p_id, 'SPEC', p_msg_retorno);

            if p_retorno != TRUE then
               return p_retorno;
            end if;

            PKG_IMPORT_FORM.p_plsql_count := 0;

            p_retorno := PKG_IMPORT_FORM.fu_ret_record_groups_b (p_id, 'BODY', p_msg_retorno);

            if p_retorno != TRUE then
               return p_retorno;
            end if;

            p_retorno := PKG_IMPORT_FORM.fu_ret_form_list_values_b (p_id, p_msg_retorno);

            if p_retorno != TRUE then
               return p_retorno;
            end if;

-- FORM TRIGGERS
            p_retorno := PKG_IMPORT_FORM.fu_ret_plsql_form_triggers_b (p_id, 'BODY', 'FORM', p_msg_retorno);

            if p_retorno != TRUE then
               return p_retorno;
            end if;

-- BLOCK TRIGGERS
            p_retorno := PKG_IMPORT_FORM.fu_ret_plsql_form_triggers_b (p_id, 'BODY', 'BLOCK', p_msg_retorno);

            if p_retorno != TRUE then
               return p_retorno;
            end if;

-- BLOCK TABLES
            p_retorno := PKG_IMPORT_FORM.fu_ret_block_tables_columns_b (p_id, p_msg_retorno);

            if p_retorno != TRUE then
               return p_retorno;
            end if;

-- PROGRAM UNITS
            p_retorno := PKG_IMPORT_FORM.fu_ret_plsql_program_units_b (p_id, 'BODY', p_msg_retorno);

            if p_retorno != TRUE then
               return p_retorno;
            end if;

-- STATIC VALUES
            p_retorno := PKG_IMPORT_FORM.fu_ret_static_values_b (p_id, p_msg_retorno);

            if p_retorno != TRUE then
               return p_retorno;
            end if;

-- RELATIONS
            p_retorno := PKG_IMPORT_FORM.fu_ret_block_relations_b (p_id, p_msg_retorno);

            if p_retorno != TRUE then
               return p_retorno;
            end if;

-- CREATE/ALTER TABLE SCRIPT
            p_retorno := PKG_IMPORT_FORM.fu_create_alter_table_cols_b (p_id, p_msg_retorno);

            if p_retorno != TRUE then
               return p_retorno;
            end if;

-- GENERATE PROPOSED CHANGES ON FORM CODE SO IT CAN BE REUSED IN ORACLE DATABASE
            p_retorno := PKG_IMPORT_FORM.fu_generate_proposed_plsql_b (p_id, p_msg_retorno);

            if p_retorno != TRUE then
               return p_retorno;
            end if;
         end if;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_collect_form_data_b;

-- fu_generate_files_from_form_b
   FUNCTION fu_generate_files_from_form_b (p_id                 M_LOAD_FORM.id%TYPE,
                                           p_msg_retorno IN OUT varchar2)
                                           RETURN boolean IS
      p_package_body  UTL_FILE.file_type;
      p_package_spec  UTL_FILE.file_type;
      p_retorno       boolean        := NULL;
      p_package_name  varchar2(100)  := NULL;
      p_prc_name      varchar2(1000) := p_pck_name || 'fu_generate_files_from_form_b (' || p_id || '): ';
      p_txt_form_name varchar2(1000) := NULL;

   BEGIN
      if p_id is NULL then
         p_msg_retorno := 'O ID do form carregado deve ser informado.';
         return FALSE;
      else
         p_retorno := PKG_IMPORT_FORM.fu_existe_id_form_b (p_id, p_msg_retorno);

         if p_retorno != TRUE then
            return p_retorno;
         end if;

         p_retorno := PKG_IMPORT_FORM.fu_obter_nome_form_b (p_id, p_txt_form_name, p_msg_retorno);

         if p_retorno != TRUE then
            return p_retorno;
         end if;

         p_package_name := lower (trim (p_package_prefix) || p_txt_form_name);

         p_package_spec := UTL_FILE.fopen (p_directory_name, p_package_name || '.pks', 'w');
         p_package_body := UTL_FILE.fopen (p_directory_name, p_package_name || '.pkb', 'w');

         UTL_FILE.put_line (p_package_spec, 'CREATE OR REPLACE PACKAGE ' || p_package_name || ' IS');
         UTL_FILE.put_line (p_package_spec, p_indent || p_pck_name_v || ' varchar2(50) := ''' || upper (p_package_name) || '.'';');
         UTL_FILE.put_line (p_package_spec, 'END ' || p_package_name || ';');
         UTL_FILE.put_line (p_package_spec, '/');

         UTL_FILE.put_line (p_package_body, 'CREATE OR REPLACE PACKAGE BODY ' || p_package_name || ' IS');
         UTL_FILE.put_line (p_package_body, 'END ' || p_package_name || ';');
         UTL_FILE.put_line (p_package_body, '/');

         UTL_FILE.fclose (p_package_spec);
         UTL_FILE.fclose (p_package_body);
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_generate_files_from_form_b;
END pkg_import_form;
/

CREATE OR REPLACE PACKAGE pkg_m_languages is
   p_pck_name varchar2(50) := 'PKG_M_LANGUAGES.';

-- fu_ret_txt_language_b
   FUNCTION fu_ret_txt_language_b (p_id                  M_LANGUAGES.id%TYPE,
                                   p_txt_language IN OUT M_LANGUAGES.txt_language%TYPE,
                                   p_msg_retorno  IN OUT varchar2)
                                   RETURN boolean;

-- fu_ret_txt_language_v
   FUNCTION fu_ret_txt_language_v (p_id M_LANGUAGES.id%TYPE)
                                   RETURN M_LANGUAGES.txt_language%TYPE;

-- fu_val_m_languages_b
   FUNCTION fu_val_m_languages_b (p_m_languages IN OUT m_languages%ROWTYPE,
                                  p_msg_retorno IN OUT varchar2)
                                  RETURN boolean;
END pkg_m_languages;
/

CREATE OR REPLACE PACKAGE BODY pkg_m_languages is
-- fu_ret_txt_language_b
   FUNCTION fu_ret_txt_language_b (p_id                  M_LANGUAGES.id%TYPE,
                                   p_txt_language IN OUT M_LANGUAGES.txt_language%TYPE,
                                   p_msg_retorno  IN OUT varchar2)
                                   RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_txt_language_b (' || p_id || '): ';

   BEGIN
      if p_id is NULL then
         p_msg_retorno := 'Erro ' || p_prc_name || 'o ID do idioma deve ser informado.';
         return FALSE;
      else
         BEGIN
            select ml.txt_language
              into p_txt_language
              from m_languages ml
             where ml.id = p_id;

         EXCEPTION
            when no_data_found then
               p_msg_retorno := 'O ID do idioma informado (' || p_id || ') não foi encontrado.';
               return FALSE;
            when others then
               p_msg_retorno := 'Erro SELECT ML em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_txt_language_b;

-- fu_ret_txt_language_v
   FUNCTION fu_ret_txt_language_v (p_id M_LANGUAGES.id%TYPE)
                                   RETURN M_LANGUAGES.txt_language%TYPE IS
      p_txt_language M_LANGUAGES.txt_language%TYPE := NULL;
      p_retorno     boolean        := NULL;
      p_prc_name    varchar2(1000) := p_pck_name || 'fu_ret_txt_language_v (' || p_id || '): ';
      p_msg_retorno varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_M_LANGUAGES.fu_ret_txt_language_b (p_id,           -- p_id                  M_LANGUAGES.id%TYPE
                                                          p_txt_language, -- p_txt_language IN OUT M_LANGUAGES.txt_language%TYPE
                                                          p_msg_retorno); -- p_msg_retorno  IN OUT varchar2

      if p_retorno = TRUE then
         return p_txt_language;
      else
         return p_msg_retorno;
      end if;

   EXCEPTION
      when others then
         return 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
   END fu_ret_txt_language_v;

-- fu_val_m_languages_b
   FUNCTION fu_val_m_languages_b (p_m_languages IN OUT m_languages%ROWTYPE,
                                  p_msg_retorno IN OUT varchar2)
                                  RETURN boolean IS
      p_existe   integer        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_val_m_languages_b (' || p_m_languages.id || '): ';
      pragma autonomous_transaction;

   BEGIN
      p_m_languages.txt_language    := trim (upper (p_m_languages.txt_language));
      p_m_languages.txt_observacoes := trim (upper (p_m_languages.txt_observacoes));

      if p_m_languages.txt_language is NULL then
         p_msg_retorno := 'Language name must be informed.';
         return FALSE;
      else
         BEGIN
            select 1
              into p_existe
              from m_languages ml
             where translate (trim (upper (ml.txt_language)),            'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC')
                 = translate (trim (upper (p_m_languages.txt_language)), 'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC')
               and ((ml.id != p_m_languages.id and p_m_languages.id is not NULL) or p_m_languages.id is NULL);

            p_msg_retorno := 'Language "' || p_m_languages.txt_language || '" already informed.';
            return FALSE;

         EXCEPTION
            when no_data_found then
               NULL;
            when others then
               p_msg_retorno := 'Erro SELECT ML em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_val_m_languages_b;
END pkg_m_languages;
/

CREATE OR REPLACE PACKAGE pkg_m_load_form_lines IS
   p_pck_name varchar2(50) := 'PKG_M_LOAD_FORM_LINES.';

-- fu_val_m_load_form_lines_b
   FUNCTION fu_val_m_load_form_lines_b (p_m_load_form_lines IN OUT m_load_form_lines%ROWTYPE,
                                        p_msg_retorno       IN OUT varchar2)
                                        RETURN boolean;
END pkg_m_load_form_lines;
/

CREATE OR REPLACE PACKAGE BODY pkg_m_load_form_lines IS
-- fu_val_m_load_form_lines_b
   FUNCTION fu_val_m_load_form_lines_b (p_m_load_form_lines IN OUT m_load_form_lines%ROWTYPE,
                                        p_msg_retorno       IN OUT varchar2)
                                        RETURN boolean IS
      p_id_language M_LANGUAGES.id%TYPE := NULL;
      p_retorno  boolean        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_val_m_load_form_lines_b (' || p_m_load_form_lines.id || '): ';

   BEGIN
      p_m_load_form_lines.txt_line_m          := NULL;
      p_m_load_form_lines.txt_line_p          := NULL;
      p_m_load_form_lines.txt_line_t          := NULL;
      p_m_load_form_lines.txt_internal_name_m := NULL;
      p_m_load_form_lines.txt_internal_name_p := NULL;

      if substr (trim (p_m_load_form_lines.txt_line), 1, 2) in ('* ', '- ', '^ ', 'o ') then
         if instr (trim (p_m_load_form_lines.txt_line), '  ') = 0 then
            p_m_load_form_lines.txt_line_m := trim (translate (trim (substr (trim (p_m_load_form_lines.txt_line),
                                                                             2)),
                                                               chr(9), ' '));
         else
            p_m_load_form_lines.txt_line_m := trim (translate (trim (substr (trim (p_m_load_form_lines.txt_line),
                                                                             2,
                                                                             instr (trim (p_m_load_form_lines.txt_line), '  '))),
                                                               chr(9), ' '));

            p_m_load_form_lines.txt_line_p := trim (upper (translate (trim (substr (trim (p_m_load_form_lines.txt_line),
                                                                                    instr (trim (p_m_load_form_lines.txt_line), '  '))),
                                                                      chr(9), ' ')));

            p_m_load_form_lines.txt_line_t := trim (translate (trim (substr (trim (p_m_load_form_lines.txt_line),
                                                                             instr (trim (p_m_load_form_lines.txt_line), '  '))),
                                                               chr(9), ' '));
         end if;

         PKG_IMPORT_FORM.p_id_language := nvl (PKG_IMPORT_FORM.fu_ret_id_language_i (p_txt_line => p_m_load_form_lines.txt_line),
                                               PKG_IMPORT_FORM.p_id_language);

         if p_m_load_form_lines.txt_line_m is not NULL then
            p_retorno := PKG_M_FORM_KEYWORDS.fu_ret_txt_internal_name_b (p_m_load_form_lines.txt_line_m,
                                                                         PKG_IMPORT_FORM.p_id_language,
                                                                         p_m_load_form_lines.txt_internal_name_m,
                                                                         p_msg_retorno);

            if p_retorno != TRUE then
               p_msg_retorno := 'Erro P_RETORNO 1 em ' || p_prc_name || p_msg_retorno;
               return FALSE;
            end if;
         end if;

         if p_m_load_form_lines.txt_line_p is not NULL then
            p_retorno := PKG_M_FORM_KEYWORDS_VALUES.fu_ret_txt_internal_name_b (p_m_load_form_lines.txt_line_p,
                                                                                PKG_IMPORT_FORM.p_id_language,
                                                                                p_m_load_form_lines.txt_internal_name_p,
                                                                                p_msg_retorno);

            if p_retorno != TRUE then
               p_msg_retorno := 'Erro P_RETORNO 2 em ' || p_prc_name || p_msg_retorno;
               return FALSE;
            end if;
         end if;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_val_m_load_form_lines_b;
END pkg_m_load_form_lines;
/

CREATE OR REPLACE PACKAGE pkg_m_load_form_blocks_items IS
   p_pck_name varchar2(50) := 'PKG_M_LOAD_FORM_BLOCKS_ITEMS.';

-- fu_m_load_form_blocks_items_b
   FUNCTION fu_m_load_form_blocks_items_b (p_m_load_form_blocks_items IN OUT m_load_form_blocks_items%ROWTYPE,
                                           p_msg_retorno              IN OUT varchar2)
                                           RETURN boolean;
END pkg_m_load_form_blocks_items;
/

CREATE OR REPLACE PACKAGE BODY pkg_m_load_form_blocks_items IS
-- fu_m_load_form_blocks_items_b
   FUNCTION fu_m_load_form_blocks_items_b (p_m_load_form_blocks_items IN OUT m_load_form_blocks_items%ROWTYPE,
                                           p_msg_retorno              IN OUT varchar2)
                                           RETURN boolean IS
      cursor c_m_load_form_custom_disposa is
         select mlfcd.*
           from m_load_form_custom_disposa mlfcd
          where mlfcd.txt_custom_disposable_text is not NULL
            and mlfcd.id_disposable_text_type     = PKG_M_LOAD_FORM_DISPOS_TXT_TYP.fu_ret_disposable_text_type_i ('ORACLE FORMS DATA BLOCK');

      r_m_load_form_custom_disposa c_m_load_form_custom_disposa%ROWTYPE := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_m_load_form_blocks_items_b (' || p_m_load_form_blocks_items.id || '): ';

   BEGIN
      p_m_load_form_blocks_items.txt_data_origin                := trim (upper (p_m_load_form_blocks_items.txt_data_origin));
      p_m_load_form_blocks_items.txt_block_name                 := trim (upper (p_m_load_form_blocks_items.txt_block_name));
      p_m_load_form_blocks_items.txt_item_name                  := trim (upper (p_m_load_form_blocks_items.txt_item_name));
      p_m_load_form_blocks_items.txt_block_single_record        := trim (upper (p_m_load_form_blocks_items.txt_block_single_record));
      p_m_load_form_blocks_items.txt_block_database_data_block  := trim (upper (p_m_load_form_blocks_items.txt_block_database_data_block));
      p_m_load_form_blocks_items.txt_block_query_allowed        := trim (upper (p_m_load_form_blocks_items.txt_block_query_allowed));
      p_m_load_form_blocks_items.txt_block_insert_allowed       := trim (upper (p_m_load_form_blocks_items.txt_block_insert_allowed));
      p_m_load_form_blocks_items.txt_block_update_allowed       := trim (upper (p_m_load_form_blocks_items.txt_block_update_allowed));
      p_m_load_form_blocks_items.txt_block_delete_allowed       := trim (upper (p_m_load_form_blocks_items.txt_block_delete_allowed));
      p_m_load_form_blocks_items.txt_block_query_data_orig_type := trim (upper (p_m_load_form_blocks_items.txt_block_query_data_orig_type));
      p_m_load_form_blocks_items.txt_item_item_type             := trim (upper (p_m_load_form_blocks_items.txt_item_item_type));
      p_m_load_form_blocks_items.txt_item_enabled               := trim (upper (p_m_load_form_blocks_items.txt_item_enabled));
      p_m_load_form_blocks_items.txt_item_justification         := trim (upper (p_m_load_form_blocks_items.txt_item_justification));
      p_m_load_form_blocks_items.txt_item_multiline             := trim (upper (p_m_load_form_blocks_items.txt_item_multiline));
      p_m_load_form_blocks_items.txt_item_case_letter           := trim (upper (p_m_load_form_blocks_items.txt_item_case_letter));
      p_m_load_form_blocks_items.txt_item_conceal_data          := trim (upper (p_m_load_form_blocks_items.txt_item_conceal_data));
      p_m_load_form_blocks_items.txt_item_field_autofill        := trim (upper (p_m_load_form_blocks_items.txt_item_field_autofill));
      p_m_load_form_blocks_items.txt_item_field_datatype        := trim (upper (p_m_load_form_blocks_items.txt_item_field_datatype));
      p_m_load_form_blocks_items.txt_item_field_maxlength       := trim (upper (p_m_load_form_blocks_items.txt_item_field_maxlength));
      p_m_load_form_blocks_items.txt_item_field_precision       := trim (upper (p_m_load_form_blocks_items.txt_item_field_precision));
      p_m_load_form_blocks_items.txt_item_field_scale           := trim (upper (p_m_load_form_blocks_items.txt_item_field_scale));
      p_m_load_form_blocks_items.txt_item_field_inivalue        := trim (upper (p_m_load_form_blocks_items.txt_item_field_inivalue));
      p_m_load_form_blocks_items.txt_item_field_mandatory       := trim (upper (p_m_load_form_blocks_items.txt_item_field_mandatory));
      p_m_load_form_blocks_items.txt_item_field_format_mask     := trim (upper (p_m_load_form_blocks_items.txt_item_field_format_mask));
      p_m_load_form_blocks_items.txt_item_field_minvalue        := trim (upper (p_m_load_form_blocks_items.txt_item_field_minvalue));
      p_m_load_form_blocks_items.txt_item_field_maxvalue        := trim (upper (p_m_load_form_blocks_items.txt_item_field_maxvalue));
      p_m_load_form_blocks_items.txt_item_field_copy_value_from := trim (upper (p_m_load_form_blocks_items.txt_item_field_copy_value_from));
      p_m_load_form_blocks_items.txt_item_field_database        := trim (upper (p_m_load_form_blocks_items.txt_item_field_database));
      p_m_load_form_blocks_items.txt_item_field_db_col_name     := trim (upper (p_m_load_form_blocks_items.txt_item_field_db_col_name));
      p_m_load_form_blocks_items.txt_item_field_primary_key     := trim (upper (p_m_load_form_blocks_items.txt_item_field_primary_key));
      p_m_load_form_blocks_items.txt_item_field_read_only       := trim (upper (p_m_load_form_blocks_items.txt_item_field_read_only));
      p_m_load_form_blocks_items.txt_item_field_qry_allowed     := trim (upper (p_m_load_form_blocks_items.txt_item_field_qry_allowed));
      p_m_load_form_blocks_items.txt_item_field_ins_allowed     := trim (upper (p_m_load_form_blocks_items.txt_item_field_ins_allowed));
      p_m_load_form_blocks_items.txt_item_field_upd_allowed     := trim (upper (p_m_load_form_blocks_items.txt_item_field_upd_allowed));
      p_m_load_form_blocks_items.txt_item_field_visible         := trim (upper (p_m_load_form_blocks_items.txt_item_field_visible));
      p_m_load_form_blocks_items.txt_observacoes                := trim (upper (p_m_load_form_blocks_items.txt_observacoes));
      p_m_load_form_blocks_items.txt_item_calculation_mode      := trim (upper (p_m_load_form_blocks_items.txt_item_calculation_mode));

      p_m_load_form_blocks_items.txt_block_query_data_orig_name := trim (p_m_load_form_blocks_items.txt_block_query_data_orig_name);

      p_m_load_form_blocks_items.txt_disposable_data_block      := nvl (trim (upper (p_m_load_form_blocks_items.txt_disposable_data_block)), 'N');

      if    p_m_load_form_blocks_items.txt_disposable_data_block not in ('Y', 'N') then
         p_m_load_form_blocks_items.txt_disposable_data_block := 'N';
      else
         for r_m_load_form_custom_disposa in c_m_load_form_custom_disposa loop
            BEGIN
               update m_load_form_plsql_contents mlfpc
                  set mlfpc.txt_disposable_routine = 'Y',
                      mlfpc.txt_disposable_reason  = PKG_M_LOAD_FORM_PLSQL_DISC_RSN.fu_ret_discard_reason_key_v ('CUSTFRMBLK')
                where mlfpc.id_form                = p_m_load_form_blocks_items.id_form
                  and mlfpc.txt_block_source       = r_m_load_form_custom_disposa.txt_custom_disposable_text;

            EXCEPTION
               when others then
                  p_msg_retorno := 'Erro UPDATE MLFPC 9 (' || r_m_load_form_custom_disposa.txt_custom_disposable_text ||
                                                   ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                  return FALSE;
            END;
         end loop;
      end if;

      if p_m_load_form_blocks_items.txt_block_name is not NULL and p_m_load_form_blocks_items.txt_item_name is not NULL then
         p_m_load_form_blocks_items.txt_block_item_name := ':' || p_m_load_form_blocks_items.txt_block_name || '.' || p_m_load_form_blocks_items.txt_item_name;
      end if;

      if   p_m_load_form_blocks_items.txt_item_name          is not NULL
       and p_m_load_form_blocks_items.txt_data_origin        =  'BLOCKS AND ITEMS'
       and p_m_load_form_blocks_items.txt_item_item_type not in ('PUSH_BUTTON') then
         p_m_load_form_blocks_items.txt_variable_parameter_name := trim (lower (PKG_IMPORT_FORM.p_parameter_prefix ||
                                                                                substr (translate (p_m_load_form_blocks_items.txt_item_name,
                                                                                                   'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜYÑÇ',
                                                                                                   'AAAAAEEEEIIIIOOOOOUUUUYNC'),
                                                                                        1,
                                                                                        PKG_IMPORT_FORM.p_oracle_objects_size
                                                                                        - length (PKG_IMPORT_FORM.p_parameter_prefix)
                                                                                        - length ('_' || trim (to_char (p_m_load_form_blocks_items.id_rownum, '0000000'))))))
                                                                   || '_'
                                                                   || trim (to_char (p_m_load_form_blocks_items.id_rownum, '0000000'));
      end if;

      p_m_load_form_blocks_items.txt_comments                   := trim (p_m_load_form_blocks_items.txt_comments);
      p_m_load_form_blocks_items.txt_item_field_hint_1          := trim (p_m_load_form_blocks_items.txt_item_field_hint_1);
      p_m_load_form_blocks_items.txt_item_field_hint_2          := trim (p_m_load_form_blocks_items.txt_item_field_hint_2);
      p_m_load_form_blocks_items.txt_block_where_clause         := trim (p_m_load_form_blocks_items.txt_block_where_clause);
      p_m_load_form_blocks_items.txt_block_order_by             := trim (p_m_load_form_blocks_items.txt_block_order_by);

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_m_load_form_blocks_items_b;
END pkg_m_load_form_blocks_items;
/

CREATE OR REPLACE PACKAGE pkg_m_load_form_static_values IS
   p_pck_name varchar2(50) := 'PKG_M_LOAD_FORM_STATIC_VALUES.';

-- fu_val_m_load_form_static_va_b
   FUNCTION fu_val_m_load_form_static_va_b (p_m_load_form_static_values IN OUT m_load_form_static_values%ROWTYPE,
                                            p_msg_retorno               IN OUT varchar2)
                                            RETURN boolean;
END pkg_m_load_form_static_values;
/

CREATE OR REPLACE PACKAGE BODY pkg_m_load_form_static_values IS
-- fu_val_m_load_form_static_va_b
   FUNCTION fu_val_m_load_form_static_va_b (p_m_load_form_static_values IN OUT m_load_form_static_values%ROWTYPE,
                                            p_msg_retorno               IN OUT varchar2)
                                            RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_val_m_load_form_static_va_b (' || p_m_load_form_static_values.id || '): ';

   BEGIN
      p_m_load_form_static_values.txt_static_data_origin         := trim (upper (p_m_load_form_static_values.txt_static_data_origin));
      p_m_load_form_static_values.txt_block_name                 := trim (upper (p_m_load_form_static_values.txt_block_name));
      p_m_load_form_static_values.txt_block_item_name            := trim (upper (p_m_load_form_static_values.txt_block_item_name));
      p_m_load_form_static_values.txt_block_item_radbut_name     := trim (upper (p_m_load_form_static_values.txt_block_item_radbut_name));
      p_m_load_form_static_values.txt_record_group_name          := trim (upper (p_m_load_form_static_values.txt_record_group_name));
      p_m_load_form_static_values.txt_colspec_column_name        := trim (upper (p_m_load_form_static_values.txt_colspec_column_name));
      p_m_load_form_static_values.txt_colspec_column_data_type   := trim (upper (p_m_load_form_static_values.txt_colspec_column_data_type));
      p_m_load_form_static_values.txt_observacoes                := trim (upper (p_m_load_form_static_values.txt_observacoes));

      p_m_load_form_static_values.txt_block_item_radbut_label    := trim (p_m_load_form_static_values.txt_block_item_radbut_label);
      p_m_load_form_static_values.txt_block_item_radbut_value    := trim (p_m_load_form_static_values.txt_block_item_radbut_value);
      p_m_load_form_static_values.txt_recorg_group_col_val_lst_n := trim (p_m_load_form_static_values.txt_recorg_group_col_val_lst_n);
      p_m_load_form_static_values.txt_recorg_group_col_val_lst_v := trim (p_m_load_form_static_values.txt_recorg_group_col_val_lst_v);

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_val_m_load_form_static_va_b;
END pkg_m_load_form_static_values;
/

CREATE OR REPLACE PACKAGE pkg_m_load_form_block_relation IS
   p_pck_name varchar2(50) := 'PKG_M_LOAD_FORM_BLOCK_RELATION.';

-- fu_val_m_load_form_block_rel_b
   FUNCTION fu_val_m_load_form_block_rel_b (p_m_load_form_block_relation IN OUT m_load_form_block_relation%ROWTYPE,
                                            p_msg_retorno                IN OUT varchar2)
                                            RETURN boolean;
END pkg_m_load_form_block_relation;
/

CREATE OR REPLACE PACKAGE BODY pkg_m_load_form_block_relation IS
-- fu_val_m_load_form_block_rel_b
   FUNCTION fu_val_m_load_form_block_rel_b (p_m_load_form_block_relation IN OUT m_load_form_block_relation%ROWTYPE,
                                            p_msg_retorno                IN OUT varchar2)
                                            RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_val_m_load_form_block_rel_b (' || p_m_load_form_block_relation.id || '): ';

   BEGIN
      p_m_load_form_block_relation.txt_relation_name          := trim (upper (p_m_load_form_block_relation.txt_relation_name));
      p_m_load_form_block_relation.txt_relation_type          := trim (upper (p_m_load_form_block_relation.txt_relation_type));
      p_m_load_form_block_relation.txt_master_data_block      := trim (upper (p_m_load_form_block_relation.txt_master_data_block));
      p_m_load_form_block_relation.txt_master_data_block_item := trim (upper (p_m_load_form_block_relation.txt_master_data_block_item));
      p_m_load_form_block_relation.txt_detail_data_block      := trim (upper (p_m_load_form_block_relation.txt_detail_data_block));
      p_m_load_form_block_relation.txt_detail_data_block_item := trim (upper (p_m_load_form_block_relation.txt_detail_data_block_item));
      p_m_load_form_block_relation.txt_observacoes            := trim (upper (p_m_load_form_block_relation.txt_observacoes));
      p_m_load_form_block_relation.txt_detailed_data_block    := trim (upper (p_m_load_form_block_relation.txt_detailed_data_block));

      p_m_load_form_block_relation.txt_join_condition         := trim (p_m_load_form_block_relation.txt_join_condition);

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_val_m_load_form_block_rel_b;
END pkg_m_load_form_block_relation;
/

CREATE OR REPLACE PACKAGE pkg_m_load_form_plsql_contents IS
   p_pck_name varchar2(50) := 'PKG_M_LOAD_FORM_PLSQL_CONTENTS.';

-- fu_val_m_load_form_plsql_con_b
   FUNCTION fu_val_m_load_form_plsql_con_b (p_m_load_form_plsql_contents IN OUT m_load_form_plsql_contents%ROWTYPE,
                                            p_msg_retorno                IN OUT varchar2)
                                            RETURN boolean;

-- fu_collect_block_gsp_items_b
   FUNCTION fu_collect_block_gsp_items_b (p_m_load_form_plsql_contents IN OUT m_load_form_plsql_contents%ROWTYPE,
                                          p_msg_retorno                IN OUT varchar2)
                                          RETURN boolean;
END pkg_m_load_form_plsql_contents;
/

CREATE OR REPLACE PACKAGE BODY pkg_m_load_form_plsql_contents IS
-- fu_val_m_load_form_plsql_con_b
   FUNCTION fu_val_m_load_form_plsql_con_b (p_m_load_form_plsql_contents IN OUT m_load_form_plsql_contents%ROWTYPE,
                                            p_msg_retorno                IN OUT varchar2)
                                            RETURN boolean IS
      p_retorno  boolean        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_val_m_load_form_plsql_con_b (' || p_m_load_form_plsql_contents.id || '): ';

   BEGIN
      p_m_load_form_plsql_contents.txt_generated_function_name := trim (upper (p_m_load_form_plsql_contents.txt_generated_function_name));
      p_m_load_form_plsql_contents.txt_plsql_source            := trim (upper (p_m_load_form_plsql_contents.txt_plsql_source));
      p_m_load_form_plsql_contents.txt_block_source            := trim (upper (p_m_load_form_plsql_contents.txt_block_source));
      p_m_load_form_plsql_contents.txt_plsql_program_unit_type := trim (upper (p_m_load_form_plsql_contents.txt_plsql_program_unit_type));
      p_m_load_form_plsql_contents.txt_block_item_source       := trim (upper (p_m_load_form_plsql_contents.txt_block_item_source));
      p_m_load_form_plsql_contents.txt_plsql_object_name       := trim (upper (p_m_load_form_plsql_contents.txt_plsql_object_name));
      p_m_load_form_plsql_contents.txt_observacoes             := trim (upper (p_m_load_form_plsql_contents.txt_observacoes));
      p_m_load_form_plsql_contents.txt_disposable_reason       := trim (upper (p_m_load_form_plsql_contents.txt_disposable_reason));

      p_m_load_form_plsql_contents.txt_comments                := trim (p_m_load_form_plsql_contents.txt_comments);

      p_m_load_form_plsql_contents.txt_disposable_routine      := nvl (trim (upper (p_m_load_form_plsql_contents.txt_disposable_routine)), 'N');

      if p_m_load_form_plsql_contents.txt_disposable_routine not in ('Y', 'N') then
         p_m_load_form_plsql_contents.txt_disposable_routine := 'N';
      end if;

      p_m_load_form_plsql_contents.clob_plsql_contents_no_comm := PKG_IMPORT_FORM.fu_remove_plsql_comments_c (p_m_load_form_plsql_contents.clob_plsql_contents);

--    if p_m_load_form_plsql_contents.txt_disposable_routine = 'N' then
--       p_retorno := PKG_IMPORT_FORM.fu_discard_prg_unit_per_line_b (p_m_load_form_plsql_contents.id_form,
--                                                                    p_m_load_form_plsql_contents.clob_plsql_contents_no_comm,
--                                                                    p_msg_retorno);
--
--       if    p_retorno = TRUE then
--          p_m_load_form_plsql_contents.txt_disposable_routine := 'Y';
--          p_m_load_form_plsql_contents.txt_disposable_reason  := 'ALL LINES DISPOSABLE';
--       elsif p_retorno = FALSE and p_msg_retorno is NULL then
--          p_m_load_form_plsql_contents.txt_disposable_routine := 'N';
--       else
--          p_msg_retorno := 'Erro P_RETORNO (' || p_m_load_form_plsql_contents.id_form                     ||
--                                         ', ' || p_m_load_form_plsql_contents.txt_generated_function_name ||
--                                      ') em ' || p_prc_name || p_msg_retorno;
--          return FALSE;
--       end if;
--    end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_val_m_load_form_plsql_con_b;

-- fu_collect_block_gsp_items_b
   FUNCTION fu_collect_block_gsp_items_b (p_m_load_form_plsql_contents IN OUT m_load_form_plsql_contents%ROWTYPE,
                                          p_msg_retorno                IN OUT varchar2)
                                          RETURN boolean IS
      cursor c_original_prg_unit_param_list is
         select trim (substr (txt_parameter_declaration, 1, instr (txt_parameter_declaration, ' '))) as txt_parameter_name,
                trim (substr (txt_parameter_declaration,    instr (txt_parameter_declaration, ' '))) as txt_variable_declaration
           from (with data as (select PKG_IMPORT_FORM.fu_ret_prg_unit_orig_param_l_v (p_clob_plsql_contents => p_m_load_form_plsql_contents.clob_plsql_contents_no_comm) as txt_parameter_declaration from dual)
                 select trim (regexp_substr (txt_parameter_declaration, '[^,]+', 1, level)) as txt_parameter_declaration from data
        connect by instr (txt_parameter_declaration, ',', 1, level - 1) > 0);

      r_original_prg_unit_param_list c_original_prg_unit_param_list%ROWTYPE := NULL;
      p_retorno                      boolean        := NULL;
      p_parameter_list               clob           := empty_clob();
      p_count                        integer        := 0;
      p_parameter_list_item          varchar2(100)  := NULL;
      p_prc_name                     varchar2(1000) := p_pck_name || 'fu_collect_block_gsp_items_b (' || p_m_load_form_plsql_contents.id || '): ';
      p_program_unit_header          varchar2(4000) := NULL;

   BEGIN
-- Collect all references of :GLOBAL.ITEM, :SYSTEM.ITEM, :PARAMETER.ITEM and :BLOCK.ITEM for non-disposable routines
      if p_m_load_form_plsql_contents.clob_plsql_contents_no_comm != empty_clob() and p_m_load_form_plsql_contents.txt_disposable_routine = 'N' then
         p_m_load_form_plsql_contents.clob_plsql_contents_no_comm := PKG_IMPORT_FORM.fu_chg_item_to_block_item_c (p_m_load_form_plsql_contents.id_form,
                                                                                                                  p_m_load_form_plsql_contents.clob_plsql_contents_no_comm);

         p_retorno := PKG_IMPORT_FORM.fu_collect_block_items_b (p_m_load_form_plsql_contents.id_form,
                                                                p_m_load_form_plsql_contents.clob_plsql_contents_no_comm,
                                                                p_parameter_list,
                                                                p_msg_retorno);

         if p_retorno != TRUE then
            p_msg_retorno := 'Erro P_RETORNO COLLECT BLOCK_ITEM em ' || p_prc_name || p_msg_retorno;
            return FALSE;
         end if;

         p_retorno := PKG_IMPORT_FORM.fu_collect_glob_syst_param_b (p_m_load_form_plsql_contents.id_form,
                                                                    p_m_load_form_plsql_contents.clob_plsql_contents_no_comm,
                                                                    p_parameter_list,
                                                                    p_msg_retorno);

         if p_retorno != TRUE then
            p_msg_retorno := 'Erro P_RETORNO GSP em ' || p_prc_name || p_msg_retorno;
            return p_retorno;
         end if;

         if p_parameter_list != empty_clob() and instr (p_parameter_list, ';') > 0 then
            loop
               p_count := p_count + 1;

               if p_count > 10000 then
                  raise_application_error (-20001, 'Demora excessiva. ' || p_m_load_form_plsql_contents.id                          ||
                                                                   ', ' || p_m_load_form_plsql_contents.id_form                     ||
                                                                   ', ' || p_m_load_form_plsql_contents.id_rownum                   ||
                                                                   ', ' || p_m_load_form_plsql_contents.txt_generated_function_name ||
                                                                   ', ' || p_m_load_form_plsql_contents.txt_plsql_program_unit_type ||
                                                                   ', ' || p_m_load_form_plsql_contents.txt_plsql_source            ||
                                                                   ', ' || p_m_load_form_plsql_contents.txt_block_source            ||
                                                                   ', ' || p_m_load_form_plsql_contents.txt_block_item_source       ||
                                                                   ', ' || p_m_load_form_plsql_contents.txt_plsql_object_name       ||
                                                                    '"' || p_parameter_list                                         || '"');
               end if;

               p_parameter_list_item := substr (p_parameter_list, 1, instr (p_parameter_list, ';') - 1);
               exit when nvl (p_parameter_list, ';') in (';', ';;') or p_parameter_list = empty_clob();
               p_parameter_list      := substr (p_parameter_list, instr (p_parameter_list, ';') + 1);

               if p_parameter_list_item is not NULL then
                  BEGIN
                     insert into m_load_form_plsql_params (id_form,
                                                           id_plsql_contents,
                                                           txt_block_item_gsp_variable)
                                                   values (p_m_load_form_plsql_contents.id_form,
                                                           p_m_load_form_plsql_contents.id,
                                                           p_parameter_list_item);

                  EXCEPTION
                     when others then
                        p_msg_retorno := 'Erro INSERT MLFPP 2 (' || p_parameter_list_item || ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                        return FALSE;
                  END;
               end if;
            end loop;
         end if;

         if p_m_load_form_plsql_contents.txt_plsql_program_unit_type in ('FUNCTION', 'PROCEDURE') then
            for r_original_prg_unit_param_list in c_original_prg_unit_param_list loop
-- INCLUIR SOMENTE PARÂMETROS DA DECLARAÇÃO DA FUNCTION/PROCEDURE.
               if   r_original_prg_unit_param_list.txt_parameter_name       is not NULL
                and instr (r_original_prg_unit_param_list.txt_parameter_name, ':') = 0
                and r_original_prg_unit_param_list.txt_variable_declaration is not NULL then
                  BEGIN
                     insert into m_load_form_plsql_params (id_form,
                                                           id_plsql_contents,
                                                           txt_block_item_gsp_variable,
                                                           txt_variable_declaration)
                                                   values (p_m_load_form_plsql_contents.id_form,
                                                           p_m_load_form_plsql_contents.id,
                                                           r_original_prg_unit_param_list.txt_parameter_name,
                                                           r_original_prg_unit_param_list.txt_variable_declaration);

                  EXCEPTION
                     when others then
                        p_msg_retorno := 'Erro INSERT MLFPP 1 (' || p_parameter_list_item || ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
                        return FALSE;
                  END;
               end if;
            end loop;
         end if;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_collect_block_gsp_items_b;
END pkg_m_load_form_plsql_contents;
/

CREATE OR REPLACE PACKAGE pkg_m_load_form_plsql_params IS
   p_pck_name varchar2(50) := 'PKG_M_LOAD_FORM_PLSQL_PARAMS.';

-- fu_val_m_load_form_plsql_par_b
   FUNCTION fu_val_m_load_form_plsql_par_b (p_m_load_form_plsql_params IN OUT m_load_form_plsql_params%ROWTYPE,
                                            p_msg_retorno              IN OUT varchar2)
                                            RETURN boolean;
END pkg_m_load_form_plsql_params;
/

CREATE OR REPLACE PACKAGE BODY pkg_m_load_form_plsql_params IS
-- fu_val_m_load_form_plsql_par_b
   FUNCTION fu_val_m_load_form_plsql_par_b (p_m_load_form_plsql_params IN OUT m_load_form_plsql_params%ROWTYPE,
                                            p_msg_retorno              IN OUT varchar2)
                                            RETURN boolean IS
      p_existe   integer        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_val_m_load_form_plsql_par_b (' || p_m_load_form_plsql_params.id || '): ';
      pragma autonomous_transaction;

   BEGIN
      p_m_load_form_plsql_params.txt_block_item_gsp_variable := trim (upper (p_m_load_form_plsql_params.txt_block_item_gsp_variable));
      p_m_load_form_plsql_params.txt_observacoes             := trim (upper (p_m_load_form_plsql_params.txt_observacoes));

      p_m_load_form_plsql_params.txt_variable_declaration    := nvl (trim (replace (p_m_load_form_plsql_params.txt_variable_declaration, chr(9), ' ')), 'IN OUT');

      p_m_load_form_plsql_params.txt_variable_type           := nvl (trim (translate (substr (p_m_load_form_plsql_params.txt_block_item_gsp_variable,
                                                                                              1,
                                                                                              instr (p_m_load_form_plsql_params.txt_block_item_gsp_variable, '.')),
                                                                                      ':.', '  ')),
                                                                     'DECLARATION');

      if   p_m_load_form_plsql_params.id_form                     is not NULL
       and p_m_load_form_plsql_params.id_plsql_contents           is not NULL
       and p_m_load_form_plsql_params.txt_block_item_gsp_variable is not NULL then
         BEGIN
            select 1
              into p_existe
              from m_load_form_plsql_params mlfpp
             where mlfpp.id_form                     = p_m_load_form_plsql_params.id_form
               and mlfpp.id_plsql_contents           = p_m_load_form_plsql_params.id_plsql_contents
               and mlfpp.txt_block_item_gsp_variable = p_m_load_form_plsql_params.txt_block_item_gsp_variable;

            p_msg_retorno := NULL; -- Não é erro. A variável já foi cadastrada
            return FALSE;

         EXCEPTION
            when no_data_found then
               NULL;
            when others then
               p_msg_retorno := 'Erro SELECT MLFPP 1 (' || p_m_load_form_plsql_params.id_form                     ||
                                                   ', ' || p_m_load_form_plsql_params.id_plsql_contents           ||
                                                   ', ' || p_m_load_form_plsql_params.txt_block_item_gsp_variable ||
                                                ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_val_m_load_form_plsql_par_b;
END pkg_m_load_form_plsql_params;
/

CREATE OR REPLACE PACKAGE pkg_m_load_form_record_groups IS
   p_pck_name varchar2(50) := 'PKG_M_LOAD_FORM_RECORD_GROUPS.';

-- fu_val_m_load_form_record_gr_b
   FUNCTION fu_val_m_load_form_record_gr_b (p_m_load_form_record_groups IN OUT m_load_form_record_groups%ROWTYPE,
                                            p_msg_retorno               IN OUT varchar2)
                                            RETURN boolean;
END pkg_m_load_form_record_groups;
/

CREATE OR REPLACE PACKAGE BODY pkg_m_load_form_record_groups IS
-- fu_val_m_load_form_record_gr_b
   FUNCTION fu_val_m_load_form_record_gr_b (p_m_load_form_record_groups IN OUT m_load_form_record_groups%ROWTYPE,
                                            p_msg_retorno               IN OUT varchar2)
                                            RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_val_m_load_form_record_gr_b (' || p_m_load_form_record_groups.id || '): ';

   BEGIN
      p_m_load_form_record_groups.txt_record_group_name         := trim (upper (p_m_load_form_record_groups.txt_record_group_name));
      p_m_load_form_record_groups.txt_record_group_type         := trim (upper (p_m_load_form_record_groups.txt_record_group_type));
      p_m_load_form_record_groups.txt_record_group_col_name     := trim (upper (p_m_load_form_record_groups.txt_record_group_col_name));
      p_m_load_form_record_groups.txt_record_group_col_maxsize  := trim (upper (p_m_load_form_record_groups.txt_record_group_col_maxsize));
      p_m_load_form_record_groups.txt_record_group_col_datatype := trim (upper (p_m_load_form_record_groups.txt_record_group_col_datatype));
      p_m_load_form_record_groups.txt_observacoes               := trim (upper (p_m_load_form_record_groups.txt_observacoes));

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_val_m_load_form_record_gr_b;
END pkg_m_load_form_record_groups;
/

CREATE OR REPLACE PACKAGE pkg_m_load_form_glob_syst_parm IS
   p_pck_name varchar2(50) := 'PKG_M_LOAD_FORM_GLOB_SYST_PARM.';

-- fu_val_m_load_form_glob_syst_b
   FUNCTION fu_val_m_load_form_glob_syst_b (p_m_load_form_glob_syst_parm IN OUT m_load_form_glob_syst_parm%ROWTYPE,
                                            p_msg_retorno                IN OUT varchar2)
                                            RETURN boolean;
END pkg_m_load_form_glob_syst_parm;
/

CREATE OR REPLACE PACKAGE BODY pkg_m_load_form_glob_syst_parm IS
-- fu_val_m_load_form_glob_syst_b
   FUNCTION fu_val_m_load_form_glob_syst_b (p_m_load_form_glob_syst_parm IN OUT m_load_form_glob_syst_parm%ROWTYPE,
                                            p_msg_retorno                IN OUT varchar2)
                                            RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_val_m_load_form_glob_syst_b (' || p_m_load_form_glob_syst_parm.id || '): ';

   BEGIN
      p_m_load_form_glob_syst_parm.txt_variable_type           := trim (upper (p_m_load_form_glob_syst_parm.txt_variable_type));
      p_m_load_form_glob_syst_parm.txt_variable_name           := trim (upper (p_m_load_form_glob_syst_parm.txt_variable_name));
      p_m_load_form_glob_syst_parm.txt_variable_data_type      := trim (upper (p_m_load_form_glob_syst_parm.txt_variable_data_type));
      p_m_load_form_glob_syst_parm.txt_variable_max_size       := trim (upper (p_m_load_form_glob_syst_parm.txt_variable_max_size));
      p_m_load_form_glob_syst_parm.txt_observacoes             := trim (upper (p_m_load_form_glob_syst_parm.txt_observacoes));

      if p_m_load_form_glob_syst_parm.txt_variable_name is not NULL then
         p_m_load_form_glob_syst_parm.txt_variable_parameter_name := trim (lower (PKG_IMPORT_FORM.p_parameter_prefix ||
                                                                                  substr (trim (translate (p_m_load_form_glob_syst_parm.txt_variable_name, ':.', ' _')),
                                                                                          1,
                                                                                          PKG_IMPORT_FORM.p_oracle_objects_size
                                                                                          - length (PKG_IMPORT_FORM.p_parameter_prefix))));
      end if;

      p_m_load_form_glob_syst_parm.txt_variable_ini_value      := trim (p_m_load_form_glob_syst_parm.txt_variable_ini_value);

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_val_m_load_form_glob_syst_b;
END pkg_m_load_form_glob_syst_parm;
/

CREATE OR REPLACE PACKAGE pkg_m_load_form_trigger_types IS
   p_pck_name varchar2(50) := 'PKG_M_LOAD_FORM_TRIGGER_TYPES.';

-- fu_ret_id_form_trigger_type_b
   FUNCTION fu_ret_id_form_trigger_type_b (p_txt_trigger_type_name        M_LOAD_FORM_TRIGGER_TYPES.txt_trigger_type_name%TYPE,
                                           p_id                    IN OUT M_LOAD_FORM_TRIGGER_TYPES.id%TYPE,
                                           p_msg_retorno           IN OUT varchar2)
                                           RETURN boolean;

-- fu_ret_id_form_trigger_type_i
   FUNCTION fu_ret_id_form_trigger_type_i (p_txt_trigger_type_name M_LOAD_FORM_TRIGGER_TYPES.txt_trigger_type_name%TYPE)
                                           RETURN M_LOAD_FORM_TRIGGER_TYPES.id%TYPE;

-- fu_val_m_load_form_trigger_t_b
   FUNCTION fu_val_m_load_form_trigger_t_b (p_m_load_form_trigger_types IN OUT m_load_form_trigger_types%ROWTYPE,
                                            p_msg_retorno               IN OUT varchar2)
                                            RETURN boolean;
END pkg_m_load_form_trigger_types;
/

CREATE OR REPLACE PACKAGE BODY pkg_m_load_form_trigger_types IS
-- fu_ret_id_form_trigger_type_b
   FUNCTION fu_ret_id_form_trigger_type_b (p_txt_trigger_type_name        M_LOAD_FORM_TRIGGER_TYPES.txt_trigger_type_name%TYPE,
                                           p_id                    IN OUT M_LOAD_FORM_TRIGGER_TYPES.id%TYPE,
                                           p_msg_retorno           IN OUT varchar2)
                                           RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_ret_id_form_trigger_type_b (' || p_txt_trigger_type_name || '): ';

   BEGIN
      if trim (p_txt_trigger_type_name) is NULL then
         p_id := NULL;
      else
         BEGIN
            select mlftt.id
              into p_id
              from m_load_form_trigger_types mlftt
             where translate (trim (mlftt.txt_trigger_type_name), 'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC')
                 = translate (trim (p_txt_trigger_type_name),     'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜYÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC');

         EXCEPTION
            when no_data_found then
               p_msg_retorno := 'O tipo de trigger "' || p_txt_trigger_type_name || '" não foi encontrado.';
               return FALSE;
            when others then
               p_msg_retorno := 'Erro SELECT MLFTT em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_ret_id_form_trigger_type_b;

-- fu_ret_id_form_trigger_type_i
   FUNCTION fu_ret_id_form_trigger_type_i (p_txt_trigger_type_name M_LOAD_FORM_TRIGGER_TYPES.txt_trigger_type_name%TYPE)
                                           RETURN M_LOAD_FORM_TRIGGER_TYPES.id%TYPE IS
      p_id M_LOAD_FORM_TRIGGER_TYPES.id%TYPE := NULL;
      p_retorno     boolean        := NULL;
      p_prc_name    varchar2(1000) := p_pck_name || 'fu_ret_id_form_trigger_type_i (' || p_txt_trigger_type_name || '): ';
      p_msg_retorno varchar2(4000) := NULL;

   BEGIN
      p_retorno := PKG_M_LOAD_FORM_TRIGGER_TYPES.fu_ret_id_form_trigger_type_b (p_txt_trigger_type_name, p_id, p_msg_retorno);

      if p_retorno = TRUE then
         return p_id;
      else
         return NULL;
      end if;

   EXCEPTION
      when others then
         return NULL;
   END fu_ret_id_form_trigger_type_i;

-- fu_val_m_load_form_trigger_t_b
   FUNCTION fu_val_m_load_form_trigger_t_b (p_m_load_form_trigger_types IN OUT m_load_form_trigger_types%ROWTYPE,
                                            p_msg_retorno               IN OUT varchar2)
                                            RETURN boolean IS
      p_existe   integer        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_val_m_load_form_trigger_t_b (' || p_m_load_form_trigger_types.id || '): ';
      pragma autonomous_transaction;

   BEGIN
      p_m_load_form_trigger_types.txt_trigger_type_name := trim (upper (p_m_load_form_trigger_types.txt_trigger_type_name));
      p_m_load_form_trigger_types.txt_observacoes       := trim (upper (p_m_load_form_trigger_types.txt_observacoes));

      if p_m_load_form_trigger_types.txt_trigger_type_name is NULL then
         p_msg_retorno := 'O nome do tipo de trigger deve ser informado.';
         return FALSE;
      else
         BEGIN
            select 1
              into p_existe
              from m_load_form_trigger_types mlftt
             where translate (trim (upper (mlftt.txt_trigger_type_name)),                       'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC')
                 = translate (trim (upper (p_m_load_form_trigger_types.txt_trigger_type_name)), 'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC')
               and ((mlftt.id != p_m_load_form_trigger_types.id and p_m_load_form_trigger_types.id is not NULL) or p_m_load_form_trigger_types.id is NULL);

            p_msg_retorno := 'O nome do tipo de trigger informado já está cadastrado.';
            return FALSE;

         EXCEPTION
            when no_data_found then
               NULL;
            when others then
               p_msg_retorno := 'Erro SELECT MLFTT (' || p_m_load_form_trigger_types.txt_trigger_type_name ||
                                              ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_val_m_load_form_trigger_t_b;
END pkg_m_load_form_trigger_types;
/

CREATE OR REPLACE PACKAGE pkg_m_load_form_custom_disposa IS
   p_pck_name varchar2(50) := 'PKG_M_LOAD_FORM_CUSTOM_DISPOSA.';

-- fu_val_m_load_form_custom_di_b
   FUNCTION fu_val_m_load_form_custom_di_b (p_m_load_form_custom_disposa IN OUT m_load_form_custom_disposa%ROWTYPE,
                                            p_msg_retorno                IN OUT varchar2)
                                            RETURN boolean;
END pkg_m_load_form_custom_disposa;
/

CREATE OR REPLACE PACKAGE BODY pkg_m_load_form_custom_disposa IS
-- fu_val_m_load_form_custom_di_b
   FUNCTION fu_val_m_load_form_custom_di_b (p_m_load_form_custom_disposa IN OUT m_load_form_custom_disposa%ROWTYPE,
                                            p_msg_retorno                IN OUT varchar2)
                                            RETURN boolean IS
      p_existe   integer        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_val_m_load_form_custom_di_b (' || p_m_load_form_custom_disposa.id || '): ';
      pragma autonomous_transaction;

   BEGIN
      p_m_load_form_custom_disposa.txt_custom_disposable_text     := trim (upper (p_m_load_form_custom_disposa.txt_custom_disposable_text));
      p_m_load_form_custom_disposa.txt_observacoes                := trim (upper (p_m_load_form_custom_disposa.txt_observacoes));
      p_m_load_form_custom_disposa.txt_disposable_text_has_params := nvl (trim (upper (p_m_load_form_custom_disposa.txt_disposable_text_has_params)), 'N');
      p_m_load_form_custom_disposa.txt_disposable_text_is_package := nvl (trim (upper (p_m_load_form_custom_disposa.txt_disposable_text_is_package)), 'N');
      p_m_load_form_custom_disposa.txt_disposable_text_detected   := nvl (trim (upper (p_m_load_form_custom_disposa.txt_disposable_text_detected)),   'N');

      if p_m_load_form_custom_disposa.txt_disposable_text_has_params not in ('Y', 'N') then
         p_m_load_form_custom_disposa.txt_disposable_text_has_params := 'N';
      end if;

      if p_m_load_form_custom_disposa.txt_disposable_text_is_package not in ('Y', 'N') then
         p_m_load_form_custom_disposa.txt_disposable_text_is_package := 'N';
      end if;

      if p_m_load_form_custom_disposa.txt_disposable_text_detected   not in ('Y', 'N') then
         p_m_load_form_custom_disposa.txt_disposable_text_detected   := 'N';
      end if;

      if p_m_load_form_custom_disposa.id_disposable_text_type is NULL then
         p_m_load_form_custom_disposa.id_disposable_text_type        := PKG_M_LOAD_FORM_DISPOS_TXT_TYP.fu_ret_disposable_text_type_i ('CUSTOM');
      end if;

      if p_m_load_form_custom_disposa.txt_custom_disposable_text is NULL then
         p_msg_retorno := 'Disposable PL/SQL routine must be informed.';
         return FALSE;
      else
         BEGIN
            select 1
              into p_existe
              from m_load_form_custom_disposa mlfcd
             where translate (trim (upper (mlfcd.txt_custom_disposable_text)),                        'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC')
                 = translate (trim (upper (p_m_load_form_custom_disposa.txt_custom_disposable_text)), 'ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÑÇ', 'AAAAAEEEEIIIIOOOOOUUUUYNC')
               and ((mlfcd.id != p_m_load_form_custom_disposa.id and p_m_load_form_custom_disposa.id is not NULL) or p_m_load_form_custom_disposa.id is NULL);

            p_msg_retorno := 'Disposable PL/SQL routine "' || p_m_load_form_custom_disposa.txt_custom_disposable_text || '" already informed.';
            return FALSE;

         EXCEPTION
            when no_data_found then
               NULL;
            when others then
               p_msg_retorno := 'Erro SELECT MLFCD (' || p_m_load_form_custom_disposa.txt_custom_disposable_text ||
                                               ') em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_val_m_load_form_custom_di_b;
END pkg_m_load_form_custom_disposa;
/

CREATE OR REPLACE PACKAGE pkg_m_disposable_form_trg_lvl IS
   p_pck_name varchar2(50) := 'PKG_M_DISPOSABLE_FORM_TRG_LVL.';

-- fu_val_m_disposable_form_trg_b
   FUNCTION fu_val_m_disposable_form_trg_b (p_m_disposable_form_trg_lvl IN OUT m_disposable_form_trg_lvl%ROWTYPE,
                                            p_msg_retorno               IN OUT varchar2)
                                            RETURN boolean;
END pkg_m_disposable_form_trg_lvl;
/

CREATE OR REPLACE PACKAGE BODY pkg_m_disposable_form_trg_lvl IS
-- fu_val_m_disposable_form_trg_b
   FUNCTION fu_val_m_disposable_form_trg_b (p_m_disposable_form_trg_lvl IN OUT m_disposable_form_trg_lvl%ROWTYPE,
                                            p_msg_retorno               IN OUT varchar2)
                                            RETURN boolean IS
      p_existe   integer        := NULL;
      p_prc_name varchar2(1000) := p_pck_name || 'fu_val_m_disposable_form_trg_b (' || p_m_disposable_form_trg_lvl.id || '): ';
      pragma autonomous_transaction;

   BEGIN
      p_m_disposable_form_trg_lvl.txt_disposa_trg_on_form_level  := nvl (trim (upper (p_m_disposable_form_trg_lvl.txt_disposa_trg_on_form_level)),  'N');
      p_m_disposable_form_trg_lvl.txt_disposa_trg_on_block_level := nvl (trim (upper (p_m_disposable_form_trg_lvl.txt_disposa_trg_on_block_level)), 'N');
      p_m_disposable_form_trg_lvl.txt_disposa_trg_on_item_level  := nvl (trim (upper (p_m_disposable_form_trg_lvl.txt_disposa_trg_on_item_level)),  'N');

      p_m_disposable_form_trg_lvl.txt_observacoes                := trim (upper (p_m_disposable_form_trg_lvl.txt_observacoes));

      if p_m_disposable_form_trg_lvl.txt_disposa_trg_on_form_level  not in ('Y', 'N') then
         p_m_disposable_form_trg_lvl.txt_disposa_trg_on_form_level  := 'N';
      end if;

      if p_m_disposable_form_trg_lvl.txt_disposa_trg_on_block_level not in ('Y', 'N') then
         p_m_disposable_form_trg_lvl.txt_disposa_trg_on_block_level := 'N';
      end if;

      if p_m_disposable_form_trg_lvl.txt_disposa_trg_on_item_level  not in ('Y', 'N') then
         p_m_disposable_form_trg_lvl.txt_disposa_trg_on_item_level  := 'N';
      end if;

      if p_m_disposable_form_trg_lvl.id_disposable_form_trg is NULL then
         p_msg_retorno := 'Disposable form trigger ID must be informed.';
         return FALSE;
      else
         BEGIN
            select 1
              into p_existe
              from m_disposable_form_trg_lvl mdftl
             where ((p_m_disposable_form_trg_lvl.id                     is not NULL
                 and p_m_disposable_form_trg_lvl.id_disposable_form_trg is not NULL
                 and mdftl.id                                           != p_m_disposable_form_trg_lvl.id
                 and mdftl.id_disposable_form_trg                        = p_m_disposable_form_trg_lvl.id_disposable_form_trg)
                 or (p_m_disposable_form_trg_lvl.id                     is NULL
                 and p_m_disposable_form_trg_lvl.id_disposable_form_trg is not NULL
                 and mdftl.id_disposable_form_trg                        = p_m_disposable_form_trg_lvl.id_disposable_form_trg));

            p_msg_retorno := 'Disposable form trigger ID ' || p_m_disposable_form_trg_lvl.id_disposable_form_trg || ' already informed.';
            return FALSE;

         EXCEPTION
            when no_data_found then
               NULL;
            when others then
               p_msg_retorno := 'Erro SELECT MDFTL "' || p_m_disposable_form_trg_lvl.id_disposable_form_trg ||
                                '" em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
               return FALSE;
         END;
      end if;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_val_m_disposable_form_trg_b;
END pkg_m_disposable_form_trg_lvl;
/

CREATE OR REPLACE PACKAGE pkg_m_load_form_list_values IS
   p_pck_name varchar2(50) := 'PKG_M_LOAD_FORM_LIST_VALUES.';

-- fu_val_m_load_form_lst_value_b
   FUNCTION fu_val_m_load_form_lst_value_b (p_m_load_form_list_values IN OUT m_load_form_list_values%ROWTYPE,
                                            p_msg_retorno             IN OUT varchar2)
                                            RETURN boolean;
END pkg_m_load_form_list_values;
/

CREATE OR REPLACE PACKAGE BODY pkg_m_load_form_list_values IS
   FUNCTION fu_val_m_load_form_lst_value_b (p_m_load_form_list_values IN OUT m_load_form_list_values%ROWTYPE,
                                            p_msg_retorno             IN OUT varchar2)
                                            RETURN boolean IS
      p_prc_name varchar2(1000) := p_pck_name || 'fu_val_m_load_form_lst_value_b (' || p_m_load_form_list_values.id || '): ';

   BEGIN
      p_m_load_form_list_values.txt_lov_name             := trim (upper (p_m_load_form_list_values.txt_lov_name));
      p_m_load_form_list_values.txt_lov_type             := trim (upper (p_m_load_form_list_values.txt_lov_type));
      p_m_load_form_list_values.txt_lov_record_group     := trim (upper (p_m_load_form_list_values.txt_lov_record_group));
      p_m_load_form_list_values.txt_lov_item_name        := trim (upper (p_m_load_form_list_values.txt_lov_item_name));
      p_m_load_form_list_values.txt_lov_item_return_item := trim (upper (p_m_load_form_list_values.txt_lov_item_return_item));

      p_m_load_form_list_values.txt_lov_item_title       := trim (p_m_load_form_list_values.txt_lov_item_title);
      p_m_load_form_list_values.txt_lov_title            := trim (p_m_load_form_list_values.txt_lov_title);
      p_m_load_form_list_values.txt_observacoes          := trim (p_m_load_form_list_values.txt_observacoes);

      return TRUE;

   EXCEPTION
      when others then
         p_msg_retorno := 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fu_val_m_load_form_lst_value_b;
END pkg_m_load_form_list_values;
/

CREATE OR REPLACE TRIGGER t01_m_load_form_plsql_disc_rsn
BEFORE INSERT OR UPDATE ON m_load_form_plsql_disc_rsn
FOR EACH ROW
DECLARE
   p_m_load_form_plsql_disc_rsn m_load_form_plsql_disc_rsn%ROWTYPE := NULL;
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T01_M_LOAD_FORM_PLSQL_DISC_RSN (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      p_m_load_form_plsql_disc_rsn.id                             := :NEW.id;
      p_m_load_form_plsql_disc_rsn.txt_plsql_discard_reason       := :NEW.txt_plsql_discard_reason;
      p_m_load_form_plsql_disc_rsn.txt_plsql_discard_reason_key   := :NEW.txt_plsql_discard_reason_key;
      p_m_load_form_plsql_disc_rsn.txt_plsql_discard_reason_means := :NEW.txt_plsql_discard_reason_means;
      p_m_load_form_plsql_disc_rsn.txt_observacoes                := :NEW.txt_observacoes;

      p_retorno := PKG_M_LOAD_FORM_PLSQL_DISC_RSN.fu_val_m_load_form_plsql_dis_b (p_m_load_form_plsql_disc_rsn, p_msg_retorno);

      if p_retorno = TRUE then
         :NEW.id                             := p_m_load_form_plsql_disc_rsn.id;
         :NEW.txt_plsql_discard_reason       := p_m_load_form_plsql_disc_rsn.txt_plsql_discard_reason;
         :NEW.txt_plsql_discard_reason_key   := p_m_load_form_plsql_disc_rsn.txt_plsql_discard_reason_key;
         :NEW.txt_plsql_discard_reason_means := p_m_load_form_plsql_disc_rsn.txt_plsql_discard_reason_means;
         :NEW.txt_observacoes                := p_m_load_form_plsql_disc_rsn.txt_observacoes;
      else
         raise_application_error (-20001, p_msg_retorno);
      end if;

      if    inserting then
         :NEW.id                 := s_m_load_form_plsql_disc_rsn.nextval;
         :NEW.user_create        := nvl (v('APP_USER'), user);
         :NEW.date_create        := sysdate;
         :NEW.app_create_id      := nv('APP_ID');
         :NEW.app_create_page_id := nv('APP_PAGE_ID');
      elsif updating then
         :NEW.user_update        := nvl (v('APP_USER'), user);
         :NEW.date_update        := sysdate;
         :NEW.app_update_page_id := nv('APP_PAGE_ID');
         :NEW.app_update_id      := nv('APP_ID');
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t01_m_load_form_plsql_disc_rsn;
/

CREATE OR REPLACE TRIGGER t01_m_load_form_block_relation
BEFORE INSERT OR UPDATE ON m_load_form_block_relation
FOR EACH ROW
DECLARE
   p_m_load_form_block_relation m_load_form_block_relation%ROWTYPE := NULL;
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T01_M_LOAD_FORM_BLOCK_RELATION (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      p_m_load_form_block_relation.id                         := :NEW.id;
      p_m_load_form_block_relation.id_form                    := :NEW.id_form;
      p_m_load_form_block_relation.id_rownum                  := :NEW.id_rownum;
      p_m_load_form_block_relation.txt_relation_name          := :NEW.txt_relation_name;
      p_m_load_form_block_relation.txt_relation_type          := :NEW.txt_relation_type;
      p_m_load_form_block_relation.txt_master_data_block      := :NEW.txt_master_data_block;
      p_m_load_form_block_relation.txt_master_data_block_item := :NEW.txt_master_data_block_item;
      p_m_load_form_block_relation.txt_detail_data_block      := :NEW.txt_detail_data_block;
      p_m_load_form_block_relation.txt_detail_data_block_item := :NEW.txt_detail_data_block_item;
      p_m_load_form_block_relation.txt_join_condition         := :NEW.txt_join_condition;
      p_m_load_form_block_relation.txt_observacoes            := :NEW.txt_observacoes;
      p_m_load_form_block_relation.txt_detailed_data_block    := :NEW.txt_detailed_data_block;

      p_retorno := PKG_M_LOAD_FORM_BLOCK_RELATION.fu_val_m_load_form_block_rel_b (p_m_load_form_block_relation, p_msg_retorno);

      if p_retorno = TRUE then
         :NEW.id                         := p_m_load_form_block_relation.id;
         :NEW.id_form                    := p_m_load_form_block_relation.id_form;
         :NEW.id_rownum                  := p_m_load_form_block_relation.id_rownum;
         :NEW.txt_relation_name          := p_m_load_form_block_relation.txt_relation_name;
         :NEW.txt_relation_type          := p_m_load_form_block_relation.txt_relation_type;
         :NEW.txt_master_data_block      := p_m_load_form_block_relation.txt_master_data_block;
         :NEW.txt_master_data_block_item := p_m_load_form_block_relation.txt_master_data_block_item;
         :NEW.txt_detail_data_block      := p_m_load_form_block_relation.txt_detail_data_block;
         :NEW.txt_detail_data_block_item := p_m_load_form_block_relation.txt_detail_data_block_item;
         :NEW.txt_join_condition         := p_m_load_form_block_relation.txt_join_condition;
         :NEW.txt_observacoes            := p_m_load_form_block_relation.txt_observacoes;
         :NEW.txt_detailed_data_block    := p_m_load_form_block_relation.txt_detailed_data_block;
      else
         raise_application_error (-20001, p_msg_retorno);
      end if;

      if    inserting then
         :NEW.id                 := s_m_load_form_block_relation.nextval;
         :NEW.user_create        := nvl (v('APP_USER'), user);
         :NEW.date_create        := sysdate;
         :NEW.app_create_id      := nv('APP_ID');
         :NEW.app_create_page_id := nv('APP_PAGE_ID');
      elsif updating then
         :NEW.user_update        := nvl (v('APP_USER'), user);
         :NEW.date_update        := sysdate;
         :NEW.app_update_page_id := nv('APP_PAGE_ID');
         :NEW.app_update_id      := nv('APP_ID');
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t01_m_load_form_block_relation;
/

CREATE OR REPLACE TRIGGER t01_m_form_keywords
BEFORE INSERT OR UPDATE ON m_form_keywords
FOR EACH ROW
DECLARE
   p_m_form_keywords m_form_keywords%ROWTYPE := NULL;
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T01_M_FORM_KEYWORDS (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      p_m_form_keywords.id                := :NEW.id;
      p_m_form_keywords.txt_keyword       := :NEW.txt_keyword;
      p_m_form_keywords.txt_internal_name := :NEW.txt_internal_name;
      p_m_form_keywords.id_language       := :NEW.id_language;
      p_m_form_keywords.txt_observacoes   := :NEW.txt_observacoes;

      p_retorno := PKG_M_FORM_KEYWORDS.fu_val_m_form_keywords_b (p_m_form_keywords, p_msg_retorno);

      if p_retorno = TRUE then
         :NEW.id                := p_m_form_keywords.id;
         :NEW.txt_keyword       := p_m_form_keywords.txt_keyword;
         :NEW.txt_internal_name := p_m_form_keywords.txt_internal_name;
         :NEW.id_language       := p_m_form_keywords.id_language;
         :NEW.txt_observacoes   := p_m_form_keywords.txt_observacoes;
      else
         raise_application_error (-20001, p_msg_retorno);
      end if;

      if    inserting then
         :NEW.id                 := s_m_form_keywords.nextval;
         :NEW.user_create        := nvl (v('APP_USER'), user);
         :NEW.date_create        := sysdate;
         :NEW.app_create_id      := nv('APP_ID');
         :NEW.app_create_page_id := nv('APP_PAGE_ID');
      elsif updating then
         :NEW.user_update        := nvl (v('APP_USER'), user);
         :NEW.date_update        := sysdate;
         :NEW.app_update_page_id := nv('APP_PAGE_ID');
         :NEW.app_update_id      := nv('APP_ID');
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t01_m_form_keywords;
/

CREATE OR REPLACE TRIGGER t01_m_languages
BEFORE INSERT OR UPDATE ON m_languages
FOR EACH ROW
DECLARE
   p_m_languages m_languages%ROWTYPE := NULL;
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T01_M_LANGUAGES (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      p_m_languages.id              := :NEW.id;
      p_m_languages.txt_language    := :NEW.txt_language;
      p_m_languages.txt_observacoes := :NEW.txt_observacoes;

      p_retorno := pkg_m_languages.fu_val_m_languages_b (p_m_languages, p_msg_retorno);

      if p_retorno = TRUE then
         :NEW.id              := p_m_languages.id;
         :NEW.txt_language    := p_m_languages.txt_language;
         :NEW.txt_observacoes := p_m_languages.txt_observacoes;
      else
         raise_application_error (-20001, p_msg_retorno);
      end if;

      if    inserting then
         :NEW.id                 := s_m_languages.nextval;
         :NEW.user_create        := nvl (v('APP_USER'), user);
         :NEW.date_create        := sysdate;
         :NEW.app_create_id      := nv('APP_ID');
         :NEW.app_create_page_id := nv('APP_PAGE_ID');
      elsif updating then
         :NEW.user_update        := nvl (v('APP_USER'), user);
         :NEW.date_update        := sysdate;
         :NEW.app_update_page_id := nv('APP_PAGE_ID');
         :NEW.app_update_id      := nv('APP_ID');
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t01_m_languages;
/

CREATE OR REPLACE TRIGGER t01_m_load_form
BEFORE INSERT OR UPDATE ON m_load_form
FOR EACH ROW
DECLARE
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T01_M_LOAD_FORM (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      if    inserting then
         :NEW.id                 := s_m_load_form.nextval;
         :NEW.user_create        := nvl (v('APP_USER'), user);
         :NEW.date_create        := sysdate;
         :NEW.app_create_id      := nv('APP_ID');
         :NEW.app_create_page_id := nv('APP_PAGE_ID');
      elsif updating then
         :NEW.user_update        := nvl (v('APP_USER'), user);
         :NEW.date_update        := sysdate;
         :NEW.app_update_page_id := nv('APP_PAGE_ID');
         :NEW.app_update_id      := nv('APP_ID');
      end if;

      if DBMS_LOB.getlength (:NEW.txt_form_blob) > 0 then
         :NEW.txt_form := PKG_IMPORT_FORM.fu_loaded_form_blob_to_clob_c (:NEW.txt_form_blob, p_msg_retorno);
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t01_m_load_form;
/

CREATE OR REPLACE TRIGGER t01_m_form_keywords_values
BEFORE INSERT OR UPDATE ON m_form_keywords_values
FOR EACH ROW
DECLARE
   p_m_form_keywords_values m_form_keywords_values%ROWTYPE := NULL;
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T01_M_FORM_KEYWORDS_VALUES (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      p_m_form_keywords_values.id                := :NEW.id;
      p_m_form_keywords_values.txt_keyword       := :NEW.txt_keyword;
      p_m_form_keywords_values.txt_internal_name := :NEW.txt_internal_name;
      p_m_form_keywords_values.id_language       := :NEW.id_language;
      p_m_form_keywords_values.txt_observacoes   := :NEW.txt_observacoes;

      p_retorno := PKG_M_FORM_KEYWORDS_VALUES.fu_val_m_form_keywords_value_b (p_m_form_keywords_values, p_msg_retorno);

      if p_retorno = TRUE then
         :NEW.id                := p_m_form_keywords_values.id;
         :NEW.txt_keyword       := p_m_form_keywords_values.txt_keyword;
         :NEW.txt_internal_name := p_m_form_keywords_values.txt_internal_name;
         :NEW.id_language       := p_m_form_keywords_values.id_language;
         :NEW.txt_observacoes   := p_m_form_keywords_values.txt_observacoes;
      else
         raise_application_error (-20001, p_msg_retorno);
      end if;

      if    inserting then
         :NEW.id                 := s_m_form_keywords_values.nextval;
         :NEW.user_create        := nvl (v('APP_USER'), user);
         :NEW.date_create        := sysdate;
         :NEW.app_create_id      := nv('APP_ID');
         :NEW.app_create_page_id := nv('APP_PAGE_ID');
      elsif updating then
         :NEW.user_update        := nvl (v('APP_USER'), user);
         :NEW.date_update        := sysdate;
         :NEW.app_update_page_id := nv('APP_PAGE_ID');
         :NEW.app_update_id      := nv('APP_ID');
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t01_m_form_keywords_values;
/

CREATE OR REPLACE TRIGGER t01_m_load_form_lines
BEFORE INSERT OR UPDATE ON m_load_form_lines
FOR EACH ROW
DECLARE
   p_m_load_form_lines m_load_form_lines%ROWTYPE := NULL;
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T01_M_LOAD_FORM_LINES (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      p_m_load_form_lines.id                  := :NEW.id;
      p_m_load_form_lines.id_form             := :NEW.id_form;
      p_m_load_form_lines.id_rownum           := :NEW.id_rownum;
      p_m_load_form_lines.txt_line            := :NEW.txt_line;
      p_m_load_form_lines.txt_line_m          := :NEW.txt_line_m;
      p_m_load_form_lines.txt_internal_name_m := :NEW.txt_internal_name_m;
      p_m_load_form_lines.txt_line_p          := :NEW.txt_line_p;
      p_m_load_form_lines.txt_internal_name_p := :NEW.txt_internal_name_p;
      p_m_load_form_lines.txt_line_t          := :NEW.txt_line_t;

      p_retorno := PKG_M_LOAD_FORM_LINES.fu_val_m_load_form_lines_b (p_m_load_form_lines, p_msg_retorno);

      if p_retorno = TRUE then
         :NEW.id                  := p_m_load_form_lines.id;
         :NEW.id_form             := p_m_load_form_lines.id_form;
         :NEW.id_rownum           := p_m_load_form_lines.id_rownum;
         :NEW.txt_line            := p_m_load_form_lines.txt_line;
         :NEW.txt_line_m          := p_m_load_form_lines.txt_line_m;
         :NEW.txt_internal_name_m := p_m_load_form_lines.txt_internal_name_m;
         :NEW.txt_line_p          := p_m_load_form_lines.txt_line_p;
         :NEW.txt_internal_name_p := p_m_load_form_lines.txt_internal_name_p;
         :NEW.txt_line_t          := p_m_load_form_lines.txt_line_t;
      else
         raise_application_error (-20001, p_msg_retorno);
      end if;

      if    inserting then
         :NEW.id                 := s_m_load_form_lines.nextval;
         :NEW.user_create        := nvl (v('APP_USER'), user);
         :NEW.date_create        := sysdate;
         :NEW.app_create_id      := nv('APP_ID');
         :NEW.app_create_page_id := nv('APP_PAGE_ID');
      elsif updating then
         :NEW.user_update        := nvl (v('APP_USER'), user);
         :NEW.date_update        := sysdate;
         :NEW.app_update_page_id := nv('APP_PAGE_ID');
         :NEW.app_update_id      := nv('APP_ID');
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t01_m_load_form_lines;
/

CREATE OR REPLACE TRIGGER t01_m_load_form_blocks_items
BEFORE INSERT OR UPDATE ON m_load_form_blocks_items
FOR EACH ROW
DECLARE
   p_m_load_form_blocks_items m_load_form_blocks_items%ROWTYPE := NULL;
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T01_M_LOAD_FORM_BLOCKS_ITEMS (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      p_m_load_form_blocks_items.id                             := :NEW.id;
      p_m_load_form_blocks_items.id_rownum                      := :NEW.id_rownum;
      p_m_load_form_blocks_items.id_form                        := :NEW.id_form;
      p_m_load_form_blocks_items.txt_data_origin                := :NEW.txt_data_origin;
      p_m_load_form_blocks_items.txt_block_name                 := :NEW.txt_block_name;
      p_m_load_form_blocks_items.txt_item_name                  := :NEW.txt_item_name;
      p_m_load_form_blocks_items.txt_disposable_data_block      := :NEW.txt_disposable_data_block;
      p_m_load_form_blocks_items.txt_block_item_name            := :NEW.txt_block_item_name;
      p_m_load_form_blocks_items.txt_variable_parameter_name    := :NEW.txt_variable_parameter_name;
      p_m_load_form_blocks_items.txt_comments                   := :NEW.txt_comments;
      p_m_load_form_blocks_items.num_block_records_display      := :NEW.num_block_records_display;
      p_m_load_form_blocks_items.txt_block_single_record        := :NEW.txt_block_single_record;
      p_m_load_form_blocks_items.txt_block_database_data_block  := :NEW.txt_block_database_data_block;
      p_m_load_form_blocks_items.txt_block_query_allowed        := :NEW.txt_block_query_allowed;
      p_m_load_form_blocks_items.txt_block_insert_allowed       := :NEW.txt_block_insert_allowed;
      p_m_load_form_blocks_items.txt_block_update_allowed       := :NEW.txt_block_update_allowed;
      p_m_load_form_blocks_items.txt_block_delete_allowed       := :NEW.txt_block_delete_allowed;
      p_m_load_form_blocks_items.txt_block_query_data_orig_type := :NEW.txt_block_query_data_orig_type;
      p_m_load_form_blocks_items.txt_block_query_data_orig_name := :NEW.txt_block_query_data_orig_name;
      p_m_load_form_blocks_items.txt_block_query_data_orig_clob := :NEW.txt_block_query_data_orig_clob;
      p_m_load_form_blocks_items.txt_block_where_clause         := :NEW.txt_block_where_clause;
      p_m_load_form_blocks_items.txt_block_order_by             := :NEW.txt_block_order_by;
      p_m_load_form_blocks_items.txt_item_item_type             := :NEW.txt_item_item_type;
      p_m_load_form_blocks_items.txt_item_enabled               := :NEW.txt_item_enabled;
      p_m_load_form_blocks_items.txt_item_justification         := :NEW.txt_item_justification;
      p_m_load_form_blocks_items.txt_item_multiline             := :NEW.txt_item_multiline;
      p_m_load_form_blocks_items.txt_item_case_letter           := :NEW.txt_item_case_letter;
      p_m_load_form_blocks_items.txt_item_conceal_data          := :NEW.txt_item_conceal_data;
      p_m_load_form_blocks_items.txt_item_field_autofill        := :NEW.txt_item_field_autofill;
      p_m_load_form_blocks_items.txt_item_field_datatype        := :NEW.txt_item_field_datatype;
      p_m_load_form_blocks_items.txt_item_field_maxlength       := :NEW.txt_item_field_maxlength;
      p_m_load_form_blocks_items.txt_item_field_precision       := :NEW.txt_item_field_precision;
      p_m_load_form_blocks_items.txt_item_field_scale           := :NEW.txt_item_field_scale;
      p_m_load_form_blocks_items.txt_item_field_inivalue        := :NEW.txt_item_field_inivalue;
      p_m_load_form_blocks_items.txt_item_field_mandatory       := :NEW.txt_item_field_mandatory;
      p_m_load_form_blocks_items.txt_item_field_format_mask     := :NEW.txt_item_field_format_mask;
      p_m_load_form_blocks_items.txt_item_field_minvalue        := :NEW.txt_item_field_minvalue;
      p_m_load_form_blocks_items.txt_item_field_maxvalue        := :NEW.txt_item_field_maxvalue;
      p_m_load_form_blocks_items.txt_item_field_copy_value_from := :NEW.txt_item_field_copy_value_from;
      p_m_load_form_blocks_items.txt_item_field_database        := :NEW.txt_item_field_database;
      p_m_load_form_blocks_items.txt_item_field_db_col_name     := :NEW.txt_item_field_db_col_name;
      p_m_load_form_blocks_items.txt_item_field_primary_key     := :NEW.txt_item_field_primary_key;
      p_m_load_form_blocks_items.txt_item_field_read_only       := :NEW.txt_item_field_read_only;
      p_m_load_form_blocks_items.txt_item_field_qry_allowed     := :NEW.txt_item_field_qry_allowed;
      p_m_load_form_blocks_items.txt_item_field_ins_allowed     := :NEW.txt_item_field_ins_allowed;
      p_m_load_form_blocks_items.txt_item_field_upd_allowed     := :NEW.txt_item_field_upd_allowed;
      p_m_load_form_blocks_items.txt_item_field_visible         := :NEW.txt_item_field_visible;
      p_m_load_form_blocks_items.txt_item_field_hint_1          := :NEW.txt_item_field_hint_1;
      p_m_load_form_blocks_items.txt_item_field_hint_2          := :NEW.txt_item_field_hint_2;

      p_retorno := PKG_M_LOAD_FORM_BLOCKS_ITEMS.fu_m_load_form_blocks_items_b (p_m_load_form_blocks_items, p_msg_retorno);

      if p_retorno = TRUE then
         :NEW.id                             := p_m_load_form_blocks_items.id;
         :NEW.id_rownum                      := p_m_load_form_blocks_items.id_rownum;
         :NEW.id_form                        := p_m_load_form_blocks_items.id_form;
         :NEW.txt_data_origin                := p_m_load_form_blocks_items.txt_data_origin;
         :NEW.txt_block_name                 := p_m_load_form_blocks_items.txt_block_name;
         :NEW.txt_item_name                  := p_m_load_form_blocks_items.txt_item_name;
         :NEW.txt_disposable_data_block      := p_m_load_form_blocks_items.txt_disposable_data_block;
         :NEW.txt_block_item_name            := p_m_load_form_blocks_items.txt_block_item_name;
         :NEW.txt_variable_parameter_name    := p_m_load_form_blocks_items.txt_variable_parameter_name;
         :NEW.txt_comments                   := p_m_load_form_blocks_items.txt_comments;
         :NEW.num_block_records_display      := p_m_load_form_blocks_items.num_block_records_display;
         :NEW.txt_block_single_record        := p_m_load_form_blocks_items.txt_block_single_record;
         :NEW.txt_block_database_data_block  := p_m_load_form_blocks_items.txt_block_database_data_block;
         :NEW.txt_block_query_allowed        := p_m_load_form_blocks_items.txt_block_query_allowed;
         :NEW.txt_block_insert_allowed       := p_m_load_form_blocks_items.txt_block_insert_allowed;
         :NEW.txt_block_update_allowed       := p_m_load_form_blocks_items.txt_block_update_allowed;
         :NEW.txt_block_delete_allowed       := p_m_load_form_blocks_items.txt_block_delete_allowed;
         :NEW.txt_block_query_data_orig_type := p_m_load_form_blocks_items.txt_block_query_data_orig_type;
         :NEW.txt_block_query_data_orig_name := p_m_load_form_blocks_items.txt_block_query_data_orig_name;
         :NEW.txt_block_query_data_orig_clob := p_m_load_form_blocks_items.txt_block_query_data_orig_clob;
         :NEW.txt_block_where_clause         := p_m_load_form_blocks_items.txt_block_where_clause;
         :NEW.txt_block_order_by             := p_m_load_form_blocks_items.txt_block_order_by;
         :NEW.txt_item_item_type             := p_m_load_form_blocks_items.txt_item_item_type;
         :NEW.txt_item_enabled               := p_m_load_form_blocks_items.txt_item_enabled;
         :NEW.txt_item_justification         := p_m_load_form_blocks_items.txt_item_justification;
         :NEW.txt_item_multiline             := p_m_load_form_blocks_items.txt_item_multiline;
         :NEW.txt_item_case_letter           := p_m_load_form_blocks_items.txt_item_case_letter;
         :NEW.txt_item_conceal_data          := p_m_load_form_blocks_items.txt_item_conceal_data;
         :NEW.txt_item_field_autofill        := p_m_load_form_blocks_items.txt_item_field_autofill;
         :NEW.txt_item_field_datatype        := p_m_load_form_blocks_items.txt_item_field_datatype;
         :NEW.txt_item_field_maxlength       := p_m_load_form_blocks_items.txt_item_field_maxlength;
         :NEW.txt_item_field_precision       := p_m_load_form_blocks_items.txt_item_field_precision;
         :NEW.txt_item_field_scale           := p_m_load_form_blocks_items.txt_item_field_scale;
         :NEW.txt_item_field_inivalue        := p_m_load_form_blocks_items.txt_item_field_inivalue;
         :NEW.txt_item_field_mandatory       := p_m_load_form_blocks_items.txt_item_field_mandatory;
         :NEW.txt_item_field_format_mask     := p_m_load_form_blocks_items.txt_item_field_format_mask;
         :NEW.txt_item_field_minvalue        := p_m_load_form_blocks_items.txt_item_field_minvalue;
         :NEW.txt_item_field_maxvalue        := p_m_load_form_blocks_items.txt_item_field_maxvalue;
         :NEW.txt_item_field_copy_value_from := p_m_load_form_blocks_items.txt_item_field_copy_value_from;
         :NEW.txt_item_field_database        := p_m_load_form_blocks_items.txt_item_field_database;
         :NEW.txt_item_field_db_col_name     := p_m_load_form_blocks_items.txt_item_field_db_col_name;
         :NEW.txt_item_field_primary_key     := p_m_load_form_blocks_items.txt_item_field_primary_key;
         :NEW.txt_item_field_read_only       := p_m_load_form_blocks_items.txt_item_field_read_only;
         :NEW.txt_item_field_qry_allowed     := p_m_load_form_blocks_items.txt_item_field_qry_allowed;
         :NEW.txt_item_field_ins_allowed     := p_m_load_form_blocks_items.txt_item_field_ins_allowed;
         :NEW.txt_item_field_upd_allowed     := p_m_load_form_blocks_items.txt_item_field_upd_allowed;
         :NEW.txt_item_field_visible         := p_m_load_form_blocks_items.txt_item_field_visible;
         :NEW.txt_item_field_hint_1          := p_m_load_form_blocks_items.txt_item_field_hint_1;
         :NEW.txt_item_field_hint_2          := p_m_load_form_blocks_items.txt_item_field_hint_2;
      else
         raise_application_error (-20001, p_msg_retorno);
      end if;

      if    inserting then
         :NEW.id                 := s_m_load_form_blocks_items.nextval;
         :NEW.user_create        := nvl (v('APP_USER'), user);
         :NEW.date_create        := sysdate;
         :NEW.app_create_id      := nv('APP_ID');
         :NEW.app_create_page_id := nv('APP_PAGE_ID');
      elsif updating then
         :NEW.user_update        := nvl (v('APP_USER'), user);
         :NEW.date_update        := sysdate;
         :NEW.app_update_page_id := nv('APP_PAGE_ID');
         :NEW.app_update_id      := nv('APP_ID');
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t01_m_load_form_blocks_items;
/

CREATE OR REPLACE TRIGGER t01_m_load_form_static_values
BEFORE INSERT OR UPDATE ON m_load_form_static_values
FOR EACH ROW
DECLARE
   p_m_load_form_static_values m_load_form_static_values%ROWTYPE := NULL;
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T01_M_LOAD_FORM_STATIC_VALUES (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      p_m_load_form_static_values.id                             := :NEW.id;
      p_m_load_form_static_values.id_form                        := :NEW.id_form;
      p_m_load_form_static_values.id_rownum                      := :NEW.id_rownum;
      p_m_load_form_static_values.txt_static_data_origin         := :NEW.txt_static_data_origin;
      p_m_load_form_static_values.txt_block_name                 := :NEW.txt_block_name;
      p_m_load_form_static_values.txt_block_item_name            := :NEW.txt_block_item_name;
      p_m_load_form_static_values.txt_block_item_radbut_name     := :NEW.txt_block_item_radbut_name;
      p_m_load_form_static_values.txt_block_item_radbut_label    := :NEW.txt_block_item_radbut_label;
      p_m_load_form_static_values.txt_block_item_radbut_value    := :NEW.txt_block_item_radbut_value;
      p_m_load_form_static_values.txt_record_group_name          := :NEW.txt_record_group_name;
      p_m_load_form_static_values.txt_recorg_group_col_val_lst_n := :NEW.txt_recorg_group_col_val_lst_n;
      p_m_load_form_static_values.txt_recorg_group_col_val_lst_v := :NEW.txt_recorg_group_col_val_lst_v;
      p_m_load_form_static_values.txt_colspec_column_name        := :NEW.txt_colspec_column_name;
      p_m_load_form_static_values.txt_colspec_maximum_length     := :NEW.txt_colspec_maximum_length;
      p_m_load_form_static_values.txt_colspec_column_data_type   := :NEW.txt_colspec_column_data_type;
      p_m_load_form_static_values.txt_observacoes                := :NEW.txt_observacoes;

      p_retorno := PKG_M_LOAD_FORM_STATIC_VALUES.fu_val_m_load_form_static_va_b (p_m_load_form_static_values, p_msg_retorno);

      if p_retorno = TRUE then
         :NEW.id                             := p_m_load_form_static_values.id;
         :NEW.id_form                        := p_m_load_form_static_values.id_form;
         :NEW.id_rownum                      := p_m_load_form_static_values.id_rownum;
         :NEW.txt_static_data_origin         := p_m_load_form_static_values.txt_static_data_origin;
         :NEW.txt_block_name                 := p_m_load_form_static_values.txt_block_name;
         :NEW.txt_block_item_name            := p_m_load_form_static_values.txt_block_item_name;
         :NEW.txt_block_item_radbut_name     := p_m_load_form_static_values.txt_block_item_radbut_name;
         :NEW.txt_block_item_radbut_label    := p_m_load_form_static_values.txt_block_item_radbut_label;
         :NEW.txt_block_item_radbut_value    := p_m_load_form_static_values.txt_block_item_radbut_value;
         :NEW.txt_record_group_name          := p_m_load_form_static_values.txt_record_group_name;
         :NEW.txt_recorg_group_col_val_lst_n := p_m_load_form_static_values.txt_recorg_group_col_val_lst_n;
         :NEW.txt_recorg_group_col_val_lst_v := p_m_load_form_static_values.txt_recorg_group_col_val_lst_v;
         :NEW.txt_colspec_column_name        := p_m_load_form_static_values.txt_colspec_column_name;
         :NEW.txt_colspec_maximum_length     := p_m_load_form_static_values.txt_colspec_maximum_length;
         :NEW.txt_colspec_column_data_type   := p_m_load_form_static_values.txt_colspec_column_data_type;
         :NEW.txt_observacoes                := p_m_load_form_static_values.txt_observacoes;
      else
         raise_application_error (-20001, p_msg_retorno);
      end if;

      if    inserting then
         :NEW.id                 := s_m_load_form_static_values.nextval;
         :NEW.user_create        := nvl (v('APP_USER'), user);
         :NEW.date_create        := sysdate;
         :NEW.app_create_id      := nv('APP_ID');
         :NEW.app_create_page_id := nv('APP_PAGE_ID');
      elsif updating then
         :NEW.user_update        := nvl (v('APP_USER'), user);
         :NEW.date_update        := sysdate;
         :NEW.app_update_page_id := nv('APP_PAGE_ID');
         :NEW.app_update_id      := nv('APP_ID');
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t01_m_load_form_static_values;
/

CREATE OR REPLACE TRIGGER t01_m_load_form_plsql_contents
BEFORE INSERT OR UPDATE ON m_load_form_plsql_contents
FOR EACH ROW
DECLARE
   p_m_load_form_plsql_contents m_load_form_plsql_contents%ROWTYPE := NULL;
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T01_M_LOAD_FORM_PLSQL_CONTENTS (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      p_m_load_form_plsql_contents.id                          := :NEW.id;
      p_m_load_form_plsql_contents.id_form                     := :NEW.id_form;
      p_m_load_form_plsql_contents.id_rownum                   := :NEW.id_rownum;
      p_m_load_form_plsql_contents.txt_generated_function_name := :NEW.txt_generated_function_name;
      p_m_load_form_plsql_contents.txt_plsql_source            := :NEW.txt_plsql_source;
      p_m_load_form_plsql_contents.txt_block_source            := :NEW.txt_block_source;
      p_m_load_form_plsql_contents.txt_plsql_program_unit_type := :NEW.txt_plsql_program_unit_type;
      p_m_load_form_plsql_contents.txt_block_item_source       := :NEW.txt_block_item_source;
      p_m_load_form_plsql_contents.txt_plsql_object_name       := :NEW.txt_plsql_object_name;
      p_m_load_form_plsql_contents.txt_comments                := :NEW.txt_comments;
      p_m_load_form_plsql_contents.clob_plsql_contents         := :NEW.clob_plsql_contents;
      p_m_load_form_plsql_contents.clob_plsql_contents_no_comm := :NEW.clob_plsql_contents_no_comm;
      p_m_load_form_plsql_contents.txt_disposable_routine      := :NEW.txt_disposable_routine;
      p_m_load_form_plsql_contents.txt_disposable_reason       := :NEW.txt_disposable_reason;
      p_m_load_form_plsql_contents.txt_observacoes             := :NEW.txt_observacoes;

      p_retorno := PKG_M_LOAD_FORM_PLSQL_CONTENTS.fu_val_m_load_form_plsql_con_b (p_m_load_form_plsql_contents, p_msg_retorno);

      if p_retorno = TRUE then
         :NEW.id                          := p_m_load_form_plsql_contents.id;
         :NEW.id_form                     := p_m_load_form_plsql_contents.id_form;
         :NEW.id_rownum                   := p_m_load_form_plsql_contents.id_rownum;
         :NEW.txt_generated_function_name := p_m_load_form_plsql_contents.txt_generated_function_name;
         :NEW.txt_plsql_source            := p_m_load_form_plsql_contents.txt_plsql_source;
         :NEW.txt_block_source            := p_m_load_form_plsql_contents.txt_block_source;
         :NEW.txt_plsql_program_unit_type := p_m_load_form_plsql_contents.txt_plsql_program_unit_type;
         :NEW.txt_block_item_source       := p_m_load_form_plsql_contents.txt_block_item_source;
         :NEW.txt_plsql_object_name       := p_m_load_form_plsql_contents.txt_plsql_object_name;
         :NEW.txt_comments                := p_m_load_form_plsql_contents.txt_comments;
         :NEW.clob_plsql_contents         := p_m_load_form_plsql_contents.clob_plsql_contents;
         :NEW.clob_plsql_contents_no_comm := p_m_load_form_plsql_contents.clob_plsql_contents_no_comm;
         :NEW.txt_disposable_routine      := p_m_load_form_plsql_contents.txt_disposable_routine;
         :NEW.txt_disposable_reason       := p_m_load_form_plsql_contents.txt_disposable_reason;
         :NEW.txt_observacoes             := p_m_load_form_plsql_contents.txt_observacoes;
      else
         raise_application_error (-20001, p_msg_retorno);
      end if;

      if    inserting then
         :NEW.id                 := s_m_load_form_plsql_contents.nextval;
         :NEW.user_create        := nvl (v('APP_USER'), user);
         :NEW.date_create        := sysdate;
         :NEW.app_create_id      := nv('APP_ID');
         :NEW.app_create_page_id := nv('APP_PAGE_ID');
      elsif updating then
         :NEW.user_update        := nvl (v('APP_USER'), user);
         :NEW.date_update        := sysdate;
         :NEW.app_update_page_id := nv('APP_PAGE_ID');
         :NEW.app_update_id      := nv('APP_ID');
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t01_m_load_form_plsql_contents;
/

CREATE OR REPLACE TRIGGER t02_m_load_form_plsql_contents
AFTER INSERT OR UPDATE ON m_load_form_plsql_contents
FOR EACH ROW
DECLARE
   p_m_load_form_plsql_contents m_load_form_plsql_contents%ROWTYPE := NULL;
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T02_M_LOAD_FORM_PLSQL_CONTENTS (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      p_m_load_form_plsql_contents.id                          := :NEW.id;
      p_m_load_form_plsql_contents.id_form                     := :NEW.id_form;
      p_m_load_form_plsql_contents.id_rownum                   := :NEW.id_rownum;
      p_m_load_form_plsql_contents.txt_generated_function_name := :NEW.txt_generated_function_name;
      p_m_load_form_plsql_contents.txt_plsql_source            := :NEW.txt_plsql_source;
      p_m_load_form_plsql_contents.txt_block_source            := :NEW.txt_block_source;
      p_m_load_form_plsql_contents.txt_plsql_program_unit_type := :NEW.txt_plsql_program_unit_type;
      p_m_load_form_plsql_contents.txt_block_item_source       := :NEW.txt_block_item_source;
      p_m_load_form_plsql_contents.txt_plsql_object_name       := :NEW.txt_plsql_object_name;
      p_m_load_form_plsql_contents.txt_comments                := :NEW.txt_comments;
      p_m_load_form_plsql_contents.clob_plsql_contents         := :NEW.clob_plsql_contents;
      p_m_load_form_plsql_contents.clob_plsql_contents_no_comm := :NEW.clob_plsql_contents_no_comm;
      p_m_load_form_plsql_contents.txt_disposable_routine      := :NEW.txt_disposable_routine;
      p_m_load_form_plsql_contents.txt_observacoes             := :NEW.txt_observacoes;

      p_retorno := PKG_M_LOAD_FORM_PLSQL_CONTENTS.fu_collect_block_gsp_items_b (p_m_load_form_plsql_contents, p_msg_retorno);

      if p_retorno != TRUE then
         raise_application_error (-20001, p_msg_retorno);
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t02_m_load_form_plsql_contents;
/

CREATE OR REPLACE TRIGGER t01_m_load_form_plsql_params
BEFORE INSERT OR UPDATE ON m_load_form_plsql_params
FOR EACH ROW
DECLARE
   p_m_load_form_plsql_params m_load_form_plsql_params%ROWTYPE := NULL;
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T01_M_LOAD_FORM_PLSQL_PARAMS (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      p_m_load_form_plsql_params.id                          := :NEW.id;
      p_m_load_form_plsql_params.id_form                     := :NEW.id_form;
      p_m_load_form_plsql_params.id_plsql_contents           := :NEW.id_plsql_contents;
      p_m_load_form_plsql_params.txt_block_item_gsp_variable := :NEW.txt_block_item_gsp_variable;
      p_m_load_form_plsql_params.txt_observacoes             := :NEW.txt_observacoes;
      p_m_load_form_plsql_params.txt_variable_declaration    := :NEW.txt_variable_declaration;
      p_m_load_form_plsql_params.txt_variable_type           := :NEW.txt_variable_type;

      p_retorno := PKG_M_LOAD_FORM_PLSQL_PARAMS.fu_val_m_load_form_plsql_par_b (p_m_load_form_plsql_params, p_msg_retorno);

      if p_retorno = TRUE then
         :NEW.id                          := p_m_load_form_plsql_params.id;
         :NEW.id_form                     := p_m_load_form_plsql_params.id_form;
         :NEW.id_plsql_contents           := p_m_load_form_plsql_params.id_plsql_contents;
         :NEW.txt_block_item_gsp_variable := p_m_load_form_plsql_params.txt_block_item_gsp_variable;
         :NEW.txt_observacoes             := p_m_load_form_plsql_params.txt_observacoes;
         :NEW.txt_variable_declaration    := p_m_load_form_plsql_params.txt_variable_declaration;
         :NEW.txt_variable_type           := p_m_load_form_plsql_params.txt_variable_type;
      else
         if p_msg_retorno is not NULL then
            raise_application_error (-20001, p_msg_retorno);
         end if;
      end if;

      if    inserting then
         :NEW.id                 := s_m_load_form_plsql_params.nextval;
         :NEW.user_create        := nvl (v('APP_USER'), user);
         :NEW.date_create        := sysdate;
         :NEW.app_create_id      := nv('APP_ID');
         :NEW.app_create_page_id := nv('APP_PAGE_ID');
      elsif updating then
         :NEW.user_update        := nvl (v('APP_USER'), user);
         :NEW.date_update        := sysdate;
         :NEW.app_update_page_id := nv('APP_PAGE_ID');
         :NEW.app_update_id      := nv('APP_ID');
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t01_m_load_form_plsql_params;
/

CREATE OR REPLACE TRIGGER t01_m_load_form_record_groups
BEFORE INSERT OR UPDATE ON m_load_form_record_groups
FOR EACH ROW
DECLARE
   p_m_load_form_record_groups m_load_form_record_groups%ROWTYPE := NULL;
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T01_M_LOAD_FORM_RECORD_GROUPS (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      p_m_load_form_record_groups.id                            := :NEW.id;
      p_m_load_form_record_groups.id_form                       := :NEW.id_form;
      p_m_load_form_record_groups.id_rownum                     := :NEW.id_rownum;
      p_m_load_form_record_groups.txt_record_group_name         := :NEW.txt_record_group_name;
      p_m_load_form_record_groups.txt_record_group_type         := :NEW.txt_record_group_type;
      p_m_load_form_record_groups.txt_record_group_col_name     := :NEW.txt_record_group_col_name;
      p_m_load_form_record_groups.txt_record_group_col_maxsize  := :NEW.txt_record_group_col_maxsize;
      p_m_load_form_record_groups.txt_record_group_col_datatype := :NEW.txt_record_group_col_datatype;
      p_m_load_form_record_groups.txt_observacoes               := :NEW.txt_observacoes;

      p_retorno := PKG_M_LOAD_FORM_RECORD_GROUPS.fu_val_m_load_form_record_gr_b (p_m_load_form_record_groups, p_msg_retorno);

      if p_retorno = TRUE then
         :NEW.id                            := p_m_load_form_record_groups.id;
         :NEW.id_form                       := p_m_load_form_record_groups.id_form;
         :NEW.id_rownum                     := p_m_load_form_record_groups.id_rownum;
         :NEW.txt_record_group_name         := p_m_load_form_record_groups.txt_record_group_name;
         :NEW.txt_record_group_type         := p_m_load_form_record_groups.txt_record_group_type;
         :NEW.txt_record_group_col_name     := p_m_load_form_record_groups.txt_record_group_col_name;
         :NEW.txt_record_group_col_maxsize  := p_m_load_form_record_groups.txt_record_group_col_maxsize;
         :NEW.txt_record_group_col_datatype := p_m_load_form_record_groups.txt_record_group_col_datatype;
         :NEW.txt_observacoes               := p_m_load_form_record_groups.txt_observacoes;
      else
         raise_application_error (-20001, p_msg_retorno);
      end if;

      if    inserting then
         :NEW.id                 := s_m_load_form_record_groups.nextval;
         :NEW.user_create        := nvl (v('APP_USER'), user);
         :NEW.date_create        := sysdate;
         :NEW.app_create_id      := nv('APP_ID');
         :NEW.app_create_page_id := nv('APP_PAGE_ID');
      elsif updating then
         :NEW.user_update        := nvl (v('APP_USER'), user);
         :NEW.date_update        := sysdate;
         :NEW.app_update_page_id := nv('APP_PAGE_ID');
         :NEW.app_update_id      := nv('APP_ID');
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t01_m_load_form_record_groups;
/

CREATE OR REPLACE TRIGGER t01_m_load_form_glob_syst_parm
BEFORE INSERT OR UPDATE ON m_load_form_glob_syst_parm
FOR EACH ROW
DECLARE
   p_m_load_form_glob_syst_parm m_load_form_glob_syst_parm%ROWTYPE := NULL;
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T01_M_LOAD_FORM_GLOB_SYST_PARM (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      p_m_load_form_glob_syst_parm.id                          := :NEW.id;
      p_m_load_form_glob_syst_parm.id_form                     := :NEW.id_form;
      p_m_load_form_glob_syst_parm.id_rownum                   := :NEW.id_rownum;
      p_m_load_form_glob_syst_parm.txt_variable_type           := :NEW.txt_variable_type;
      p_m_load_form_glob_syst_parm.txt_variable_parameter_name := :NEW.txt_variable_parameter_name;
      p_m_load_form_glob_syst_parm.txt_variable_name           := :NEW.txt_variable_name;
      p_m_load_form_glob_syst_parm.txt_variable_data_type      := :NEW.txt_variable_data_type;
      p_m_load_form_glob_syst_parm.txt_variable_max_size       := :NEW.txt_variable_max_size;
      p_m_load_form_glob_syst_parm.txt_variable_ini_value      := :NEW.txt_variable_ini_value;
      p_m_load_form_glob_syst_parm.txt_observacoes             := :NEW.txt_observacoes;

      p_retorno := PKG_M_LOAD_FORM_GLOB_SYST_PARM.fu_val_m_load_form_glob_syst_b (p_m_load_form_glob_syst_parm, p_msg_retorno);

      if p_retorno = TRUE then
         :NEW.id                          := p_m_load_form_glob_syst_parm.id;
         :NEW.id_form                     := p_m_load_form_glob_syst_parm.id_form;
         :NEW.id_rownum                   := p_m_load_form_glob_syst_parm.id_rownum;
         :NEW.txt_variable_type           := p_m_load_form_glob_syst_parm.txt_variable_type;
         :NEW.txt_variable_parameter_name := p_m_load_form_glob_syst_parm.txt_variable_parameter_name;
         :NEW.txt_variable_name           := p_m_load_form_glob_syst_parm.txt_variable_name;
         :NEW.txt_variable_data_type      := p_m_load_form_glob_syst_parm.txt_variable_data_type;
         :NEW.txt_variable_max_size       := p_m_load_form_glob_syst_parm.txt_variable_max_size;
         :NEW.txt_variable_ini_value      := p_m_load_form_glob_syst_parm.txt_variable_ini_value;
         :NEW.txt_observacoes             := p_m_load_form_glob_syst_parm.txt_observacoes;
      else
         raise_application_error (-20001, p_msg_retorno);
      end if;

      if    inserting then
         :NEW.id                 := s_m_load_form_glob_syst_parm.nextval;
         :NEW.user_create        := nvl (v('APP_USER'), user);
         :NEW.date_create        := sysdate;
         :NEW.app_create_id      := nv('APP_ID');
         :NEW.app_create_page_id := nv('APP_PAGE_ID');
      elsif updating then
         :NEW.user_update        := nvl (v('APP_USER'), user);
         :NEW.date_update        := sysdate;
         :NEW.app_update_page_id := nv('APP_PAGE_ID');
         :NEW.app_update_id      := nv('APP_ID');
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t01_m_load_form_glob_syst_parm;
/

CREATE OR REPLACE TRIGGER t01_m_disposable_contents
BEFORE INSERT OR UPDATE ON m_disposable_contents
FOR EACH ROW
DECLARE
   p_m_disposable_contents m_disposable_contents%ROWTYPE := NULL;
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T01_M_DISPOSABLE_CONTENTS (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      p_m_disposable_contents.id                             := :NEW.id;
      p_m_disposable_contents.txt_disposable_text            := :NEW.txt_disposable_text;
      p_m_disposable_contents.id_disposable_text_type        := :NEW.id_disposable_text_type;
      p_m_disposable_contents.txt_disposable_text_has_params := :NEW.txt_disposable_text_has_params;
      p_m_disposable_contents.txt_disposable_text_is_package := :NEW.txt_disposable_text_is_package;
      p_m_disposable_contents.txt_observacoes                := :NEW.txt_observacoes;

      p_retorno := PKG_M_DISPOSABLE_CONTENTS.fu_val_m_disposable_contents_b (p_m_disposable_contents, p_msg_retorno);

      if p_retorno = TRUE then
         :NEW.id                             := p_m_disposable_contents.id;
         :NEW.txt_disposable_text            := p_m_disposable_contents.txt_disposable_text;
         :NEW.id_disposable_text_type        := p_m_disposable_contents.id_disposable_text_type;
         :NEW.txt_disposable_text_has_params := p_m_disposable_contents.txt_disposable_text_has_params;
         :NEW.txt_disposable_text_is_package := p_m_disposable_contents.txt_disposable_text_is_package;
         :NEW.txt_observacoes                := p_m_disposable_contents.txt_observacoes;
      else
         raise_application_error (-20001, p_msg_retorno);
      end if;

      if    inserting then
         :NEW.id                 := s_m_disposable_contents.nextval;
         :NEW.user_create        := nvl (v('APP_USER'), user);
         :NEW.date_create        := sysdate;
         :NEW.app_create_id      := nv('APP_ID');
         :NEW.app_create_page_id := nv('APP_PAGE_ID');
      elsif updating then
         :NEW.user_update        := nvl (v('APP_USER'), user);
         :NEW.date_update        := sysdate;
         :NEW.app_update_page_id := nv('APP_PAGE_ID');
         :NEW.app_update_id      := nv('APP_ID');
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t01_m_disposable_contents;
/

CREATE OR REPLACE TRIGGER t01_m_load_form_trigger_types
BEFORE INSERT OR UPDATE ON m_load_form_trigger_types
FOR EACH ROW
DECLARE
   p_m_load_form_trigger_types m_load_form_trigger_types%ROWTYPE := NULL;
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T01_M_LOAD_FORM_TRIGGER_TYPES (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      p_m_load_form_trigger_types.id                    := :NEW.id;
      p_m_load_form_trigger_types.txt_trigger_type_name := :NEW.txt_trigger_type_name;
      p_m_load_form_trigger_types.txt_observacoes       := :NEW.txt_observacoes;

      p_retorno := PKG_M_LOAD_FORM_TRIGGER_TYPES.fu_val_m_load_form_trigger_t_b (p_m_load_form_trigger_types, p_msg_retorno);

      if p_retorno = TRUE then
         :NEW.id                    := p_m_load_form_trigger_types.id;
         :NEW.txt_trigger_type_name := p_m_load_form_trigger_types.txt_trigger_type_name;
         :NEW.txt_observacoes       := p_m_load_form_trigger_types.txt_observacoes;
      else
         raise_application_error (-20001, p_msg_retorno);
      end if;

      if    inserting then
         :NEW.id                 := s_m_load_form_trigger_types.nextval;
         :NEW.user_create        := nvl (v('APP_USER'), user);
         :NEW.date_create        := sysdate;
         :NEW.app_create_id      := nv('APP_ID');
         :NEW.app_create_page_id := nv('APP_PAGE_ID');
      elsif updating then
         :NEW.user_update        := nvl (v('APP_USER'), user);
         :NEW.date_update        := sysdate;
         :NEW.app_update_page_id := nv('APP_PAGE_ID');
         :NEW.app_update_id      := nv('APP_ID');
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t01_m_load_form_trigger_types;
/

CREATE OR REPLACE TRIGGER t01_m_load_form_dispos_txt_typ
BEFORE INSERT OR UPDATE ON m_load_form_dispos_txt_typ
FOR EACH ROW
DECLARE
   p_m_load_form_dispos_txt_typ m_load_form_dispos_txt_typ%ROWTYPE := NULL;
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T01_M_LOAD_FORM_DISPOS_TXT_TYP (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      p_m_load_form_dispos_txt_typ.id                       := :NEW.id;
      p_m_load_form_dispos_txt_typ.txt_disposable_text_type := :NEW.txt_disposable_text_type;
      p_m_load_form_dispos_txt_typ.txt_observacoes          := :NEW.txt_observacoes;

      p_retorno := PKG_M_LOAD_FORM_DISPOS_TXT_TYP.fu_val_m_load_form_dispos_tx_b (p_m_load_form_dispos_txt_typ, p_msg_retorno);

      if p_retorno = TRUE then
         :NEW.id                       := p_m_load_form_dispos_txt_typ.id;
         :NEW.txt_disposable_text_type := p_m_load_form_dispos_txt_typ.txt_disposable_text_type;
         :NEW.txt_observacoes          := p_m_load_form_dispos_txt_typ.txt_observacoes;
      else
         raise_application_error (-20001, p_msg_retorno);
      end if;

      if    inserting then
         :NEW.id                 := s_m_load_form_dispos_txt_typ.nextval;
         :NEW.user_create        := nvl (v('APP_USER'), user);
         :NEW.date_create        := sysdate;
         :NEW.app_create_id      := nv('APP_ID');
         :NEW.app_create_page_id := nv('APP_PAGE_ID');
      elsif updating then
         :NEW.user_update        := nvl (v('APP_USER'), user);
         :NEW.date_update        := sysdate;
         :NEW.app_update_page_id := nv('APP_PAGE_ID');
         :NEW.app_update_id      := nv('APP_ID');
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t01_m_load_form_dispos_txt_typ;
/

CREATE OR REPLACE TRIGGER t01_m_load_form_custom_disposa
BEFORE INSERT OR UPDATE ON m_load_form_custom_disposa
FOR EACH ROW
DECLARE
   p_m_load_form_custom_disposa m_load_form_custom_disposa%ROWTYPE := NULL;
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T01_M_LOAD_FORM_CUSTOM_DISPOSA (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      p_m_load_form_custom_disposa.id                             := :NEW.id;
      p_m_load_form_custom_disposa.txt_custom_disposable_text     := :NEW.txt_custom_disposable_text;
      p_m_load_form_custom_disposa.id_disposable_text_type        := :NEW.id_disposable_text_type;
      p_m_load_form_custom_disposa.txt_disposable_text_has_params := :NEW.txt_disposable_text_has_params;
      p_m_load_form_custom_disposa.txt_disposable_text_is_package := :NEW.txt_disposable_text_is_package;
      p_m_load_form_custom_disposa.txt_disposable_text_detected   := :NEW.txt_disposable_text_detected;
      p_m_load_form_custom_disposa.txt_observacoes                := :NEW.txt_observacoes;

      p_retorno := PKG_M_LOAD_FORM_CUSTOM_DISPOSA.fu_val_m_load_form_custom_di_b (p_m_load_form_custom_disposa, p_msg_retorno);

      if p_retorno = TRUE then
         :NEW.id                             := p_m_load_form_custom_disposa.id;
         :NEW.txt_custom_disposable_text     := p_m_load_form_custom_disposa.txt_custom_disposable_text;
         :NEW.id_disposable_text_type        := p_m_load_form_custom_disposa.id_disposable_text_type;
         :NEW.txt_disposable_text_has_params := p_m_load_form_custom_disposa.txt_disposable_text_has_params;
         :NEW.txt_disposable_text_is_package := p_m_load_form_custom_disposa.txt_disposable_text_is_package;
         :NEW.txt_disposable_text_detected   := p_m_load_form_custom_disposa.txt_disposable_text_detected;
         :NEW.txt_observacoes                := p_m_load_form_custom_disposa.txt_observacoes;
      else
         raise_application_error (-20001, p_msg_retorno);
      end if;

      if    inserting then
         :NEW.id                 := s_m_load_form_custom_disposa.nextval;
         :NEW.user_create        := nvl (v('APP_USER'), user);
         :NEW.date_create        := sysdate;
         :NEW.app_create_id      := nv('APP_ID');
         :NEW.app_create_page_id := nv('APP_PAGE_ID');
      elsif updating then
         :NEW.user_update        := nvl (v('APP_USER'), user);
         :NEW.date_update        := sysdate;
         :NEW.app_update_page_id := nv('APP_PAGE_ID');
         :NEW.app_update_id      := nv('APP_ID');
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t01_m_load_form_custom_disposa;
/

CREATE OR REPLACE TRIGGER t01_m_disposable_form_trg_lvl
BEFORE INSERT OR UPDATE ON m_disposable_form_trg_lvl
FOR EACH ROW
DECLARE
   p_m_disposable_form_trg_lvl m_disposable_form_trg_lvl%ROWTYPE := NULL;
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T01_M_DISPOSABLE_FORM_TRG_LVL (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      p_m_disposable_form_trg_lvl.id                             := :NEW.id;
      p_m_disposable_form_trg_lvl.id_disposable_form_trg         := :NEW.id_disposable_form_trg;
      p_m_disposable_form_trg_lvl.txt_disposa_trg_on_form_level  := :NEW.txt_disposa_trg_on_form_level;
      p_m_disposable_form_trg_lvl.txt_disposa_trg_on_block_level := :NEW.txt_disposa_trg_on_block_level;
      p_m_disposable_form_trg_lvl.txt_disposa_trg_on_item_level  := :NEW.txt_disposa_trg_on_item_level;

      p_retorno := PKG_M_DISPOSABLE_FORM_TRG_LVL.fu_val_m_disposable_form_trg_b (p_m_disposable_form_trg_lvl, p_msg_retorno);

      if p_retorno = TRUE then
         :NEW.id                             := p_m_disposable_form_trg_lvl.id;
         :NEW.id_disposable_form_trg         := p_m_disposable_form_trg_lvl.id_disposable_form_trg;
         :NEW.txt_disposa_trg_on_form_level  := p_m_disposable_form_trg_lvl.txt_disposa_trg_on_form_level;
         :NEW.txt_disposa_trg_on_block_level := p_m_disposable_form_trg_lvl.txt_disposa_trg_on_block_level;
         :NEW.txt_disposa_trg_on_item_level  := p_m_disposable_form_trg_lvl.txt_disposa_trg_on_item_level;
      else
         raise_application_error (-20001, p_msg_retorno);
      end if;

      if    inserting then
         :NEW.id                 := s_m_disposable_form_trg_lvl.nextval;
         :NEW.user_create        := nvl (v('APP_USER'), user);
         :NEW.date_create        := sysdate;
         :NEW.app_create_id      := nv('APP_ID');
         :NEW.app_create_page_id := nv('APP_PAGE_ID');
      elsif updating then
         :NEW.user_update        := nvl (v('APP_USER'), user);
         :NEW.date_update        := sysdate;
         :NEW.app_update_page_id := nv('APP_PAGE_ID');
         :NEW.app_update_id      := nv('APP_ID');
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t01_m_disposable_form_trg_lvl;
/

CREATE OR REPLACE TRIGGER t01_m_load_form_list_values
BEFORE INSERT OR UPDATE ON m_load_form_list_values
FOR EACH ROW
DECLARE
   p_m_load_form_list_values m_load_form_list_values%ROWTYPE := NULL;
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'T01_M_LOAD_FORM_LIST_VALUES (' || :NEW.id || '): ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   if inserting or updating then
      p_m_load_form_list_values.id                         := :NEW.id;
      p_m_load_form_list_values.id_form                    := :NEW.id_form;
      p_m_load_form_list_values.txt_lov_name               := :NEW.txt_lov_name;
      p_m_load_form_list_values.txt_lov_title              := :NEW.txt_lov_title;
      p_m_load_form_list_values.txt_lov_type               := :NEW.txt_lov_type;
      p_m_load_form_list_values.txt_lov_record_group       := :NEW.txt_lov_record_group;
      p_m_load_form_list_values.txt_lov_item_name          := :NEW.txt_lov_item_name;
      p_m_load_form_list_values.txt_lov_item_title         := :NEW.txt_lov_item_title;
      p_m_load_form_list_values.txt_lov_item_return_item   := :NEW.txt_lov_item_return_item;
      p_m_load_form_list_values.txt_lov_item_display_width := :NEW.txt_lov_item_display_width;
      p_m_load_form_list_values.txt_observacoes            := :NEW.txt_observacoes;

      p_retorno := PKG_M_LOAD_FORM_LIST_VALUES.fu_val_m_load_form_lst_value_b (p_m_load_form_list_values, p_msg_retorno);

      if p_retorno = TRUE then
         :NEW.id                         := p_m_load_form_list_values.id;
         :NEW.id_form                    := p_m_load_form_list_values.id_form;
         :NEW.txt_lov_name               := p_m_load_form_list_values.txt_lov_name;
         :NEW.txt_lov_title              := p_m_load_form_list_values.txt_lov_title;
         :NEW.txt_lov_type               := p_m_load_form_list_values.txt_lov_type;
         :NEW.txt_lov_record_group       := p_m_load_form_list_values.txt_lov_record_group;
         :NEW.txt_lov_item_name          := p_m_load_form_list_values.txt_lov_item_name;
         :NEW.txt_lov_item_title         := p_m_load_form_list_values.txt_lov_item_title;
         :NEW.txt_lov_item_return_item   := p_m_load_form_list_values.txt_lov_item_return_item;
         :NEW.txt_lov_item_display_width := p_m_load_form_list_values.txt_lov_item_display_width;
         :NEW.txt_observacoes            := p_m_load_form_list_values.txt_observacoes;
      else
         raise_application_error (-20001, p_msg_retorno);
      end if;

      if    inserting then
         :NEW.id                 := s_m_load_form_list_values.nextval;
         :NEW.user_create        := nvl (v('APP_USER'), user);
         :NEW.date_create        := sysdate;
         :NEW.app_create_id      := nv('APP_ID');
         :NEW.app_create_page_id := nv('APP_PAGE_ID');
      elsif updating then
         :NEW.user_update        := nvl (v('APP_USER'), user);
         :NEW.date_update        := sysdate;
         :NEW.app_update_page_id := nv('APP_PAGE_ID');
         :NEW.app_update_id      := nv('APP_ID');
      end if;
   end if;

EXCEPTION
   when others then
      raise_application_error (-20000, 'Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END t01_m_load_form_list_values;
/
