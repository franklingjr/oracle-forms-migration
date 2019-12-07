CREATE OR REPLACE PACKAGE pkg_sch0001 IS
   p_pck_name varchar2(50) := 'PKG_SCH0001.';


-- PARAMETERS ARE CONVERTED TO PACKAGE VARIABLES AND DECLARED WITH THEIR RESPECTIVE DATA TYPES.

-- RECORD GROUPS ARE RECREATED AS PIPELINED FUNCTIONS SO THEY CAN BE REUSED.
-- SOURCE: LIST OF VALUES "T_SCHOOL.SCH_STATE"

   type t_t_school_sch_state is record (display_value                  varchar2(4000)
                                      , return_value                   varchar2(4000));

   type h_t_school_sch_state is table of t_t_school_sch_state;

-- fn_t_school_sch_state_c
   FUNCTION fn_t_school_sch_state_c (p_display_value                varchar2 default NULL
                                   , p_return_value                 varchar2 default NULL
                                   , p_return                       IN OUT boolean
                                   , p_msg_return                   IN OUT varchar2)
                                     RETURN sys_refcursor;

-- select * from table (pkg_sch0001.fn_t_school_sch_state_p)
-- fn_t_school_sch_state_p
   FUNCTION fn_t_school_sch_state_p (p_display_value                varchar2 default NULL
                                   , p_return_value                 varchar2 default NULL
                                   ) RETURN h_t_school_sch_state PIPELINED;

-- SOURCE: RADIO GROUP "T_SCHOOL.SCH_COUNTRY"

   type t_t_school_sch_country is record (display_value                  varchar2(4000)
                                        , return_value                   varchar2(4000));

   type h_t_school_sch_country is table of t_t_school_sch_country;

-- fn_t_school_sch_country_c
   FUNCTION fn_t_school_sch_country_c (p_display_value                varchar2 default NULL
                                     , p_return_value                 varchar2 default NULL
                                     , p_return                       IN OUT boolean
                                     , p_msg_return                   IN OUT varchar2)
                                       RETURN sys_refcursor;

-- select * from table (pkg_sch0001.fn_t_school_sch_country_p)
-- fn_t_school_sch_country_p
   FUNCTION fn_t_school_sch_country_p (p_display_value                varchar2 default NULL
                                     , p_return_value                 varchar2 default NULL
                                     ) RETURN h_t_school_sch_country PIPELINED;


-- FORM, BLOCK AND BLOCK.ITEM TRIGGER OBJECTS ARE CONVERTED INTO BOOLEAN FUNCTIONS.
-- fn_pre_insert_0001_b
-- SOURCE: "BLOCK TRIGGER" T_SCHOOL: PRE-INSERT
   FUNCTION fn_pre_insert_0001_b (p_sch_id_0000342 IN OUT number -- :T_SCHOOL.SCH_ID
                                , p_msg_return     IN OUT varchar2
                                  ) RETURN boolean;

-- fn_when_validate_record_0002_b
-- SOURCE: "BLOCK TRIGGER" T_SCHOOL: WHEN-VALIDATE-RECORD
   FUNCTION fn_when_validate_record_0002_b (p_sch_name_0000413          IN OUT varchar2 -- :T_SCHOOL.SCH_NAME
                                          , p_sch_address_0000514       IN OUT varchar2 -- :T_SCHOOL.SCH_ADDRESS
                                          , p_sch_city_0000615          IN OUT varchar2 -- :T_SCHOOL.SCH_CITY
                                          , p_sch_director_name_0000716 IN OUT varchar2 -- :T_SCHOOL.SCH_DIRECTOR_NAME
                                          , p_sch_website_0000817       IN OUT varchar2 -- :T_SCHOOL.SCH_WEBSITE
                                          , p_sch_country_0000918       IN OUT number -- :T_SCHOOL.SCH_COUNTRY
                                          , p_sch_state_0001118         IN OUT varchar2 -- :T_SCHOOL.SCH_STATE
                                          , p_msg_return                IN OUT varchar2
                                            ) RETURN boolean;

-- fn_when_radio_changed_0003_b
-- SOURCE: "BLOCK.ITEM TRIGGER" T_SCHOOL.SCH_COUNTRY: WHEN-RADIO-CHANGED
   FUNCTION fn_when_radio_changed_0003_b (p_sch_country_0000918 IN OUT number -- :T_SCHOOL.SCH_COUNTRY
                                        , p_sch_state_0001118   IN OUT varchar2 -- :T_SCHOOL.SCH_STATE
                                        , p_msg_return          IN OUT varchar2
                                          ) RETURN boolean;


-- PROGRAM UNITS ARE REUSED.
-- MSG_ALERT
   PROCEDURE msg_alert (p_txt_msg_alert  IN varchar2
                      , p_txt_alert_type IN varchar2 default 'E'
                      , p_msg_return     IN OUT varchar2
                        );

