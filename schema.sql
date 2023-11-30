CREATE DATABASE  IF NOT EXISTS `cs336db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cs336db`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: cs336db
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customeraccount`
--

DROP TABLE IF EXISTS `customeraccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customeraccount` (
  `username` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  PRIMARY KEY (`username`),
  INDEX idx_firstName (`firstName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customeraccount`
--

LOCK TABLES `customeraccount` WRITE;
/*!40000 ALTER TABLE `customeraccount` DISABLE KEYS */;
INSERT INTO `customeraccount` VALUES ('','','',''),(',,.',',.',',.',',.,'),('.,','','',''),('tochu','tochu\'sPassword','Tommy','Chu'),('tochu2','tochu2','tochu2','tochu2'),('toushei','toushei\'sPassword','Tommy','Chu');
/*!40000 ALTER TABLE `customeraccount` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Table structure for table `flightTicket`
--

DROP TABLE IF EXISTS `flightTicket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flightTicket` (
  `totalFare` float NOT NULL,
  `ticketID` varchar(20) NOT NULL,
  `class` varchar(20) NOT NULL,
  `changeFee` float NOT NULL,
  `bookingFee` float NOT NULL,
  `seatNumber` varchar(3) NOT NULL,
  `passenger` varchar(50) NOT NULL,
  `purchaseDateTime` DATE NOT NULL,
  PRIMARY KEY (`ticketID`),
  CONSTRAINT `fk_flightTicket_customeraccount` FOREIGN KEY (`passenger`) REFERENCES `customeraccount` (`firstName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flightTicket`
--

LOCK TABLES `flightTicket` WRITE;
/*!40000 ALTER TABLE `flightTicket` DISABLE KEYS */;
INSERT INTO `flightTicket` VALUES (100,'A12390','Economy',10, 20,'A12',10,'2023-11-30');
/*!40000 ALTER TABLE `flightTicket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airports`
--

DROP TABLE IF EXISTS `airports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airports` (
  `airportID` varchar(20) NOT NULL,
  PRIMARY KEY (`airportID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airports`
--

LOCK TABLES `airports` WRITE;
/*!40000 ALTER TABLE `airports` DISABLE KEYS */;
INSERT INTO `airports` VALUES ('A10293');
/*!40000 ALTER TABLE `airports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airline`
--

DROP TABLE IF EXISTS `airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airline` (
  `alineID` varchar(20) NOT NULL,
  PRIMARY KEY (`alineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airline`
--

LOCK TABLES `airline` WRITE;
/*!40000 ALTER TABLE `airline` DISABLE KEYS */;
INSERT INTO `airline` VALUES ('B123123');
/*!40000 ALTER TABLE `airline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operatesAt`
--

DROP TABLE IF EXISTS `operatesAt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operatesAt` (
  `airportID` varchar(20) NOT NULL,
  `alineID` varchar(20) NOT NULL,
  PRIMARY KEY (`airportID`, `alineID`),
  CONSTRAINT `fk_operatesAt_airports` FOREIGN KEY (`airportID`) REFERENCES `airports` (`airportID`),
  CONSTRAINT `fk_operatesAt_airline` FOREIGN KEY (`alineID`) REFERENCES `airline` (`alineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operatesAt`
--

LOCK TABLES `operatesAt` WRITE;
/*!40000 ALTER TABLE `operatesAt` DISABLE KEYS */;
INSERT INTO `operatesAt` VALUES ('A10293', 'B123123');
/*!40000 ALTER TABLE `operatesAt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aircraft`
--

DROP TABLE IF EXISTS `aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aircraft` (
  `acraftID` varchar(20) NOT NULL,
  `daysOfTheWeek` varchar(20) NOT NULL,
  `numOfSeats` INTEGER NOT NULL,
  `alineID` varchar(20) NOT NULL,
  PRIMARY KEY (`acraftID`, `alineID`),
  CONSTRAINT `fk_aircraft_airline` FOREIGN KEY (`alineID`) REFERENCES `airline` (`alineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft`
--

LOCK TABLES `aircraft` WRITE;
/*!40000 ALTER TABLE `aircraft` DISABLE KEYS */;
INSERT INTO `aircraft` VALUES ('B12', 'H299', 299, 'H299');
/*!40000 ALTER TABLE `aircraft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `domestic/international` varchar(20) NOT NULL,
  `flightNumber` varchar(20) NOT NULL,
  `departedFrom` varchar(20) NOT NULL,
  `departureTime` DATE NOT NULL,
  `arrivalDestination` varchar(20) NOT NULL,
  `arrivalTime` DATE NOT NULL,
  `operatedBy` varchar(20) NOT NULL,
  `flownBy` varchar(20) NOT NULL,
  PRIMARY KEY (`flightNumber`, `operatedBy`),
  CONSTRAINT `fk_flight_airport` FOREIGN KEY (`departedFrom`) REFERENCES `airport` (`airportID`),
  CONSTRAINT `fk_flight_airport_AD` FOREIGN KEY (`arrivalDestination`) REFERENCES `airport` (`airportID`),
  CONSTRAINT `fk_flight_airline` FOREIGN KEY (`operatedBy`) REFERENCES `airline` (`alineID`),
  CONSTRAINT `fk_flight_aircraft` FOREIGN KEY (`flownBy`) REFERENCES `aircraft` (`acraftID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES ('International', 'B123123', 'DepartureCity', '2023-11-30', 'ArrivalCity', '2023-12-01', 'OperatedAirline', 'FlownAircraft');
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uses`
--

DROP TABLE IF EXISTS `uses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uses` (
  `flightNumber` varchar(20) NOT NULL,
  `ticketID` varchar(20) NOT NULL,
  PRIMARY KEY (`flightNumber`, `ticketID`),
  CONSTRAINT `fk_uses_flight` FOREIGN KEY (`flightNumber`) REFERENCES `flight` (`flightNumber`),
  CONSTRAINT `fk_uses_flightTicket` FOREIGN KEY (`ticketID`) REFERENCES `flightTicket` (`ticketID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uses`
--

LOCK TABLES `uses` WRITE;
/*!40000 ALTER TABLE `uses` DISABLE KEYS */;
INSERT INTO `uses` VALUES ('B123123', 'V123431');
/*!40000 ALTER TABLE `uses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inWaitingList`
--

DROP TABLE IF EXISTS `inWaitingList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inWaitingList` (
  `flightNumber` varchar(20) NOT NULL,
  `alineID` varchar(20) NOT NULL,
  `IDnumber` varchar(50) NOT NULL,
  PRIMARY KEY (`flightNumber`, `alineID`, `IDnumber`),
  CONSTRAINT `fk_inWaitingList_flight` FOREIGN KEY (`flightNumber`) REFERENCES `flight` (`flightNumber`),
  CONSTRAINT `fk_inWaitingList_airline` FOREIGN KEY (`alineID`) REFERENCES `airline` (`alineID`),
  CONSTRAINT `fk_inWaitingList_customeraccount` FOREIGN KEY (`IDnumber`) REFERENCES `customeraccount` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inWaitingList`
--

LOCK TABLES `inWaitingList` WRITE;
/*!40000 ALTER TABLE `inWaitingList` DISABLE KEYS */;
INSERT INTO `inWaitingList` VALUES ('B123123', 'V123431', 'G123');
/*!40000 ALTER TABLE `inWaitingList` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Questions`
--

DROP TABLE IF EXISTS `Questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Questions` (
  `QID` INTEGER NOT NULL,
  `questionText` TEXT NOT NULL,
  `reply` TEXT NOT NULL,
  `customerID` varchar(50) NOT NULL,
  PRIMARY KEY (`QID`, `customerID`),
  CONSTRAINT `fk_Questions_customeraccount` FOREIGN KEY (`customerID`) REFERENCES `customeraccount` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Questions`
--

LOCK TABLES `Questions` WRITE;
/*!40000 ALTER TABLE `Questions` DISABLE KEYS */;
INSERT INTO `Questions` VALUES ('123', 'hello my son', 'goodbye my son', 'father2');
/*!40000 ALTER TABLE `Questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CustomerRep`
--

DROP TABLE IF EXISTS `CustomerRep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CustomerRep` (
  `repID` INTEGER NOT NULL,
  PRIMARY KEY (`repID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerRep`
--

LOCK TABLES `CustomerRep` WRITE;
/*!40000 ALTER TABLE `CustomerRep` DISABLE KEYS */;
INSERT INTO `CustomerRep` VALUES ('1234');
/*!40000 ALTER TABLE `CustomerRep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answeredBy`
--

DROP TABLE IF EXISTS `answeredBy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answeredBy` (
  `repID` INTEGER NOT NULL,
  `QID` INTEGER NOT NULL,
  PRIMARY KEY (`repID`, `QID`),
  CONSTRAINT `fk_answeredBy_CustomerRep` FOREIGN KEY (`repID`) REFERENCES `CustomerRep` (`repID`),
  CONSTRAINT `fk_answeredBy_Questions` FOREIGN KEY (`QID`) REFERENCES `Questions` (`QID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answeredBy`
--

LOCK TABLES `answeredBy` WRITE;
/*!40000 ALTER TABLE `answeredBy` DISABLE KEYS */;
INSERT INTO `answeredBy` VALUES ('1234', '56');
/*!40000 ALTER TABLE `answeredBy` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

