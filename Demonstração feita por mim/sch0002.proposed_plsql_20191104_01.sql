CREATE OR REPLACE PACKAGE pkg_sch0002 IS
   p_pck_name varchar2(50) := 'PKG_SCH0002.';


-- PARAMETERS ARE CONVERTED TO PACKAGE VARIABLES AND DECLARED WITH THEIR RESPECTIVE DATA TYPES.

-- RECORD GROUPS ARE RECREATED AS PIPELINED FUNCTIONS SO THEY CAN BE REUSED.
-- SOURCE: RECORD GROUP "RG_SCHOOL_MEMBER_TYPES"
-- RECORD GROUP "RG_SCHOOL_MEMBER_TYPES" IS RELATED TO THE LOV(S):
-- LV_SCHOOL_MEMBER_TYPES (LOV TITLE: "Membership Types") ITEM: "SCH_MT_NAME" (ITEM TITLE: "Membership Name"; RETURN ITEM VALUE TO BLOCK.ITEM "T_SCHOOL_MEMBERS.SCH_MT_NAME"; ITEM WIDTH = 200)
-- LV_SCHOOL_MEMBER_TYPES (LOV TITLE: "Membership Types") ITEM: "SCH_MT_ID" (ITEM TITLE: "ID"; RETURN ITEM VALUE TO BLOCK.ITEM "T_SCHOOL_MEMBERS.SCH_ME_MT_ID"; ITEM WIDTH = 0)
   type t_rg_school_member_types is record (sch_mt_name                    varchar2(100)
                                          , sch_mt_id                      number(23)
);

   type h_rg_school_member_types is table of t_rg_school_member_types;

-- fn_rg_school_member_types_c
   FUNCTION fn_rg_school_member_types_c (p_sch_mt_name                  varchar2 default NULL
                                       , p_sch_mt_id                    number default NULL
                                       , p_return                       IN OUT boolean
                                       , p_msg_return                   IN OUT varchar2)
                                         RETURN sys_refcursor;

-- select * from table (pkg_sch0002.fn_rg_school_member_types_p)
-- fn_rg_school_member_types_p
   FUNCTION fn_rg_school_member_types_p (p_sch_mt_name                  varchar2 default NULL
                                       , p_sch_mt_id                    number default NULL
                                       ) RETURN h_rg_school_member_types PIPELINED;

-- SOURCE: RECORD GROUP "RG_SCHOOLS"
-- RECORD GROUP "RG_SCHOOLS" IS RELATED TO THE LOV(S):
-- LV_SCHOOLS (LOV TITLE: "Schools") ITEM: "SCH_NAME" (ITEM TITLE: "Sch_Name"; RETURN ITEM VALUE TO BLOCK.ITEM "T_SCHOOL_MEMBERS.SCH_NAME"; ITEM WIDTH = 200)
-- LV_SCHOOLS (LOV TITLE: "Schools") ITEM: "SCH_ID" (ITEM TITLE: "Sch_Id"; RETURN ITEM VALUE TO BLOCK.ITEM "T_SCHOOL_MEMBERS.SCH_ME_SC_ID"; ITEM WIDTH = 0)
   type t_rg_schools is record (sch_name                       varchar2(100)
                              , sch_id                         number(23)
);

   type h_rg_schools is table of t_rg_schools;

-- fn_rg_schools_c
   FUNCTION fn_rg_schools_c (p_sch_name                     varchar2 default NULL
                           , p_sch_id                       number default NULL
                           , p_return                       IN OUT boolean
                           , p_msg_return                   IN OUT varchar2)
                             RETURN sys_refcursor;

-- select * from table (pkg_sch0002.fn_rg_schools_p)
-- fn_rg_schools_p
   FUNCTION fn_rg_schools_p (p_sch_name                     varchar2 default NULL
                           , p_sch_id                       number default NULL
                           ) RETURN h_rg_schools PIPELINED;


