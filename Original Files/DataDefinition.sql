-- FILE: DataDefinition.sql
-- PROJECT STEP 3 DRAFT
-- GROUP 82
-- MEMBERS: Billy O'Brien, Deptmer Ashley
-- TITLE: Youth Basketball League Schedule Management System

-- DESCRIPTION:
    -- This is the DDL file for Step 3 Draft of the course project. This file includes the
    -- create commands for each of the tables in the database. It also includes adding sample
    -- data to add to each table. The database serves as a scheduling tool for a youth basketball 
    -- league. The problem we are aiming to solve is the difficulty of accessing information 
    -- regarding games and times. By creating this database, players, coaches, and spectators 
    -- will be able to view any information that they need regarding the league, games, when 
    -- games are played, players on teams, rules of the league, etc. 

-- Disable commits and foreign key checks before file starts
SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;


-- Table Structure for "Coaches" table. 
-- This is the table that tracks information about coaches in the basketball league. 
-- Specifically it tracks the name, email, and training certificate of hte coach. 
-- It uses a coachID as a primary key.
CREATE OR REPLACE TABLE Coaches (
    coachID int NOT NULL AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    email varchar(100) NOT NULL,
    trainingComplete tinyint(1) NOT NULL,
    PRIMARY KEY (coachID)
);


-- Table Structure for "Teams" table. 
-- This is the table that tracks information about teams in the basketball league. 
-- Each team has a name, color, and a coach assigned to the team. The teams compete 
-- in the league. 
-- It uses a teamID as a primary key. Uses coachID from the coaches table as a foreign Key. 
CREATE OR REPLACE TABLE Teams (
    teamID int NOT NULL AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    color varchar(45) NOT NULL,
    coachID int,
    PRIMARY KEY (teamID),
    FOREIGN KEY (coachID) REFERENCES Coaches(coachID) ON DELETE CASCADE
);


-- Table Structure for "Players" table. 
-- This is the table that tracks information about a player in the basketball league. 
-- The name, email, and birthday for a player are recorded. Each player is assigned to 
-- a team via a foreign key to the Teams table. 
-- Table uses a playerID as a primary key.
CREATE OR REPLACE TABLE Players (
    playerID int NOT NULL AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    email varchar(100) NOT NULL,
    birthday date NOT NULL,
    teamID int,
    PRIMARY KEY (playerID),
    FOREIGN KEY (teamID) REFERENCES Teams(teamID) ON DELETE CASCADE
);


-- Table Structure for "Gyms" table. 
-- The gym is a location where a game is played. The table tracks the name of the gym
-- and if the gym is regulation size or not. There are no foreign key assignments in 
-- this table, but the Table does use a gymID as a primary key for the table. 
CREATE OR REPLACE TABLE Gyms (
    gymID int NOT NULL AUTO_INCREMENT,
    name varchar(100) NOT NULL,
    regulationSize tinyint(1) NOT NULL,
    PRIMARY KEY (gymID)
);


-- Table Structure for the "Games" table. 
-- This table holds the information about a game in the league. Games will be played 
-- between two teams in the league, but the teams playing in the game are tracked in 
-- a seperate intersection table. This table holds the date that the game takes place, 
-- and holds the gym where the game is played a foreign key from the gyms table. Uses 
-- a gameID as the primary key in the Games table. 
CREATE OR REPLACE TABLE Games (
    gameID int NOT NULL AUTO_INCREMENT,
    gameDate date NOT NULL,
    gymID int,
    PRIMARY KEY (gameID),
    FOREIGN KEY (gymID) REFERENCES Gyms(gymID) ON DELETE CASCADE
);


-- Table structure for the "TeamGames" intersection table. 
-- This table is the intersection table that holds the information about which teams 
-- are playing in which games. Because each team plays in many games, and each game 
-- has many teams, a N:M table is needed to satisfy the relationship. This table 
-- essentially uses two Foreign Keys for each entry to hold the teamID and gameID. 
CREATE OR REPLACE TABLE TeamGames (
    teamGameID int NOT NULL AUTO_INCREMENT,
    teamID int,
    gameID int, 
    PRIMARY KEY (teamGameID),
    FOREIGN KEY (teamID) REFERENCES Teams(teamID) ON DELETE CASCADE,
    FOREIGN KEY (gameID) REFERENCES Games(gameID) ON DELETE CASCADE
);


-- Insert statements for inserting sample data into the coaches table. 
-- Inserting information for 3 fictional coaches. 
INSERT INTO Coaches (
    name,
    email,
    trainingComplete
)
VALUES
(
    "Jessie Harrison",
    "jessieharrison@team.com",
    1
),
(
    "Kelly Garner",
    "kellygarner@hotmail.com",
    1
),
(
    "Kaden Reid",
    "kadenreid@gmail.com",
    1
);


