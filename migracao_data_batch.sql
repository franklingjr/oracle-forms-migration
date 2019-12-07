-- THIS SCRIPT READS ALL FILE NAMES ON "object_list_reports" TEXT FILE. MUST BE RE-RUN WHENEVER NEW FILE CONTENTS MUST BE IMPORTED INTO DATABASE.
-- TEXT FILES MUST BE SAVED IN UTF-8 FORMAT.
-- PLEASE RUN BATCH FILE "object_list_reports.bat" TO UPDATE THE FILE LIST BEFORE RUNNING THIS SCRIPT. IT PERFORMS THE FOLLOWING COMMAND:
-- dir /b /ogn *.txt > object_list_reports
set serveroutput on size unlimited

DECLARE
   p_directory_name      ALL_DIRECTORIES.directory_name%TYPE := 'SCRIPT'; -- C:\oraclexe\script
   p_retorno             boolean        := NULL;
   p_object_list_reports UTL_FILE.file_type := UTL_FILE.fopen (p_directory_name, 'object_list_reports', 'r');
   p_filename            varchar2(500)  := NULL;
   p_prc_name            varchar2(1000) := 'Importar arquivo (' || p_directory_name || '): ';
   p_msg_retorno         varchar2(4000) := NULL;

BEGIN
   DBMS_OUTPUT.put_line (p_prc_name);

