-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 30, 2024 at 01:24 AM
-- Server version: 8.0.31
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chhann_nimith`
--

-- --------------------------------------------------------

--
-- Table structure for table `tblproduct`
--

DROP TABLE IF EXISTS `tblproduct`;
CREATE TABLE IF NOT EXISTS `tblproduct` (
  `ProductID` int NOT NULL AUTO_INCREMENT,
  `ProductName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `Description` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `CategoryID` int NOT NULL,
  `Barcode` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `ExpiredDate` date DEFAULT NULL,
  `Qty` int NOT NULL,
  `UnitPriceIn` double NOT NULL,
  `UnitPriceOut` double NOT NULL,
  `ProductImage` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'default.png',
  `isDeleted` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ProductID`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tblproduct`
--

INSERT INTO `tblproduct` (`ProductID`, `ProductName`, `Description`, `CategoryID`, `Barcode`, `ExpiredDate`, `Qty`, `UnitPriceIn`, `UnitPriceOut`, `ProductImage`, `isDeleted`) VALUES
(1, 'coca', 'drink', 1, '012', '2025-12-12', 1, 1500, 2500, 'default.png', 0),
(3, 'Sting', 'drink', 1, '099', '2025-12-12', 1, 1500, 2500, 'default.png', 0),
(4, 'Fanta', 'drink', 1, '089', '2025-12-12', 1, 1500, 2500, 'default.png', 0),
(5, 'Pepsi', 'drink', 1, '079', '2025-12-12', 1, 1500, 2500, 'default.png', 0),
(6, 'Nike007', 'shoe', 3, 'S001', '2025-12-01', 1, 500000, 700000, 'default.png', 0),
(7, 'Addidas', '', 3, 'S0125', '2025-12-01', 1, 500000, 750000, 'default.png', 0),
(8, 'Puma001', '', 5, 'S2014', '2025-12-01', 1, 1500, 2500, 'default.png', 0),
(9, 'Men Suit', '', 2, 'C2365', '2030-12-01', 1, 60000, 80000, 'default.png', 0);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
