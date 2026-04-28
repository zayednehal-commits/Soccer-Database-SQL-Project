--CHECK THE CONTENTS OF THE TABLES
SELECT * FROM STADIUMS;
SELECT * FROM TEAMS;
SELECT * FROM PLAYERS;
SELECT * FROM MATCHES;
SELECT * FROM MATCH_STATS;
-- TABLE CREATION
--STADIUM
CREATE TABLE STADIUMS (
    STADIUM_ID    NUMBER(5)      NOT NULL,
    STADIUM_NAME  VARCHAR2(100)  NOT NULL,
    CITY          VARCHAR2(80)   NOT NULL,
    CAPACITY      NUMBER(7)      NULL,
    OPENED_YEAR   NUMBER(4)      NULL,
    CONSTRAINT PK_STADIUMS PRIMARY KEY (STADIUM_ID)
);
--TEAMS
CREATE TABLE TEAMS (
    TEAM_ID       NUMBER(5)      NOT NULL,
    TEAM_NAME     VARCHAR2(100)  NOT NULL,
    CITY          VARCHAR2(80)   NOT NULL,
    COACH_NAME    VARCHAR2(100)  NULL,
    FOUNDED_YEAR  NUMBER(4)      NULL,
    STADIUM_ID    NUMBER(5)      NULL,
    CONSTRAINT PK_TEAMS     PRIMARY KEY (TEAM_ID),
    CONSTRAINT FK_TEAMS_STD FOREIGN KEY (STADIUM_ID) REFERENCES STADIUMS(STADIUM_ID)
);
--PLAYERS
CREATE TABLE PLAYERS (
    PLAYER_ID     NUMBER(7)      NOT NULL,
    FIRST_NAME    VARCHAR2(60)   NOT NULL,
    LAST_NAME     VARCHAR2(60)   NOT NULL,
    POSITION      VARCHAR2(30)   NULL,
    NATIONALITY   VARCHAR2(60)   NULL,
    DATE_OF_BIRTH DATE           NULL,
    JERSEY_NUMBER NUMBER(3)      NULL,
    TEAM_ID       NUMBER(5)      NULL,
    MARKET_VALUE  NUMBER(12,2)   NULL,
    CONSTRAINT PK_PLAYERS      PRIMARY KEY (PLAYER_ID),
    CONSTRAINT FK_PLAYERS_TEAM FOREIGN KEY (TEAM_ID) REFERENCES TEAMS(TEAM_ID)
);
--MATCHES
CREATE TABLE MATCHES (
    MATCH_ID       NUMBER(7)   NOT NULL,
    MATCH_DATE     DATE        NOT NULL,
    HOME_TEAM_ID   NUMBER(5)   NOT NULL,
    AWAY_TEAM_ID   NUMBER(5)   NOT NULL,
    HOME_GOALS     NUMBER(3)   DEFAULT 0 NOT NULL,
    AWAY_GOALS     NUMBER(3)   DEFAULT 0 NOT NULL,
    STADIUM_ID     NUMBER(5)   NULL,
    ATTENDANCE     NUMBER(7)   NULL,
    CONSTRAINT PK_MATCHES       PRIMARY KEY (MATCH_ID),
    CONSTRAINT FK_MATCH_HOME    FOREIGN KEY (HOME_TEAM_ID) REFERENCES TEAMS(TEAM_ID),
    CONSTRAINT FK_MATCH_AWAY    FOREIGN KEY (AWAY_TEAM_ID) REFERENCES TEAMS(TEAM_ID),
    CONSTRAINT FK_MATCH_STADIUM FOREIGN KEY (STADIUM_ID)   REFERENCES STADIUMS(STADIUM_ID)
);
--MATCH STATS
CREATE TABLE MATCH_STATS (
    STAT_ID     NUMBER(9)   NOT NULL,
    MATCH_ID    NUMBER(7)   NOT NULL,
    PLAYER_ID   NUMBER(7)   NOT NULL,
    GOALS       NUMBER(3)   DEFAULT 0 NOT NULL,
    ASSISTS     NUMBER(3)   DEFAULT 0 NOT NULL,
    MINUTES_PLAYED NUMBER(3) DEFAULT 0 NOT NULL,
    YELLOW_CARDS   NUMBER(1) DEFAULT 0 NOT NULL,
    RED_CARDS      NUMBER(1) DEFAULT 0 NOT NULL,
    CONSTRAINT PK_MATCH_STATS       PRIMARY KEY (STAT_ID),
    CONSTRAINT FK_STATS_MATCH  FOREIGN KEY (MATCH_ID)  REFERENCES MATCHES(MATCH_ID),
    CONSTRAINT FK_STATS_PLAYER FOREIGN KEY (PLAYER_ID) REFERENCES PLAYERS(PLAYER_ID)
);

