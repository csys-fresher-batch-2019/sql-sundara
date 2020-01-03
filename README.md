# ICC Player Ranking

* http://iccranking.in



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
create sequence player_id_sq start with 1;
drop sequence player_id_sq;
```
```sql
INSERT INTO players
(player_id,player_fullname,date_of_birth,nick_name,role_name) 
VALUES (player_id_sq.nextval,'Mahendra singh dhoni',to_date('07-07-1981','dd-mm-yyyy'),'Mr.cool','batsman');
INSERT INTO players
(player_id,player_fullname,date_of_birth,nick_name,role_name) 
VALUES (player_id_sq.nextval,'Ravindrasinh Anirudhsinh Jadeja',to_date('06-12-1988','dd-mm-yyyy'),'jaddu','all-rounder');
INSERT INTO players
(player_id,player_fullname,date_of_birth,nick_name,role_name) 
VALUES (player_id_sq.nextval,'	Deepak Lokendrasingh Chahar',to_date('07-08-1992','dd-mm-yyyy'),'DL ','bowler');
```
```sql
create table career(
career_no number,
matches number not null,
innings number,
not_outs number,
runs_scored	number,
balls_bowled number,
runs_conceded number,
wickets number,
catches number,
stumpings number,
constraint career_no_pkk primary key(career_no),
constraint matches_ck check(matches>0),
constraint runs_scored_ck check(runs_scored>=0),
constraint innings_ck check(innings>=0),
constraint not_outs_ck check(not_outs>=0),
constraint  catches_ck check(catches>=0),
constraint runs_conceded_ck check(runs_conceded>=0),
constraint balls_bowled_ck check(balls_bowled>=0),
constraint wickets_ck check(wickets>=0),
constraint career_fk foreign key(career_no)references players(player_id)
);
create sequence career_no_sq start with 1;
```
```sql
insert into career
(career_no,matches,innings,not_outs,runs_scored,balls_bowled,runs_conceded,wickets,catches,stumpings) 
values(career_no_sq.nextval,350,297,84,10773,36,31,1,321,123);
insert into career
(career_no,matches,innings,not_outs,runs_scored,balls_bowled,runs_conceded,wickets,catches,stumpings) 
values(career_no_sq.nextval,159,106,36,2188, 8029,6552,181,58,0);
insert into career
(career_no,matches,innings,not_outs,runs_scored,balls_bowled,runs_conceded,wickets,catches,stumpings) 
values(career_no_sq.nextval,3,2,1,18,126,129,2,0,0);
```
```sql
create table cricketing(
cric_no number,
full_name varchar2(50) not null,
jersey_no number not null,
height number not null,
batting varchar2(10) not null,
bowling varchar2(10),
bowling_speed varchar2(10),
constraint cric_no_pk primary key(cric_no),
constraint batting_ck check (batting in ('left-hand','right-hand')),
constraint bowling_ck check (bowling in ('left-hand','right-hand')),
constraint bowling_speed_ck check (bowling_speed in ('slow','medium','fast'))
);
create sequence cric_no_sq start with 1;
```
```sql
insert into cricketing
(cric_no,full_name,jersey_no,height,batting,bowling,bowling_speed)
values(cric_no_sq.nextval,'Mahendra singh dhoni',7,178,'right-hand','right-hand','medium');
insert into cricketing
(cric_no,full_name,jersey_no,height,batting,bowling,bowling_speed)
values(cric_no_sq.nextval,'Ravindrasinh Anirudhsinh Jadeja',8,170,'left-hand','left-hand','slow');
insert into cricketing
(cric_no,full_name,jersey_no,height,batting,bowling,bowling_speed)
values(cric_no_sq.nextval,'Deepak Lokendrasingh Chahar',223,175,'right-hand','right-hand','medium');
```

Query:

## Features

* list all players under ICC
```sql
select * from players;
```
| player_id | player_fullname                 | date_of_birth | nick_name | role_name   |
|-----------|---------------------------------|---------------|-----------|-------------|
| 1         | Mahendra singh dhoni            | 07-07-81      | Mr.cool   | batsman     |
| 2         | Ravindrasinh Anirudhsinh Jadeja | 06-12-88      | jaddu     | all-rounder |
| 3         | Deepak Lokendrasingh Chahar"    | 07-08-92      | DL        | bowler      |

* for updating current match details of the players

```sql

