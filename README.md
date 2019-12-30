# ICC Player Ranking

* http://iccranking.in

## Features

* list all players under ICC

```sql
create table players(
player_id number,
full_name varchar2(50) not null,
date_of_birth date not null,
nick_name varchar2(20),
role_name varchar2(20) not null,
constraint player_id_pk primary key (player_id),
constraint role_name_ck check (role_name in ('batsman','bowler','all-rounder'))
);
```
```sql
Query:
select * from players;
```