--INSERT STATEMENTS
--STADIUMS
INSERT INTO STADIUMS VALUES (1, 'Santiago Bernabeu',  'Madrid',       81044, 1947);
INSERT INTO STADIUMS VALUES (2, 'Spotify Camp Nou',   'Barcelona',    99354, 1957);
INSERT INTO STADIUMS VALUES (3, 'Etihad Stadium',     'Manchester',   53400, 2003);
INSERT INTO STADIUMS VALUES (4, 'Allianz Arena',      'Munich',       75024, 2005);
COMMIT;

--TEAMS
INSERT INTO TEAMS VALUES (1, 'Real Madrid',      'Madrid',     'Carlo Ancelotti',  1902, 1);
INSERT INTO TEAMS VALUES (2, 'FC Barcelona',     'Barcelona',  'Hansi Flick',      1899, 2);
INSERT INTO TEAMS VALUES (3, 'Manchester City',  'Manchester', 'Pep Guardiola',    1880, 3);
INSERT INTO TEAMS VALUES (4, 'Bayern Munich',    'Munich',     'Vincent Kompany',  1900, 4);
COMMIT;

--PLAYERS INPUT
INSERT INTO PLAYERS VALUES (1, 'Thibaut',  'Courtois',  'Goalkeeper', 'Belgian',
    to_date('1992-05-11','yyyy-mm-dd'), 1,  1, 20000000);

INSERT INTO PLAYERS VALUES (2, 'Dani',     'Carvajal',  'Defender',   'Spanish',
    to_date('1992-01-11','yyyy-mm-dd'), 2,  1, 18000000);

INSERT INTO PLAYERS VALUES (3, 'Jude',     'Bellingham','Midfielder', 'English',
    to_date('2003-06-29','yyyy-mm-dd'), 5,  1, 180000000);

INSERT INTO PLAYERS VALUES (4, 'Vinicius', 'Junior',    'Forward',    'Brazilian',
    to_date('2000-07-12','yyyy-mm-dd'), 7,  1, 200000000);

--PLAYERS
--REAL MADRID
INSERT INTO PLAYERS VALUES (1, 'Thibaut',  'Courtois',  'Goalkeeper', 'Belgian',
    to_date('1992-05-11','yyyy-mm-dd'), 1,  1, 20000000);

INSERT INTO PLAYERS VALUES (2, 'Dani',     'Carvajal',  'Defender',   'Spanish',
    to_date('1992-01-11','yyyy-mm-dd'), 2,  1, 18000000);

INSERT INTO PLAYERS VALUES (3, 'Jude',     'Bellingham','Midfielder', 'English',
    to_date('2003-06-29','yyyy-mm-dd'), 5,  1, 180000000);

INSERT INTO PLAYERS VALUES (4, 'Vinicius', 'Junior',    'Forward',    'Brazilian',
    to_date('2000-07-12','yyyy-mm-dd'), 7,  1, 200000000);

--BARCELONA
INSERT INTO PLAYERS VALUES (5, 'Marc-Andre','ter Stegen','Goalkeeper','German',
    to_date('1992-04-30','yyyy-mm-dd'), 1,  2, 25000000);

