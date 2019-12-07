prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_190200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2019.10.04'
,p_release=>'19.2.0.00.18'
,p_default_workspace_id=>2378617360132921
,p_default_application_id=>103
,p_default_id_offset=>0
,p_default_owner=>'MIGRACAO'
);
end;
/
 
prompt APPLICATION 103 - SCH
--
-- Application Export:
--   Application:     103
--   Name:            SCH
--   Date and Time:   22:34 Monday November 4, 2019
--   Exported By:     FRANKLIN
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 0
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     248313597106740
--

begin
null;
end;
/
prompt --application/pages/delete_00000
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>0);
end;
/
prompt --application/pages/page_00000
begin
wwv_flow_api.create_page(
 p_id=>0
,p_user_interface_id=>wwv_flow_api.id(1461381538421363)
,p_name=>'Global Page - Desktop'
,p_step_title=>'Global Page - Desktop'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'D'
,p_last_updated_by=>'FRANKLIN'
,p_last_upd_yyyymmddhh24miss=>'20191104210644'
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
