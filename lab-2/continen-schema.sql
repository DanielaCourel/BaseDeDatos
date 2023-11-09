USE `world`;
DROP TABLE IF EXISTS `countrylanguage`;
CREATE TABLE continent (
	`Name` char(30) NOT NULL DEFAULT '',
	`Area` int NOT NULL DEFAULT '0',
	`PercentageLandArea` decimal NOT NULL DEFAULT '0.00',
	`PopulousCity` int NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (`Name`),
	CONSTRAINT `continent_ibfk_1` FOREIGN KEY (`PopulousCity`) REFERENCES `city` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