-- Insert statement for inserting sample data into teams table. 
-- Inserting data for four fictional teams. The four teams in the
-- fictional league are the tigers, panthers, eagles, and bulldogs. 
INSERT INTO Teams (
    name, 
    color,
    coachID
)
VALUES 
(
    "Tigers",
    "Orange",
    (SELECT coachID from Coaches where name = 'Jessie Harrison')
),
(
    "Panthers",
    "Blue",
    (SELECT coachID from Coaches where name = 'Kelly Garner')
),
(
    "Eagles",
    "Green",
    (SELECT coachID from Coaches where name = 'Kaden Reid')
),
(
    "Bulldogs",
    "Red",
    (SELECT coachID from Coaches where name = 'Jessie Harrison')
);


-- Insert statement for inserting data into the players table. 
-- The sample data includes information about 8 fictional players. 
-- Each player is assigned to a team in the league. 
INSERT INTO Players (
    name,
    email,
    birthday,
    teamID
)
VALUES
(
    "Max Jenkins",
    "maxjenkins@aol.com",
    "2002-02-04",
    (SELECT teamID from Teams where name = 'Tigers')
),
(
    "Jade Phillips",
    "jadephillips@team.com",
    "2002-06-10",
    (SELECT teamID from Teams where name = 'Tigers')
),
(
    "Sana Phelps",
    "sanaphelps@gmail.com",
    "2001-11-18",
    (SELECT teamID from Teams where name = 'Tigers')
),
(
    "Jerry Davis",
    "jerrydavis@hotmail.com",
    "2003-01-24",
    (SELECT teamID from Teams where name = 'Tigers')
),
(
    "Jan Park",
    "janpark@gmail.com",
    "2001-12-14",
    (SELECT teamID from Teams where name = 'Panthers')
),
(
    "Tim Landry",
    "timlandry@yahoo.com",
    "2002-08-01",
    (SELECT teamID from Teams where name = 'Panthers')
),
(
    "Cordell Roberts",
    "cordellroberts@gmail.com",
    "2003-02-01",
    (SELECT teamID from Teams where name = 'Panthers')
),
(
    "Nana Kelley",
    "nanakelley@yahoo.com",
    "2002-04-22",
    (SELECT teamID from Teams where name = 'Eagles')
);


-- Insert statement for inserting sample data for the gyms. 
-- There are 3 gyms where games can be played. Each gym name 
-- and if it is regulation size is entered into the database. 
INSERT INTO Gyms (
    name,
    regulationSize
)
VALUES
(
    "Southport Fieldhouse",
    1
),
(
    "Kalama Gym",
    0
),
(
    "Allen Center",
    1
);


-- Insert statement for inserting fictional game data into the Games table.
-- Includes the date of the game and the gym where the game takes place. 
-- There are 6 games added to the database. This allows for each of the four teams 
-- to play one game verse the other 3 teams in the leage. 
INSERT INTO Games (
    gameDate,
    gymID
)
VALUES
(
    "2024-10-01",
    (SELECT gymID from Gyms where name = 'Southport Fieldhouse')
),
(
    "2024-10-03",
    (SELECT gymID from Gyms where name = 'Kalama Gym')
),
(
    "2024-10-05",
    (SELECT gymID from Gyms where name = 'Allen Center')
),
(
    "2024-10-08",
    (SELECT gymID from Gyms where name = 'Southport Fieldhouse')
),
(
    "2024-10-10",
    (SELECT gymID from Gyms where name = 'Kalama Gym')
),
(
    "2024-10-12",
    (SELECT gymID from Gyms where name = 'Allen Center')
);


-- Insert statement for the TeamGames table. Inserting sample data into this 
-- table is how teams are assigned to each game. 
-- Each team is assigned to 3 different games. 
INSERT INTO TeamGames (
    teamID,
    gameID
)
VALUES
(
    (SELECT teamID from Teams where name = 'Tigers'),
    (SELECT gameID from Games where gameID = 1)
),
(
    (SELECT teamID from Teams where name = 'Panthers'),
    (SELECT gameID from Games where gameID = 1)
),
(
    (SELECT teamID from Teams where name = 'Eagles'),
    (SELECT gameID from Games where gameID = 2)
),
(
    (SELECT teamID from Teams where name = 'Bulldogs'),
    (SELECT gameID from Games where gameID = 2)
),
(
    (SELECT teamID from Teams where name = 'Tigers'),
    (SELECT gameID from Games where gameID = 3)
),
(
    (SELECT teamID from Teams where name = 'Eagles'),
    (SELECT gameID from Games where gameID = 3)
),
(
    (SELECT teamID from Teams where name = 'Panthers'),
    (SELECT gameID from Games where gameID = 4)
),
(
    (SELECT teamID from Teams where name = 'Bulldogs'),
    (SELECT gameID from Games where gameID = 4)
),
(
    (SELECT teamID from Teams where name = 'Tigers'),
    (SELECT gameID from Games where gameID = 5)
),
(
    (SELECT teamID from Teams where name = 'Bulldogs'),
    (SELECT gameID from Games where gameID = 5)
),
(
    (SELECT teamID from Teams where name = 'Panthers'),
    (SELECT gameID from Games where gameID = 6)
),
(
    (SELECT teamID from Teams where name = 'Eagles'),
    (SELECT gameID from Games where gameID = 6)
);


-- Turn commits and foreign key checks back on
SET FOREIGN_KEY_CHECKS=1;
COMMIT;
