USE `redemrp`;

ALTER TABLE `characters`
	ADD COLUMN `coords` VARCHAR(200) NULL DEFAULT '{}';