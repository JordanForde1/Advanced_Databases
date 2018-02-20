-- Create an SQL script to create the following dimensional model
DROP TABLE results1 CASCADE CONSTRAINTS PURGE;
DROP TABLE results2 CASCADE CONSTRAINTS PURGE;
DROP TABLE players1 CASCADE CONSTRAINTS PURGE;
DROP TABLE players2 CASCADE CONSTRAINTS PURGE;
DROP TABLE team1 CASCADE CONSTRAINTS PURGE;
DROP TABLE team2 CASCADE CONSTRAINTS PURGE;
DROP TABLE tournament1 CASCADE CONSTRAINTS PURGE;
DROP TABLE tournament2 CASCADE CONSTRAINTS PURGE;


DROP TABLE Player_Dimensional CASCADE CONSTRAINTS PURGE;
DROP TABLE Tournament_Dimensional CASCADE CONSTRAINTS PURGE;
DROP TABLE Team_Dimensional CASCADE CONSTRAINTS PURGE;
DROP TABLE Date_Dimensional CASCADE CONSTRAINTS PURGE;
DROP TABLE fact_results CASCADE CONSTRAINTS PURGE;

DROP TABLE teams_stage CASCADE CONSTRAINTS PURGE;
DROP TABLE players_stage CASCADE CONSTRAINTS PURGE;
DROP TABLE tournaments_stage CASCADE CONSTRAINTS PURGE;
DROP TABLE date_stage CASCADE CONSTRAINTS PURGE;
DROP TABLE facts_stage CASCADE CONSTRAINTS PURGE;

Create Table Team1(
Team_id integer primary key,
Team_name varchar(100)
);

Create Table Team2(
Team_id integer primary key,
Team_name varchar(100)
);

Create Table Players1(
p_id integer primary key,
p_name varchar(50),
p_sname varchar(50),
team_id integer,
constraint fk_team_1 foreign key (team_id) references team1
);

Create Table Players2(
p_id integer primary key,
p_name varchar(50),
p_sname varchar(50),
team_id integer,
constraint fk_team_2 foreign key (team_id) references team2
);

Create Table Tournament1(
T_id integer primary key,
t_descriprion varchar(100),
t_date date,
Total_price float
);

Create Table Tournament2(
T_id integer primary key,
t_descriprion varchar(100),
t_date date,
Total_price float
);

Create Table Results1(
t_id integer,
p_id integer,
rank integer,
price float,
CONSTRAINT  FK_player1 FOREIGN KEY (p_id) REFERENCES players1,
CONSTRAINT  FK_tournament1 FOREIGN KEY (t_id) REFERENCES tournament1,
CONSTRAINT PK_Results1 PRIMARY KEY (t_id,p_id)
);

Create Table Results2(
t_id integer,
p_id integer,
rank integer,
price float,
CONSTRAINT  FK_player2 FOREIGN KEY (p_id) REFERENCES players2,
CONSTRAINT  FK_tournament2 FOREIGN KEY (t_id) REFERENCES tournament2,
CONSTRAINT PK_Results2 PRIMARY KEY (t_id,p_id)
);

--data 
INSERT INTO TEAM1 (TEAM_ID, TEAM_NAME) VALUES (1, 'USA');
INSERT INTO TEAM1 (TEAM_ID, TEAM_NAME) VALUES (2, 'AUSTRALIA');
INSERT INTO TEAM1 (TEAM_ID, TEAM_NAME) VALUES (3, 'UK');
INSERT INTO TEAM1 (TEAM_ID, TEAM_NAME) VALUES (4, 'IRELAND');

INSERT INTO TEAM2 (TEAM_ID, TEAM_NAME) VALUES (1, 'UK');
INSERT INTO TEAM2 (TEAM_ID, TEAM_NAME) VALUES (2, 'IRELAND');
INSERT INTO TEAM2 (TEAM_ID, TEAM_NAME) VALUES (3, 'USA');
INSERT INTO TEAM2 (TEAM_ID, TEAM_NAME) VALUES (4, 'ITALY');



INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (1, 'Tiger', 'Woods', 1);
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (2, 'Mary', 'Smith', 2);
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (3, 'Mark', 'Deegan', 2);
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (4, 'James', 'Bryan', 3);
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (5, 'John', 'McDonald', 1);
INSERT INTO PLAYERS1 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (6, 'Mario', 'Baggio', 1);

