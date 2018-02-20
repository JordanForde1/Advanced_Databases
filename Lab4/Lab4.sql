DROP TABLE LOGTEAM;
DROP TABLE EUROLEAGUE;
DROP TABLE MATCHES;
DROP TABLE TEAMS;
DROP SEQUENCE MATCH_ID_SEQUENCE; 

CREATE TABLE TEAMS(
  team_name VARCHAR2(50) PRIMARY KEY,
  team_country VARCHAR2(50),
  
  CONSTRAINT check_country CHECK (team_country='Spain' OR team_country='England')
);

CREATE TABLE MATCHES(
  matchid NUMBER(6) PRIMARY KEY,
  teamA_name VARCHAR2(50),
  teamB_name VARCHAR2(50),
  goalA NUMBER(3),
  goalB NUMBER(3),
  competition VARCHAR2(50),

  CONSTRAINT check_goalA CHECK (goalA >= 0),
  CONSTRAINT check_goalB CHECK (goalB >= 0),
  CONSTRAINT check_competition CHECK (Competition='Champions League' OR  Competition='Europa League' OR Competition='Premier League' OR Competition='La Liga'),

  FOREIGN KEY (teamA_name) REFERENCES TEAMS(team_name),
  FOREIGN KEY (teamB_name) REFERENCES TEAMS(team_name)
);

CREATE TABLE EUROLEAGUE(
  team_name VARCHAR2(50),
  points NUMBER(6),
  goals_scored NUMBER(6),
  goals_conceded NUMBER(6),
  difference NUMBER(6)
);

CREATE TABLE LOGTEAM(
  team_name VARCHAR2(50),
  log_date DATE
);

CREATE SEQUENCE MATCH_ID_SEQUENCE
      START WITH 1
      INCREMENT BY 1;
    
CREATE OR REPLACE TRIGGER MATCH_ID_TRIGGER
  BEFORE INSERT ON MATCHES 
  FOR EACH ROW
  Begin
  SELECT MATCH_ID_SEQUENCE.nextval into :new.MatchID from dual;
  END;
  /

CREATE OR REPLACE TRIGGER LOGTEAM_TRIGGER
  AFTER INSERT ON TEAMS
  FOR EACH ROW
  BEGIN
  INSERT INTO LOGTEAM (team_name, log_date) VALUES (:new.team_name, sysdate);
  END;
  /

CREATE OR REPLACE TRIGGER EUROLEAGUE_INSERT
  AFTER INSERT ON TEAMS
  FOR EACH ROW
  DECLARE
  team_count NUMBER(6);
  BEGIN 
  SELECT COUNT(*) INTO team_count FROM EUROLEAGUE WHERE team_name = :new.team_name;
  IF team_count > 0 THEN Raise_application_error(-20000,'Team is already in the table');
  ELSE
  INSERT INTO EUROLEAGUE (team_name, points, goals_scored, goals_conceded, difference) VALUES (:new.team_name, 0, 0, 0, 0);
  END IF;
  END;
  /

INSERT INTO TEAMS (team_name, team_country) VALUES ('Arsenal', 'England');
INSERT INTO TEAMS (team_name, team_country) VALUES ('Manchester United', 'England');
INSERT INTO TEAMS (team_name, team_country) VALUES ('Chelsea', 'England');
INSERT INTO TEAMS (team_name, team_country) VALUES ('Everton', 'England');
INSERT INTO TEAMS (team_name, team_country) VALUES ('Barcelona', 'Spain');
INSERT INTO TEAMS (team_name, team_country) VALUES ('Real Madrid', 'Spain');
INSERT INTO TEAMS (team_name, team_country) VALUES ('Atletico Madrid', 'Spain');
INSERT INTO TEAMS (team_name, team_country) VALUES ('Sevilla', 'Spain');
--To fail EUROLEAGUE_INSERT
INSERT INTO EUROLEAGUE (team_name,points,goals_scored,goals_conceded,difference) VALUES ('Manchester City',0 ,0 ,0 ,0);

