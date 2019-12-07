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
--     PAGE: 2
--   Manifest End
--   Version:         19.2.0.00.18
--   Instance ID:     248313597106740
--

begin
null;
end;
/
prompt --application/pages/delete_00002
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>2);
end;
/
prompt --application/pages/page_00002
begin
wwv_flow_api.create_page(
 p_id=>2
,p_user_interface_id=>wwv_flow_api.id(1461381538421363)
,p_name=>'Schools'
,p_alias=>'SCH0001'
,p_step_title=>'Schools'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'FRANKLIN'
,p_last_upd_yyyymmddhh24miss=>'20191104222509'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(1473243710552926)
,p_plug_name=>'Schools'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(1378182437419895)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY'
,p_query_type=>'TABLE'
,p_query_table=>'T_SCHOOL'
,p_include_rowid_column=>true
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(1474317954553142)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(1474744749553219)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_label=>'Actions'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>20
,p_value_alignment=>'CENTER'
,p_enable_hide=>true
,p_is_primary_key=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(1475374131553306)
,p_name=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROWID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_control_break=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(1475831713553551)
,p_name=>'SCH_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SCH_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'ID'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attribute_02=>'VALUE'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(1476379491553555)
,p_name=>'SCH_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SCH_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>100
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(1476925591553556)
,p_name=>'SCH_ADDRESS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SCH_ADDRESS'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Address'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>200
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(1477566336553561)
,p_name=>'SCH_COUNTRY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SCH_COUNTRY'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Country'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>100
,p_value_alignment=>'LEFT'
,p_is_required=>true
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>'select t.display_value, t.return_value from table (pkg_sch0001.fn_t_school_sch_country_p) t;'
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(1478107763553562)
,p_name=>'SCH_STATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SCH_STATE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'State'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>110
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>'select t.display_value, t.return_value from table (pkg_sch0001.fn_t_school_sch_state_p) t;'
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(1478798783553562)
,p_name=>'SCH_CITY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SCH_CITY'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'City'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_max_length=>50
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(1479346918553568)
,p_name=>'SCH_DIRECTOR_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SCH_DIRECTOR_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Director Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>100
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(1479962116553568)
,p_name=>'SCH_WEBSITE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SCH_WEBSITE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Website'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>200
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(1473626988553066)
,p_internal_uid=>1473626988553066
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>true
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(1474025494553099)
,p_interactive_grid_id=>wwv_flow_api.id(1473626988553066)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(1474157036553129)
,p_report_id=>wwv_flow_api.id(1474025494553099)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(1475142407553230)
,p_view_id=>wwv_flow_api.id(1474157036553129)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(1474744749553219)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(1475609158553319)
,p_view_id=>wwv_flow_api.id(1474157036553129)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(1475374131553306)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(1476146079553552)
,p_view_id=>wwv_flow_api.id(1474157036553129)
,p_display_seq=>2
,p_column_id=>wwv_flow_api.id(1475831713553551)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>53
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(1476780896553555)
,p_view_id=>wwv_flow_api.id(1474157036553129)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(1476379491553555)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(1477381763553559)
,p_view_id=>wwv_flow_api.id(1474157036553129)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(1476925591553556)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(1477961617553561)
,p_view_id=>wwv_flow_api.id(1474157036553129)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(1477566336553561)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(1478512296553562)
,p_view_id=>wwv_flow_api.id(1474157036553129)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(1478107763553562)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(1479140825553568)
,p_view_id=>wwv_flow_api.id(1474157036553129)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(1478798783553562)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(1479769921553568)
,p_view_id=>wwv_flow_api.id(1474157036553129)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(1479346918553568)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(1480321223553569)
,p_view_id=>wwv_flow_api.id(1474157036553129)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(1479962116553568)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(3194365721587036)
,p_tabular_form_region_id=>wwv_flow_api.id(1473243710552926)
,p_validation_name=>'fn_when_validate_record_0002_b'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'   p_return boolean := NULL;',
'   p_prc_name varchar2(100) := ''fn_when_validate_record_0002_b: '';',
'   p_msg_return varchar2(4000) := NULL;',
'',
'BEGIN',
'   if :APEX$ROW_STATUS in (''U'', ''C'') then',
'      p_return := PKG_SCH0001.fn_when_validate_record_0002_b (p_sch_name_0000413 =>          :SCH_NAME',
'                                                            , p_sch_address_0000514 =>       :SCH_ADDRESS',
'                                                            , p_sch_city_0000615 =>          :SCH_CITY',
'                                                            , p_sch_director_name_0000716 => :SCH_DIRECTOR_NAME',
'                                                            , p_sch_website_0000817 =>       :SCH_WEBSITE',
'                                                            , p_sch_country_0000918 =>       :SCH_COUNTRY',
'                                                            , p_sch_state_0001118 =>         :SCH_STATE',
'                                                            , p_msg_return =>                p_msg_return);',
'   end if;',
'',
'   return p_msg_return;',
'',
'EXCEPTION',
'   when others then',
'      return ''Error '' || p_prc_name || to_char (sqlcode) || '' - '' || sqlerrm;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(3194498083587037)
,p_tabular_form_region_id=>wwv_flow_api.id(1473243710552926)
,p_validation_name=>'fn_pre_insert_0001_b'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'   p_return boolean := NULL;',
'   p_prc_name varchar2(100) := ''fn_pre_insert_0001_b: '';',
'   p_msg_return varchar2(4000) := NULL;',
'',
'BEGIN',
'   if :APEX$ROW_STATUS = ''C'' then',
'      p_return := PKG_SCH0001.fn_pre_insert_0001_b (p_sch_id_0000342 => :SCH_ID',
'                                                  , p_msg_return =>     p_msg_return);',
'   end if;',
'',
'   return p_msg_return;',
'',
'EXCEPTION',
'   when others then',
'      return ''Error '' || p_prc_name || to_char (sqlcode) || '' - '' || sqlerrm;',
'END;'))
,p_validation_type=>'FUNC_BODY_RETURNING_ERR_TEXT'
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(1480579654553582)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(1473243710552926)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Schools - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
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
