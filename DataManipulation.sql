-- FILE: DataManipulation.sql
-- PROJECT STEP 3 DRAFT
-- GROUP 82
-- MEMBERS: Billy O'Brien, Deptmer Ashley
-- TITLE: Youth Basketball League Schedule Management System

-- DESCRIPTION:
    -- This is the data manipulation file for Step 3 Draft of the course project.
    -- This file includes the select, insert, delete, and update functions.

-- Disable commits and foreign key checks before file starts
SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;


-- Select query for the Coaches table.
-- Selects the coachID, name, and email for every coach in the database.
select coachID, name, email from Coaches;


-- Select query for the Teams table.
-- Shows the team id, name, color, and coaches name.
SELECT Teams.teamID, Teams.name, Teams.color, Coaches.name
FROM Teams
INNER JOIN Coaches ON Coaches.coachID = Teams.coachID;


-- Select query for the Players table.
-- Shows the playerID, name, email, birthday, and team name for each player
SELECT Players.playerID, Players.name, Players.email, Players.birthday, Teams.name
FROM Players
INNER JOIN Teams ON Teams.teamID = Players.teamID;


-- Select query for the Gyms table.
-- Displays the gym id and name and if it regulation size or not.
SELECT * FROM Gyms;


-- Select query for the teamGames table
-- Essentially this shows the schedule for all the teams.
-- Displays the gameID, game date, gym name, and the teams in the game
SELECT TeamGames.gameID, Games.gameDate, Gyms.name,
GROUP_CONCAT(Teams.name) AS teams
FROM TeamGames
INNER JOIN Games ON Games.gameID = TeamGames.gameID
INNER JOIN Teams ON TeamGames.teamID = Teams.teamID
INNER JOIN Gyms ON Games.gymID = Gyms.gymID
GROUP BY gameID;


-- Insert a new coach
INSERT INTO Coaches (name, email, trainingComplete)
VALUES (:nameInput, :emailInput, :trainingCompleteInput);


-- Insert a new team
INSERT INTO Teams (name, color, coachID)
VALUES (:nameInput, :colorInput, (SELECT coachID from Coaches where name = :coach_name_from_dropdown_list))


-- Insert a new player
INSERT INTO Players (name, email, birthday, teamID)
VALUES (:nameInput, :emailInput, :birthdayInput,
(SELECT teamID from Teams where name = :team_name_from_dropdown_list))


-- Insert a new gym
INSERT INTO Gyms (name, regulationSize)
VALUES (:nameInput, :regulationSizeInput);


-- Insert a new game
INSERT INTO Games (gameDate, gymID)
VALUES (:gameDateInput, (SELECT gymID from Gyms where name = :gym_name_from_dropdown_list))


-- Add teams to an existing game
INSERT INTO TeamGames (teamID, gameID)
VALUES ((SELECT teamID from Teams where name = :team_name_from_dropdown_list),
    (SELECT gameID from Games where gameDate = :game_date_from_dropdown_list))


-- Update a game in the database.
-- This allows a user to change the date or gym for a game. Gym can be left
-- null in this update.
UPDATE Games
SET gameDate = "2024-12-01", gymID = (SELECT gymID from Gyms where name = 'Kalama Gym')
WHERE gameID = 1;


-- Delete query for the Players Table
-- This deletion will be done with a dropdown menu
 DELETE FROM Players WHERE playerID = :player_ID_selected_from_dropdown_menu;


-- Dis-associate a team from a game. This is the M-M relationship delation.
-- This is done to delete a single team from a game but leave the game and the
-- team intact in the rest of the database.
DELETE FROM TeamGames WHERE gameID = :gameID_selected_from_TeamGames_list
AND teamID = teamID_selected_from_TeamGames_list;


-- Turn commits and foreign key checks back on
SET FOREIGN_KEY_CHECKS=1;
COMMIT;
