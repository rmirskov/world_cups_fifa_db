DROP DATABASE IF EXISTS world_cups_fifa;
CREATE DATABASE world_cups_fifa;
USE world_cups_fifa;

DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	soccer_region ENUM('UEFA', 'AFC', 'CAF', 'OFC', 'CONCACAF', 'CONMEBOL') DEFAULT 'UEFA'
);

DROP TABLE IF EXISTS teams;
CREATE TABLE teams (
	id SERIAL PRIMARY KEY,
	country_id BIGINT UNSIGNED NOT NULL,
	letter_group ENUM('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H') DEFAULT 'A',
	basecamp_id BIGINT UNSIGNED,
	year_of_world_cup INT NOT NULL,
	is_host_country BIT DEFAULT 0,
	
	FOREIGN KEY (country_id) REFERENCES countries(id),
	CHECK (year_of_world_cup > 1930)
);

DROP TABLE IF EXISTS basecamps;
CREATE TABLE basecamps (
	id SERIAL PRIMARY KEY,
	city VARCHAR(100) NOT NULL,
	host_country_region VARCHAR(255)
);

ALTER TABLE teams
ADD CONSTRAINT team_on_basecamp
FOREIGN KEY (basecamp_id) REFERENCES basecamps(id);

DROP TABLE IF EXISTS coaches;
CREATE TABLE coaches (
	id SERIAL PRIMARY KEY,
	fullname VARCHAR(255) NOT NULL,
	team_id BIGINT UNSIGNED NOT NULL,
	country_id BIGINT UNSIGNED,
	birthday DATETIME,
	
	FOREIGN KEY (country_id) REFERENCES countries(id),
	FOREIGN KEY (team_id) REFERENCES teams(id)
);

DROP TABLE IF EXISTS referees;
CREATE TABLE referees (
	id SERIAL PRIMARY KEY,
	fullname VARCHAR(255) NOT NULL,
	country_id BIGINT UNSIGNED,
	birthday DATETIME,
	
	FOREIGN KEY (country_id) REFERENCES countries(id)
);

DROP TABLE IF EXISTS players;
CREATE TABLE players (
	id SERIAL PRIMARY KEY,
	fullname VARCHAR(255) NOT NULL,
	team_id BIGINT UNSIGNED NOT NULL,
	tshirt_number INT,
	amplua ENUM('CG', 'DF', 'MF', 'FW') DEFAULT 'MF',
	birthday DATETIME,
	club_id BIGINT UNSIGNED,
	
	FOREIGN KEY (team_id) REFERENCES teams(id)
);

DROP TABLE IF EXISTS game_places;
CREATE TABLE game_places (
	id SERIAL PRIMARY KEY,
	city VARCHAR(100) NOT NULL,
	stadium VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS game;
CREATE TABLE games (
	id SERIAL PRIMARY KEY,
	team1_id BIGINT UNSIGNED NOT NULL,
	team2_id BIGINT UNSIGNED NOT NULL,
	game_date DATETIME,
	game_place_id BIGINT UNSIGNED NOT NULL,
	stage ENUM('group', '1/8', '1/4', 'semifinals', 'final') DEFAULT 'group',
	
	FOREIGN KEY (team1_id) REFERENCES teams(id),
	FOREIGN KEY (team2_id) REFERENCES teams(id),
	FOREIGN KEY (game_place_id) REFERENCES game_places(id)
);

DROP TABLE IF EXISTS game_events;
CREATE TABLE game_events (
	game_id BIGINT UNSIGNED NOT NULL,
	player_id BIGINT UNSIGNED NOT NULL,
	minute_of_event INT,
	event ENUM('yellow card', 'red card', 'second yellow card', 'goal', 'replace', 'penalty') DEFAULT 'yellow card',
	assist_or_replace BIGINT UNSIGNED DEFAULT NULL,  -- в случаях, когда event равен 'goal' или 'replace' (нужен триггер на операцию INSERT)  
	
	FOREIGN KEY (game_id) REFERENCES games(id),
	FOREIGN KEY (player_id) REFERENCES players(id),
	FOREIGN KEY (assist_or_replace) REFERENCES players(id)
);

DROP TABLE IF EXISTS clubs;
CREATE TABLE clubs (
	id SERIAL PRIMARY KEY,
	club_name VARCHAR(255),
	from_city VARCHAR(255),
	country_id BIGINT UNSIGNED,
	
	FOREIGN KEY (country_id) REFERENCES countries(id)
);

ALTER TABLE players
ADD CONSTRAINT player_on_club
FOREIGN KEY (club_id) REFERENCES clubs(id);

DROP TABLE IF EXISTS player_on_game;
CREATE TABLE player_on_game (
	player_id BIGINT UNSIGNED NOT NULL,
	game_id BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (player_id) REFERENCES players(id),
	FOREIGN KEY (game_id) REFERENCES games(id)
);

DROP TABLE IF EXISTS game_staffs;
CREATE TABLE game_staffs (
	referee_id BIGINT UNSIGNED NOT NULL,
	game_id BIGINT UNSIGNED NOT NULL,
	referee_role ENUM('main_referee', 'assistant', 'reserve_referee') DEFAULT 'assistant',
	
	FOREIGN KEY (referee_id) REFERENCES referees(id),
	FOREIGN KEY (game_id) REFERENCES games(id)
);








