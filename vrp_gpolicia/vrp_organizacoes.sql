-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.11-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table reactive.vrp_organizacoes
CREATE TABLE IF NOT EXISTS `vrp_organizacoes` (
  `user_id` int(11) DEFAULT NULL,
  `banco` int(11) NOT NULL DEFAULT 0,
  `glock` int(11) NOT NULL DEFAULT 0,
  `sigsauer` int(100) NOT NULL DEFAULT 0,
  `mp5` int(100) NOT NULL DEFAULT 0,
  `remington` int(100) NOT NULL DEFAULT 0,
  `fall` int(100) NOT NULL DEFAULT 0,
  `m4a1` int(100) NOT NULL DEFAULT 0,
  `organizacao` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table reactive.vrp_organizacoes: ~2 rows (approximately)
/*!40000 ALTER TABLE `vrp_organizacoes` DISABLE KEYS */;
INSERT INTO `vrp_organizacoes` (`user_id`, `banco`, `glock`, `sigsauer`, `mp5`, `remington`, `fall`, `m4a1`, `organizacao`) VALUES
	(0, 0, 0, 0, 0, 0, 0, 0, 'lspd'),
	(0, 0, 0, 0, 0, 0, 0, 0, 'lssd');
/*!40000 ALTER TABLE `vrp_organizacoes` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
