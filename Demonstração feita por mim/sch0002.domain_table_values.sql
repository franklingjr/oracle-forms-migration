set serveroutput on size unlimited
set define off

DECLARE
   p_prc_name varchar2(50) := 'INSERT INTO DOMAIN TABLES: ';

BEGIN

   commit;

EXCEPTION
   when others then
      rollback;
      DBMS_OUTPUT.put_line ('Error ' || p_prc_name || to_char (sqlcode) || ' - ' || sqlerrm);
END;
/
