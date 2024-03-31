-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 07, 2022 at 03:46 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `exercise`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `ad_code` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`ad_code`) VALUES
('');

-- --------------------------------------------------------

--
-- Table structure for table `adress`
--

CREATE TABLE `adress` (
  `employee_em_code` int(11) NOT NULL,
  `strt_name` varchar(14) NOT NULL,
  `strt_num` int(11) NOT NULL,
  `city_name` varchar(20) NOT NULL,
  `zip_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `assembled_part`
--

CREATE TABLE `assembled_part` (
  `ap_code` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `assembled_part`
--

INSERT INTO `assembled_part` (`ap_code`) VALUES
('none');

-- --------------------------------------------------------

--
-- Table structure for table `batch`
--

CREATE TABLE `batch` (
  `b_num` int(11) NOT NULL,
  `arr_date` datetime NOT NULL,
  `cap` int(11) NOT NULL,
  `admin_ad_code` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `bin`
--

CREATE TABLE `bin` (
  `warehouse_wh_code` varchar(4) CHARACTER SET utf8 NOT NULL,
  `bin_code` varchar(10) NOT NULL,
  `capacity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `c_name` varchar(40) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `em_code` int(11) NOT NULL,
  `surname` varchar(10) NOT NULL,
  `fname` varchar(10) NOT NULL,
  `warehouse_wh_code` varchar(4) CHARACTER SET utf8 NOT NULL,
  `admin_ad_code` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `name`
--

CREATE TABLE `name` (
  `employee_em_code` int(11) NOT NULL,
  `name` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `order_id` varchar(40) CHARACTER SET utf8 NOT NULL,
  `order_date` datetime NOT NULL,
  `order_q` int(11) NOT NULL,
  `admin_ad_code` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `phone`
--

CREATE TABLE `phone` (
  `employee_em_code` int(11) NOT NULL,
  `num` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `product_part`
--

CREATE TABLE `product_part` (
  `p_code` varchar(10) NOT NULL,
  `bin_bin_code` varchar(10) NOT NULL,
  `batch_b_num` int(11) NOT NULL,
  `assembled_part_ap_code` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `warehouse`
--

CREATE TABLE `warehouse` (
  `company_c_name` varchar(40) CHARACTER SET utf8 NOT NULL,
  `wh_code` varchar(4) CHARACTER SET utf8 NOT NULL,
  `wcap` int(11) NOT NULL,
  `ext_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`ad_code`);

--
-- Indexes for table `adress`
--
ALTER TABLE `adress`
  ADD PRIMARY KEY (`employee_em_code`);

--
-- Indexes for table `assembled_part`
--
ALTER TABLE `assembled_part`
  ADD PRIMARY KEY (`ap_code`);

--
-- Indexes for table `batch`
--
ALTER TABLE `batch`
  ADD PRIMARY KEY (`b_num`),
  ADD KEY `batch_admin_fk` (`admin_ad_code`);

--
-- Indexes for table `bin`
--
ALTER TABLE `bin`
  ADD PRIMARY KEY (`bin_code`),
  ADD KEY `bin_warehouse_fk` (`warehouse_wh_code`);

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`c_name`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`em_code`),
  ADD KEY `employee_admin_fk` (`admin_ad_code`),
  ADD KEY `employee_warehouse_fk` (`warehouse_wh_code`);

--
-- Indexes for table `name`
--
ALTER TABLE `name`
  ADD PRIMARY KEY (`name`,`employee_em_code`),
  ADD KEY `name_employee_fk` (`employee_em_code`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `order_admin_fk` (`admin_ad_code`);

--
-- Indexes for table `phone`
--
ALTER TABLE `phone`
  ADD PRIMARY KEY (`employee_em_code`);

--
-- Indexes for table `product_part`
--
ALTER TABLE `product_part`
  ADD PRIMARY KEY (`p_code`),
  ADD KEY `product_part_assembled_part_fk` (`assembled_part_ap_code`),
  ADD KEY `product_part_batch_fk` (`batch_b_num`),
  ADD KEY `product_part_bin_fk` (`bin_bin_code`);

--
-- Indexes for table `warehouse`
--
ALTER TABLE `warehouse`
  ADD PRIMARY KEY (`wh_code`),
  ADD KEY `warehouse_company_fk` (`company_c_name`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `adress`
--
ALTER TABLE `adress`
  ADD CONSTRAINT `adress_employee_fk` FOREIGN KEY (`employee_em_code`) REFERENCES `employee` (`em_code`);

--
-- Constraints for table `batch`
--
ALTER TABLE `batch`
  ADD CONSTRAINT `batch_admin_fk` FOREIGN KEY (`admin_ad_code`) REFERENCES `admin` (`ad_code`);

--
-- Constraints for table `bin`
--
ALTER TABLE `bin`
  ADD CONSTRAINT `bin_warehouse_fk` FOREIGN KEY (`warehouse_wh_code`) REFERENCES `warehouse` (`wh_code`);

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_admin_fk` FOREIGN KEY (`admin_ad_code`) REFERENCES `admin` (`ad_code`),
  ADD CONSTRAINT `employee_warehouse_fk` FOREIGN KEY (`warehouse_wh_code`) REFERENCES `warehouse` (`wh_code`);

--
-- Constraints for table `name`
--
ALTER TABLE `name`
  ADD CONSTRAINT `name_employee_fk` FOREIGN KEY (`employee_em_code`) REFERENCES `employee` (`em_code`);

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_admin_fk` FOREIGN KEY (`admin_ad_code`) REFERENCES `admin` (`ad_code`);

--
-- Constraints for table `phone`
--
ALTER TABLE `phone`
  ADD CONSTRAINT `phone_employee_fk` FOREIGN KEY (`employee_em_code`) REFERENCES `employee` (`em_code`);

--
-- Constraints for table `product_part`
--
ALTER TABLE `product_part`
  ADD CONSTRAINT `product_part_assembled_part_fk` FOREIGN KEY (`assembled_part_ap_code`) REFERENCES `assembled_part` (`ap_code`),
  ADD CONSTRAINT `product_part_batch_fk` FOREIGN KEY (`batch_b_num`) REFERENCES `batch` (`b_num`),
  ADD CONSTRAINT `product_part_bin_fk` FOREIGN KEY (`bin_bin_code`) REFERENCES `bin` (`bin_code`);

--
-- Constraints for table `warehouse`
--
ALTER TABLE `warehouse`
  ADD CONSTRAINT `warehouse_company_fk` FOREIGN KEY (`company_c_name`) REFERENCES `company` (`c_name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