END pkg_sch0001;
/

CREATE OR REPLACE PACKAGE BODY pkg_sch0001 IS
-- SOURCE: LIST OF VALUES "T_SCHOOL.SCH_STATE"
-- fn_t_school_sch_state_c
   FUNCTION fn_t_school_sch_state_c (p_display_value                varchar2 default NULL
                                   , p_return_value                 varchar2 default NULL
                                   , p_return                       IN OUT boolean
                                   , p_msg_return                   IN OUT varchar2)
                                     RETURN sys_refcursor IS
      c_t_school_sch_state sys_refcursor;
      p_prc_name varchar2(4000) := p_pck_name || 'fn_t_school_sch_state_c: ';

   BEGIN
      open c_t_school_sch_state for
         select t.display_value
              , t.return_value
           from (
                 select 'Alabama' as display_value, 'AL' as return_value from dual union
                 select 'Alaska' as display_value, 'AK' as return_value from dual union
                 select 'Arizona' as display_value, 'AZ' as return_value from dual union
                 select 'Arkansas' as display_value, 'AR' as return_value from dual union
                 select 'California' as display_value, 'CA' as return_value from dual union
                 select 'Colorado' as display_value, 'CO' as return_value from dual union
                 select 'Connecticut' as display_value, 'CT' as return_value from dual union
                 select 'Delaware' as display_value, 'DE' as return_value from dual union
                 select 'District of Columbia' as display_value, 'DC' as return_value from dual union
                 select 'Florida' as display_value, 'FL' as return_value from dual union
                 select 'Georgia' as display_value, 'GA' as return_value from dual union
                 select 'Hawaii' as display_value, 'HI' as return_value from dual union
                 select 'Idaho' as display_value, 'ID' as return_value from dual union
                 select 'Illinois' as display_value, 'IL' as return_value from dual union
                 select 'Indiana' as display_value, 'IN' as return_value from dual union
                 select 'Iowa' as display_value, 'IA' as return_value from dual union
                 select 'Kansas' as display_value, 'KS' as return_value from dual union
                 select 'Kentucky' as display_value, 'KY' as return_value from dual union
                 select 'Louisiana' as display_value, 'LA' as return_value from dual union
                 select 'Maine' as display_value, 'ME' as return_value from dual union
                 select 'Maryland' as display_value, 'MD' as return_value from dual union
                 select 'Massachusetts' as display_value, 'MA' as return_value from dual union
                 select 'Michigan' as display_value, 'MI' as return_value from dual union
                 select 'Minnesota' as display_value, 'MN' as return_value from dual union
                 select 'Mississippi' as display_value, 'MS' as return_value from dual union
                 select 'Missouri' as display_value, 'MO' as return_value from dual union
                 select 'Montana' as display_value, 'MT' as return_value from dual union
                 select 'Nebraska' as display_value, 'NE' as return_value from dual union
                 select 'Nevada' as display_value, 'NV' as return_value from dual union
                 select 'New Hampshire' as display_value, 'NH' as return_value from dual union
                 select 'New Jersey' as display_value, 'NJ' as return_value from dual union
                 select 'New Mexico' as display_value, 'NM' as return_value from dual union
                 select 'New York' as display_value, 'NY' as return_value from dual union
                 select 'North Carolina' as display_value, 'NC' as return_value from dual union
                 select 'North Dakota' as display_value, 'ND' as return_value from dual union
                 select 'OTHER, NOT LISTED' as display_value, 'OO' as return_value from dual union
                 select 'Ohio' as display_value, 'OH' as return_value from dual union
                 select 'Oklahoma' as display_value, 'OK' as return_value from dual union
                 select 'Oregon' as display_value, 'OR' as return_value from dual union
                 select 'Pennsylvania' as display_value, 'PA' as return_value from dual union
                 select 'Rhode Island' as display_value, 'RI' as return_value from dual union
                 select 'South Carolina' as display_value, 'SC' as return_value from dual union
                 select 'South Dakota' as display_value, 'SD' as return_value from dual union
                 select 'Tennessee' as display_value, 'TN' as return_value from dual union
                 select 'Texas' as display_value, 'TX' as return_value from dual union
                 select 'Utah' as display_value, 'UT' as return_value from dual union
                 select 'Vermont' as display_value, 'VT' as return_value from dual union
                 select 'Virginia' as display_value, 'VA' as return_value from dual union
                 select 'Washington' as display_value, 'WA' as return_value from dual union
                 select 'West Virginia' as display_value, 'WV' as return_value from dual union
                 select 'Wisconsin' as display_value, 'WI' as return_value from dual union
                 select 'Wyoming' as display_value, 'WY' as return_value from dual) t
          where t.display_value = nvl (p_display_value, t.display_value)
            and t.return_value  = nvl (p_return_value,  t.return_value);

      p_return := TRUE;
      p_msg_return := NULL;
      return c_t_school_sch_state;

   EXCEPTION
      when others then
         p_return := FALSE;
         p_msg_return := 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return NULL;
   END fn_t_school_sch_state_c;

