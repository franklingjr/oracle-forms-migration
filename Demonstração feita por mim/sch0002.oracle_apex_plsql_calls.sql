-- CALL: PKG_SCH0002.FN_POST_QUERY_0001_B
DECLARE
   p_return boolean := NULL;
   p_prc_name varchar2(100) := 'fn_post_query_0001_b: ';
   p_msg_return varchar2(4000) := NULL;

BEGIN
   p_return := PKG_SCH0002.fn_post_query_0001_b (p_sch_name_0002241 =>     :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL_MEMBERS.SCH_NAME
                                               , p_sch_mt_name_0002517 =>  :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL_MEMBERS.SCH_MT_NAME
                                               , p_sch_me_sc_id_0002034 => :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL_MEMBERS.SCH_ME_SC_ID
                                               , p_sch_me_mt_id_0002312 => :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL_MEMBERS.SCH_ME_MT_ID
                                               , p_msg_return =>           p_msg_return);

   if p_return != TRUE then
      APEX_ERROR.add_error (p_message => p_msg_return, p_display_location => 'INLINE_IN_NOTIFICATION');
   end if;

EXCEPTION
   when others then
      APEX_ERROR.add_error (p_message => 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm, p_display_location => 'INLINE_IN_NOTIFICATION');
END;

-- CALL: PKG_SCH0002.FN_PRE_INSERT_0002_B
DECLARE
   p_return boolean := NULL;
   p_prc_name varchar2(100) := 'fn_pre_insert_0002_b: ';
   p_msg_return varchar2(4000) := NULL;

BEGIN
   p_return := PKG_SCH0002.fn_pre_insert_0002_b (p_sch_me_id_0001862 => :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL_MEMBERS.SCH_ME_ID
                                               , p_msg_return =>        p_msg_return);

   if p_return != TRUE then
      APEX_ERROR.add_error (p_message => p_msg_return, p_display_location => 'INLINE_IN_NOTIFICATION');
   end if;

EXCEPTION
   when others then
      APEX_ERROR.add_error (p_message => 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm, p_display_location => 'INLINE_IN_NOTIFICATION');
END;

-- CALL: PKG_SCH0002.FN_WHEN_VALIDATE_RECORD_0003_B
DECLARE
   p_return boolean := NULL;
   p_prc_name varchar2(100) := 'fn_when_validate_record_0003_b: ';
   p_msg_return varchar2(4000) := NULL;

BEGIN
   p_return := PKG_SCH0002.fn_when_validate_record_0003_b (p_sch_me_name_0001933 =>  :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL_MEMBERS.SCH_ME_NAME
                                                         , p_sch_me_sc_id_0002034 => :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL_MEMBERS.SCH_ME_SC_ID
                                                         , p_sch_me_mt_id_0002312 => :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL_MEMBERS.SCH_ME_MT_ID
                                                         , p_msg_return =>           p_msg_return);

   if p_return != TRUE then
      APEX_ERROR.add_error (p_message => p_msg_return, p_display_location => 'INLINE_IN_NOTIFICATION');
   end if;

EXCEPTION
   when others then
      APEX_ERROR.add_error (p_message => 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm, p_display_location => 'INLINE_IN_NOTIFICATION');
END;

-- CALL: PKG_SCH0002.FN_WHEN_VALIDATE_ITEM_0004_B
DECLARE
   p_return boolean := NULL;
   p_prc_name varchar2(100) := 'fn_when_validate_item_0004_b: ';
   p_msg_return varchar2(4000) := NULL;

BEGIN
   p_return := PKG_SCH0002.fn_when_validate_item_0004_b (p_sch_name_0002241 =>     :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL_MEMBERS.SCH_NAME
                                                       , p_sch_me_sc_id_0002034 => :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL_MEMBERS.SCH_ME_SC_ID
                                                       , p_msg_return =>           p_msg_return);

   if p_return != TRUE then
      APEX_ERROR.add_error (p_message => p_msg_return, p_display_location => 'INLINE_IN_NOTIFICATION');
   end if;

EXCEPTION
   when others then
      APEX_ERROR.add_error (p_message => 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm, p_display_location => 'INLINE_IN_NOTIFICATION');
END;

-- CALL: PKG_SCH0002.FN_WHEN_VALIDATE_ITEM_0006_B
DECLARE
   p_return boolean := NULL;
   p_prc_name varchar2(100) := 'fn_when_validate_item_0006_b: ';
   p_msg_return varchar2(4000) := NULL;

BEGIN
   p_return := PKG_SCH0002.fn_when_validate_item_0006_b (p_sch_mt_name_0002517 =>  :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL_MEMBERS.SCH_MT_NAME
                                                       , p_sch_me_mt_id_0002312 => :P0000_ORACLE_APEX_PAGE_FIELD -- :T_SCHOOL_MEMBERS.SCH_ME_MT_ID
                                                       , p_msg_return =>           p_msg_return);

   if p_return != TRUE then
      APEX_ERROR.add_error (p_message => p_msg_return, p_display_location => 'INLINE_IN_NOTIFICATION');
   end if;

EXCEPTION
   when others then
      APEX_ERROR.add_error (p_message => 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm, p_display_location => 'INLINE_IN_NOTIFICATION');
END;

-- CALL: PKG_SCH0002.MSG_ALERT
DECLARE
   p_return boolean := NULL;
   p_prc_name varchar2(100) := 'msg_alert: ';
   p_msg_return varchar2(4000) := NULL;

BEGIN
   p_return := PKG_SCH0002.msg_alert (p_txt_msg_alert =>  :P0000_ORACLE_APEX_PAGE_FIELD -- P_TXT_MSG_ALERT
                                    , p_txt_alert_type => :P0000_ORACLE_APEX_PAGE_FIELD -- P_TXT_ALERT_TYPE
                                    , p_msg_return =>     p_msg_return);

   if p_return != TRUE then
      APEX_ERROR.add_error (p_message => p_msg_return, p_display_location => 'INLINE_IN_NOTIFICATION');
   end if;

EXCEPTION
   when others then
      APEX_ERROR.add_error (p_message => 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm, p_display_location => 'INLINE_IN_NOTIFICATION');
END;