CREATE OR REPLACE TRIGGER MATCH_INSERT_TRIGGER
  BEFORE INSERT ON MATCHES
  FOR EACH ROW
  DECLARE
  teamA_country VARCHAR2(50);
  teamB_country VARCHAR2(50);
  match_id_gen NUMBER(6);
  BEGIN
  SELECT team_country INTO teamA_country FROM TEAMS WHERE team_name = :new.teamA_name;
  SELECT team_country INTO teamB_country FROM TEAMS WHERE team_name = :new.teamB_name;
  IF :new.competition = 'Premier League' AND teamA_country = 'England' AND teamB_country = 'England' THEN dbms_output.put_line('Inserted into England');
  ELSE IF :new.competition = 'La Liga' AND teamA_country = 'Spain' AND teamB_country = 'Spain' THEN dbms_output.put_line('Inserted into Spain');
  ELSE
  Raise_application_error(-20002,'Invalid match entry');
  END IF;
  END IF;
  END;
  /

CREATE OR REPLACE TRIGGER NUMBER_MATCHES_PER_TEAM
  BEFORE INSERT ON MATCHES
  FOR EACH ROW
  DECLARE
  teamA_count NUMBER(6);
  teamB_count NUMBER(6);
  BEGIN
  BEGIN
  SELECT COUNT(*) INTO teamA_count FROM MATCHES WHERE teamA_name = :new.teamA_name OR teamB_name = :new.teamA_name;
  EXCEPTION WHEN NO_DATA_FOUND THEN teamA_count := 0;
  END;
  BEGIN
  SELECT COUNT(*) INTO teamB_count FROM MATCHES WHERE teamA_name = :new.teamB_name OR teamB_name = :new.teamB_name;
  EXCEPTION WHEN NO_DATA_FOUND THEN teamB_count := 0;
  END;
  IF teamA_count = 4 OR teamB_count = 4 THEN Raise_application_error(-20003,'Too many entries for one team');
  ELSE
    -- If the teams draw    
    IF :new.goalA = :new.goalB THEN
      UPDATE EUROLEAGUE 
      SET 
        points = points + 1,
        goals_scored = goals_scored + :new.goalA,
        goals_conceded = goals_conceded + :new.goalB
      WHERE team_name = :new.teamA_name;
      
      UPDATE EUROLEAGUE 
      SET 
        points = points + 1,
        goals_scored = goals_scored + :new.goalB,
        goals_conceded = goals_conceded + :new.goalA
      WHERE team_name = :new.teamB_name;
    -- If team A wins
      ELSE IF :new.goalA > :new.goalB THEN
      UPDATE EUROLEAGUE 
      SET 
        points = points + 3,
        goals_scored = goals_scored + :new.goalA,
        goals_conceded = goals_conceded + :new.goalB
      WHERE team_name = :new.teamA_name;
      
      UPDATE EUROLEAGUE 
      SET 
        goals_scored = goals_scored + :new.goalB,
        goals_conceded = goals_conceded + :new.goalA
      WHERE team_name = :new.teamB_name;
    -- If team B wins
      ELSE
      UPDATE EUROLEAGUE 
      SET 
        goals_scored = goals_scored + :new.goalA,
        goals_conceded = goals_conceded + :new.goalB
      WHERE team_name = :new.teamA_name;
      
      UPDATE EUROLEAGUE 
      SET 
        points = points + 3,
        goals_scored = goals_scored + :new.goalB,
        goals_conceded = goals_conceded + :new.goalA
      WHERE team_name = :new.teamB_name;
      END IF;
    -- Update the difference for all rows   
      UPDATE EUROLEAGUE SET difference = goals_scored - goals_conceded; 
  END IF;
  END IF;
END;
/