-- FORM, BLOCK AND BLOCK.ITEM TRIGGER OBJECTS ARE CONVERTED INTO BOOLEAN FUNCTIONS.
-- fn_post_query_0001_b
-- SOURCE: "BLOCK TRIGGER" T_SCHOOL_MEMBERS: POST-QUERY
   FUNCTION fn_post_query_0001_b (p_sch_name_0002241     IN OUT varchar2 -- :T_SCHOOL_MEMBERS.SCH_NAME
                                , p_sch_mt_name_0002517  IN OUT varchar2 -- :T_SCHOOL_MEMBERS.SCH_MT_NAME
                                , p_sch_me_sc_id_0002034 IN OUT number -- :T_SCHOOL_MEMBERS.SCH_ME_SC_ID
                                , p_sch_me_mt_id_0002312 IN OUT number -- :T_SCHOOL_MEMBERS.SCH_ME_MT_ID
                                , p_msg_return           IN OUT varchar2
                                  ) RETURN boolean;

-- fn_pre_insert_0002_b
-- SOURCE: "BLOCK TRIGGER" T_SCHOOL_MEMBERS: PRE-INSERT
   FUNCTION fn_pre_insert_0002_b (p_sch_me_id_0001862 IN OUT number -- :T_SCHOOL_MEMBERS.SCH_ME_ID
                                , p_msg_return        IN OUT varchar2
                                  ) RETURN boolean;

-- fn_when_validate_record_0003_b
-- SOURCE: "BLOCK TRIGGER" T_SCHOOL_MEMBERS: WHEN-VALIDATE-RECORD
   FUNCTION fn_when_validate_record_0003_b (p_sch_me_name_0001933  IN OUT varchar2 -- :T_SCHOOL_MEMBERS.SCH_ME_NAME
                                          , p_sch_me_sc_id_0002034 IN OUT number -- :T_SCHOOL_MEMBERS.SCH_ME_SC_ID
                                          , p_sch_me_mt_id_0002312 IN OUT number -- :T_SCHOOL_MEMBERS.SCH_ME_MT_ID
                                          , p_msg_return           IN OUT varchar2
                                            ) RETURN boolean;

-- fn_when_validate_item_0004_b
-- SOURCE: "BLOCK.ITEM TRIGGER" T_SCHOOL_MEMBERS.SCH_ME_SC_ID: WHEN-VALIDATE-ITEM
   FUNCTION fn_when_validate_item_0004_b (p_sch_name_0002241     IN OUT varchar2 -- :T_SCHOOL_MEMBERS.SCH_NAME
                                        , p_sch_me_sc_id_0002034 IN OUT number -- :T_SCHOOL_MEMBERS.SCH_ME_SC_ID
                                        , p_msg_return           IN OUT varchar2
                                          ) RETURN boolean;

-- fn_when_validate_item_0006_b
-- SOURCE: "BLOCK.ITEM TRIGGER" T_SCHOOL_MEMBERS.SCH_ME_MT_ID: WHEN-VALIDATE-ITEM
   FUNCTION fn_when_validate_item_0006_b (p_sch_mt_name_0002517  IN OUT varchar2 -- :T_SCHOOL_MEMBERS.SCH_MT_NAME
                                        , p_sch_me_mt_id_0002312 IN OUT number -- :T_SCHOOL_MEMBERS.SCH_ME_MT_ID
                                        , p_msg_return           IN OUT varchar2
                                          ) RETURN boolean;


-- PROGRAM UNITS ARE REUSED.
-- MSG_ALERT
   PROCEDURE msg_alert (p_txt_msg_alert  IN varchar2
                      , p_txt_alert_type IN varchar2 default 'E'
                      , p_msg_return     IN OUT varchar2
                        );

END pkg_sch0002;
/

CREATE OR REPLACE PACKAGE BODY pkg_sch0002 IS
-- SOURCE: RECORD GROUP "RG_SCHOOL_MEMBER_TYPES"
-- fn_rg_school_member_types_c
   FUNCTION fn_rg_school_member_types_c (p_sch_mt_name                  varchar2 default NULL
                                       , p_sch_mt_id                    number default NULL
                                       , p_return                       IN OUT boolean
                                       , p_msg_return                   IN OUT varchar2)
                                         RETURN sys_refcursor IS
      c_rg_school_member_types sys_refcursor;
      p_prc_name varchar2(4000) := p_pck_name || 'fn_rg_school_member_types_c (' || p_sch_mt_id
                                                                         || ', ' || p_sch_mt_name
                                                                         || '): ';

   BEGIN
      open c_rg_school_member_types for
         select t.sch_mt_name
              , t.sch_mt_id
           from (
select tsmt.sch_mt_name,
tsmt.sch_mt_id
from t_school_member_types tsmt
where ltrim (rtrim (upper (tsmt.sch_mt_id_active))) = 'Y'
order by tsmt.sch_mt_name


         ) t
          where t.sch_mt_name                    = nvl (p_sch_mt_name, t.sch_mt_name)
            and t.sch_mt_id                      = nvl (p_sch_mt_id, t.sch_mt_id)
