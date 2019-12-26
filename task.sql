create table task(
task_id number not null,
task_name varchar2(20) not null,
task_by varchar2(15) not null,
task_deadline_date date,
task_completed_date date,
constraint task_id_pk primary key(task_id),
constraint task_name_uq unique(task_name),
constraint task_status_ck check (task_status in('completed','Notcompleted')
);
insert into task(
task_id,
task_name,
task_by,
task_deadline_date,
task_completed_date,
task_status) 
values(1,'Install Oracle','Bharathi',to_date('28-12-2019','dd-mm-yyyy'),to_date('26-12-2019','dd-mm-yyyy'),'completed');
insert into task(
task_id,
task_name,
task_by,
task_deadline_date,
task_completed_date,
task_status) 
values(1,'Install IDE','Sundar',to_date('24-12-2019','dd-mm-yyyy'),to_date('25-12-2019','dd-mm-yyyy'),'Notcompleted');
select * from task where task_status='completed';