INSERT INTO PLAYERS VALUES (6, 'Jules',    'Kounde',    'Defender',   'French',
    to_date('1998-11-12','yyyy-mm-dd'), 23, 2, 60000000);

INSERT INTO PLAYERS VALUES (7, 'Pedri',    'Gonzalez',  'Midfielder', 'Spanish',
    to_date('2002-11-25','yyyy-mm-dd'), 8,  2, 120000000);

INSERT INTO PLAYERS VALUES (8, 'Robert',   'Lewandowski','Forward',   'Polish',
    to_date('1988-08-21','yyyy-mm-dd'), 9,  2, 15000000);

--MANCHESTER CITY
INSERT INTO PLAYERS VALUES (9,  'Ederson',  'Moraes',   'Goalkeeper', 'Brazilian',
    to_date('1993-08-17','yyyy-mm-dd'), 31, 3, 50000000);

INSERT INTO PLAYERS VALUES (10, 'Ruben',    'Dias',     'Defender',   'Portuguese',
    to_date('1997-05-14','yyyy-mm-dd'), 3,  3, 80000000);

INSERT INTO PLAYERS VALUES (11, 'Kevin',    'De Bruyne','Midfielder', 'Belgian',
    to_date('1991-06-28','yyyy-mm-dd'), 17, 3, 40000000);

INSERT INTO PLAYERS VALUES (12, 'Erling',   'Haaland',  'Forward',    'Norwegian',
    to_date('2000-07-21','yyyy-mm-dd'), 9,  3, 200000000);

--BAYERN MUNICH
INSERT INTO PLAYERS VALUES (13, 'Manuel',   'Neuer',    'Goalkeeper', 'German',
    to_date('1986-03-27','yyyy-mm-dd'), 1,  4, 10000000);

INSERT INTO PLAYERS VALUES (14, 'Alphonso', 'Davies',   'Defender',   'Canadian',
    to_date('2000-11-02','yyyy-mm-dd'), 19, 4, 70000000);

INSERT INTO PLAYERS VALUES (15, 'Joshua',   'Kimmich',  'Midfielder', 'German',
    to_date('1995-02-08','yyyy-mm-dd'), 6,  4, 70000000);

INSERT INTO PLAYERS VALUES (16, 'Harry',    'Kane',     'Forward',    'English',
    to_date('1993-07-28','yyyy-mm-dd'), 9,  4, 100000000);
    
COMMIT;

--MATCH INPUT
-- Match 1: Real Madrid 2-1 FC Barcelona
INSERT INTO MATCHES VALUES (1, to_date('2024-10-26','yyyy-mm-dd'), 1, 2, 2, 1, 1, 80023);

-- Match 2: Manchester City 3-1 Bayern Munich
INSERT INTO MATCHES VALUES (2, to_date('2024-11-05','yyyy-mm-dd'), 3, 4, 3, 1, 3, 53200);

-- Match 3: FC Barcelona 0-2 Manchester City
INSERT INTO MATCHES VALUES (3, to_date('2024-11-20','yyyy-mm-dd'), 2, 3, 0, 2, 2, 91500);

-- Match 4: Bayern Munich 1-1 Real Madrid
INSERT INTO MATCHES VALUES (4, to_date('2024-12-03','yyyy-mm-dd'), 4, 1, 1, 1, 4, 74800);

-- Match 5: Real Madrid 4-0 Manchester City
INSERT INTO MATCHES VALUES (5, to_date('2024-12-17','yyyy-mm-dd'), 1, 3, 4, 0, 1, 79910);

-- Match 6: FC Barcelona 2-3 Bayern Munich
INSERT INTO MATCHES VALUES (6, to_date('2025-01-08','yyyy-mm-dd'), 2, 4, 2, 3, 2, 88200);

COMMIT;

