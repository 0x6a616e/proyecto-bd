-- MariaDB dump 10.19  Distrib 10.5.16-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: arte_dental
-- ------------------------------------------------------
-- Server version	10.5.16-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ce_pac`
--

DROP TABLE IF EXISTS `ce_pac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_pac` (
  `pid` int(11) NOT NULL,
  `ceid` int(11) NOT NULL,
  PRIMARY KEY (`pid`,`ceid`),
  KEY `ceid` (`ceid`),
  CONSTRAINT `ce_pac_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `pacientes` (`pid`),
  CONSTRAINT `ce_pac_ibfk_2` FOREIGN KEY (`ceid`) REFERENCES `cuidados_especiales` (`ceid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ce_pac`
--

LOCK TABLES `ce_pac` WRITE;
/*!40000 ALTER TABLE `ce_pac` DISABLE KEYS */;
INSERT INTO `ce_pac` VALUES (2,2),(3,11),(7,9),(12,13),(15,10),(25,6),(35,1),(45,1),(65,8),(74,5);
/*!40000 ALTER TABLE `ce_pac` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citas`
--

DROP TABLE IF EXISTS `citas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `citas` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `eid` int(11) DEFAULT NULL,
  `serid` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `numero_sala` int(11) DEFAULT NULL,
  PRIMARY KEY (`cid`),
  KEY `pid` (`pid`),
  KEY `eid` (`eid`),
  KEY `serid` (`serid`),
  CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `pacientes` (`pid`),
  CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`eid`) REFERENCES `dentistas` (`eid`),
  CONSTRAINT `citas_ibfk_3` FOREIGN KEY (`serid`) REFERENCES `servicios` (`serid`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citas`
--

LOCK TABLES `citas` WRITE;
/*!40000 ALTER TABLE `citas` DISABLE KEYS */;
INSERT INTO `citas` VALUES (1,1,1,8,'2021-03-09','10:30:00',2),(2,1,2,8,'2021-04-03','09:30:00',5),(3,2,3,2,'2021-06-04','15:30:00',2),(4,1,3,4,'2021-06-23','08:30:00',1),(5,2,3,5,'2021-07-19','16:00:00',1),(6,3,4,8,'2021-07-23','12:30:00',3),(7,4,4,8,'2021-08-01','17:00:00',4),(8,5,5,8,'2021-08-10','13:00:00',4),(9,6,7,8,'2021-09-12','11:30:00',5),(10,7,9,8,'2021-09-22','10:30:00',3),(11,1,8,6,'2021-09-29','16:30:00',1),(12,3,4,7,'2021-10-01','09:30:00',1),(13,8,6,8,'2021-10-14','13:00:00',2),(14,2,10,6,'2021-10-20','10:30:00',5),(15,9,13,8,'2021-10-28','18:30:00',3),(16,9,13,5,'2021-11-12','16:00:00',4),(17,10,11,2,'2021-11-15','13:30:00',2),(18,1,1,6,'2021-11-22','13:30:00',4),(19,11,9,8,'2021-11-30','09:30:00',3),(20,12,15,8,'2021-12-04','09:30:00',3),(21,13,17,8,'2021-12-05','13:30:00',3),(22,5,5,7,'2021-12-05','08:00:00',3),(23,3,4,6,'2021-12-05','12:30:00',2),(24,6,7,7,'2021-12-05','14:30:00',3),(25,10,11,5,'2021-12-07','10:00:00',4),(26,11,9,6,'2021-12-26','10:00:00',2),(27,14,12,8,'2021-12-27','15:30:00',3),(28,15,14,8,'2021-12-26','08:30:00',1),(29,1,1,7,'2021-12-31','11:00:00',3),(30,7,9,6,'2022-01-02','10:00:00',4),(31,8,6,6,'2022-01-04','16:00:00',4),(32,1,1,2,'2022-01-05','17:30:00',2),(33,16,5,8,'2022-01-05','13:30:00',5),(34,17,7,8,'2022-01-09','18:30:00',5),(35,2,10,5,'2022-01-17','11:00:00',5),(36,18,18,3,'2022-01-21','08:30:00',4),(37,19,18,8,'2022-01-21','11:00:00',5),(38,20,16,8,'2022-01-23','11:30:00',4),(39,21,2,8,'2022-01-26','14:00:00',1),(40,15,14,5,'2022-02-06','15:00:00',1),(41,10,11,6,'2022-02-04','09:00:00',3),(42,3,4,7,'2022-02-09','17:30:00',3),(43,13,4,6,'2022-02-11','10:00:00',2),(44,7,9,7,'2022-02-13','09:30:00',1),(45,21,2,6,'2022-02-13','12:30:00',5),(46,22,9,8,'2022-02-22','08:00:00',5),(47,9,13,6,'2022-02-28','14:30:00',5),(48,23,9,8,'2022-03-01','10:30:00',3),(49,17,7,7,'2022-03-05','09:00:00',4),(50,24,6,8,'2022-03-06','13:30:00',1),(51,16,5,6,'2022-03-08','16:00:00',4),(52,25,15,8,'2022-03-12','10:30:00',2),(53,15,14,7,'2022-03-13','09:00:00',5),(54,1,1,3,'2022-03-18','10:00:00',4),(55,26,3,8,'2022-03-25','15:30:00',1),(56,27,20,2,'2022-03-25','16:00:00',3),(57,28,12,8,'2022-03-28','17:30:00',4),(58,1,1,7,'2022-04-01','09:30:00',2),(59,2,10,6,'2022-04-05','12:30:00',4),(60,3,4,6,'2022-04-06','12:00:00',4),(61,7,9,5,'2022-04-06','08:30:00',4),(62,29,18,8,'2022-04-07','10:30:00',2),(63,12,15,5,'2022-04-09','14:30:00',5),(64,13,4,6,'2022-04-10','12:00:00',2),(65,14,12,7,'2022-04-15','14:30:00',5),(66,30,14,8,'2022-04-17','14:30:00',4),(67,21,2,6,'2022-04-19','15:00:00',2),(68,27,20,5,'2022-04-28','14:00:00',2),(69,1,1,7,'2022-05-04','16:00:00',2),(70,3,4,6,'2022-05-06','08:30:00',4),(71,5,5,5,'2022-05-06','14:30:00',4),(72,7,9,7,'2022-05-09','10:00:00',2),(73,9,13,6,'2022-05-11','14:00:00',5),(74,11,9,7,'2022-05-12','09:00:00',4),(75,31,20,8,'2022-05-12','15:30:00',4),(76,32,6,8,'2022-05-20','08:30:00',2),(77,33,10,4,'2022-05-20','12:30:00',5),(78,34,7,3,'2022-05-22','15:30:00',3),(79,35,17,3,'2022-05-28','11:00:00',4),(80,36,2,2,'2022-05-26','17:30:00',2),(81,2,10,8,'2022-06-03','11:00:00',1),(82,4,14,5,'2022-06-05','15:00:00',5),(83,6,7,6,'2022-06-04','08:30:00',5),(84,8,6,7,'2022-06-08','14:00:00',2),(85,9,13,6,'2022-06-08','17:00:00',4),(86,10,11,5,'2022-06-16','11:30:00',2),(87,37,20,2,'2022-06-17','16:00:00',4),(88,38,19,3,'2022-06-21','11:00:00',2),(89,39,11,2,'2022-06-22','12:00:00',2),(90,40,5,4,'2022-06-22','17:30:00',2),(91,41,10,8,'2022-06-22','10:30:00',5),(92,42,9,8,'2022-06-23','08:30:00',4),(93,43,18,8,'2022-06-28','09:30:00',1),(94,44,13,8,'2022-06-30','15:00:00',2),(95,13,4,7,'2022-07-01','10:30:00',5),(96,15,14,3,'2022-07-03','16:30:00',5),(97,17,7,5,'2022-07-03','10:00:00',1),(98,19,18,6,'2022-07-04','08:00:00',5),(99,21,2,7,'2022-07-04','16:00:00',5),(100,45,2,8,'2022-07-05','12:00:00',4),(101,46,5,8,'2022-07-12','14:00:00',5),(102,47,17,8,'2022-07-16','18:00:00',3),(103,48,8,8,'2022-07-18','19:00:00',4),(104,49,13,8,'2022-07-19','18:00:00',5),(105,50,11,8,'2022-07-21','10:00:00',2),(106,51,10,8,'2022-07-22','09:00:00',3),(107,52,19,8,'2022-07-25','12:30:00',2),(108,53,9,3,'2022-07-28','10:00:00',4),(109,54,14,8,'2022-07-31','15:00:00',1),(110,12,15,6,'2022-08-06','15:30:00',2),(111,14,12,6,'2022-08-05','18:00:00',4),(112,16,5,5,'2022-08-12','16:00:00',4),(113,18,18,3,'2022-08-15','10:30:00',3),(114,20,16,7,'2022-08-14','17:00:00',2),(115,55,19,8,'2022-08-18','11:30:00',3),(116,56,2,8,'2022-08-19','15:00:00',2),(117,57,19,8,'2022-08-24','13:30:00',2),(118,58,11,8,'2022-08-26','11:30:00',5),(119,59,12,8,'2022-08-29','19:30:00',4),(120,20,16,5,'2022-09-04','11:00:00',3),(121,31,20,6,'2022-09-02','14:30:00',1),(122,60,5,8,'2022-09-04','09:30:00',3),(123,61,8,2,'2022-09-04','08:30:00',5),(124,62,3,3,'2022-09-07','10:00:00',2),(125,63,6,8,'2022-09-07','14:00:00',5),(126,64,9,2,'2022-09-11','09:00:00',4),(127,65,19,4,'2022-09-12','12:00:00',2),(128,66,14,8,'2022-09-18','14:00:00',2),(129,67,12,8,'2022-09-19','15:00:00',3),(130,68,11,8,'2022-09-30','08:30:00',2),(131,69,5,2,'2022-10-02','08:30:00',1),(132,44,13,6,'2022-10-04','16:30:00',1),(133,70,11,8,'2022-10-07','10:00:00',5),(134,13,4,7,'2022-10-12','17:00:00',3),(135,1,1,6,'2022-10-20','10:30:00',5),(136,63,12,3,'2022-10-20','16:00:00',4),(137,55,19,5,'2022-10-24','11:00:00',5),(138,71,19,8,'2022-10-26','13:30:00',4),(139,72,6,2,'2022-11-01','19:30:00',4),(140,35,17,8,'2022-10-29','18:00:00',2),(141,23,9,6,'2022-11-03','09:30:00',5),(142,2,10,8,'2022-11-04','12:30:00',5),(143,73,20,8,'2022-11-07','15:30:00',3),(144,44,13,6,'2022-11-14','18:00:00',2),(145,74,19,8,'2022-11-15','12:30:00',3),(146,47,17,3,'2022-11-19','12:30:00',5),(147,51,5,7,'2022-11-17','14:00:00',2),(148,75,14,2,'2022-11-20','16:00:00',4),(149,18,18,5,'2022-11-21','09:30:00',5),(150,21,2,4,'2022-11-21','16:00:00',3);
/*!40000 ALTER TABLE `citas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinicas`
--

DROP TABLE IF EXISTS `clinicas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clinicas` (
  `clid` int(11) NOT NULL AUTO_INCREMENT,
  `direccion` varchar(128) DEFAULT NULL,
  `nombre` varchar(64) DEFAULT NULL,
  `telefono` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`clid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinicas`
--

LOCK TABLES `clinicas` WRITE;
/*!40000 ALTER TABLE `clinicas` DISABLE KEYS */;
INSERT INTO `clinicas` VALUES (1,'Sucursal Santa Catarina C. José María Morelos 108, Col. Ixtlera, Santa Catarina, N. L.','Arte Dental','8118241906');
/*!40000 ALTER TABLE `clinicas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuidados_especiales`
--

DROP TABLE IF EXISTS `cuidados_especiales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuidados_especiales` (
  `ceid` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ceid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuidados_especiales`
--

LOCK TABLES `cuidados_especiales` WRITE;
/*!40000 ALTER TABLE `cuidados_especiales` DISABLE KEYS */;
INSERT INTO `cuidados_especiales` VALUES (1,'Alergia al polen, causa problemas como conjuntivitis, fiebre del heno o asma.'),(2,'Monitor cardíaco'),(3,'Ventiladores mecánicos para ayudar a la respiracion'),(4,'Anemia'),(5,'Gingivitis'),(6,'Caries'),(7,'Periodontitis'),(8,'Halitosis'),(9,'Aftas'),(10,'Herpes labial'),(11,'Cáncer Oral'),(12,'Ulcerals Bucales'),(13,'Erosión dental'),(14,'Sensibilidad dental'),(15,'Traumatismos dentales');
/*!40000 ALTER TABLE `cuidados_especiales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `den_clin`
--

DROP TABLE IF EXISTS `den_clin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `den_clin` (
  `clid` int(11) NOT NULL,
  `eid` int(11) NOT NULL,
  PRIMARY KEY (`clid`,`eid`),
  KEY `eid` (`eid`),
  CONSTRAINT `den_clin_ibfk_1` FOREIGN KEY (`clid`) REFERENCES `clinicas` (`clid`),
  CONSTRAINT `den_clin_ibfk_2` FOREIGN KEY (`eid`) REFERENCES `dentistas` (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `den_clin`
--

LOCK TABLES `den_clin` WRITE;
/*!40000 ALTER TABLE `den_clin` DISABLE KEYS */;
INSERT INTO `den_clin` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20);
/*!40000 ALTER TABLE `den_clin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `den_esp`
--

DROP TABLE IF EXISTS `den_esp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `den_esp` (
  `eid` int(11) NOT NULL,
  `espid` int(11) NOT NULL,
  PRIMARY KEY (`eid`,`espid`),
  KEY `espid` (`espid`),
  CONSTRAINT `den_esp_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `dentistas` (`eid`),
  CONSTRAINT `den_esp_ibfk_2` FOREIGN KEY (`espid`) REFERENCES `especialidades` (`espid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `den_esp`
--

LOCK TABLES `den_esp` WRITE;
/*!40000 ALTER TABLE `den_esp` DISABLE KEYS */;
INSERT INTO `den_esp` VALUES (1,8),(2,3),(5,2),(7,6),(8,2),(9,1),(10,6),(13,1),(13,6),(13,8),(14,8),(15,2),(18,7),(19,1),(20,5);
/*!40000 ALTER TABLE `den_esp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dentistas`
--

DROP TABLE IF EXISTS `dentistas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dentistas` (
  `eid` int(11) NOT NULL AUTO_INCREMENT,
  `rfc` varchar(16) DEFAULT NULL,
  `nombres` varchar(64) DEFAULT NULL,
  `apellidoP` varchar(32) DEFAULT NULL,
  `apellidoM` varchar(32) DEFAULT NULL,
  `direccion` varchar(128) DEFAULT NULL,
  `telefono` varchar(16) DEFAULT NULL,
  `cedula` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dentistas`
--

LOCK TABLES `dentistas` WRITE;
/*!40000 ALTER TABLE `dentistas` DISABLE KEYS */;
INSERT INTO `dentistas` VALUES (1,'658-88-4667','Gladi','Shee','Sagrott','7 Eggendart Alley','146-493-8068','19376676'),(2,'111-90-1591','Juliana','Leman','Toseland','16770 Bluejay Point','926-765-4753','09321250'),(3,'453-29-7421','Torrance','Temperley','Van T\'Hoog','65 Mccormick Circle','591-512-5095','36637849'),(4,'749-77-4694','Blakelee','Mahon','Stollwerck','287 Eastlawn Crossing','285-940-8564','67711899'),(5,'326-87-1706','Aaren','Kwietak','Casetti','0332 Corry Alley','942-540-2081','39815493'),(6,'166-07-7113','Babara','De Coursey','Sands','63 Center Parkway','950-367-8308','78834353'),(7,'612-02-7028','Vivi','Scones','McDade','1482 Truax Crossing','573-783-3393','33579614'),(8,'456-10-8191','Alex','Tathacott','Coetzee','4207 Mendota Road','106-649-7720','02711240'),(9,'584-47-7946','Albina','Selwin','Ryce','2 Derek Drive','311-213-8649','84989528'),(10,'847-50-4599','Vanya','Gieves','Hart','5 Stang Center','241-208-5458','11038953'),(11,'329-03-1808','Nat','MacDavitt','Lurner','20 Utah Court','944-117-3935','39949591'),(12,'341-91-7477','Hunfredo','Blakes','Toghill','2 Towne Place','553-835-8194','88302118'),(13,'168-50-0996','Deva','Wackett','Trenam','8 Nevada Terrace','139-319-4130','04506426'),(14,'175-16-2863','Pansie','Thomton','Gonzalo','721 Farragut Trail','155-261-7267','19682383'),(15,'352-13-9457','Earl','Sudell','Sier','9 Buena Vista Court','764-158-8760','20066245'),(16,'634-93-7251','Dru','Kinver','Wharrier','86305 Rigney Park','120-144-6021','23566312'),(17,'643-06-5398','Myca','Lobb','Keeble','93 Lindbergh Hill','482-869-5516','06415311'),(18,'205-28-6345','Basil','Mauser','Kidd','72 Pearson Park','993-779-4279','17845806'),(19,'788-87-2449','Dulce','Frediani','Seer','06 Badeau Point','679-264-4658','24500466'),(20,'286-95-6330','Kiersten','Winterburn','Sailor','2135 Forster Crossing','178-132-9526','63494665');
/*!40000 ALTER TABLE `dentistas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dentistas_estatus`
--

DROP TABLE IF EXISTS `dentistas_estatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dentistas_estatus` (
  `eid` int(11) NOT NULL,
  `fecha_contratacion` date NOT NULL,
  `estatus` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`eid`,`fecha_contratacion`),
  CONSTRAINT `dentistas_estatus_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `dentistas` (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dentistas_estatus`
--

LOCK TABLES `dentistas_estatus` WRITE;
/*!40000 ALTER TABLE `dentistas_estatus` DISABLE KEYS */;
INSERT INTO `dentistas_estatus` VALUES (1,'2021-03-04','Despedido'),(1,'2021-10-08','Activo'),(2,'2021-01-08','Despedido'),(2,'2021-12-25','Activo'),(3,'2021-03-28','Activo'),(4,'2021-02-13','Activo'),(5,'2021-11-25','Activo'),(6,'2021-01-16','Activo'),(7,'2021-05-25','Activo'),(8,'2021-12-17','Activo'),(9,'2021-09-17','Activo'),(10,'2021-11-29','Activo'),(11,'2021-06-27','Activo'),(12,'2021-05-07','Activo'),(13,'2021-09-16','Activo'),(14,'2021-05-09','Activo'),(15,'2021-12-24','Activo'),(16,'2021-03-20','Activo'),(17,'2021-06-12','Activo'),(18,'2021-07-31','Activo'),(19,'2021-03-09','Activo'),(20,'2021-11-16','Activo');
/*!40000 ALTER TABLE `dentistas_estatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `especialidades`
--

DROP TABLE IF EXISTS `especialidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `especialidades` (
  `espid` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(128) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  PRIMARY KEY (`espid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especialidades`
--

LOCK TABLES `especialidades` WRITE;
/*!40000 ALTER TABLE `especialidades` DISABLE KEYS */;
INSERT INTO `especialidades` VALUES (1,'Odontopediatra','Dentista especializado en atender niños'),(2,'Ortodoncista','Especialista en la alineación de dientes mediante alambres y aparatos dentales'),(3,'Periodoncista','Trata las enfermedades de las encías'),(4,'Endodoncista','Trata los problemas que afectan los nervios dentales'),(5,'Patólogos orales','Tratan las enfermedades orales en dientes y mandíbula'),(6,'Prostodoncistas','Reparan los dientes y huesos de la mandíbula'),(7,'Cirujano oral','Interviene quirúrjicamente para atacar enfermedades variadas'),(8,'Radiólogo oral','Se encarga del estudio e interpretación de las radigrafías para identificar enfermedades');
/*!40000 ALTER TABLE `especialidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horarios`
--

DROP TABLE IF EXISTS `horarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horarios` (
  `hid` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) DEFAULT NULL,
  `dia_semana` int(11) DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  `estatus` bit(1) DEFAULT NULL,
  PRIMARY KEY (`hid`),
  KEY `eid` (`eid`),
  CONSTRAINT `horarios_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `dentistas` (`eid`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horarios`
--

LOCK TABLES `horarios` WRITE;
/*!40000 ALTER TABLE `horarios` DISABLE KEYS */;
INSERT INTO `horarios` VALUES (1,1,0,'08:00:00','20:00:00',''),(2,1,1,'10:30:00','14:30:00',''),(3,1,2,'08:00:00','20:00:00','\0'),(4,1,3,'08:00:00','20:00:00',''),(5,1,4,'10:30:00','14:30:00',''),(6,2,5,'09:00:00','17:00:00','\0'),(7,2,6,'12:00:00','16:00:00','\0'),(8,2,0,'11:00:00','19:00:00',''),(9,2,1,'11:00:00','19:00:00',''),(10,2,2,'11:30:00','14:30:00',''),(11,2,3,'11:00:00','19:00:00',''),(12,2,4,'11:30:00','19:30:00',''),(13,3,0,'15:30:00','19:30:00',''),(14,3,2,'08:00:00','19:30:00',''),(15,3,4,'15:30:00','19:30:00',''),(16,4,0,'12:00:00','14:00:00',''),(17,4,0,'17:00:00','20:00:00',''),(18,4,1,'12:00:00','14:00:00',''),(19,4,1,'17:00:00','20:00:00',''),(20,4,3,'12:00:00','14:00:00',''),(21,4,3,'17:00:00','20:00:00',''),(22,4,4,'12:00:00','14:00:00',''),(23,4,4,'17:00:00','20:00:00',''),(24,4,5,'08:00:00','12:00:00',''),(25,4,5,'15:00:00','19:00:00','\0'),(26,5,1,'13:00:00','20:00:00',''),(27,5,2,'13:30:00','20:00:00',''),(28,5,3,'13:00:00','20:00:00',''),(29,5,4,'13:00:00','18:00:00',''),(30,5,6,'08:00:00','10:30:00',''),(31,6,0,'13:30:00','15:30:00',''),(32,6,2,'12:00:00','20:00:00',''),(33,6,3,'13:30:00','15:30:00',''),(34,6,4,'12:00:00','18:00:00',''),(35,6,5,'08:00:00','11:30:00',''),(36,7,5,'08:00:00','20:00:00',''),(37,7,6,'08:00:00','20:00:00',''),(38,8,0,'16:00:00','20:00:00',''),(39,8,1,'16:00:00','20:00:00',''),(40,8,2,'10:30:00','15:30:00',''),(41,8,3,'16:00:00','20:00:00',''),(42,8,4,'08:00:00','11:30:00',''),(43,8,4,'18:00:00','20:00:00','\0'),(44,8,5,'08:30:00','11:30:00',''),(45,8,6,'08:30:00','11:30:00','\0'),(46,9,0,'08:00:00','11:30:00',''),(47,9,1,'08:00:00','11:30:00',''),(48,9,2,'08:00:00','11:00:00',''),(49,9,3,'08:00:00','11:30:00',''),(50,9,6,'09:00:00','12:30:00',''),(51,10,0,'08:00:00','14:00:00',''),(52,10,1,'08:00:00','14:00:00','\0'),(53,10,2,'08:00:00','14:00:00',''),(54,10,3,'08:00:00','14:00:00','\0'),(55,10,4,'08:00:00','14:00:00',''),(56,11,0,'08:00:00','14:00:00','\0'),(57,11,1,'08:00:00','14:00:00',''),(58,11,2,'08:00:00','14:00:00','\0'),(59,11,3,'08:00:00','14:00:00',''),(60,11,4,'08:00:00','14:00:00','\0'),(61,12,0,'14:00:00','20:00:00',''),(62,12,1,'14:00:00','20:00:00','\0'),(63,12,2,'14:00:00','20:00:00',''),(64,12,3,'14:00:00','20:00:00','\0'),(65,12,4,'14:00:00','20:00:00',''),(66,13,0,'14:00:00','20:00:00','\0'),(67,13,1,'14:00:00','20:00:00',''),(68,13,2,'14:00:00','20:00:00','\0'),(69,13,3,'14:00:00','20:00:00',''),(70,13,4,'14:00:00','20:00:00','\0'),(71,14,5,'08:00:00','11:00:00','\0'),(72,14,6,'08:00:00','11:00:00',''),(73,15,5,'08:00:00','11:00:00',''),(74,15,6,'08:00:00','11:00:00','\0'),(75,16,5,'11:00:00','14:00:00','\0'),(76,16,6,'11:00:00','14:00:00',''),(77,17,5,'11:00:00','14:00:00',''),(78,17,6,'11:00:00','14:00:00','\0'),(79,14,5,'14:00:00','17:00:00','\0'),(80,14,6,'14:00:00','17:00:00',''),(81,15,5,'14:00:00','17:00:00',''),(82,15,6,'14:00:00','17:00:00','\0'),(83,16,5,'17:00:00','20:00:00','\0'),(84,16,6,'17:00:00','20:00:00',''),(85,17,5,'17:00:00','20:00:00',''),(86,17,6,'17:00:00','20:00:00','\0'),(87,18,0,'08:00:00','11:30:00',''),(88,18,1,'08:00:00','11:30:00',''),(89,18,3,'08:00:00','11:30:00',''),(90,18,4,'08:00:00','11:30:00',''),(91,19,0,'11:00:00','14:00:00',''),(92,19,1,'11:00:00','14:00:00',''),(93,19,2,'11:00:00','14:00:00',''),(94,19,3,'11:00:00','14:00:00',''),(95,19,4,'11:00:00','14:00:00',''),(96,20,0,'14:00:00','17:00:00',''),(97,20,1,'14:00:00','17:00:00',''),(98,20,2,'14:00:00','17:00:00',''),(99,20,3,'14:00:00','17:00:00',''),(100,20,4,'14:00:00','17:00:00','');
/*!40000 ALTER TABLE `horarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicamentos`
--

DROP TABLE IF EXISTS `medicamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicamentos` (
  `mid` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `via_aplicacion` varchar(50) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `dosis` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicamentos`
--

LOCK TABLES `medicamentos` WRITE;
/*!40000 ALTER TABLE `medicamentos` DISABLE KEYS */;
INSERT INTO `medicamentos` VALUES (1,'Shunga','Oral','Other physeal fracture of unspecified metatarsal, subsequent encounter for fracture with delayed healing','40ml'),(2,'Flu and Severe Cold and Cough','Oral','Secondary esophageal varices','20ml'),(3,'Pamidronate Disodium','Sublingual','Atherosclerosis of unspecified type of bypass graft(s) of the extremities with gangrene, bilateral legs','40mg'),(4,'Nigrospora sphaerica','Sublingual','Other specified fracture of right acetabulum, subsequent encounter for fracture with delayed healing','50mg'),(5,'REQUIP','Sublingual','Abrasion of unspecified parts of thorax, sequela','100mg'),(6,'Supremacie','Oral','Burn of first degree of unspecified shoulder','50ml'),(7,'Aspirin','Sublingual','Displaced fracture of base of unspecified metacarpal bone, subsequent encounter for fracture with nonunion','60mg'),(8,'Levothyroxine Sodium','Sublingual','Villonodular synovitis (pigmented), unspecified wrist','15mg'),(9,'Anticavity','Oral','Poisoning by monoamine-oxidase-inhibitor antidepressants, intentional self-harm, subsequent encounter','45ml'),(10,'Lancome Paris Bienfait MultiVital Spectrum','Sublingual','Charcot\'s joint, hip','35mg'),(11,'Regular Strength Enteric coated aspirin','Oral','Other symptoms and signs involving the musculoskeletal system','25ml'),(12,'ACETAMINOPHEN AND CODEINE PHOSPHATE','Sublingual','Other specified injury of lesser saphenous vein at lower leg level, unspecified leg, initial encounter','36mg'),(13,'CD Creme Enhancing Sunscreen Eye Illuminator','Oral','Palindromic rheumatism, ankle and foot','20ml'),(14,'Thiothixene','Sublingual','Nondisplaced fracture of second metatarsal bone, right foot, initial encounter for closed fracture','10mg'),(15,'Levothroid','Sublingual','Unspecified fracture of lower end of left tibia, subsequent encounter for open fracture type IIIA, IIIB, or IIIC with routine healing','30mg'),(16,'Hydrocodone Bitartrate and Acetaminophen','Oral','Displaced bimalleolar fracture of unspecified lower leg, subsequent encounter for open fracture type IIIA, IIIB, or IIIC with malunion','25ml'),(17,'Liposyn II','Oral','Fracture of medial cuneiform','30ml'),(18,'Topco','Oral','Serous detachment of retinal pigment epithelium, right eye','40ml'),(19,'NARS PURE RADIANT TINTED MOISTURIZER','Oral','Carcinoma in situ of other parts of cervix','25ml'),(20,'pain and fever','Oral','Sprain of interphalangeal joint of right index finger, initial encounter','20ml');
/*!40000 ALTER TABLE `medicamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas`
--

DROP TABLE IF EXISTS `notas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notas` (
  `cid` int(11) NOT NULL,
  `notas` text DEFAULT NULL,
  PRIMARY KEY (`cid`),
  CONSTRAINT `notas_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `citas` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas`
--

LOCK TABLES `notas` WRITE;
/*!40000 ALTER TABLE `notas` DISABLE KEYS */;
INSERT INTO `notas` VALUES (1,'Aliquam erat volutpat.'),(3,'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia.'),(4,'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.'),(5,'Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.'),(7,'Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.'),(8,'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl.'),(9,'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.'),(10,'Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.'),(11,'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum.'),(13,'Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.'),(14,'Nullam sit amet turpis elementum ligula vehicula consequat.'),(15,'Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius.'),(16,'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.'),(17,'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.'),(20,'Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.'),(21,'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.'),(22,'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero.'),(23,'Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl.'),(24,'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum.'),(26,'Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.'),(27,'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula.'),(28,'Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.'),(29,'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros.'),(30,'Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.'),(31,'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio.'),(32,'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis.'),(33,'Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.'),(34,'Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna.'),(35,'Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.'),(36,'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus.'),(37,'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.'),(38,'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.'),(39,'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio.'),(40,'Mauris lacinia sapien quis libero.'),(41,'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.'),(42,'Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.'),(43,'Morbi non quam nec dui luctus rutrum.'),(44,'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.'),(45,'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.'),(46,'Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.'),(47,'Morbi non quam nec dui luctus rutrum. Nulla tellus.'),(48,'Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.'),(49,'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.'),(50,'Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.'),(51,'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.'),(52,'Vivamus in felis eu sapien cursus vestibulum.'),(53,'Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.'),(54,'Vivamus vel nulla eget eros elementum pellentesque.'),(55,'Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.'),(56,'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio.'),(57,'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.'),(58,'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.'),(59,'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.'),(60,'Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.'),(61,'Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.'),(62,'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.'),(63,'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui.'),(64,'Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.'),(65,'Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.'),(66,'Aenean fermentum.'),(67,'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.'),(68,'Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.'),(69,'Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.'),(70,'Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.'),(72,'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.'),(73,'Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque.'),(74,'Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.'),(75,'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.'),(77,'Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet.'),(78,'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'),(79,'Vivamus tortor. Duis mattis egestas metus.'),(80,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'),(81,'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula.'),(82,'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.'),(83,'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.'),(84,'Proin leo odio, porttitor id, consequat in, consequat ut, nulla.'),(85,'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.'),(88,'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.'),(89,'Suspendisse potenti.'),(90,'Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.'),(91,'Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.'),(92,'Duis aliquam convallis nunc.'),(93,'Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis.'),(95,'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.'),(99,'Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo.'),(103,'Etiam justo. Etiam pretium iaculis justo.'),(107,'Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet.'),(113,'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula.'),(116,'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.'),(117,'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.'),(125,'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.'),(126,'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.'),(128,'Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.'),(129,'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.'),(131,'Cras pellentesque volutpat dui.'),(134,'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh.'),(139,'Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.'),(143,'Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus.'),(144,'Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.'),(148,'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
/*!40000 ALTER TABLE `notas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pacientes`
--

DROP TABLE IF EXISTS `pacientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pacientes` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(50) DEFAULT NULL,
  `apellidoP` varchar(50) DEFAULT NULL,
  `apellidoM` varchar(50) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pacientes`
--

LOCK TABLES `pacientes` WRITE;
/*!40000 ALTER TABLE `pacientes` DISABLE KEYS */;
INSERT INTO `pacientes` VALUES (1,'Valentine','Dyett','Tungate','583-551-6671','vtungate0@dailymotion.com','2001-03-28'),(2,'Clementine','Castelain','Broek','973-598-4462','cbroek1@accuweather.com','2003-01-31'),(3,'Cornall','Domenc','Cohan','732-298-3041','ccohan2@microsoft.com','1992-06-23'),(4,'Andres','Blest','Galsworthy','877-168-9471','agalsworthy3@ezinearticles.com','1992-10-12'),(5,'Quintus','Fawdry','Paviour','930-742-9132','qpaviour4@bbc.co.uk','1992-02-29'),(6,'Eleonore','MacMearty','Mathys','929-778-8669','emathys5@wunderground.com','2003-10-16'),(7,'Marthe','Maunders','Cristol','355-606-9159','mcristol6@amazonaws.com','2001-01-27'),(8,'Randee','Ivett','Manley','633-721-4792','rmanley7@google.ru','2001-11-28'),(9,'Rex','Rait','Heinert','123-258-2762','rheinert8@hugedomains.com','1991-05-14'),(10,'Rene','Torrejon','Singyard','362-887-4419','rsingyard9@amazon.co.uk','2000-12-12'),(11,'Brigit','Hankins','Dillicate','206-710-7717','bdillicatea@taobao.com','2004-11-11'),(12,'Shelley','Tutchings','Heugh','210-456-0761','sheughb@people.com.cn','2002-04-13'),(13,'Hogan','Gaskall','McGrill','225-762-4452','hmcgrillc@yellowpages.com','1996-05-29'),(14,'Julianne','Challinor','Muggeridge','433-887-1892','jmuggeridged@privacy.gov.au','1991-12-23'),(15,'Roma','Blyden','Issatt','681-204-9542','rissatte@weibo.com','1995-01-11'),(16,'Niki','Greatrakes','Whitworth','608-600-0097','nwhitworthf@usa.gov','1993-02-16'),(17,'Almeda','Pummery','Pressdee','872-928-0065','apressdeeg@acquirethisname.com','2000-12-07'),(18,'Kati','Croux','Labbez','716-416-1502','klabbezh@unesco.org','2004-11-30'),(19,'Jacquie','Mansford','Surman-Wells','242-132-4644','jsurmanwellsi@posterous.com','1993-01-09'),(20,'Mabel','Leese','Demoge','294-784-7469','mdemogej@bing.com','2004-06-21'),(21,'Crawford','Elvy','Castaner','619-470-0916','ccastanerk@istockphoto.com','1994-09-30'),(22,'Cristiano','Domenc','Paskerful','733-960-8753','cpaskerfull@soup.io','2000-05-01'),(23,'Guglielmo','Sissot','Pitbladdo','961-106-6519','gpitbladdom@weibo.com','1990-11-11'),(24,'Enriqueta','Jellard','Culbard','388-990-1046','eculbardn@mayoclinic.com','1994-04-30'),(25,'Wilhelmina','Blucher','Clacson','632-440-4982','wclacsono@reddit.com','1998-06-24'),(26,'Diena','Nias','Oldershaw','342-673-2373','doldershawp@gnu.org','1993-07-07'),(27,'Emera','Romme','McKimmey','853-722-8331','emckimmeyq@imdb.com','1999-01-02'),(28,'Waring','Arnow','Roke','224-831-5331','wroker@uiuc.edu','2003-11-24'),(29,'Elka','Smyth','Seak','219-837-7592','eseaks@macromedia.com','1993-08-17'),(30,'Joelle','Lenden','Duggen','752-299-3762','jduggent@soundcloud.com','1995-09-21'),(31,'Daren','Baack','Lattos','935-167-2797','dlattosu@nationalgeographic.com','1999-08-22'),(32,'Thibaud','Beert','Renak','126-504-0644','trenakv@biglobe.ne.jp','2005-12-18'),(33,'Karmen','Edney','Floweth','132-509-8998','kflowethw@chicagotribune.com','1999-08-14'),(34,'Sebastien','Roobottom','Koene','279-627-5913','skoenex@nifty.com','1994-07-11'),(35,'Kyla','Andri','Gebhardt','697-828-1209','kgebhardty@bloomberg.com','2002-12-28'),(36,'Marco','Speedin','Guare','252-917-9550','mguarez@exblog.jp','1993-10-10'),(37,'Homerus','Honnan','Lowrie','610-158-6739','hlowrie10@skyrock.com','1999-01-07'),(38,'Lebbie','Gilbride','Lockless','792-187-1921','llockless11@whitehouse.gov','2005-06-29'),(39,'Svend','Telega','Major','246-151-7533','smajor12@sakura.ne.jp','1997-10-08'),(40,'Bamby','Bullion','Cuddy','179-163-3184','bcuddy13@narod.ru','2004-04-26'),(41,'Laney','Taylo','Lawrenz','429-692-4050','llawrenz14@icq.com','1999-08-04'),(42,'Ashlin','De Bischof','Fridlington','273-471-3360','afridlington15@uiuc.edu','1995-04-24'),(43,'Yolanda','Hanselmann','Petrussi','984-257-2238','ypetrussi16@surveymonkey.com','1997-06-02'),(44,'Sheelagh','Callaghan','Willey','673-600-1765','swilley17@yellowpages.com','2000-06-12'),(45,'Dael','Monget','Redford','655-851-8663','dredford18@networksolutions.com','2005-03-02'),(46,'Bron','Williscroft','Geekie','274-969-6406','bgeekie19@epa.gov','1992-08-11'),(47,'Johna','Williams','Van der Beken','661-131-8043','jvanderbeken1a@google.co.jp','1993-08-23'),(48,'Niko','Noni','Ebbing','104-558-0895','nebbing1b@mashable.com','1990-02-06'),(49,'Dorri','Gibbonson','Sigge','987-167-2120','dsigge1c@miibeian.gov.cn','1993-08-03'),(50,'Sukey','Durtnal','Cicullo','566-203-6069','scicullo1d@youku.com','2000-11-13'),(51,'Gerik','Eacle','Dodson','147-746-7100','gdodson1e@blogger.com','2001-01-07'),(52,'Meghan','Castleman','Persse','174-341-8832','mpersse1f@51.la','1991-05-01'),(53,'Cleavland','Jilkes','January','222-950-5821','cjanuary1g@fc2.com','1999-06-27'),(54,'Ryon','Hursthouse','Battie','332-433-8242','rbattie1h@cbc.ca','1999-01-22'),(55,'Julienne','Cassey','Dellar','398-355-7471','jdellar1i@naver.com','1999-10-12'),(56,'Vina','Keoghan','Housley','650-668-8389','vhousley1j@usda.gov','1990-02-09'),(57,'Maurie','Itzcovich','O\' Loughran','613-535-2084','moloughran1k@foxnews.com','1992-03-16'),(58,'Zita','Casaro','Matthew','829-796-7577','zmatthew1l@newyorker.com','2001-02-02'),(59,'Tiphani','Buggs','Liepmann','202-270-6732','tliepmann1m@e-recht24.de','2002-09-18'),(60,'Corrinne','Budge','Leander','105-400-3407','cleander1n@e-recht24.de','1999-03-12'),(61,'Aeriel','Stoffels','Hartropp','387-556-1072','ahartropp1o@eepurl.com','1991-02-05'),(62,'Cari','Chinge de Hals','Downage','772-474-3022','cdownage1p@smh.com.au','2002-06-13'),(63,'Xylia','Djakovic','McGucken','585-867-4141','xmcgucken1q@webeden.co.uk','1999-05-23'),(64,'Talia','Shoppee','Maulden','297-926-6999','tmaulden1r@yelp.com','1995-07-16'),(65,'Frederigo','Freeborne','Santi','541-890-0530','fsanti1s@wunderground.com','1999-07-22'),(66,'Diane','Frayling','Metson','460-485-7320','dmetson1t@youtube.com','1990-11-22'),(67,'Nathaniel','Lisciandro','Squirrel','712-981-2801','nsquirrel1u@github.com','2002-02-26'),(68,'Giff','Geertsen','Nowaczyk','936-371-2728','gnowaczyk1v@webs.com','1998-03-09'),(69,'Sondra','Catley','Braddock','142-623-0519','sbraddock1w@home.pl','2003-06-19'),(70,'Nealson','Menelaws','Kamall','795-468-4848','nkamall1x@bandcamp.com','1998-10-20'),(71,'Karie','Hawkswood','Duffus','271-901-9060','kduffus1y@opensource.org','2002-12-05'),(72,'Dionis','Skurray','Cannop','226-133-1576','dcannop1z@wordpress.com','2000-10-03'),(73,'Fiann','Giller','Timms','402-635-1640','ftimms20@artisteer.com','2001-01-26'),(74,'Cash','Khosa','Verni','518-375-3775','cverni21@studiopress.com','2003-10-13'),(75,'Brian','Dolden','Twidale','331-818-7001','btwidale22@upenn.edu','2001-05-01');
/*!40000 ALTER TABLE `pacientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recetas`
--

DROP TABLE IF EXISTS `recetas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recetas` (
  `cid` int(11) NOT NULL,
  `mid` int(11) NOT NULL,
  `frecuencia` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cid`,`mid`),
  KEY `mid` (`mid`),
  CONSTRAINT `recetas_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `citas` (`cid`),
  CONSTRAINT `recetas_ibfk_2` FOREIGN KEY (`mid`) REFERENCES `medicamentos` (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recetas`
--

LOCK TABLES `recetas` WRITE;
/*!40000 ALTER TABLE `recetas` DISABLE KEYS */;
INSERT INTO `recetas` VALUES (1,2,'1/3 horas'),(2,6,'2/6 horas'),(2,17,'1/24 horas'),(3,8,'2/9 horas'),(4,6,'1/3 horas'),(4,9,'2/12 horas'),(5,11,'2/15 horas'),(5,16,'1/18 horas'),(6,12,'2/18 horas'),(7,19,'2/24 horas'),(8,20,'1/3 horas'),(9,13,'1/6 horas'),(10,5,'1/6 horas'),(12,8,'1/12 horas'),(13,8,'1/12 horas'),(14,5,'1/15 horas'),(14,11,'1/18 horas'),(14,12,'1/9 horas'),(16,11,'1/12 horas'),(16,19,'1/15 horas'),(17,17,'1/15 horas'),(18,6,'1/18 horas'),(18,7,'1/9 horas'),(19,7,'1/9 horas'),(19,9,'1/24 horas'),(20,12,'1/24 horas'),(21,10,'2/3 horas'),(23,12,'2/18 horas'),(24,1,'1/6 horas'),(24,19,'2/9 horas'),(25,11,'1/15 horas'),(29,11,'2/3 horas'),(31,20,'2/6 horas'),(32,11,'2/9 horas'),(33,2,'1/24 horas'),(34,11,'2/24 horas'),(44,9,'1/18 horas'),(46,11,'2/12 horas'),(54,15,'2/15 horas'),(58,3,'1/3 horas'),(66,1,'2/3 horas'),(67,12,'2/12 horas'),(70,13,'2/18 horas'),(78,12,'2/6 horas'),(78,20,'2/15 horas'),(79,2,'1/6 horas'),(81,2,'2/24 horas'),(90,8,'1/12 horas'),(92,7,'1/9 horas'),(101,19,'2/3 horas');
/*!40000 ALTER TABLE `recetas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicios`
--

DROP TABLE IF EXISTS `servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servicios` (
  `serid` int(11) NOT NULL AUTO_INCREMENT,
  `nombreServicio` varchar(50) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `duracion` int(11) DEFAULT NULL,
  `esBasico` bit(1) DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`serid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicios`
--

LOCK TABLES `servicios` WRITE;
/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
INSERT INTO `servicios` VALUES (1,'Ortodoncia','Proporcionamos un servicio para corregir o prevenir la malposición de los dientes.',2,'\0','Estético'),(2,'Limpieza','¿Dientes sucios? Nada como una limpieza para dejarlos relucientes.',1,'','Estético'),(3,'Blanqueamiento','Ofrecemos un proceso eficaz para dar presentación a tus dientes.',1,'','Estético'),(4,'Carilla dental','Recubrimos los dientes para evitar que le lleguen agentes que arruinen su aspecto.',1,'','Estético'),(5,'Implantes','Contamos con los medios necesarios para proveer nuevas oportunidades a tu boca.',3,'\0','Salud'),(6,'Extracciones','Para evitar complicaciones mayores, puede ser preciso remover piezas bucales.',2,'\0','Salud'),(7,'Corona dental','Como esculpir una estatua, podemos generar una nueva pieza según tu caso.',3,'\0','Salud'),(8,'Consulta general','Revisión y diagnóstico.',1,'','General');
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `usuario` varchar(32) NOT NULL,
  `contrasenia` varchar(256) DEFAULT NULL,
  `eid` int(11) DEFAULT NULL,
  PRIMARY KEY (`usuario`),
  KEY `eid` (`eid`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `dentistas` (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES ('aedney6','3IW7l2N',7),('atruckellg','9tcGRe',17),('birnis5','EDsy5T',6),('blucyf','63tG3u3',16),('cnapolione9','KOGJzpPiUWeF',10),('cradbonec','XXQq43iJpu6D',13),('dgwinnettb','BNJ2CO',12),('ebeiningj','3jFWEXD',20),('fputtend','ICkd8v',14),('gitzik1','vRut8C2',2),('jbarff7','dgPuXjkIh',8),('jconstantineh','26nkyc',18),('jmarietoni','HxYxrrZPYy',19),('mbrazear4','mPbb3cQolO',5),('ngipp8','kwV8LIejJ7w',9),('odaviee','BpMhPQ',15),('pbelt3','f3rNRjpNcC8',4),('rdrake0','l0FOBCP',1),('rwisby2','nxCfiHDR06',3),('ssydenhama','HHckkwC',11);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-21  5:05:21
