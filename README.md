# ICC Player Ranking

* http://iccranking.in

## Features

* list all players under ICC

```sql
create table players(
player_id number,
Full_name varchar2(100) not null,
dob date not null,
Nick_name varchar2(50),
role_name varchar2(20) not null,
constraint playerid_id_pk primary key (player_id),
constraint role_name_ck check (role_name in ('batsman','bowler','all-rounder'))
);
```
```sql
Query:
select * from players;
```