--INPUT MATCH STATS
--MATCH 1 REAL MADRID 2-1 BARCELONA
INSERT INTO MATCH_STATS VALUES ( 1, 1,  4, 1, 1, 90, 0, 0);  -- Vinicius Jr:    1G 1A
INSERT INTO MATCH_STATS VALUES ( 2, 1,  3, 1, 0, 88, 1, 0);  -- Bellingham:     1G 0A 1Y
INSERT INTO MATCH_STATS VALUES ( 3, 1,  8, 1, 0, 90, 0, 0);  -- Lewandowski:    1G 0A
INSERT INTO MATCH_STATS VALUES ( 4, 1,  7, 0, 1, 85, 0, 0);  -- Pedri:          0G 1A

--MATCH 2 MANCHESTER CITY 3-1 BAYERN MUNICH
INSERT INTO MATCH_STATS VALUES ( 5, 2, 12, 2, 0, 90, 0, 0);  -- Haaland:        2G 0A
INSERT INTO MATCH_STATS VALUES ( 6, 2, 11, 0, 2, 88, 0, 0);  -- De Bruyne:      0G 2A
INSERT INTO MATCH_STATS VALUES ( 7, 2,  4, 1, 1, 79, 0, 0);  -- Vinicius Jr: wait -- wrong match
INSERT INTO MATCH_STATS VALUES ( 7, 2, 16, 1, 0, 90, 1, 0);  -- Harry Kane:     1G 0A 1Y
INSERT INTO MATCH_STATS VALUES ( 8, 2, 15, 0, 1, 90, 0, 0);  -- Kimmich:        0G 1A

--MATCH 3 FC BARCELONA 0-2 MANCHESTER CITY
INSERT INTO MATCH_STATS VALUES ( 9, 3, 12, 1, 0, 90, 0, 0);  -- Haaland:        1G 0A
INSERT INTO MATCH_STATS VALUES (10, 3, 11, 1, 1, 88, 0, 0);  -- De Bruyne:      1G 1A
INSERT INTO MATCH_STATS VALUES (11, 3,  7, 0, 0, 90, 1, 0);  -- Pedri:          0G 0A 1Y

--MATCH 4 BAYERN MUNICH 1-1 REAL MADRID
INSERT INTO MATCH_STATS VALUES (12, 4, 16, 1, 0, 90, 0, 0);  -- Harry Kane:     1G 0A
INSERT INTO MATCH_STATS VALUES (13, 4,  4, 1, 0, 87, 0, 0);  -- Vinicius Jr:    1G 0A
INSERT INTO MATCH_STATS VALUES (14, 4,  3, 0, 1, 90, 1, 0);  -- Bellingham:     0G 1A 1Y

--MATCH 5 REAL MADRID 4-0 MANCHESTER CITY
INSERT INTO MATCH_STATS VALUES (15, 5,  4, 2, 1, 90, 0, 0);  -- Vinicius Jr:    2G 1A
INSERT INTO MATCH_STATS VALUES (16, 5,  3, 1, 1, 90, 0, 0);  -- Bellingham:     1G 1A
INSERT INTO MATCH_STATS VALUES (17, 5,  8, 0, 0, 90, 0, 1);  -- Lewandowski: wrong match - Kane
INSERT INTO MATCH_STATS VALUES (17, 5, 12, 1, 0, 85, 0, 0);  -- Haaland:        1G 0A

--MATCH 6 FC BARCELONA 2-3 BAYERN MUNICH
INSERT INTO MATCH_STATS VALUES (18, 6,  8, 1, 0, 88, 0, 0);  -- Lewandowski:    1G 0A
INSERT INTO MATCH_STATS VALUES (19, 6,  7, 0, 1, 90, 0, 0);  -- Pedri:          0G 1A
INSERT INTO MATCH_STATS VALUES (20, 6, 16, 2, 1, 90, 0, 0);  -- Harry Kane:     2G 1A
INSERT INTO MATCH_STATS VALUES (21, 6, 15, 1, 0, 90, 0, 0);  -- Kimmich:        1G 0A
COMMIT;