update career set matches=matches + 0,innings=innings+0,not_outs=not_outs+0,runs_scored=runs_scored+ 0,
balls_bowled=balls_bowled+0,runs_conceded=runs_conceded+0,wickets=wickets+0,catches=catches+0,
stumpings=stumpings+0 where career_no=3;
```
* list career details of players
```sql

select * from career;
```
| career_no | matches | innings | not_outs | runs_scored | balls_bowled | runs_conceded | wickets | catches | stumpings |
|-----------|---------|---------|----------|-------------|--------------|---------------|---------|---------|-----------|
| 1         | 350     | 297     | 84       | 10773       | 36           | 31            | 1       | 321     | 123       |
| 2         | 159     | 106     | 36       | 2188        | 8029         | 6552          | 181     | 58      | 0         |
| 3         | 3       | 2       | 1        | 18          | 126          | 129           | 2       | 0       | 0         |

* function for calculating batting average
```sql

create or replace FUNCTION BATTING_AVERAGE_CALC(runs_scored number, not_outs number,innings number)
RETURN NUMBER AS
batting_average number;
times_out number;
BEGIN
times_out:=innings-not_outs;
batting_average := runs_scored / times_out;
  RETURN batting_average;
END BATTING_AVERAGE_CALC;
```
* function for calculating bowling average
```sql

create or replace FUNCTION BOWLING_AVERAGE_CALC (runs_conceded number,wickets number)
RETURN NUMBER AS 
bowling_average number;
BEGIN
bowling_average := runs_conceded/wickets;
  RETURN bowling_average;
END BOWLING_AVERAGE_CALC;
```
* for viewing best batting average of players
```sql

select p.player_fullname,p.role_name,r.batting,round(BATTING_AVERAGE_CALC(runs_scored, not_outs,innings),2)
as batting_average from career c,players p ,cricketing r 
where c.career_no = p. player_id and r.cric_no = p.player_id 
order by BATTING_AVERAGE_CALC (runs_scored, not_outs,innings) DESC;
```
| player_fullname                 | role_name   | batting    | batting_average |
|---------------------------------|-------------|------------|-----------------|
| Mahendra singh dhoni            | batsman     | right-hand | 50.58           |
| Ravindrasinh Anirudhsinh Jadeja | all-rounder | left-hand  | 31.26           |
| Deepak Lokendrasingh Chahar     | bowler      | right-hand | 18              |

* for viewing best bowling average of players
```sql

select p.player_fullname,p.role_name,r.bowling,r.bowling_speed,
round(BOWLING_AVERAGE_CALC (runs_conceded,wickets),2) as bowling_average
from career c,players p,cricketing r
where c.career_no = p.player_id and r.cric_no = p.player_id;
order by BOWLING_AVERAGE_CALC(runs_conceded,wickets) ASC;
```
| player_fullname                 | role_name   | bowling    | bowling_speed | bowling_average |
|---------------------------------|-------------|------------|---------------|-----------------|
| Mahendra singh dhoni            | batsman     | right-hand | medium        | 31              |
| Ravindrasinh Anirudhsinh Jadeja | all-rounder | left-hand  | slow          | 36.2            |
| Deepak Lokendrasingh Chahar     | bowler      | right-hand | medium        | 64              |

* for viewing best allrounders
```sql

select p.player_fullname,p.role_name,r.batting,
round(BATTING_AVERAGE_CALC(runs_scored, not_outs,innings),2)as batting_average,
r.bowling,r.bowling_speed,round(BOWLING_AVERAGE_CALC (runs_conceded,wickets),2)
as bowling_average from career c, players p,cricketing r 
where c.career_no = p.player_id and r.cric_no = p.player_id and p.role_name='all-rounder';
```
| player_fullname                 | role_name   | batting   | batting_average | bowling   | bowling_speed | bowling_average |
|---------------------------------|-------------|-----------|-----------------|-----------|---------------|-----------------|
| Ravindrasinh Anirudhsinh Jadeja | all-rounder | left-hand | 31.26           | left-hand | slow          | 36.2            |

* for viewing most experienced players
```sql

select players.player_fullname,career.matches from players inner join career on player_id=career_no; 
```
| player_fullname                 | matches |
|---------------------------------|---------|
| Mahendra singh dhoni            | 350     |
| Ravindrasinh Anirudhsinh Jadeja | 159     |
| Deepak Lokendrasingh Chahar     | 2       |

