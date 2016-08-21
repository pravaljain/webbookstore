-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: bookstore
-- ------------------------------------------------------
-- Server version	5.5.47-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books` (
  `ISBN` char(13) NOT NULL,
  `title` varchar(70) NOT NULL,
  `description` varchar(300) DEFAULT NULL,
  `cost` decimal(4,2) NOT NULL,
  `id` decimal(5,0) NOT NULL,
  PRIMARY KEY (`ISBN`),
  KEY `id` (`id`),
  CONSTRAINT `books_ibfk_1` FOREIGN KEY (`id`) REFERENCES `writer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES ('0517553473123','img/liff.jpg','A useful dictionary',3.99,54321),('9780316098113','img/2312.jpg','It is the year 2312',4.99,23451),('9780345391803','img/hhgtg.jpg','A book about the meaning of Life, the Universe, and Everything',4.99,12345),('9780547572482','img/the_man_in_the_high_castle_frontcover.jpg','What if the nazis won the war in a different reality?',5.99,34512),('9781597805384','img/quarantine.jpg','The mind is the ultimate quantum wave collapser',3.99,45123),('9781597805385','img/cryptonomicon.jpg','How to get rich with cryptography and other stories',3.99,51234);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookwriter`
--

DROP TABLE IF EXISTS `bookwriter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookwriter` (
  `ISBN` char(13) NOT NULL,
  `id` decimal(5,0) NOT NULL,
  PRIMARY KEY (`ISBN`,`id`),
  KEY `id` (`id`),
  CONSTRAINT `bookwriter_ibfk_1` FOREIGN KEY (`id`) REFERENCES `writer` (`id`),
  CONSTRAINT `bookwriter_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `books` (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookwriter`
--

LOCK TABLES `bookwriter` WRITE;
/*!40000 ALTER TABLE `bookwriter` DISABLE KEYS */;
INSERT INTO `bookwriter` VALUES ('9780345391803',12345),('9780316098113',23451),('9780547572482',34512),('9781597805384',45123),('9781597805385',51234),('0517553473123',54321);
/*!40000 ALTER TABLE `bookwriter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history` (
  `hid` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` int(11) DEFAULT NULL,
  `userid` decimal(2,0) NOT NULL,
  `ISBN` char(13) NOT NULL,
  `orderdetails` datetime NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`hid`),
  KEY `userid` (`userid`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `history_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `books` (`ISBN`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
INSERT INTO `history` VALUES (3,4,99,'9780316098113','2016-03-31 00:20:20',5),(4,4,20,'9780316098113','2016-03-28 00:20:20',5),(5,1,99,'0517553473123','2016-04-06 00:46:18',6),(6,2,50,'0517553473123','2016-04-06 00:48:07',3),(7,3,99,'9780345391803','2016-04-06 00:48:43',1),(8,4,99,'0517553473123','2016-04-06 00:48:43',2),(10,6,22,'0517553473123','2016-04-06 02:44:27',1);
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `orderid` int(11) NOT NULL AUTO_INCREMENT,
  `ISBN` char(13) NOT NULL,
  `userid` decimal(2,0) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `order_date` datetime NOT NULL,
  PRIMARY KEY (`orderid`),
  KEY `userid` (`userid`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `books` (`ISBN`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (5,'0517553473123',50,8,'2016-04-06 01:17:52');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `userid` decimal(2,0) NOT NULL,
  `username` varchar(50) NOT NULL,
  `pass_word` varchar(50) NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `address` varchar(80) NOT NULL,
  `credit_card` decimal(16,0) NOT NULL,
  `utype` varchar(12) NOT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (6,'sdfghjk','dfghnjmkl',',kmlkmlklk','fc gvhbkml,',5416545619546854,'fbsfhsbsbf'),(7,'nitin','nitin','nitin surya','someplace i dont care',7897465453135219,'registered'),(10,'rigel','rigel','Rigel Gjomemo','809 S Morgan Chicago IL',1234341231234124,'admin'),(12,'vishi','vishi','nihira goel','b85, chetak apt, sec-9, rohini, new delhi',1234556456465135,'registered'),(19,'sdfghjkl','sdfghjkl','sdfghjkl','xcvbnm,',7414852569636965,'sdfghjkl'),(20,'amanda','amanda','Amanda Olson','809 S Morgan Chicago IL',1241234123434123,'admin'),(22,'Sherlock','sherlock','Sherlock Holmes','221B Baker Street, London',5646545465645646,'registered'),(25,'sanjay','sanjay','sanjay jain','61, gulab vihar apt, rohini, new delhi',3214569874563215,'registered'),(30,'nooshin','nooshin','Nooshin','809 S Morgan Chicago IL',4123123412341234,'admin'),(36,'nikita','nikita','nikita agnihotri','525 washington ave, apt 2, albany, NY',3652147896541236,'registered'),(40,'grader','grader','Austin Powers','809 S Morgan Chicago IL',1233412344123412,'admin'),(50,'pj','pjs','Praval Jain','809 S Damen Ave Chicago IL',3423411412231234,'admin'),(51,'benedict','benedict','benedict cumberbatch','221B Baker Street, London',8789789789798779,'registered'),(65,'vinay','vinay','vinay jain','b-81, chetak apt sec-9, rohini, new delhi',1457896587126985,'registered'),(68,'gvfcvgbhnbgvf','cvgbhgvfcvgbhgv','fcvgbhgvfcvgbhgvf','cvgbhnbgvbhnj',5484548758745874,'hfnjskfvjf'),(69,'hehehe','hehehe','messing around','asdfghjkjhgfdsa',4725856396585147,'registered'),(77,'njbhjnhb','jnhbgyhjnhb','jnhbjnhbnbnhbnhb','hjbgvhbjkbhughbjkh',4578457847847848,'45787858'),(84,'shanti','shanti','shanti priya','jkdfgnjkdngjknkgjn',8976545645646846,'registered'),(86,'madhu','madhu','madhu jain','srdtfvgybhunjinuhbgyvtf',5645645645645646,'registered'),(91,'dxcfvgbhnjmk','xcfgsdfgsfdgs','dxcfvgbhnjmk','xdcfvgbhnjmk,',4124145154851858,'c vbnmjnhb'),(99,'parul','parul','parul jain','india, asia, earth',1234567898523697,'registered');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `writer`
--

DROP TABLE IF EXISTS `writer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `writer` (
  `id` decimal(5,0) NOT NULL,
  `author_name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `writer`
--

LOCK TABLES `writer` WRITE;
/*!40000 ALTER TABLE `writer` DISABLE KEYS */;
INSERT INTO `writer` VALUES (12345,'Douglas Adams'),(23451,'Kim Stanley Robinson'),(34512,'Philip Dick'),(45123,'Greg Egan'),(51234,'Neal Stephenson'),(54321,'John Lloyd');
/*!40000 ALTER TABLE `writer` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-06 15:21:46
