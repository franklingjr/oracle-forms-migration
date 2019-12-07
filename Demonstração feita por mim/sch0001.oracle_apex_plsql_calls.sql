-- CALL: PKG_SCH0001.FN_PRE_INSERT_0001_B
DECLARE
   p_return boolean := NULL;
   p_prc_name varchar2(100) := 'fn_pre_insert_0001_b: ';
   p_msg_return varchar2(4000) := NULL;

BEGIN
   p_return := PKG_SCH0001.fn_pre_insert_0001_b (p_sch_id_0000342 => :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL.SCH_ID
                                               , p_msg_return =>     p_msg_return);

   if p_return != TRUE then
      APEX_ERROR.add_error (p_message => p_msg_return, p_display_location => 'INLINE_IN_NOTIFICATION');
   end if;

EXCEPTION
   when others then
      APEX_ERROR.add_error (p_message => 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm, p_display_location => 'INLINE_IN_NOTIFICATION');
END;

-- CALL: PKG_SCH0001.FN_WHEN_VALIDATE_RECORD_0002_B
DECLARE
   p_return boolean := NULL;
   p_prc_name varchar2(100) := 'fn_when_validate_record_0002_b: ';
   p_msg_return varchar2(4000) := NULL;

BEGIN
   p_return := PKG_SCH0001.fn_when_validate_record_0002_b (p_sch_name_0000413 =>          :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL.SCH_NAME
                                                         , p_sch_address_0000514 =>       :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL.SCH_ADDRESS
                                                         , p_sch_city_0000615 =>          :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL.SCH_CITY
                                                         , p_sch_director_name_0000716 => :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL.SCH_DIRECTOR_NAME
                                                         , p_sch_website_0000817 =>       :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL.SCH_WEBSITE
                                                         , p_sch_country_0000918 =>       :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL.SCH_COUNTRY
                                                         , p_sch_state_0001118 =>         :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL.SCH_STATE
                                                         , p_msg_return =>                p_msg_return);

   if p_return != TRUE then
      APEX_ERROR.add_error (p_message => p_msg_return, p_display_location => 'INLINE_IN_NOTIFICATION');
   end if;

EXCEPTION
   when others then
      APEX_ERROR.add_error (p_message => 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm, p_display_location => 'INLINE_IN_NOTIFICATION');
END;

-- CALL: PKG_SCH0001.FN_WHEN_RADIO_CHANGED_0003_B
DECLARE
   p_return boolean := NULL;
   p_prc_name varchar2(100) := 'fn_when_radio_changed_0003_b: ';
   p_msg_return varchar2(4000) := NULL;

BEGIN
   p_return := PKG_SCH0001.fn_when_radio_changed_0003_b (p_sch_country_0000918 => :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL.SCH_COUNTRY
                                                       , p_sch_state_0001118 =>   :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL.SCH_STATE
                                                       , p_msg_return =>          p_msg_return);

   if p_return != TRUE then
      APEX_ERROR.add_error (p_message => p_msg_return, p_display_location => 'INLINE_IN_NOTIFICATION');
   end if;

EXCEPTION
   when others then
      APEX_ERROR.add_error (p_message => 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm, p_display_location => 'INLINE_IN_NOTIFICATION');
END;

-- CALL: PKG_SCH0001.MSG_ALERT
DECLARE
   p_return boolean := NULL;
   p_prc_name varchar2(100) := 'msg_alert: ';
   p_msg_return varchar2(4000) := NULL;

BEGIN
   p_return := PKG_SCH0001.msg_alert (p_txt_msg_alert =>  :P0000_ORACLE_APEX_PAGE_FIELD -- P_TXT_MSG_ALERT
                                    , p_txt_alert_type => :P0000_ORACLE_APEX_PAGE_FIELD -- P_TXT_ALERT_TYPE
                                    , p_msg_return =>     p_msg_return);

   if p_return != TRUE then
      APEX_ERROR.add_error (p_message => p_msg_return, p_display_location => 'INLINE_IN_NOTIFICATION');
   end if;

EXCEPTION
   when others then
      APEX_ERROR.add_error (p_message => 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm, p_display_location => 'INLINE_IN_NOTIFICATION');
END;

