DROP DATABASE IF EXISTS `redemrp`;
CREATE DATABASE IF NOT EXISTS `redemrp`;
USE `redemrp`;

CREATE TABLE IF NOT EXISTS `version` (
  `id` int(11) NOT NULL,
  `current` varchar(3) COLLATE utf8mb4_bin DEFAULT 'no',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `characters` (
  `identifier` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `characterid` int(11) DEFAULT 0,
  `money` int(11) DEFAULT 0,
  `gold` int(11) DEFAULT 0,
  `xp` int(11) DEFAULT 0,
  `level` int(11) DEFAULT 0,
  `job` varchar(50) COLLATE utf8mb4_bin DEFAULT 'unemployed',
  `firstname` varchar(50) COLLATE utf8mb4_bin DEFAULT 'first',
  `lastname` varchar(50) COLLATE utf8mb4_bin DEFAULT 'last',
  `jobgrade` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  `permission_level` int(11) DEFAULT NULL,
  `group` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