--Insert teams into both country must run to run other insterts below as they are used in the insterts
INSERT INTO TEAMS (team_name, team_country) VALUES ('Liverpool', 'England');
INSERT INTO TEAMS (team_name, team_country) VALUES ('Alavés', 'Spain');

--Insert data into Premier League Matches
INSERT INTO MATCHES (teamA_name, teamB_name, goalA, goalB, competition) VALUES ('Liverpool', 'Manchester United', 5, 2, 'Premier League');
INSERT INTO MATCHES (teamA_name, teamB_name, goalA, goalB, competition) VALUES ('Liverpool', 'Chelsea', 3, 1, 'Premier League');
INSERT INTO MATCHES (teamA_name, teamB_name, goalA, goalB, competition) VALUES ('Manchester United', 'Liverpool', 1, 1, 'Premier League');
INSERT INTO MATCHES (teamA_name, teamB_name, goalA, goalB, competition) VALUES ('Chelsea', 'Liverpool', 2, 1, 'Premier League');

--Insert data into La Liga Matches
INSERT INTO MATCHES (teamA_name, teamB_name, goalA, goalB, competition) VALUES ('Barcelona', 'Real Madrid', 2, 4, 'La Liga');
INSERT INTO MATCHES (teamA_name, teamB_name, goalA, goalB, competition) VALUES ('Atletico Madrid', 'Barcelona', 4, 1, 'La Liga');
INSERT INTO MATCHES (teamA_name, teamB_name, goalA, goalB, competition) VALUES ('Sevilla', 'Barcelona', 1, 5, 'La Liga');
INSERT INTO MATCHES (teamA_name, teamB_name, goalA, goalB, competition) VALUES ('Barcelona', 'Real Madrid', 3, 1, 'La Liga');

--Show Amount of matches played in Premier League
SELECT COUNT(*) FROM MATCHES WHERE teamA_name = 'Liverpool' OR teamB_name = 'Liverpool' GROUP BY competition;
SELECT COUNT(*) FROM MATCHES WHERE teamA_name = 'Manchester United' OR teamB_name = 'Manchester United' GROUP BY competition;
SELECT COUNT(*) FROM MATCHES WHERE teamA_name = 'Chelsea';
SELECT COUNT(*) FROM MATCHES WHERE teamB_name = 'Chelsea';

--Show Amount of matches played in La Liga
SELECT COUNT(*) FROM MATCHES WHERE teamA_name = 'Barcelona' OR teamB_name = 'Barcelona' GROUP BY competition;
SELECT COUNT(*) FROM MATCHES WHERE teamA_name = 'Atletico Madrid' OR teamB_name = 'Atletico Madrid' GROUP BY competition;
SELECT COUNT(*) FROM MATCHES WHERE teamA_name = 'Real Madrid';
SELECT COUNT(*) FROM MATCHES WHERE teamB_name = 'Real Madrid';

--Added inserts to fail after above insterts have ran
-- This will fail the MATCH_INSERT_TRIGGER
INSERT INTO MATCHES (teamA_name, teamB_name, goalA, goalB, competition) VALUES ('Sevilla', 'Atletico Madrid', 3, 2, 'Scotish league');

-- This will fail NUMBER_MATCHES_PER_TEAM
INSERT INTO MATCHES (teamA_name, teamB_name, goalA, goalB, competition) VALUES ('Chelsea', 'Liverpool', 2, 1, 'Premier League');
INSERT INTO MATCHES (teamA_name, teamB_name, goalA, goalB, competition) VALUES ('Sevilla', 'Barcelona', 2, 4, 'La Liga');

-- This will fail EUROLEAGUE_INSERT
INSERT INTO TEAMS (team_name,team_country) VALUES ('Manchester City', 'England');

-- This will fail CHECK_COUNTRY constraint
INSERT INTO TEAMS (team_name, team_country) VALUES ('Bowes', 'Ireland');

SELECT * FROM EUROLEAGUE;
SELECT * FROM LOGTEAM;
SELECT * FROM MATCHES;
SELECT * FROM TEAMS;


