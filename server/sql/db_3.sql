USE `redemrp`;

ALTER TABLE `version`
	ADD COLUMN `resource` varchar(50),
    DROP PRIMARY KEY;