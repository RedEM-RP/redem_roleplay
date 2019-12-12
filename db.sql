-- Dumping database structure for xrp
CREATE DATABASE IF NOT EXISTS `xrp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin */;
USE `xrp`;

-- Dumping structure for table xrp.users
CREATE TABLE `users` (
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `money` int(11) DEFAULT NULL,
  `gold` int(11) DEFAULT NULL,
  `group` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `firstname` varchar(12) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'noname',
  `lastname` varchar(12) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'noname',
  `xp` int(11) NOT NULL DEFAULT '1',
  `level` int(11) NOT NULL DEFAULT '1',
  `job` varchar(25) COLLATE utf8mb4_bin NOT NULL DEFAULT 'unemployed',
  `jobgrade` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;