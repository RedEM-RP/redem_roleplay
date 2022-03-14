DROP DATABASE IF EXISTS `redemrp_gamemode`;
CREATE DATABASE IF NOT EXISTS `redemrp_gamemode`;
USE `redemrp_gamemode`;

-- --------------------------------------------------------

DROP TABLE IF EXISTS `characters`;
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `characterid` int(11) DEFAULT '0',
  `money` int(11) DEFAULT '0',
  `gold` int(11) DEFAULT '0',
  `xp` int(11) DEFAULT '0',
  `level` int(11) DEFAULT '0',
  `job` varchar(50) COLLATE utf8mb4_bin DEFAULT 'unemployed',
  `firstname` varchar(50) COLLATE utf8mb4_bin DEFAULT 'first',
  `lastname` varchar(50) COLLATE utf8mb4_bin DEFAULT 'last',
  `jobgrade` int(11) DEFAULT '0',
  `coords` varchar(200) COLLATE utf8mb4_bin DEFAULT '{}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

DROP TABLE IF EXISTS `users`;
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

-- --------------------------------------------------------

DROP TABLE IF EXISTS `version`;
CREATE TABLE IF NOT EXISTS `version` (
  `id` int(11) NOT NULL,
  `current` varchar(3) COLLATE utf8mb4_bin DEFAULT 'no',
  `resource` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

DROP TABLE IF EXISTS `web_permissions`;
CREATE TABLE IF NOT EXISTS `web_permissions` (
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
