-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.11-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for redemrp
DROP DATABASE IF EXISTS `redemrp`;
CREATE DATABASE IF NOT EXISTS `redemrp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin */;
USE `redemrp`;

-- Dumping structure for table redemrp.characters
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
  `jobgrade` int(11) DEFAULT 0,
  `id` int(11) NOT NULL AUTO_INCREMENT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Data exporting was unselected.
ALTER TABLE `characters`
  ADD PRIMARY KEY (`id`);

-- Dumping structure for table redemrp.users
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

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
