-- MySQL dump 10.13  Distrib 8.0.26, for Linux (x86_64)
--
-- Host: localhost    Database: world_cups_fifa
-- ------------------------------------------------------
-- Server version	8.0.26-0ubuntu0.20.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `basecamps`
--

DROP TABLE IF EXISTS `basecamps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `basecamps` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `city` varchar(100) NOT NULL,
  `host_country_region` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `basecamps`
--

LOCK TABLES `basecamps` WRITE;
/*!40000 ALTER TABLE `basecamps` DISABLE KEYS */;
INSERT INTO `basecamps` VALUES (2,'Санкт-Петербург','Санкт-Петербург'),(5,'Сочи','Краснодарский край'),(7,'Саранск','Республика Мордовия'),(9,'Химки','Московская область'),(10,'Светлогорск','Калининградская область'),(12,'Бор','Нижегородская область'),(13,'Истра','Московская область'),(20,'Краснодар','Краснодарский край'),(22,'Бронницы','Московская область'),(24,'Грозный','Чеченская республика');
/*!40000 ALTER TABLE `basecamps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clubs`
--

DROP TABLE IF EXISTS `clubs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clubs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `club_name` varchar(255) DEFAULT NULL,
  `from_city` varchar(255) DEFAULT NULL,
  `country_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `clubs_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clubs`
--

LOCK TABLES `clubs` WRITE;
/*!40000 ALTER TABLE `clubs` DISABLE KEYS */;
INSERT INTO `clubs` VALUES (1,'ЦСКА','Москва',1),(2,'Вильярреал','Вильярреаль',6),(3,'Краснодар','Краснодар',1),(4,'Арсенал','Тула',1),(5,'Леванте','Валенсия',6),(6,'Атлетико Мадрид','Мадрид',6),(7,'Васко да Гама',' Рио-де-Жанейро',9),(8,'Бока Хуниорс','Буэнос-Айрес',5),(9,'Пари Сен-Жермен','Париж',12),(10,'Крузейро','Белу-Оризонти',9);
/*!40000 ALTER TABLE `clubs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coaches`
--

DROP TABLE IF EXISTS `coaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coaches` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `fullname` varchar(255) NOT NULL,
  `team_id` bigint unsigned NOT NULL,
  `country_id` bigint unsigned DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `country_id` (`country_id`),
  KEY `team_id` (`team_id`),
  CONSTRAINT `coaches_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`),
  CONSTRAINT `coaches_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coaches`
--

LOCK TABLES `coaches` WRITE;
/*!40000 ALTER TABLE `coaches` DISABLE KEYS */;
INSERT INTO `coaches` VALUES (1,'Станислав Черчесов',1,1,'1963-09-02 00:00:00'),(2,'Эктор Купер',2,5,'1955-11-16 00:00:00'),(3,'Оскар Табарес',3,3,'1947-03-03 00:00:00'),(4,'Хуан Антонио Пицци',4,6,'1968-06-07 00:00:00'),(5,'Хорхе Сампаоли',5,5,'1960-03-13 00:00:00'),(6,'Фернандо Йерро',6,6,'1968-03-23 00:00:00'),(7,'Младен Крстаич',7,8,'1974-03-04 00:00:00'),(8,'Аденор Леонардо Бакши',8,9,'1961-05-25 00:00:00'),(9,'Дидье Дешам',9,12,'1968-10-15 00:00:00'),(10,'Эрнан Дарио Гомес',10,14,'1956-02-03 00:00:00');
/*!40000 ALTER TABLE `coaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `soccer_region` enum('UEFA','AFC','CAF','OFC','CONCACAF','CONMEBOL') DEFAULT 'UEFA',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'Россия','UEFA'),(2,'Египет','CAF'),(3,'Уругвай','CONMEBOL'),(4,'Саудовская Аравия','AFC'),(5,'Аргентина','CONMEBOL'),(6,'Испания','UEFA'),(7,'Нидерланды','UEFA'),(8,'Сербия','UEFA'),(9,'Бразилия','CONMEBOL'),(10,'Парагвай','CONMEBOL'),(11,'Турция','UEFA'),(12,'Франция','UEFA'),(13,'Панама','CONCACAF'),(14,'Колумбия','CONMEBOL');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_events`
--

DROP TABLE IF EXISTS `game_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_events` (
  `game_id` bigint unsigned NOT NULL,
  `player_id` bigint unsigned NOT NULL,
  `minute_of_event` int DEFAULT NULL,
  `event` enum('yellow card','red card','second yellow card','goal','replace','penalty') DEFAULT 'yellow card',
  `assist_or_replace` bigint unsigned DEFAULT NULL,
  KEY `game_id` (`game_id`),
  KEY `player_id` (`player_id`),
  KEY `assist_or_replace` (`assist_or_replace`),
  CONSTRAINT `game_events_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`),
  CONSTRAINT `game_events_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`),
  CONSTRAINT `game_events_ibfk_3` FOREIGN KEY (`assist_or_replace`) REFERENCES `players` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_events`
