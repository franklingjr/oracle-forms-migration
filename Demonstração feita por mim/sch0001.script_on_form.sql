-- ACCORDING TO DATABASE DATA BLOCKS

-- DATABASE DATA BLOCK: T_SCHOOL
CREATE TABLE T_SCHOOL (
  SCH_ID                          NUMBER(38,0)
, SCH_NAME                        VARCHAR2(100)
, SCH_ADDRESS                     VARCHAR2(200)
, SCH_CITY                        VARCHAR2(50)
, SCH_DIRECTOR_NAME               VARCHAR2(100)
, SCH_WEBSITE                     VARCHAR2(200)
, SCH_COUNTRY                     NUMBER(38,0)
, SCH_STATE                       VARCHAR2(2)
);
/


-- ACCORDING TO QUERY DATA SOURCE

-- QUERY DATA SOURCE COLUMNS: BLOCK: T_SCHOOL
CREATE TABLE T_SCHOOL (
  SCH_ID                          NUMBER(38,0) NOT NULL
, SCH_NAME                        VARCHAR2(100) NOT NULL
, SCH_ADDRESS                     VARCHAR2(200) NOT NULL
, SCH_COUNTRY                     NUMBER(38,0) NOT NULL
, SCH_STATE                       VARCHAR2(2)
, SCH_CITY                        VARCHAR2(50) NOT NULL
, SCH_DIRECTOR_NAME               VARCHAR2(100)
, SCH_WEBSITE                     VARCHAR2(200)
);
/

