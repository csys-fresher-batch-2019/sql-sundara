create table task
(
task_id number,
task_name varchar2(50) not null,
task_priority varchar(20) not null,
task_created date not null,
task_modified date not null,
task_by varchar2(30) not null,
task_dd date not null,
task_cd date,
task_status varchar(30),
constraint task_id_pk primary key(task_id),
constraint task_name_uq unique(task_name),
constraint task_status_ck check(task_status in('completed','notcompleted'),
constraint task_priority_ck check(task_priority in('High','Medium','Low'),
constraint task_created_ck check(task_created<SYSDATE),
constraint task_modified_ck check(task_created<task_modified)
);
insert into task
(
task_id, task_name, task_priority,task_created,task_modified, task_by, task_dd, task_cd, task_status) values
(1,'Install Oracle','High',
to_date('20-12-2019','dd-mm-yyyy'),to_date('27-12-2019','dd-mm-yyyy'),
'Bharathi',
to_date('27-12-2019','dd-mm-yyyy'),to_date('26-12-2019','dd-mm-yyyy','completed')
);

insert into task
(
task_id, task_name, task_priority,task_created,task_modified, task_by, task_dd, task_cd, task_status) values
(2,'Install IDE','Low',
to_date('10-12-2019','dd-mm-yyyy'),to_date('20-12-2019','dd-mm-yyyy'),
'Sundar',
to_date('28-12-2019','dd-mm-yyyy'),to_date('29-12-2019','dd-mm-yyyy','notcompleted')
);
select * from task where task_status='completed';
