USE world_cups_fifa;

-- Show number of games what a player was on the field
SELECT p.fullname, COUNT(*) AS count_game FROM player_on_game AS pon
  JOIN players AS p ON p.id = pon.player_id
  JOIN games AS g ON g.id = pon.game_id
  WHERE p.id = 1 AND YEAR(g.game_date) = 2018;

-- Show list of bombardirs
SELECT p.fullname, COUNT(*) AS goals FROM game_events AS ge
  JOIN games AS g ON g.id = ge.game_id 
  JOIN players AS p ON p.id = ge.player_id
 WHERE YEAR(g.game_date) = 2018
   AND ge.event = 'goal'
 GROUP BY p.fullname
 ORDER BY goals DESC, p.fullname;

-- Show results all games in the group A
SELECT CONCAT(c1.name, " - ", c2.name) AS game,
	   CONCAT(count_goals(g.id, t1.id), ":", count_goals(g.id, t2.id)) AS score
  FROM games AS g
  JOIN teams AS t1 ON t1.id = g.team1_id
  JOIN teams AS t2 ON t2.id = g.team2_id
  JOIN countries AS c1 ON c1.id = t1.country_id
  JOIN countries AS c2 ON c2.id = t2.country_id
 WHERE YEAR(game_date) = 2018 
   AND t1.letter_group = 'A'
   AND stage = 'group';

  -- Function for counting goals on game_id and team_id
DELIMITER //

DROP FUNCTION IF EXISTS count_goals//
CREATE FUNCTION count_goals(game INT, team INT)
RETURNS INT NO SQL
BEGIN
	DECLARE goals INT DEFAULT 0;
	SELECT COUNT(*) INTO goals FROM games AS g 
  	  JOIN game_events AS ge ON ge.game_id = g.id
      JOIN players AS p ON p.id = ge.player_id
  	  JOIN teams AS t ON t.id = p.team_id 
  	  JOIN countries AS c ON c.id = t.country_id
 	 WHERE g.id = game  AND ge.event = 'goal' AND p.team_id = team;
	RETURN goals;
END//

DELIMITER ;

-- Procedure for showing teams on the fifa world cup
DELIMITER //

DROP PROCEDURE IF EXISTS show_teams//
CREATE PROCEDURE show_teams(wc_year INT)
BEGIN
	SELECT c.name FROM teams AS t 
  	  JOIN countries AS c ON c.id = t.country_id
 	 WHERE t.year_of_world_cup = wc_year;
END//

DELIMITER ;

CALL show_teams(2018);

-- Show starting lineup team on the game
DELIMITER //

DROP PROCEDURE IF EXISTS show_start_lineup//
CREATE PROCEDURE show_start_lineup(game_id INT)
BEGIN
	SELECT p.tshirt_number, p.amplua, p.fullname, c.name FROM player_on_game AS pon 
	  JOIN players AS p ON p.id = pon.player_id
	  JOIN games AS g ON g.id = pon.game_id
	  JOIN teams AS t ON t.id = p.team_id 
	  JOIN countries AS c ON c.id = t.country_id
	 WHERE pon.game_id = game_id AND p.id NOT IN
	 	(SELECT assist_or_replace FROM game_events AS ge
	 	  WHERE event = 'replace'
	 	  AND assist_or_replace IS NOT NULL)
	 ORDER BY c.name, FIELD(amplua, 'GK', 'DF', 'MF', 'FW');
END//

DELIMITER ; 

CALL show_start_lineup(1);

-- View for showing teams on world cup fifa 2018
DROP VIEW IF EXISTS teams_2018;
CREATE OR REPLACE VIEW teams_2018 AS
	SELECT c.name, t.letter_group FROM teams AS t 
	  JOIN countries AS c ON c.id = t.country_id 
	 WHERE t.year_of_world_cup = 2018
	 ORDER BY t.letter_group;

SELECT * FROM teams_2018;

-- View for counting players on different countries leagues in 2018
DROP VIEW IF EXISTS players_from_cl_2018;
CREATE OR REPLACE VIEW players_from_cl_2018 AS
	SELECT c2.name, COUNT(*) AS players_on_league FROM players AS p 
	  JOIN teams AS t ON t.id = p.team_id
	  JOIN clubs AS c1 ON c1.id = p.club_id
	  JOIN countries AS c2 ON c2.id = c1.country_id 
	 WHERE t.year_of_world_cup = 2018
	 GROUP BY c2.name
	 ORDER BY players_on_league DESC;

SELECT * FROM players_from_cl_2018;

-- Trigger for checking field "assist_or_replace" when field's value "event" equals "replace"
DELIMITER //

DROP TRIGGER IF EXISTS check_replace//
CREATE TRIGGER check_replace BEFORE INSERT ON game_events 
FOR EACH ROW
BEGIN
	IF (NEW.event = 'replace' AND NEW.assist_or_replace IS NULL) THEN
    	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Need to fill field "assist_or_replace"';
	END IF;
END//

DELIMITER ;