--SELECT QUERIES
--WHO ARE ALL THE FORWARDS IN THE LEAGUE? CHANGE POSITION TO GET DIFFERENT DATA
SELECT PLAYER_ID
     , FIRST_NAME
     , LAST_NAME
     , NATIONALITY
     , JERSEY_NUMBER
FROM   PLAYERS
WHERE  UPPER(POSITION) = 'FORWARD'
ORDER BY LAST_NAME, FIRST_NAME;

--How old is each player today, and what is their estimated market value per year of age?
SELECT FIRST_NAME, LAST_NAME          AS PLAYER_NAME
     , POSITION
     , ROUND( (SYSDATE - DATE_OF_BIRTH) / 365.25, 1 )  AS AGE_YEARS
     , MARKET_VALUE
     , ROUND( MARKET_VALUE / ((SYSDATE - DATE_OF_BIRTH) / 365.25), 2 ) AS VALUE_PER_YEAR
FROM   PLAYERS
WHERE  DATE_OF_BIRTH IS NOT NULL
ORDER BY AGE_YEARS;

--What unique nationalities and positions are represented in the league?
-- Unique nationalities
SELECT DISTINCT NATIONALITY
FROM   PLAYERS
WHERE  NATIONALITY IS NOT NULL
ORDER BY NATIONALITY;

-- Unique combinations of position and nationality
SELECT DISTINCT POSITION, NATIONALITY
FROM   PLAYERS
WHERE  POSITION IS NOT NULL
ORDER BY 1, 2;

-- What is the average, minimum, and maximum market value of players across the whole league?
SELECT COUNT(*)                           AS TOTAL_PLAYERS
     , COUNT(MARKET_VALUE)                AS PLAYERS_WITH_VALUE
     , COUNT(*) - COUNT(MARKET_VALUE)     AS MISSING_VALUES
     , ROUND( MIN(MARKET_VALUE), 2 )      AS MIN_VALUE
     , ROUND( MAX(MARKET_VALUE), 2 )      AS MAX_VALUE
     , ROUND( AVG(MARKET_VALUE), 2 )      AS AVG_VALUE
     , ROUND( SUM(MARKET_VALUE), 2 )      AS TOTAL_VALUE
FROM   PLAYERS;

--How many players does each team have, and what is their average market value?
SELECT T.TEAM_NAME
     , COUNT(P.PLAYER_ID)           AS TOTAL_PLAYERS
     , ROUND( AVG(P.MARKET_VALUE), 0 ) AS AVG_MARKET_VALUE
     , ROUND( SUM(P.MARKET_VALUE), 0 ) AS SQUAD_TOTAL_VALUE
FROM   TEAMS   T
JOIN   PLAYERS P ON P.TEAM_ID = T.TEAM_ID
GROUP BY T.TEAM_NAME
ORDER BY SQUAD_TOTAL_VALUE DESC;

--Which teams have scored more than 5 goals in total across all matches?
SELECT T.TEAM_NAME,
       SUM(G.GOALS) AS TOTAL_GOALS
FROM TEAMS T
JOIN (
      SELECT HOME_TEAM_ID AS TEAM_ID, HOME_GOALS AS GOALS
      FROM MATCHES
      UNION ALL
      SELECT AWAY_TEAM_ID AS TEAM_ID, AWAY_GOALS AS GOALS
      FROM MATCHES
     ) G
ON G.TEAM_ID = T.TEAM_ID
GROUP BY T.TEAM_NAME
HAVING SUM(G.GOALS) > 5
ORDER BY TOTAL_GOALS DESC;

--Show each match result with team names, stadium, and attendance.
SELECT TO_CHAR(M.MATCH_DATE, 'DD-MON-YYYY')  AS MATCH_DATE
     , HT.TEAM_NAME                           AS HOME_TEAM
     , M.HOME_GOALS
     , M.AWAY_GOALS
     , AT.TEAM_NAME                           AS AWAY_TEAM
     , S.STADIUM_NAME
     , M.ATTENDANCE