-- Limpar as tabelas usadas para importação e análise
   BEGIN
      delete m_load_form;
      delete m_load_form_lines;
      delete m_load_form_blocks_items;
      delete m_load_form_static_values;
      delete m_load_form_block_relation;
      delete m_load_form_plsql_contents;
      delete m_load_form_plsql_params;
      delete m_load_form_record_groups;
      delete m_load_form_glob_syst_parm;
      delete m_load_form_custom_disposa;
      delete m_load_form_list_values;

      commit;

   EXCEPTION
      when others then
         raise_application_error (-20001, 'Erro DELETE em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
   END;

   BEGIN
      DBMS_OUTPUT.put_line (to_char (sysdate, 'dd/mm/rrrr hh24:mi:ss') || ': importação iniciada.');

      loop
         UTL_FILE.get_line (p_object_list_reports, p_filename);

         p_retorno := PKG_IMPORT_FORM.fu_import_form_from_dir_b (p_directory_name, p_filename, p_msg_retorno);

         if p_retorno = TRUE then
            commit;
            DBMS_OUTPUT.put_line (to_char (sysdate, 'dd/mm/rrrr hh24:mi:ss') || ': arquivo "' || p_filename || '" importado.');
         else
            DBMS_OUTPUT.put_line (p_msg_retorno);
         end if;
      end loop;

   EXCEPTION
      when no_data_found then
         NULL;
      when others then
         raise_application_error (-20002, 'Erro IMPORT ' || p_filename || ' em ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
   END;

   DBMS_OUTPUT.put_line (to_char (sysdate, 'dd/mm/rrrr hh24:mi:ss') || ': importação finalizada.');
   UTL_FILE.fclose (p_object_list_reports);

EXCEPTION
   when others then
      DBMS_OUTPUT.put_line ('Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END;
/

-- Gera a package para todos os arquivos TXT - não esquecer de atualizar o conteúdo do arquivo object_list_reports
set serveroutput on size unlimited

DECLARE
   p_retorno     boolean        := NULL;
   p_prc_name    varchar2(1000) := 'GERAR PACKAGE: ';
   p_msg_retorno varchar2(4000) := NULL;

BEGIN
   DBMS_OUTPUT.put_line (to_char (sysdate, 'dd/mm/rrrr hh24:mi:ss') || ': início da geração da package.');

   for r_load_form in (select id from m_load_form) loop
      p_retorno := PKG_IMPORT_FORM.fu_collect_form_data_b (r_load_form.id, p_msg_retorno);
      DBMS_OUTPUT.put_line (to_char (sysdate, 'dd/mm/rrrr hh24:mi:ss') || ': número ' || r_load_form.id || ' gerado.');

      if p_retorno != TRUE then
         DBMS_OUTPUT.put_line (p_msg_retorno);
      end if;
   end loop;

   DBMS_OUTPUT.put_line (to_char (sysdate, 'dd/mm/rrrr hh24:mi:ss') || ': fim da geração da package.');

EXCEPTION
   when others then
      DBMS_OUTPUT.put_line ('Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END;
/

-- Exporta o conteúdo das variáveis CLOB para os arquivos
set serveroutput on size unlimited

DECLARE
   cursor c_load_form is
      select mlf.*
        from m_load_form mlf
       order by mlf.id;

   r_load_form      c_load_form%ROWTYPE                 := NULL;
   p_directory_name ALL_DIRECTORIES.directory_name%TYPE := 'SCRIPT'; -- C:\oraclexe\script
   p_prc_name       varchar2(1000) := 'Exportar arquivo (' || p_directory_name || '): ';

BEGIN
   for r_load_form in c_load_form loop
      DBMS_OUTPUT.put_line (to_char (sysdate, 'dd/mm/rrrr hh24:mi:ss') || ': Exportando: ' || r_load_form.txt_proposed_plsql_f);
      DBMS_XSLPROCESSOR.clob2file (r_load_form.txt_proposed_plsql,          p_directory_name, r_load_form.txt_proposed_plsql_f);

      DBMS_OUTPUT.put_line (to_char (sysdate, 'dd/mm/rrrr hh24:mi:ss') || ': Exportando: ' || r_load_form.txt_disposed_content_f);
      DBMS_XSLPROCESSOR.clob2file (r_load_form.txt_disposed_content,        p_directory_name, r_load_form.txt_disposed_content_f);

      DBMS_OUTPUT.put_line (to_char (sysdate, 'dd/mm/rrrr hh24:mi:ss') || ': Exportando: ' || r_load_form.txt_oracle_apex_plsql_calls_f);
      DBMS_XSLPROCESSOR.clob2file (r_load_form.txt_oracle_apex_plsql_calls, p_directory_name, r_load_form.txt_oracle_apex_plsql_calls_f);

      DBMS_OUTPUT.put_line (to_char (sysdate, 'dd/mm/rrrr hh24:mi:ss') || ': Exportando: ' || r_load_form.txt_script_on_form_f);
      DBMS_XSLPROCESSOR.clob2file (r_load_form.txt_script_on_form,          p_directory_name, r_load_form.txt_script_on_form_f);

      DBMS_OUTPUT.put_line (to_char (sysdate, 'dd/mm/rrrr hh24:mi:ss') || ': Exportando: ' || r_load_form.txt_static_values_rg_f);
      DBMS_XSLPROCESSOR.clob2file (r_load_form.txt_static_values_rg,        p_directory_name, r_load_form.txt_static_values_rg_f);

      DBMS_OUTPUT.put_line (to_char (sysdate, 'dd/mm/rrrr hh24:mi:ss') || ': Exportando: ' || r_load_form.txt_static_values_li_f);
      DBMS_XSLPROCESSOR.clob2file (r_load_form.txt_static_values_li,        p_directory_name, r_load_form.txt_static_values_li_f);

      DBMS_OUTPUT.put_line (to_char (sysdate, 'dd/mm/rrrr hh24:mi:ss') || ': Exportando: ' || r_load_form.txt_domain_table_values_f);
      DBMS_XSLPROCESSOR.clob2file (r_load_form.txt_domain_table_values,     p_directory_name, r_load_form.txt_domain_table_values_f);

--    DBMS_OUTPUT.put_line (to_char (sysdate, 'dd/mm/rrrr hh24:mi:ss') || ': Exportando: ' || r_load_form.txt_select_query_lov_f);
--    DBMS_XSLPROCESSOR.clob2file (r_load_form.txt_select_query_lov,        p_directory_name, r_load_form.txt_select_query_lov_f);
   end loop;

EXCEPTION
   when others then
      DBMS_OUTPUT.put_line ('Erro ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END;
/
