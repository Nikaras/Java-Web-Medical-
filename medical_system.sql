-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: medical_system
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fname` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `lname` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `hashed_pwd` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `salt` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('admin','Admin','Admin','A86B076215C83153A2E03A1CDDCDCF551729ADD2FF68A75B9851C04727EEADAD','41223502');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `doctor_username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `patient_username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `date` date NOT NULL,
  `hour` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('pending','completed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`doctor_username`,`patient_username`,`date`,`hour`),
  KEY `patient_username` (`patient_username`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`doctor_username`) REFERENCES `doctor` (`username`) ON DELETE CASCADE,
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`patient_username`) REFERENCES `patient` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES ('crln_cook_76','hnry_wheeler_89','2025-09-01','19:00-20:00','completed'),('crln_cook_76','hnry_wheeler_89','2025-09-04','8:00-9:00','pending'),('crln_cook_76','hnry_wheeler_89','2025-10-01','19:00-20:00','cancelled');
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `availability`
--

DROP TABLE IF EXISTS `availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `availability` (
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `date` date NOT NULL,
  `hours` set('8:00-9:00','9:00-10:00','10:00-11:00','11:00-12:00','12:00-13:00','13:00-14:00','14:00-15:00','15:00-16:00','16:00-17:00','17:00-18:00','18:00-19:00','19:00-20:00') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`username`,`date`),
  CONSTRAINT `availability_ibfk_1` FOREIGN KEY (`username`) REFERENCES `doctor` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `availability`
--

LOCK TABLES `availability` WRITE;
/*!40000 ALTER TABLE `availability` DISABLE KEYS */;
INSERT INTO `availability` VALUES ('crln_cook_76','2025-09-01','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-02','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-03','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-04','9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-05','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-06','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-07','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-08','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-09','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-10','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-11','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-12','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-13','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-14','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-15','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-16','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-17','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-18','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-19','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-20','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-21','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-22','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-23','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-24','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-25','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-26','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-27','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-28','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-29','8:00-9:00,9:00-10:00,10:00-11:00'),('crln_cook_76','2025-09-30','8:00-9:00,9:00-10:00,10:00-11:00');
/*!40000 ALTER TABLE `availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor` (
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fname` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `lname` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `speciality` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `hashed_pwd` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `salt` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` VALUES ('crln_cook_76','Carolyn','Cook','Pediatrician','9EFCFD0F81CA75E48D3B6BF91BEDD711A7EA6446EB9C4A1688CFABE70709A650','99369223');
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fname` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `lname` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `amka` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `hashed_pwd` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `salt` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `amka` (`amka`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES ('hnry_wheeler_89','Henry','Wheeler','16128957947','53237AC70FC45BC036DBDF40BA291B64C147728DD04F8EFCC4924FE10AF29C14','13669051');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-14 12:16:20