FROM   MATCHES   M
JOIN   TEAMS     HT ON HT.TEAM_ID   = M.HOME_TEAM_ID
JOIN   TEAMS     AT ON AT.TEAM_ID   = M.AWAY_TEAM_ID
JOIN   STADIUMS  S  ON S.STADIUM_ID = M.STADIUM_ID
ORDER BY M.MATCH_DATE;

--Show all teams and how many matches they have played 
SELECT T.TEAM_NAME
     , COUNT(M.MATCH_ID)  AS MATCHES_PLAYED
FROM   TEAMS   T
LEFT JOIN MATCHES M ON M.HOME_TEAM_ID = T.TEAM_ID
                    OR M.AWAY_TEAM_ID  = T.TEAM_ID
GROUP BY T.TEAM_NAME
ORDER BY MATCHES_PLAYED DESC;

--Who scored the most goals in each match?
SELECT M.MATCH_ID
     , TO_CHAR(M.MATCH_DATE, 'DD-MON-YYYY')       AS MATCH_DATE
     , P.FIRST_NAME || ' ' || P.LAST_NAME          AS TOP_SCORER
     , MS.GOALS
FROM   MATCH_STATS MS
JOIN   MATCHES     M  ON M.MATCH_ID  = MS.MATCH_ID
JOIN   PLAYERS     P  ON P.PLAYER_ID = MS.PLAYER_ID
WHERE  MS.GOALS = (
    SELECT MAX(GOALS)
    FROM   MATCH_STATS
    WHERE  MATCH_ID = MS.MATCH_ID
)
ORDER BY M.MATCH_DATE;

--What percentage of total league goals did each team score?
SELECT T.TEAM_NAME
     , SUM(MS.GOALS)  AS TEAM_GOALS
     , ROUND(
           100 * SUM(MS.GOALS) / ( SELECT SUM(GOALS) FROM MATCH_STATS ),
       2 )            AS PCT_OF_TOTAL_GOALS
FROM   TEAMS T
JOIN   PLAYERS  P  ON P.TEAM_ID   = T.TEAM_ID
JOIN   MATCH_STATS MS ON MS.PLAYER_ID = P.PLAYER_ID
GROUP BY T.TEAM_NAME
ORDER BY TEAM_GOALS DESC;

--Which players scored above the league average for goals per match?
SELECT PLAYER_NAME
     , TOTAL_GOALS
     , MATCHES_PLAYED
     , ROUND( TOTAL_GOALS / MATCHES_PLAYED, 2 )  AS GOALS_PER_MATCH
FROM (
    SELECT P.FIRST_NAME || ' ' || P.LAST_NAME   AS PLAYER_NAME
         , SUM(MS.GOALS)                         AS TOTAL_GOALS
         , COUNT(DISTINCT MS.MATCH_ID)           AS MATCHES_PLAYED
    FROM   PLAYERS     P
    JOIN   MATCH_STATS MS ON MS.PLAYER_ID = P.PLAYER_ID
    GROUP BY P.FIRST_NAME || ' ' || P.LAST_NAME
    HAVING SUM(MS.GOALS) > 0
)
WHERE TOTAL_GOALS / MATCHES_PLAYED > (
    SELECT AVG(GOALS)
    FROM   MATCH_STATS
    WHERE  GOALS > 0
)
ORDER BY GOALS_PER_MATCH DESC;

--Show all players who have received at least one red card this season.
SELECT P.FIRST_NAME || ' ' || P.LAST_NAME  AS PLAYER_NAME
     , P.POSITION
     , T.TEAM_NAME
FROM   PLAYERS P
JOIN   TEAMS T ON T.TEAM_ID = P.TEAM_ID
WHERE  P.PLAYER_ID IN (
    SELECT DISTINCT PLAYER_ID
    FROM   MATCH_STATS
    WHERE  RED_CARDS >= 1
)
ORDER BY T.TEAM_NAME, P.LAST_NAME;