-- fn_t_school_sch_state_p
   FUNCTION fn_t_school_sch_state_p (p_display_value                varchar2 default NULL
                                   , p_return_value                 varchar2 default NULL
                                     ) RETURN h_t_school_sch_state PIPELINED IS
      p_return boolean := NULL;
      p_msg_return varchar2(4000) := NULL;
      p_prc_name varchar2(4000) := p_pck_name || 'fn_t_school_sch_state_p: ';
      c_t_school_sch_state sys_refcursor;
      r_t_school_sch_state t_t_school_sch_state;

   BEGIN
      c_t_school_sch_state := PKG_SCH0001.fn_t_school_sch_state_c (p_display_value => p_display_value
                                                                 , p_return_value => p_return_value
                                                                 , p_return => p_return
                                                                 , p_msg_return => p_msg_return);

      if p_return = TRUE then
         loop
            BEGIN
               fetch c_t_school_sch_state into r_t_school_sch_state;
               exit when c_t_school_sch_state%NOTFOUND;
               pipe row (r_t_school_sch_state);

            EXCEPTION
               when no_data_needed then
                  close c_t_school_sch_state;
                  return;
               when others then
                  close c_t_school_sch_state;
                  raise_application_error (-20002, 'Error PIPE ROW ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
            END;
         end loop;
      else
         raise_application_error (-20001, 'Error P_RETURN ' || p_prc_name || p_msg_return);
      end if;

   EXCEPTION
      when others then
         raise_application_error (-20000, 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
   END fn_t_school_sch_state_p;

-- SOURCE: RADIO GROUP "T_SCHOOL.SCH_COUNTRY"
-- fn_t_school_sch_country_c
   FUNCTION fn_t_school_sch_country_c (p_display_value                varchar2 default NULL
                                     , p_return_value                 varchar2 default NULL
                                     , p_return                       IN OUT boolean
                                     , p_msg_return                   IN OUT varchar2)
                                       RETURN sys_refcursor IS
      c_t_school_sch_country sys_refcursor;
      p_prc_name varchar2(4000) := p_pck_name || 'fn_t_school_sch_country_c: ';

   BEGIN
      open c_t_school_sch_country for
         select t.display_value
              , t.return_value
           from (
                 select 'Canada' as display_value, '2' as return_value from dual union
                 select 'Other' as display_value, '0' as return_value from dual union
                 select 'USA' as display_value, '1' as return_value from dual) t
          where t.display_value = nvl (p_display_value, t.display_value)
            and t.return_value  = nvl (p_return_value,  t.return_value);

      p_return := TRUE;
      p_msg_return := NULL;
      return c_t_school_sch_country;

   EXCEPTION
      when others then
         p_return := FALSE;
         p_msg_return := 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return NULL;
   END fn_t_school_sch_country_c;

-- fn_t_school_sch_country_p
   FUNCTION fn_t_school_sch_country_p (p_display_value                varchar2 default NULL
                                     , p_return_value                 varchar2 default NULL
                                       ) RETURN h_t_school_sch_country PIPELINED IS
      p_return boolean := NULL;
      p_msg_return varchar2(4000) := NULL;
      p_prc_name varchar2(4000) := p_pck_name || 'fn_t_school_sch_country_p: ';
      c_t_school_sch_country sys_refcursor;
      r_t_school_sch_country t_t_school_sch_country;

   BEGIN
      c_t_school_sch_country := PKG_SCH0001.fn_t_school_sch_country_c (p_display_value => p_display_value
                                                                     , p_return_value => p_return_value
                                                                     , p_return => p_return
                                                                     , p_msg_return => p_msg_return);

      if p_return = TRUE then
         loop
            BEGIN
               fetch c_t_school_sch_country into r_t_school_sch_country;
               exit when c_t_school_sch_country%NOTFOUND;
               pipe row (r_t_school_sch_country);

            EXCEPTION
               when no_data_needed then
                  close c_t_school_sch_country;
                  return;
               when others then
                  close c_t_school_sch_country;
                  raise_application_error (-20002, 'Error PIPE ROW ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
            END;
         end loop;
      else
         raise_application_error (-20001, 'Error P_RETURN ' || p_prc_name || p_msg_return);
      end if;

   EXCEPTION
      when others then
         raise_application_error (-20000, 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
   END fn_t_school_sch_country_p;


-- FORM, BLOCK AND BLOCK.ITEM TRIGGER OBJECTS ARE CONVERTED INTO BOOLEAN FUNCTIONS.
-- fn_pre_insert_0001_b
-- SOURCE: "BLOCK TRIGGER" T_SCHOOL: PRE-INSERT
   FUNCTION fn_pre_insert_0001_b (p_sch_id_0000342 IN OUT number -- :T_SCHOOL.SCH_ID
                                , p_msg_return     IN OUT varchar2
                                  ) RETURN boolean IS
      p_prc_name varchar2(4000) := p_pck_name || 'fn_pre_insert_0001_b: ';

   BEGIN

BEGIN
   select s_t_school.nextval into p_sch_id_0000342 from dual;
END;


      return TRUE;

   EXCEPTION
      when others then
         p_msg_return := 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fn_pre_insert_0001_b;

-- fn_when_validate_record_0002_b
-- SOURCE: "BLOCK TRIGGER" T_SCHOOL: WHEN-VALIDATE-RECORD
   FUNCTION fn_when_validate_record_0002_b (p_sch_name_0000413          IN OUT varchar2 -- :T_SCHOOL.SCH_NAME
                                          , p_sch_address_0000514       IN OUT varchar2 -- :T_SCHOOL.SCH_ADDRESS
                                          , p_sch_city_0000615          IN OUT varchar2 -- :T_SCHOOL.SCH_CITY
                                          , p_sch_director_name_0000716 IN OUT varchar2 -- :T_SCHOOL.SCH_DIRECTOR_NAME
                                          , p_sch_website_0000817       IN OUT varchar2 -- :T_SCHOOL.SCH_WEBSITE
                                          , p_sch_country_0000918       IN OUT number -- :T_SCHOOL.SCH_COUNTRY
                                          , p_sch_state_0001118         IN OUT varchar2 -- :T_SCHOOL.SCH_STATE
                                          , p_msg_return                IN OUT varchar2
                                            ) RETURN boolean IS
      p_prc_name varchar2(4000) := p_pck_name || 'fn_when_validate_record_0002_b: ';

   BEGIN

BEGIN
   p_sch_name_0000413          := ltrim (rtrim (p_sch_name_0000413));
   p_sch_address_0000514       := ltrim (rtrim (p_sch_address_0000514));
   p_sch_city_0000615          := ltrim (rtrim (p_sch_city_0000615));
   p_sch_director_name_0000716 := ltrim (rtrim (p_sch_director_name_0000716));
   p_sch_website_0000817       := ltrim (rtrim (lower (p_sch_website_0000817)));
   p_sch_country_0000918       := ltrim (rtrim (p_sch_country_0000918));
   p_sch_state_0001118         := ltrim (rtrim (p_sch_state_0001118));
   p_sch_country_0000918       := nvl (p_sch_country_0000918, 1); -- 1 = USA

   synchronize;

   if p_sch_name_0000413 is NULL then
      msg_alert ('Name must be informed.');
   end if;

   if p_sch_address_0000514 is NULL then
      msg_alert ('Address must be informed.');
   end if;

   if p_sch_country_0000918 is NULL then
      msg_alert ('Country must be informed.');
   end if;

   if p_sch_city_0000615 is NULL then
      msg_alert ('City must be informed.');
   end if;

   if p_sch_country_0000918 = 1 and p_sch_state_0001118 is NULL then
      msg_alert ('State must be informed for country = USA.');
   end if;

   if p_sch_country_0000918 != 1 and p_sch_state_0001118 is not NULL then
      msg_alert ('State must not be informed for other countries.');
   end if;
END;


      return TRUE;

   EXCEPTION
      when others then
         p_msg_return := 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fn_when_validate_record_0002_b;

-- fn_when_radio_changed_0003_b
-- SOURCE: "BLOCK.ITEM TRIGGER" T_SCHOOL.SCH_COUNTRY: WHEN-RADIO-CHANGED
   FUNCTION fn_when_radio_changed_0003_b (p_sch_country_0000918 IN OUT number -- :T_SCHOOL.SCH_COUNTRY
                                        , p_sch_state_0001118   IN OUT varchar2 -- :T_SCHOOL.SCH_STATE
                                        , p_msg_return          IN OUT varchar2
                                          ) RETURN boolean IS
      p_prc_name varchar2(4000) := p_pck_name || 'fn_when_radio_changed_0003_b: ';

   BEGIN

BEGIN
   if p_sch_country_0000918 != 1 then -- USA
      p_sch_state_0001118 := NULL;
   end if;
END;


      return TRUE;

   EXCEPTION
      when others then
         p_msg_return := 'Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm;
         return FALSE;
   END fn_when_radio_changed_0003_b;


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


END pkg_sch0001;
/
