-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2017 at 05:57 PM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pcgt`
--

-- --------------------------------------------------------

--
-- Table structure for table `binneddata`
--

CREATE TABLE `binneddata` (
  `speedbin` double DEFAULT NULL,
  `speedbinmin` double DEFAULT NULL,
  `speedbinmax` double DEFAULT NULL,
  `windspeedavg` double DEFAULT NULL,
  `poweravg` double DEFAULT NULL,
  `pitchavg` double DEFAULT NULL,
  `rpmavg` double DEFAULT NULL,
  `cpavg` double DEFAULT NULL,
  `turbulenceavg` double DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `stddev` double DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `binneddata`
--



-- --------------------------------------------------------

--
-- Table structure for table `inter1`
--

CREATE TABLE `inter1` (
  `binspeed` double DEFAULT NULL,
  `pdiff` double DEFAULT NULL,
  `wdiff` double DEFAULT NULL,
  `cvi` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inter1`
--



-- --------------------------------------------------------

--
-- Table structure for table `rawdata1`
--

CREATE TABLE `rawdata1` (
  `date` varchar(20) DEFAULT NULL,
  `time` varchar(20) DEFAULT NULL,
  `windspeed` double DEFAULT NULL,
  `windspeed_max` double DEFAULT NULL,
  `windspeed_min` double DEFAULT NULL,
  `windspeed_sig` double DEFAULT NULL,
  `winddirection` double DEFAULT NULL,
  `temperature` double DEFAULT NULL,
  `temperature_min` double DEFAULT NULL,
  `temperature_max` double DEFAULT NULL,
  `temperature_sd` double DEFAULT NULL,
  `humidity` double DEFAULT NULL,
  `pressure` double DEFAULT NULL,
  `pressure_max` double DEFAULT NULL,
  `pressure_min` double DEFAULT NULL,
  `pressure_sd` double DEFAULT NULL,
  `power` double DEFAULT NULL,
  `power_max` double DEFAULT NULL,
  `power_min` double DEFAULT NULL,
  `power_sd` double DEFAULT NULL,
  `manualstop` double DEFAULT NULL,
  `turbineavailibilty` double DEFAULT NULL,
  `gridavailibility` double DEFAULT NULL,
  `fault` double DEFAULT NULL,
  `rotorrpm` double DEFAULT NULL,
  `rotorrpm_max` double DEFAULT NULL,
  `rotorrpm_min` double DEFAULT NULL,
  `rotorrpm_sd` double DEFAULT NULL,
  `pitchangle` double DEFAULT NULL,
  `pitchangle_max` double DEFAULT NULL,
  `pitchangle_min` double DEFAULT NULL,
  `pitchangle_sd` double DEFAULT NULL,
  `frequency` double DEFAULT NULL,
  `frequency_max` double DEFAULT NULL,
  `frequency_min` double DEFAULT NULL,
  `frequency_sd` double DEFAULT NULL,
  `rain` double DEFAULT NULL,
  `upflowangle` double DEFAULT NULL,
  `extra1` double DEFAULT NULL,
  `extra2` double DEFAULT NULL,
  `extra3` double DEFAULT NULL,
  `extra4` double DEFAULT NULL,
  `extra5` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rawdata1`
--


-- --------------------------------------------------------

--
-- Table structure for table `rawdata2`
--

CREATE TABLE `rawdata2` (
  `date` varchar(255) DEFAULT NULL,
  `time` varchar(255) DEFAULT NULL,
  `windspeed` double DEFAULT NULL,
  `windspeed_max` double DEFAULT NULL,
  `windspeed_min` double DEFAULT NULL,
  `windspeed_sig` double DEFAULT NULL,
  `winddirection` double DEFAULT NULL,
  `temperature` double DEFAULT NULL,
  `temperature_max` double DEFAULT NULL,
  `temperature_min` double DEFAULT NULL,
  `temperature_sd` double DEFAULT NULL,
  `humidity` double DEFAULT NULL,
  `pressure` double DEFAULT NULL,
  `pressure_max` double DEFAULT NULL,
  `pressure_min` double DEFAULT NULL,
  `pressure_sd` double DEFAULT NULL,
  `power` double DEFAULT NULL,
  `power_max` double DEFAULT NULL,
  `power_min` double DEFAULT NULL,
  `power_sd` double DEFAULT NULL,
  `manualstop` double DEFAULT NULL,
  `turbineavailibility` double DEFAULT NULL,
  `gridavailibility` double DEFAULT NULL,
  `fault` double DEFAULT NULL,
  `rotorrpm` double DEFAULT NULL,
  `rotorrpm_max` double DEFAULT NULL,
  `rotorrpm_min` double DEFAULT NULL,
  `rotorrpm_sd` double DEFAULT NULL,
  `pitchangle` double DEFAULT NULL,
  `pitchangle_max` double DEFAULT NULL,
  `pitchangle_min` double DEFAULT NULL,
  `pitchangle_sd` double DEFAULT NULL,
  `frequency` double DEFAULT NULL,
  `frequency_max` double DEFAULT NULL,
  `frequency_min` double DEFAULT NULL,
  `frequency_sd` double DEFAULT NULL,
  `rain` double DEFAULT NULL,
  `upflowangle` double DEFAULT NULL,
  `extra1` double DEFAULT NULL,
  `extra2` double DEFAULT NULL,
  `extra3` double DEFAULT NULL,
  `extra4` double DEFAULT NULL,
  `extra5` double DEFAULT NULL,
  `cp` double DEFAULT NULL,
  `ti` double DEFAULT NULL,
  `rho` double DEFAULT NULL,
  `corrwindspeed` double DEFAULT NULL,
  `corrwindspeedmin` double DEFAULT NULL,
  `corrwindspeedmax` double DEFAULT NULL,
  `corrwindspeedsig` double DEFAULT NULL,
  `corrpressure` double DEFAULT NULL,
  `stddev` double NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rawdata2`
--


-- --------------------------------------------------------

--
-- Table structure for table `rawsitedetails`
--

CREATE TABLE `rawsitedetails` (
  `site_name` varchar(255) DEFAULT NULL,
  `from_date` varchar(255) DEFAULT NULL,
  `to_date` varchar(255) DEFAULT NULL,
  `test_turbine` varchar(255) DEFAULT NULL,
  `make` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `turbine_capacity` double DEFAULT NULL,
  `rotor_diameter` double DEFAULT NULL,
  `hub_height` double DEFAULT NULL,
  `test_turbine_location` double DEFAULT NULL,
  `reference_mast_location` double DEFAULT NULL,
  `presensorheight` double DEFAULT NULL,
  `turbinealtitude` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rawsitedetails`
--


-- --------------------------------------------------------

--
-- Table structure for table `result1`
--

CREATE TABLE `result1` (
  `binspeed` double DEFAULT NULL,
  `minspeedbin` double DEFAULT NULL,
  `maxspeedbin` double DEFAULT NULL,
  `windspeedresult` double DEFAULT NULL,
  `powerresult` double DEFAULT NULL,
  `countresult` double DEFAULT NULL,
  `unpowerbresult` double DEFAULT NULL,
  `unwindspeedbresult` double DEFAULT NULL,
  `untempbresult` double DEFAULT NULL,
  `unpressurebresult` double DEFAULT NULL,
  `combinedbunresult` double DEFAULT NULL,
  `unpoweraresult` double DEFAULT NULL,
  `uncertaintycombined` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `result1`
--


-- --------------------------------------------------------

--
-- Table structure for table `result2`
--

CREATE TABLE `result2` (
  `binspeed` double DEFAULT NULL,
  `stdpowerresult` double DEFAULT NULL,
  `measuredpowerresult` double DEFAULT NULL,
  `frequencyresult` double DEFAULT NULL,
  `combinedstduncertainty` double DEFAULT NULL,
  `actualenergyresult` double DEFAULT NULL,
  `estenergyresult` double DEFAULT NULL,
  `unenergyresult` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `result2`
--


-- --------------------------------------------------------

--
-- Table structure for table `result3`
--

CREATE TABLE `result3` (
  `GAE` double DEFAULT NULL,
  `TUE` double DEFAULT NULL,
  `GEE` double DEFAULT NULL,
  `UE` double DEFAULT NULL,
  `PP` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `result3`
--


-- --------------------------------------------------------

--
-- Table structure for table `staticfrequency`
--

CREATE TABLE `staticfrequency` (
  `statwindspeed2` double NOT NULL,
  `statfrequency2` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staticfrequency`
--


-- --------------------------------------------------------

--
-- Table structure for table `staticpower`
--

CREATE TABLE `staticpower` (
  `statwindspeed` double NOT NULL,
  `statpower` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staticpower`
--


-- --------------------------------------------------------

--
-- Table structure for table `uncertainty`
--

CREATE TABLE `uncertainty` (
  `Pn` double DEFAULT NULL,
  `Ucl` double DEFAULT NULL,
  `Uvl` double DEFAULT NULL,
  `Upl` double DEFAULT NULL,
  `Ud1` double DEFAULT NULL,
  `Pmr` double DEFAULT NULL,
  `Upt` double DEFAULT NULL,
  `Udp` double DEFAULT NULL,
  `Ud2` double DEFAULT NULL,
  `Vmr` double DEFAULT NULL,
  `Uac` double DEFAULT NULL,
  `Uf` double DEFAULT NULL,
  `k` double DEFAULT NULL,
  `Um` double NOT NULL,
  `Udv` double DEFAULT NULL,
  `Ud3` double DEFAULT NULL,
  `Tmr` double DEFAULT NULL,
  `Uts` double DEFAULT NULL,
  `Urt` double DEFAULT NULL,
  `Umot` double DEFAULT NULL,
  `Udt` double DEFAULT NULL,
  `Ud4` double DEFAULT NULL,
  `Prmr` double DEFAULT NULL,
  `Uprc` double DEFAULT NULL,
  `Umtpr` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `uncertainty`
--


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