INSERT INTO PLAYERS2 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (2, 'Tiger', 'Woods', 3);
INSERT INTO PLAYERS2 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (1, 'John', 'McDonald', 3);
INSERT INTO PLAYERS2 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (3, 'Jim', 'Burke', 3);
INSERT INTO PLAYERS2 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (4, 'Paul', 'Bin', 3);
INSERT INTO PLAYERS2 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (5, 'Peter', 'Flynn', 3);
INSERT INTO PLAYERS2 (P_ID, P_NAME, P_SNAME, TEAM_ID) VALUES (6, 'Martha', 'Ross', 4);


INSERT INTO TOURNAMENT1 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (1, 'US open', 1700000,'01-jan-2014');
INSERT INTO TOURNAMENT1 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (2, 'British Open', 7000000,'01-apr-2014');
INSERT INTO TOURNAMENT1 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (3, 'Italian Open', 2000000,'11-mar-2014');
INSERT INTO TOURNAMENT1 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (4, 'Irish Open', 300000,'21-jul-2014');

INSERT INTO TOURNAMENT2 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (1, 'Dutch open', 1700000,'22-nov-2014');
INSERT INTO TOURNAMENT2 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (2, 'French Open', 7000000,'17-dec-2014');
INSERT INTO TOURNAMENT2 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (3, 'panish Open', 2000000,'03-mar-2014');
INSERT INTO TOURNAMENT2 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (4, 'Chiinese Open', 300000,'15-jul-2014');
INSERT INTO TOURNAMENT2 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (5, 'Dubai Open', 600000,'10-aug-2014');
INSERT INTO TOURNAMENT2 (T_ID, T_DESCRIPRION, TOTAL_PRICE,t_date) VALUES (6, 'US Master', 1000000,'10-jul-2014');


INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (1, 1, 1, 10000);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (1, 2, 2, 20000);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (2, 2, 4, 1000);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (3, 2, 3, 10000);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (3, 1, 2, 1100);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (4, 6, 3, 6000);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (4, 2, 2, 9000);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (4, 1, 1, 10000);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (3, 5, 2, 9500);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (4, 5, 4, 10000);
INSERT INTO RESULTS1 (T_ID, P_ID, RANK, PRICE) VALUES (2, 5, 7, 100);

INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (1, 1, 1, 1000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (1, 2, 3, 2000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (2, 2, 1, 6000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (3, 2, 3, 17000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (3, 1, 12, 1100);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (4, 6, 10, 8000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (4, 2, 2, 12000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (4, 1, 3, 10000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (3, 5, 1, 9000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (4, 5, 5, 1000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (2, 5, 3, 1000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (5, 5, 3, 8000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (5, 2, 2, 16000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (5, 1, 1, 20000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (6, 1, 3, 2000);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (6, 5, 2, 9400);
INSERT INTO RESULTS2 (T_ID, P_ID, RANK, PRICE) VALUES (6, 4, 1, 12000);

--Create an SQL script to create the following dimensional mode
create table Player_Dimensional (
  player_sk integer primary key,
  player_name varchar(50)
);

create table Tournament_Dimensional (
  tournament_sk integer primary key,
  tournament_desc varchar(100),
  total_price float
);

create table Team_Dimensional (
  team_sk integer primary key,
  team_name varchar (100)
);

create table Date_Dimensional (
  date_sk integer primary key,
  day integer,
  month integer,
  year integer,
  week integer,
  quarter integer,
  dayofweek integer
);

create table fact_results (
  player_sk integer,
  tournament_sk integer,
  team_sk integer,
  date_sk integer,
  rank integer,
  price float,

  constraint player_fk foreign key (player_sk) references Player_Dimensional(player_sk),
  constraint tournament_fk foreign key (tournament_sk) references Tournament_Dimensional(tournament_sk),
  constraint team_fk foreign key (team_sk) references Team_Dimensional(team_sk),
  constraint date_sk foreign key (date_sk) references Date_Dimensional(date_sk),
  constraint fact_pk primary key (player_sk, tournament_sk, team_sk, date_sk)
);

-- INITIAL ETL
-- Load Dimension Customers
-- Staging Area

-- teams stage
create table teams_stage (
  team_sk integer,
  sourceDB integer,
  team_id integer,
  team_name varchar(100)
);

drop sequence team_stage_sequence;

create sequence team_stage_sequence
start with 1
increment by 1
nomaxvalue;

drop trigger team_stage_trigger;

create or replace trigger team_stage_trigger 
before insert on teams_stage
for each row
begin
select team_stage_sequence.nextval into :new.team_sk from dual;
end;

-- players stage
create table players_stage (
  player_sk integer,
  sourceDB integer,
  player_id integer,
  player_first_name varchar(100),
  player_sname varchar(100),
  team_id integer
);

drop sequence player_stage_sequence;

create sequence player_stage_sequence
start with 1
increment by 1
nomaxvalue;

drop trigger player_stage_trigger;

create or replace trigger player_stage_trigger 
before insert on players_stage
for each row
begin
select player_stage_sequence.nextval into :new.player_sk from dual;
end;

-- tournament stage
create table tournaments_stage (
  tournament_sk integer,
  sourceDB integer,
  tournament_id integer,
  tournament_desc varchar(100),
  tournament_date date,
  total_price float
);

drop sequence tournament_stage_sequence;

create sequence tournament_stage_sequence
start with 1
increment by 1
nomaxvalue;

drop trigger tournament_stage_trigger;

create or replace trigger tournament_stage_trigger 
before insert on tournaments_stage
for each row
begin
select tournament_stage_sequence.nextval into :new.tournament_sk from dual;
end;

-- date stage
create table date_stage (
  date_sk integer primary key,
  sourceDB integer,
  day integer,
  month integer,
  year integer,
  week integer,
  quarter integer,
  dayofweek integer,
  tournament_date date
);

drop sequence date_stage_sequence;

create sequence date_stage_sequence 
start with 1 
increment by 1 
nomaxvalue; 

drop trigger date_stage_trigger;

create or replace trigger date_stage_trigger
before insert on date_stage
for each row
begin
select date_stage_sequence.nextval into :new.date_sk from dual;
end;

-- facts stage
create table facts_stage (
  player_sk integer,
  tournament_sk integer,
  team_sk integer,
  date_sk integer,
  rank integer,
  price float,
  player_id integer,
  tournament_id integer,
  team_id integer,
  tournament_date date,
  sourceDB integer
);

--team stage inserts 
insert into teams_stage (sourceDB, team_name, team_id) select 1, team_name, team_id from team1;
insert into teams_stage (sourceDB, team_name, team_id) select 2, team_name, team_id from team2;

-- insert from DB 1
insert into Team_Dimensional (team_sk, team_name) 
select t.team_sk, t.team_name from teams_stage t
where not exists (select team_name from Team_Dimensional td where td.team_name = t.team_name) and sourceDB = 1; 

-- insert from DB 2
insert into Team_Dimensional (team_sk, team_name)
select t.team_sk, t.team_name from teams_stage t
where not exists (select team_name from Team_Dimensional td where td.team_name = t.team_name) and sourceDB = 2; 

-- player insterts
insert into players_stage (sourceDB, player_id, player_first_name, player_sname, team_id)
select 1, p_id, p_name, p_sname, team_id from players1;

insert into players_stage (sourceDB, player_id, player_first_name, player_sname, team_id)
select 2, p_id, p_name, p_sname, team_id from players2;

-- insert from DB 1
insert into Player_Dimensional (player_sk, player_name)
select p.player_sk, p.player_first_name || ' ' || p.player_sname  from players_stage p
where not exists (select player_name from Player_Dimensional pd where pd.player_name = p.player_first_name || ' ' || p.player_sname ) and sourceDB = 1; 

-- insert from DB 2
insert into Player_Dimensional (player_sk, player_name)
select p.player_sk, p.player_first_name || ' ' || p.player_sname from players_stage p
where not exists (select player_name from Player_Dimensional pd where pd.player_name = p.player_first_name || ' ' || p.player_sname ) and sourceDB = 2; 

-- tournament inserts
insert into tournaments_stage (sourceDB, tournament_id, tournament_desc, tournament_date, total_price)
select 1, t_id, t_descriprion, t_date, total_price from tournament1;

insert into tournaments_stage (sourceDB, tournament_id, tournament_desc, tournament_date, total_price)
select 2, t_id, t_descriprion, t_date, total_price from tournament2;

update tournaments_stage
set total_price = (total_price * 0.7)
where sourceDB = 2;

insert into Tournament_Dimensional (tournament_sk, tournament_desc, total_price)
select tournament_sk, tournament_desc, total_price from tournaments_stage;

-- date inserts
insert into date_stage (sourceDB, day, month, year, week, quarter, dayofweek, tournament_date)
select  1,
        cast(to_char(t_date,'DD') as integer),cast(to_char(t_date,'MM') as integer),
        cast(to_char(t_date,'YYYY') as integer),cast(to_char(t_date,'WW') as integer),
        cast(to_char(t_date,'Q') as integer),cast(to_char(t_date,'D') as integer),
        t_date
from tournament1;

insert into date_stage (sourceDB, day, month, year, week, quarter, dayofweek, tournament_date)
select  2, cast(to_char(t_date,'DD') as integer),cast(to_char(t_date,'MM') as integer),
           cast(to_char(t_date,'YYYY') as integer),cast(to_char(t_date,'WW') as integer),
           cast(to_char(t_date,'Q') as integer),cast(to_char(t_date,'D') as integer),
           t_date
from tournament2;

insert into Date_Dimensional(date_sk, day, month, year, week, quarter, dayofweek)
select date_sk, day, month, year, week, quarter, dayofweek from date_stage;

-- fact insters
insert into facts_stage (rank, price, player_id, tournament_id, team_id, tournament_date, sourceDB)
select r1.rank, r1.price, r1.p_id, r1.t_id, t1.team_id, tn1.t_date, 1
from results1 r1
join players1 p1 on p1.p_id = r1.p_id
join team1 t1 on t1.team_id = p1.team_id
join tournament1 tn1 on tn1.t_id = r1.t_id;

insert into facts_stage (rank, price, player_id, tournament_id, team_id, tournament_date, sourceDB)
select r2.rank, r2.price, r2.p_id, r2.t_id, t2.team_id, tn2.t_date, 2
from results2 r2
join players2 p2 on p2.p_id = r2.p_id
join team2 t2 on t2.team_id = p2.team_id
join tournament2 tn2 on tn2.t_id = r2.t_id;

update facts_stage
set price = (price * 0.7)
where sourceDB = 2;
  
-- Surrogate Keys

-- Player SK
update facts_stage sf
set player_sk = (select player_sk from players_stage p where p.sourceDB = sf.sourceDB and p.player_id = sf.player_id);

-- Normalize data
update facts_stage sf
set player_sk = 1 
where player_id = 2
and sourceDB = 2;

update facts_stage sf
set player_sk = 5 
where player_id = 1
and sourceDB = 2;

-- Tournament SK
update facts_stage sf
set tournament_sk = (select tournament_sk from tournaments_stage t where t.sourceDB = sf.sourceDB and t.tournament_id = sf.tournament_id);
  
-- Team SK
update facts_stage sf
set team_sk = (select team_sk from teams_stage t where t.sourceDB = sf.sourceDB and t.team_id = sf.team_id);

-- Normalize data
update facts_stage sf
set team_sk = 1 
where team_id = 3
and sourceDB = 2;

-- Date SK
update facts_stage sf
set date_sk = (select date_sk from date_stage ds where ds.sourceDB = sf.sourceDB  and ds.tournament_date = sf.tournament_date);

insert into fact_results(player_sk, tournament_sk, team_sk, date_sk, rank, price)
select player_sk, tournament_sk, team_sk, date_sk, rank, price from facts_stage;

-- Lab inserts
INSERT INTO PLAYERS1 (p_id, p_name, p_sname, team_id) VALUES (7, 'Alan', 'Parker', 1);
INSERT INTO PLAYERS1  (p_id, p_name, p_sname, team_id) VALUES (8, 'Martha', 'Bag', 2);
INSERT INTO TOURNAMENT1  (t_id, t_descriprion, t_date, total_price) VALUES (5, 'Saudi Open', '01-sep-2014', 500000);

INSERT INTO RESULTS1 (t_id, p_id, rank, price) VALUES (5, 1, 1, 60000);
INSERT INTO RESULTS1 (t_id, p_id, rank, price) VALUES (5, 7, 5, 20000);
INSERT INTO RESULTS1 (t_id, p_id, rank, price) VALUES (2, 8, 3, 1000);

-- Insert player data 
insert into players_stage (sourceDB, player_id, player_first_name, player_sname, team_id)
select 1, p_id, p_name, p_sname, team_id from players1
where not exists (select * from players_stage p where p.player_id = players1.p_id and p.sourceDB = 1);

insert into Player_Dimensional (player_sk, player_name)
select p.player_sk, p.player_first_name || ' ' || p.player_sname from players_stage p
where not exists (select * from Player_Dimensional pd where p.player_sk = pd.player_sk or pd.player_name = p.player_first_name || ' ' || p.player_sname);

-- Insert tournament data
insert into tournaments_stage (sourceDB, tournament_id, tournament_desc, tournament_date, total_price)
select 1, t_id, t_descriprion, t_date, total_price from tournament1
where not exists (select * from tournaments_stage t where t.tournament_id = tournament1.t_id and t.sourceDB = 1);

insert into Tournament_Dimensional (tournament_sk, tournament_desc, total_price)
select tournament_sk, tournament_desc, total_price from tournaments_stage t
where not exists (select * from Tournament_Dimensional td where t.tournament_sk = td.tournament_sk);

-- Insert date data
insert into date_stage (sourceDB, day, month, year, week, quarter, dayofweek, tournament_date)
select  1,
        cast(to_char(t_date,'DD') as integer),cast(to_char(t_date,'MM') as integer),
        cast(to_char(t_date,'YYYY') as integer),cast(to_char(t_date,'WW') as integer),
        cast(to_char(t_date,'Q') as integer), cast(to_char(t_date,'D') as integer),
        t_date
from tournament1
where not exists (select * from date_stage ds where ds.tournament_date = tournament1.t_date and ds.sourceDB = 1);

insert into Date_Dimensional(date_sk, day, month, year, week, quarter, dayofweek)
select date_sk, day, month, year, week, quarter, dayofweek from date_stage ds
where not exists (select * from Date_Dimensional dd where dd.date_sk = ds.date_sk);

-- Insert result data
insert into facts_stage (rank, price, player_id, tournament_id, team_id, tournament_date, sourceDB)
select r1.rank, r1.price, r1.p_id, r1.t_id, t1.team_id, tn1.t_date, 1 from results1 r1
join players1 p1 on p1.p_id = r1.p_id
join team1 t1 on t1.team_id = p1.team_id
join tournament1 tn1 on tn1.t_id = r1.t_id
where not exists (select * from facts_stage sf where sf.player_id = r1.p_id and sf.tournament_id = r1.t_id and sf.team_id = t1.team_id);

-- Set surrogate keys
update facts_stage sf
set player_sk = (select player_sk from players_stage p where p.sourceDB = sf.sourceDB and p.player_id = sf.player_id);

-- Normalize data
update facts_stage sf set player_sk = 1 
where player_id = 2 and sourceDB = 2;

update facts_stage sf set player_sk = 5 
where player_id = 1 and sourceDB = 2;

update facts_stage sf
set tournament_sk = (select tournament_sk from tournaments_stage t where t.sourceDB = sf.sourceDB and t.tournament_id = sf.tournament_id);

update facts_stage sf
set team_sk = ( select team_sk from teams_stage t where t.sourceDB = sf.sourceDB and t.team_id = sf.team_id);

-- Normalize data
update facts_stage sf set team_sk = 1 
where team_id = 3 and sourceDB = 2;

update facts_stage sf
set date_sk = ( select date_sk from date_stage ds where ds.sourceDB = sf.sourceDB  and ds.tournament_date = sf.tournament_date);

-- Update facts table
insert into fact_results(player_sk, tournament_sk, team_sk, date_sk, rank, price)
select player_sk, tournament_sk, team_sk, date_sk, rank, price from facts_stage sf
where not exists (select * from fact_results where fact_results.player_sk = sf.player_sk
and fact_results.tournament_sk = sf.tournament_sk and fact_results.team_sk = sf.team_sk and fact_results.date_sk = sf.date_sk);