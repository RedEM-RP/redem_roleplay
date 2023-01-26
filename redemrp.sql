-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE `characters` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `characterid` int(11) DEFAULT 0,
  `citizenid` varchar(10) COLLATE utf8mb4_bin NOT NULL,
  `money` int(11) DEFAULT 200,
  `bank` int(11) DEFAULT 0,
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

-- --------------------------------------------------------

--
-- Table structure for table `clothes`
--

CREATE TABLE `clothes` (
  `id` int(11) NOT NULL,
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `clothes` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `outfits`
--

CREATE TABLE `outfits` (
  `id` int(11) NOT NULL,
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `clothes` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `skins`
--

CREATE TABLE `skins` (
  `id` int(11) NOT NULL,
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `skin` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stashes`
--

CREATE TABLE `stashes` (
  `id` int(11) NOT NULL,
  `stashid` text NOT NULL,
  `items` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_inventory`
--

CREATE TABLE `user_inventory` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `charid` int(11) NOT NULL,
  `items` varchar(16000) COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clothes`
--
ALTER TABLE `clothes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `outfits`
--
ALTER TABLE `outfits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `skins`
--
ALTER TABLE `skins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stashes`
--
ALTER TABLE `stashes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_inventory`
--
ALTER TABLE `user_inventory`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clothes`
--
ALTER TABLE `clothes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `outfits`
--
ALTER TABLE `outfits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `skins`
--
ALTER TABLE `skins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stashes`
--
ALTER TABLE `stashes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_inventory`
--
ALTER TABLE `user_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;