--

LOCK TABLES `game_events` WRITE;
/*!40000 ALTER TABLE `game_events` DISABLE KEYS */;
INSERT INTO `game_events` VALUES (1,4,12,'goal',1),(1,4,24,'replace',3),(1,3,43,'goal',1),(1,2,71,'goal',1),(1,3,91,'goal',2),(1,1,94,'goal',NULL),(1,5,60,'replace',NULL),(2,4,68,'replace',3);
/*!40000 ALTER TABLE `game_events` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`roman`@`localhost`*/ /*!50003 TRIGGER `check_replace` BEFORE INSERT ON `game_events` FOR EACH ROW BEGIN
	IF (NEW.event = 'replace' AND NEW.assist_or_replace IS NULL) THEN
    	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Need to fill field "assist_or_replace"';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `game_places`
--

DROP TABLE IF EXISTS `game_places`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_places` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `city` varchar(100) NOT NULL,
  `stadium` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_places`
--

LOCK TABLES `game_places` WRITE;
/*!40000 ALTER TABLE `game_places` DISABLE KEYS */;
INSERT INTO `game_places` VALUES (1,'Москва','Лужники'),(2,'Калининград','Калининград'),(3,'Санкт-Петербург','Санкт-Петербург'),(4,'Нижний Новгород','Нижний Новгород'),(5,'Волгоград','Волгоград Арена'),(6,'Казань','Казань Арена'),(7,'Самара','Самара Арена'),(8,'Саранск','Мордовия Арена'),(9,'Ростов-на-Дону','Ростов Арена'),(10,'Сочи','Фишт'),(11,'Екатеринбург','Екатеринбург Арена'),(12,'Москва','Спартак');
/*!40000 ALTER TABLE `game_places` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_staffs`
--

DROP TABLE IF EXISTS `game_staffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_staffs` (
  `referee_id` bigint unsigned NOT NULL,
  `game_id` bigint unsigned NOT NULL,
  `referee_role` enum('main_referee','assistant','reserve_referee') DEFAULT 'assistant',
  KEY `referee_id` (`referee_id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `game_staffs_ibfk_1` FOREIGN KEY (`referee_id`) REFERENCES `referees` (`id`),
  CONSTRAINT `game_staffs_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_staffs`
--

LOCK TABLES `game_staffs` WRITE;
/*!40000 ALTER TABLE `game_staffs` DISABLE KEYS */;
INSERT INTO `game_staffs` VALUES (1,1,'main_referee'),(2,1,'assistant'),(3,1,'assistant'),(4,1,'reserve_referee'),(5,2,'main_referee'),(6,2,'assistant'),(7,2,'assistant'),(8,2,'reserve_referee');
/*!40000 ALTER TABLE `game_staffs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `games` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `team1_id` bigint unsigned NOT NULL,
  `team2_id` bigint unsigned NOT NULL,
  `game_date` datetime DEFAULT NULL,
  `game_place_id` bigint unsigned NOT NULL,
  `stage` enum('group','1/8','1/4','semifinals','final') DEFAULT 'group',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `team1_id` (`team1_id`),
  KEY `team2_id` (`team2_id`),
  KEY `game_place_id` (`game_place_id`),
  CONSTRAINT `games_ibfk_1` FOREIGN KEY (`team1_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `games_ibfk_2` FOREIGN KEY (`team2_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `games_ibfk_3` FOREIGN KEY (`game_place_id`) REFERENCES `game_places` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games`
--

LOCK TABLES `games` WRITE;
/*!40000 ALTER TABLE `games` DISABLE KEYS */;
INSERT INTO `games` VALUES (1,1,4,'2018-06-14 18:00:00',1,'group'),(2,2,3,'2018-06-15 17:00:00',11,'group'),(3,1,2,'2018-06-19 21:00:00',3,'group'),(4,3,4,'2018-06-20 18:00:00',9,'group'),(5,3,1,'2018-06-25 18:00:00',7,'group'),(6,4,2,'2018-06-25 17:00:00',5,'group'),(7,6,1,'2018-07-01 17:00:00',1,'1/8');
/*!40000 ALTER TABLE `games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_on_game`
--

DROP TABLE IF EXISTS `player_on_game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_on_game` (
  `player_id` bigint unsigned NOT NULL,
  `game_id` bigint unsigned NOT NULL,
  KEY `player_id` (`player_id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `player_on_game_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`),
  CONSTRAINT `player_on_game_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_on_game`
--

LOCK TABLES `player_on_game` WRITE;
/*!40000 ALTER TABLE `player_on_game` DISABLE KEYS */;
INSERT INTO `player_on_game` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(1,5),(2,5),(3,5),(9,5),(10,5);
/*!40000 ALTER TABLE `player_on_game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `players` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `fullname` varchar(255) NOT NULL,
  `team_id` bigint unsigned NOT NULL,
  `tshirt_number` int DEFAULT NULL,
  `amplua` enum('CG','DF','MF','FW') DEFAULT 'MF',
  `birthday` datetime DEFAULT NULL,
  `club_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `team_id` (`team_id`),
  KEY `player_on_club` (`club_id`),
  CONSTRAINT `player_on_club` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`id`),
  CONSTRAINT `players_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` VALUES (1,'Александр Головин',1,17,'MF','1996-05-30 00:00:00',1),(2,'Артём Дзюба',1,22,'FW','1988-08-22 00:00:00',4),(3,'Денис Черышев',1,6,'MF','1990-12-26 00:00:00',2),(4,'Юрий Газинский',1,8,'MF','1989-07-20 00:00:00',3),(5,'Фахад аль-Муваллад',4,19,'FW','1994-09-14 00:00:00',5),(6,'Салим аль-Давсари',4,18,'MF','1991-08-19 00:00:00',2),(7,'Диего Годин',3,3,'DF','1986-02-16 00:00:00',6),(8,'Джорджиан Де Арраскаэта',3,10,'MF','1994-06-01 00:00:00',10),(9,'Эдинсон Кавани',3,21,'FW','1987-02-14 00:00:00',9),(10,'Найтан Нандес',3,8,'MF','1995-12-28 00:00:00',8);
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `players_from_cl_2018`
--

DROP TABLE IF EXISTS `players_from_cl_2018`;
/*!50001 DROP VIEW IF EXISTS `players_from_cl_2018`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `players_from_cl_2018` AS SELECT 
 1 AS `name`,
 1 AS `players_on_league`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `referees`
--

DROP TABLE IF EXISTS `referees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referees` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `fullname` varchar(255) NOT NULL,
  `country_id` bigint unsigned DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `referees_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referees`
--

LOCK TABLES `referees` WRITE;
/*!40000 ALTER TABLE `referees` DISABLE KEYS */;
INSERT INTO `referees` VALUES (1,'Нестор Питана',5,'1975-07-17 00:00:00'),(2,'Эрнан Майдана',5,'1972-02-14 00:00:00'),(3,'Хуан Пабло Белатти',5,'1979-04-15 00:00:00'),(4,'Сандро Риччи',9,'1974-11-19 00:00:00'),(5,'Бьерн Кёйперс',7,'1973-03-28 00:00:00'),(6,'Сандер ван Рукель',7,'1974-03-28 00:00:00'),(7,'Эрвин Зейнстра',7,'1977-01-31 00:00:00'),(8,'Милорад Мажич',8,'1973-03-23 00:00:00');
/*!40000 ALTER TABLE `referees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teams` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `country_id` bigint unsigned NOT NULL,
  `letter_group` enum('A','B','C','D','E','F','G','H') DEFAULT 'A',
  `basecamp_id` bigint unsigned DEFAULT NULL,
  `year_of_world_cup` int NOT NULL,
  `is_host_country` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `country_id` (`country_id`),
  KEY `team_on_basecamp` (`basecamp_id`),
  CONSTRAINT `team_on_basecamp` FOREIGN KEY (`basecamp_id`) REFERENCES `basecamps` (`id`),
  CONSTRAINT `teams_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`),
  CONSTRAINT `teams_chk_1` CHECK ((`year_of_world_cup` > 1930))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
INSERT INTO `teams` VALUES (1,1,'A',9,2018,_binary ''),(2,2,'A',24,2018,_binary '\0'),(3,3,'A',12,2018,_binary '\0'),(4,4,'A',2,2018,_binary '\0'),(5,5,'D',22,2018,_binary '\0'),(6,6,'B',20,2018,_binary '\0'),(7,8,'E',10,2018,_binary '\0'),(8,9,'E',5,2018,_binary '\0'),(9,12,'C',13,2018,_binary '\0'),(10,13,'G',7,2018,_binary '\0');
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `teams_2018`
--

DROP TABLE IF EXISTS `teams_2018`;
/*!50001 DROP VIEW IF EXISTS `teams_2018`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `teams_2018` AS SELECT 
 1 AS `name`,
 1 AS `letter_group`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `players_from_cl_2018`
--

/*!50001 DROP VIEW IF EXISTS `players_from_cl_2018`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`roman`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `players_from_cl_2018` AS select `c2`.`name` AS `name`,count(0) AS `players_on_league` from (((`players` `p` join `teams` `t` on((`t`.`id` = `p`.`team_id`))) join `clubs` `c1` on((`c1`.`id` = `p`.`club_id`))) join `countries` `c2` on((`c2`.`id` = `c1`.`country_id`))) where (`t`.`year_of_world_cup` = 2018) group by `c2`.`name` order by `players_on_league` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `teams_2018`
--

/*!50001 DROP VIEW IF EXISTS `teams_2018`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`roman`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `teams_2018` AS select `c`.`name` AS `name`,`t`.`letter_group` AS `letter_group` from (`teams` `t` join `countries` `c` on((`c`.`id` = `t`.`country_id`))) where (`t`.`year_of_world_cup` = 2018) order by `t`.`letter_group` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-26 19:02:49