;

      p_return := TRUE;
      p_msg_return := NULL;
      return c_rg_school_member_types;

   EXCEPTION
      when others then
         p_return := FALSE;
         p_msg_return := 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return NULL;
   END fn_rg_school_member_types_c;

-- fn_rg_school_member_types_p
   FUNCTION fn_rg_school_member_types_p (p_sch_mt_name                  varchar2 default NULL
                                       , p_sch_mt_id                    number default NULL
                                       ) RETURN h_rg_school_member_types PIPELINED IS
      p_return boolean := NULL;
      p_msg_return varchar2(4000) := NULL;
      p_prc_name varchar2(4000) := p_pck_name || 'fn_rg_school_member_types_p (' || p_sch_mt_id
                                                                         || ', ' || p_sch_mt_name
                                                                         || '): ';
      c_rg_school_member_types sys_refcursor;
      r_rg_school_member_types t_rg_school_member_types;

   BEGIN
      c_rg_school_member_types := PKG_SCH0002.fn_rg_school_member_types_c (p_sch_mt_name => p_sch_mt_name
                                                                         , p_sch_mt_id => p_sch_mt_id
                                                                         , p_return => p_return
                                                                         , p_msg_return => p_msg_return);

      if p_return = TRUE then
         loop
            BEGIN
               fetch c_rg_school_member_types into r_rg_school_member_types;
               exit when c_rg_school_member_types%NOTFOUND;
               pipe row (r_rg_school_member_types);

            EXCEPTION
               when no_data_needed then
                  close c_rg_school_member_types;
                  return;
               when others then
                  close c_rg_school_member_types;
                  raise_application_error (-20002, 'Error PIPE ROW ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
            END;
         end loop;
      else
         raise_application_error (-20001, 'Error P_RETURN ' || p_prc_name || p_msg_return);
      end if;

   EXCEPTION
      when others then
         raise_application_error (-20000, 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
   END fn_rg_school_member_types_p;

-- SOURCE: RECORD GROUP "RG_SCHOOLS"
-- fn_rg_schools_c
   FUNCTION fn_rg_schools_c (p_sch_name                     varchar2 default NULL
                           , p_sch_id                       number default NULL
                           , p_return                       IN OUT boolean
                           , p_msg_return                   IN OUT varchar2)
                             RETURN sys_refcursor IS
      c_rg_schools sys_refcursor;
      p_prc_name varchar2(4000) := p_pck_name || 'fn_rg_schools_c (' || p_sch_id
                                                             || ', ' || p_sch_name
                                                             || '): ';

   BEGIN
      open c_rg_schools for
         select t.sch_name
              , t.sch_id
           from (
select ts.sch_name, ts.sch_id from t_school ts order by ts.sch_name

         ) t
          where t.sch_name                       = nvl (p_sch_name, t.sch_name)
            and t.sch_id                         = nvl (p_sch_id, t.sch_id)
;

      p_return := TRUE;
      p_msg_return := NULL;
      return c_rg_schools;

   EXCEPTION
      when others then
         p_return := FALSE;
         p_msg_return := 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return NULL;
   END fn_rg_schools_c;

-- fn_rg_schools_p
   FUNCTION fn_rg_schools_p (p_sch_name                     varchar2 default NULL
                           , p_sch_id                       number default NULL
                           ) RETURN h_rg_schools PIPELINED IS
      p_return boolean := NULL;
      p_msg_return varchar2(4000) := NULL;
      p_prc_name varchar2(4000) := p_pck_name || 'fn_rg_schools_p (' || p_sch_id
                                                             || ', ' || p_sch_name
                                                             || '): ';
      c_rg_schools sys_refcursor;
      r_rg_schools t_rg_schools;

   BEGIN
      c_rg_schools := PKG_SCH0002.fn_rg_schools_c (p_sch_name => p_sch_name
                                                 , p_sch_id => p_sch_id
                                                 , p_return => p_return
                                                 , p_msg_return => p_msg_return);

      if p_return = TRUE then
         loop
            BEGIN
               fetch c_rg_schools into r_rg_schools;
               exit when c_rg_schools%NOTFOUND;
               pipe row (r_rg_schools);

            EXCEPTION
               when no_data_needed then
                  close c_rg_schools;
                  return;
               when others then
                  close c_rg_schools;
                  raise_application_error (-20002, 'Error PIPE ROW ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
            END;
         end loop;
      else
         raise_application_error (-20001, 'Error P_RETURN ' || p_prc_name || p_msg_return);
      end if;

   EXCEPTION
      when others then
         raise_application_error (-20000, 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
   END fn_rg_schools_p;


-- FORM, BLOCK AND BLOCK.ITEM TRIGGER OBJECTS ARE CONVERTED INTO BOOLEAN FUNCTIONS.
-- fn_post_query_0001_b
-- SOURCE: "BLOCK TRIGGER" T_SCHOOL_MEMBERS: POST-QUERY
   FUNCTION fn_post_query_0001_b (p_sch_name_0002241     IN OUT varchar2 -- :T_SCHOOL_MEMBERS.SCH_NAME
                                , p_sch_mt_name_0002517  IN OUT varchar2 -- :T_SCHOOL_MEMBERS.SCH_MT_NAME
                                , p_sch_me_sc_id_0002034 IN OUT number -- :T_SCHOOL_MEMBERS.SCH_ME_SC_ID
                                , p_sch_me_mt_id_0002312 IN OUT number -- :T_SCHOOL_MEMBERS.SCH_ME_MT_ID
                                , p_msg_return           IN OUT varchar2
                                  ) RETURN boolean IS
      p_prc_name varchar2(4000) := p_pck_name || 'fn_post_query_0001_b: ';

   BEGIN

BEGIN
   select ts.sch_name
     into p_sch_name_0002241
     from t_school ts
    where ts.sch_id = p_sch_me_sc_id_0002034;

EXCEPTION
   when no_data_found then
      p_sch_name_0002241 := NULL;
   when others then
      p_sch_name_0002241 := sqlerrm;
END;

BEGIN
   select tsmt.sch_mt_name
     into p_sch_mt_name_0002517
     from t_school_member_types tsmt
    where tsmt.sch_mt_id = p_sch_me_mt_id_0002312;

EXCEPTION
   when no_data_found then
      p_sch_mt_name_0002517 := NULL;
   when others then
      p_sch_mt_name_0002517 := sqlerrm;
END;


      return TRUE;

   EXCEPTION
      when others then
         p_msg_return := 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fn_post_query_0001_b;

-- fn_pre_insert_0002_b
-- SOURCE: "BLOCK TRIGGER" T_SCHOOL_MEMBERS: PRE-INSERT
   FUNCTION fn_pre_insert_0002_b (p_sch_me_id_0001862 IN OUT number -- :T_SCHOOL_MEMBERS.SCH_ME_ID
                                , p_msg_return        IN OUT varchar2
                                  ) RETURN boolean IS
      p_prc_name varchar2(4000) := p_pck_name || 'fn_pre_insert_0002_b: ';

   BEGIN

select s_t_school_members.nextval into p_sch_me_id_0001862 from dual;

      return TRUE;

   EXCEPTION
      when others then
         p_msg_return := 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fn_pre_insert_0002_b;

-- fn_when_validate_record_0003_b
-- SOURCE: "BLOCK TRIGGER" T_SCHOOL_MEMBERS: WHEN-VALIDATE-RECORD
   FUNCTION fn_when_validate_record_0003_b (p_sch_me_name_0001933  IN OUT varchar2 -- :T_SCHOOL_MEMBERS.SCH_ME_NAME
                                          , p_sch_me_sc_id_0002034 IN OUT number -- :T_SCHOOL_MEMBERS.SCH_ME_SC_ID
                                          , p_sch_me_mt_id_0002312 IN OUT number -- :T_SCHOOL_MEMBERS.SCH_ME_MT_ID
                                          , p_msg_return           IN OUT varchar2
                                            ) RETURN boolean IS
      p_prc_name varchar2(4000) := p_pck_name || 'fn_when_validate_record_0003_b: ';

   BEGIN

BEGIN
   p_sch_me_name_0001933 := ltrim (rtrim (p_sch_me_name_0001933));

   if p_sch_me_name_0001933 is NULL then
      msg_alert ('Member name must be informed.');
   end if;

   if p_sch_me_sc_id_0002034 is NULL then
      msg_alert ('School must be informed.');
   end if;

   if p_sch_me_mt_id_0002312 is NULL then
      msg_alert ('Membership type must be informed.');
   end if;
END;


      return TRUE;

   EXCEPTION
      when others then
         p_msg_return := 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fn_when_validate_record_0003_b;

-- fn_when_validate_item_0004_b
-- SOURCE: "BLOCK.ITEM TRIGGER" T_SCHOOL_MEMBERS.SCH_ME_SC_ID: WHEN-VALIDATE-ITEM
   FUNCTION fn_when_validate_item_0004_b (p_sch_name_0002241     IN OUT varchar2 -- :T_SCHOOL_MEMBERS.SCH_NAME
                                        , p_sch_me_sc_id_0002034 IN OUT number -- :T_SCHOOL_MEMBERS.SCH_ME_SC_ID
                                        , p_msg_return           IN OUT varchar2
                                          ) RETURN boolean IS
      p_prc_name varchar2(4000) := p_pck_name || 'fn_when_validate_item_0004_b: ';

   BEGIN

BEGIN
   select ts.sch_name
     into p_sch_name_0002241
     from t_school ts
    where ts.sch_id = p_sch_me_sc_id_0002034;

EXCEPTION
   when no_data_found then
      p_sch_name_0002241 := NULL;
   when others then
      p_sch_name_0002241 := sqlerrm;
END;


      return TRUE;

   EXCEPTION
      when others then
         p_msg_return := 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fn_when_validate_item_0004_b;

-- fn_when_validate_item_0006_b
-- SOURCE: "BLOCK.ITEM TRIGGER" T_SCHOOL_MEMBERS.SCH_ME_MT_ID: WHEN-VALIDATE-ITEM
   FUNCTION fn_when_validate_item_0006_b (p_sch_mt_name_0002517  IN OUT varchar2 -- :T_SCHOOL_MEMBERS.SCH_MT_NAME
                                        , p_sch_me_mt_id_0002312 IN OUT number -- :T_SCHOOL_MEMBERS.SCH_ME_MT_ID
                                        , p_msg_return           IN OUT varchar2
                                          ) RETURN boolean IS
      p_prc_name varchar2(4000) := p_pck_name || 'fn_when_validate_item_0006_b: ';

   BEGIN

BEGIN
   select tsmt.sch_mt_name
     into p_sch_mt_name_0002517
     from t_school_member_types tsmt
    where tsmt.sch_mt_id = p_sch_me_mt_id_0002312;

EXCEPTION
   when no_data_found then
      p_sch_mt_name_0002517 := NULL;
   when others then
      p_sch_mt_name_0002517 := sqlerrm;
END;


      return TRUE;

   EXCEPTION
      when others then
         p_msg_return := 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fn_when_validate_item_0006_b;


-- PROGRAM UNITS ARE REUSED.
-- MSG_ALERT
   PROCEDURE msg_alert (p_txt_msg_alert  IN varchar2
                      , p_txt_alert_type IN varchar2 default 'E'
                      , p_msg_return     IN OUT varchar2
                        ) IS
   p_alert_id alert;
   p_alert_bt number;

BEGIN
   if ltrim (rtrim (p_txt_msg_alert)) is not NULL and ltrim (rtrim (p_txt_alert_type)) is not NULL then
      if    ltrim (rtrim (upper (p_txt_alert_type))) = 'E' then -- Error
         p_alert_id := find_alert ('MSG_ALERT');
      elsif ltrim (rtrim (upper (p_txt_alert_type))) = 'W' then -- Warning
         p_alert_id := find_alert ('MSG_WARNING');
      else -- Note
         p_alert_id := find_alert ('MSG_NOTE');
      end if;

      set_alert_property (p_alert_id, alert_message_text, p_txt_msg_alert);
      p_alert_bt := show_alert (p_alert_id);

      if ltrim (rtrim (upper (p_txt_alert_type))) = 'E' then
         raise form_trigger_failure;
      end if;
   end if;
END;


END pkg_sch0002;
/
