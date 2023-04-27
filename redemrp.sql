CREATE TABLE `characters` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `characterid` int(11) DEFAULT 0,
  `citizenid` varchar(10) COLLATE utf8mb4_bin NOT NULL,
  `money` double(11,2) DEFAULT 0.00,
  `bank` double(11,2) DEFAULT 0.00,
  `job` varchar(50) COLLATE utf8mb4_bin DEFAULT 'unemployed',
  `firstname` varchar(50) COLLATE utf8mb4_bin DEFAULT 'first',
  `lastname` varchar(50) COLLATE utf8mb4_bin DEFAULT 'last',
  `jobgrade` int(11) DEFAULT 0,
  `gang` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'none',
  `ganggrade` int(11) NOT NULL DEFAULT 0,
  `coords` varchar(200) COLLATE utf8mb4_bin DEFAULT '{}',
  `pobox` int(11) NOT NULL,
  `jailed` int(11) NOT NULL DEFAULT 0,
  `metadata` varchar(512) COLLATE utf8mb4_bin NOT NULL DEFAULT '''[]'''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE `clothes` (
  `id` int(11) NOT NULL,
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `clothes` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `outfits` (
  `id` int(11) NOT NULL,
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `clothes` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `skins` (
  `id` int(11) NOT NULL,
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `skin` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `stashes` (
  `id` int(11) NOT NULL,
  `stashid` text NOT NULL,
  `items` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `user_inventory` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `charid` int(11) NOT NULL,
  `items` varchar(16000) COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `identifier` varchar(32) NOT NULL,
  `permissiongroup` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

ALTER TABLE `characters`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `clothes`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `outfits`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `skins`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `stashes`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `user_inventory`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `clothes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `outfits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `skins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `stashes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `user_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;