--Which players have not played in any match yet this season?
SELECT P.FIRST_NAME || ' ' || P.LAST_NAME  AS PLAYER_NAME
     , P.POSITION
     , T.TEAM_NAME
FROM   PLAYERS P
JOIN   TEAMS   T ON T.TEAM_ID = P.TEAM_ID
WHERE  P.PLAYER_ID NOT IN (
    SELECT DISTINCT PLAYER_ID
    FROM   MATCH_STATS
)
ORDER BY T.TEAM_NAME, P.LAST_NAME;

--Rank all players by total goals scored this season. Show all rankings including ties.
SELECT P.FIRST_NAME || ' ' || P.LAST_NAME   AS PLAYER_NAME
     , T.TEAM_NAME
     , SUM(MS.GOALS)                         AS TOTAL_GOALS
     , SUM(MS.ASSISTS)                        AS TOTAL_ASSISTS
     , RANK()        OVER (ORDER BY SUM(MS.GOALS) DESC)  AS RANK_GOALS
     , DENSE_RANK()  OVER (ORDER BY SUM(MS.GOALS) DESC)  AS DENSE_RANK_GOALS
     , ROW_NUMBER()  OVER (ORDER BY SUM(MS.GOALS) DESC)  AS ROW_NUM
FROM   MATCH_STATS MS
JOIN   PLAYERS     P  ON P.PLAYER_ID = MS.PLAYER_ID
JOIN   TEAMS       T  ON T.TEAM_ID   = P.TEAM_ID
GROUP BY P.FIRST_NAME || ' ' || P.LAST_NAME, T.TEAM_NAME
ORDER BY TOTAL_GOALS DESC
FETCH FIRST 10 ROWS ONLY;

--Show the full league standings: wins, draws, losses, goals for, goals against, goal difference, and points.
SELECT TEAM_NAME
     , PLAYED
     , WON
     , DRAWN
     , LOST
     , GOALS_FOR
     , GOALS_AGAINST
     , GOALS_FOR - GOALS_AGAINST   AS GOAL_DIFFERRENCE
     , (WON * 3) + DRAWN           AS POINTS
     , DENSE_RANK() OVER (ORDER BY (WON*3)+DRAWN DESC,
                                    GOALS_FOR - GOALS_AGAINST DESC) AS POSITION
FROM (
    SELECT T.TEAM_NAME
         , COUNT(*)  AS PLAYED
         , SUM(CASE WHEN (M.HOME_TEAM_ID=T.TEAM_ID AND M.HOME_GOALS>M.AWAY_GOALS)
                      OR (M.AWAY_TEAM_ID=T.TEAM_ID AND M.AWAY_GOALS>M.HOME_GOALS)
                    THEN 1 ELSE 0 END)  AS WON
         , SUM(CASE WHEN M.HOME_GOALS = M.AWAY_GOALS
                    THEN 1 ELSE 0 END)  AS DRAWN
         , SUM(CASE WHEN (M.HOME_TEAM_ID=T.TEAM_ID AND M.HOME_GOALS<M.AWAY_GOALS)
                      OR (M.AWAY_TEAM_ID=T.TEAM_ID AND M.AWAY_GOALS<M.HOME_GOALS)
                    THEN 1 ELSE 0 END)  AS LOST
         , SUM(CASE WHEN M.HOME_TEAM_ID=T.TEAM_ID THEN M.HOME_GOALS
                    ELSE M.AWAY_GOALS END) AS GOALS_FOR
         , SUM(CASE WHEN M.HOME_TEAM_ID=T.TEAM_ID THEN M.AWAY_GOALS
                    ELSE M.HOME_GOALS END) AS GOALS_AGAINST
    FROM   TEAMS T
    JOIN   MATCHES M ON M.HOME_TEAM_ID=T.TEAM_ID OR M.AWAY_TEAM_ID=T.TEAM_ID
    GROUP BY T.TEAM_NAME
)
ORDER BY POSITION;
