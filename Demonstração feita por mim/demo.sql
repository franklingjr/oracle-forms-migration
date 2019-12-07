-- WARNING! Create these objects in a new user
-- sys@oracle as sysdba: create user school identified by (password);
drop sequence s_t_school;
drop sequence s_t_school_member_types;
drop sequence s_t_school_members;

drop table t_school;
drop table t_school_member_types;
drop table t_school_members;

create sequence s_t_school              start with 1 minvalue 1 increment by 1;
create sequence s_t_school_member_types start with 1 minvalue 1 increment by 1;
create sequence s_t_school_members      start with 1 minvalue 1 increment by 1;

-- sch0001.fmb
create table t_school
(sch_id            integer       not NULL,
 sch_name          varchar2(100) not NULL,
 sch_address       varchar2(200) not NULL,
 sch_country       integer       not NULL, -- This field will be hardcoded on form for demonstration purposes
 sch_state         varchar2(2),            -- This field will be hardcoded on form for demonstration purposes
 sch_city          varchar2(50)  not NULL,
 sch_director_name varchar2(100),
 sch_website       varchar2(200),
 constraint t_school_pk primary key (sch_id));

-- No form for this table
create table t_school_member_types
(sch_mt_id        integer       not NULL,
 sch_mt_name      varchar2(100) not NULL,
 sch_mt_id_active varchar2(1)   default 'Y',
 constraint t_school_member_types_pk primary key (sch_mt_id));

-- sch0002.fmb
create table t_school_members
(sch_me_id    integer not NULL,
 sch_me_name  varchar2(100),
 sch_me_sc_id integer not NULL, -- school
 sch_me_mt_id integer not NULL, -- member type
 constraint t_school_members_pk primary key (sch_me_id),
 constraint t_school_members_1_fk foreign key (sch_me_sc_id) references t_school (sch_id),
 constraint t_school_members_2_fk foreign key (sch_me_mt_id) references t_school_member_types (sch_mt_id));

-- Data for t_school_member_types table
BEGIN
   insert into t_school_member_types (sch_mt_id, sch_mt_name) values (s_t_school_member_types.nextval, 'President');
   insert into t_school_member_types (sch_mt_id, sch_mt_name) values (s_t_school_member_types.nextval, 'Director');
   insert into t_school_member_types (sch_mt_id, sch_mt_name) values (s_t_school_member_types.nextval, 'Manager');
   insert into t_school_member_types (sch_mt_id, sch_mt_name) values (s_t_school_member_types.nextval, 'Teacher');
   insert into t_school_member_types (sch_mt_id, sch_mt_name) values (s_t_school_member_types.nextval, 'Assistant');
   insert into t_school_member_types (sch_mt_id, sch_mt_name) values (s_t_school_member_types.nextval, 'Cleaner');
   insert into t_school_member_types (sch_mt_id, sch_mt_name) values (s_t_school_member_types.nextval, 'Librarian');
   insert into t_school_member_types (sch_mt_id, sch_mt_name) values (s_t_school_member_types.nextval, 'Student');

   commit;
END;
/
