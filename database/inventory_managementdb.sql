-- Combined dump of inventory_managementdb
-- Generated for single-file import (restaurant inventory)
-- Source: database/inventory_managementdb/*.sql

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

-- --------------------------------------------------------------------------------
-- suppliers
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE `suppliers` (
	`SupplierID` int NOT NULL AUTO_INCREMENT,
	`SupplierName` varchar(100) NOT NULL,
	`Location` enum('Restaurant','Room','Both') NOT NULL,
	`facebookpage` varchar(255) DEFAULT NULL,
	`gmail` varchar(150) NOT NULL,
	`contact_no` varchar(11) NOT NULL,
	`address` varchar(150) NOT NULL,
	PRIMARY KEY (`SupplierID`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (2,'RoomNeeds Supplier','Room','fb.com/roomneeds','roomneeds@gmail.com','09179876543','45 Hotel Avenue'),(6,'Room and Restaurant supplier','Both','fb.com/rarsupplier','admin@example.com','09701134977','Malasiqui, Pangasinan Philippines'),(71,'Fresh Food Wholesale','Restaurant','fb.com/freshfoodwholesale','freshfood@gmail.com','09171111001','Quezon City Market'),(72,'Premium Ingredients Supply','Restaurant','fb.com/premiumingredients','premium@gmail.com','09171111002','Makati Commercial'),(73,'Daily Essentials Depot','Restaurant','fb.com/dailyessentials','daily@gmail.com','09171111003','Manila Central Supply');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

-- --------------------------------------------------------------------------------
-- supplieritems
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS `supplieritems`;
CREATE TABLE `supplieritems` (
	`SupplierItemID` int NOT NULL AUTO_INCREMENT,
	`SupplierID` int NOT NULL,
	`ItemName` varchar(100) NOT NULL,
	`Measurement` enum('Box','Pack','Sack','Pcs','Sets','Bottle') NOT NULL,
	`Price` decimal(10,2) NOT NULL,
	`InitialStock` int NOT NULL DEFAULT '0',
	`DefaultExpiryDate` date DEFAULT NULL,
	`DefaultMinimumStock` int NOT NULL DEFAULT '10',
	PRIMARY KEY (`SupplierItemID`),
	KEY `SupplierID` (`SupplierID`),
	CONSTRAINT `supplieritems_ibfk_1` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`)
) ENGINE=InnoDB AUTO_INCREMENT=540 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `supplieritems` WRITE;
/*!40000 ALTER TABLE `supplieritems` DISABLE KEYS */;
INSERT INTO `supplieritems` VALUES (3,2,'Shampoo','Bottle',120.00,0,NULL,10),(4,2,'Soap','Pack',30.00,0,NULL,10),(11,6,'Chicken','Box',170.00,0,NULL,0),(12,6,'Soap','Pack',150.00,0,NULL,0),(505,71,'Rice','Sack',45.00,50,NULL,10),(506,71,'Chicken Breast','Pack',180.00,20,NULL,5),(507,71,'Beef Shank','Pack',320.00,15,NULL,5),(508,71,'Pork Leg','Pack',250.00,10,NULL,3),(509,71,'Shrimp','Pack',450.00,8,NULL,2),(510,71,'Squid','Pack',280.00,5,NULL,2),(511,71,'Tuna','Pack',380.00,7,NULL,2),(512,71,'Mussels','Pack',220.00,4,NULL,1),(513,71,'Lettuce','Pack',65.00,3,NULL,1),(514,71,'Tomatoes','Pack',75.00,5,NULL,1),(515,71,'Onions','Pack',45.00,8,NULL,2),(516,71,'Garlic','Pack',95.00,3,NULL,1),(517,72,'Milk','Bottle',85.00,10,NULL,2),(518,72,'Eggs','Sets',8.00,100,NULL,20),(519,72,'Cheese','Pack',380.00,5,NULL,1),(520,72,'Cream','Bottle',180.00,6,NULL,1),(521,72,'Bacon','Pack',420.00,3,NULL,1),(522,72,'Ham','Pack',350.00,4,NULL,1),(523,72,'Peanut Sauce','Bottle',150.00,2,NULL,1),(524,72,'Chocolate','Pack',280.00,5,NULL,1),(525,72,'Matcha Powder','Pack',850.00,2,NULL,1),(526,72,'Coffee Beans','Pack',420.00,5,NULL,1),(527,72,'Tapioca Pearls','Pack',120.00,3,NULL,1),(528,73,'Flour','Sack',35.00,25,NULL,5),(529,73,'Sugar','Sack',55.00,30,NULL,5),(530,73,'Salt','Pack',15.00,10,NULL,2),(531,73,'Oil','Bottle',120.00,15,NULL,3),(532,73,'Soy Sauce','Bottle',65.00,3,NULL,1),(533,73,'Vinegar','Bottle',35.00,4,NULL,1),(534,73,'Pineapple','Pcs',45.00,20,NULL,5),(535,73,'Watermelon','Pcs',85.00,10,NULL,3),(536,73,'Lemon','Pcs',12.00,30,NULL,10),(537,73,'Dragon Fruit','Pcs',95.00,15,NULL,5),(538,73,'Cola Syrup','Bottle',85.00,3,NULL,1),(539,73,'Ice','Sack',5.00,100,NULL,10);
/*!40000 ALTER TABLE `supplieritems` ENABLE KEYS */;
UNLOCK TABLES;

-- --------------------------------------------------------------------------------
-- items
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
	`ItemID` int NOT NULL AUTO_INCREMENT,
	`ItemName` varchar(100) NOT NULL,
	`SupplierItemID` int NOT NULL,
	`Location` enum('Restaurant','Room') NOT NULL DEFAULT 'Restaurant',
	`Stock` int NOT NULL,
	`Measurement` enum('Box','Pack','Sack','Pcs','Sets','Bottle') NOT NULL,
	`ExpiryDate` date DEFAULT NULL,
	`Conditions` varchar(50) DEFAULT NULL,
	`MinimumStock` int NOT NULL DEFAULT '10',
	PRIMARY KEY (`ItemID`),
	KEY `SupplierItemID` (`SupplierItemID`),
	CONSTRAINT `items_ibfk_1` FOREIGN KEY (`SupplierItemID`) REFERENCES `supplieritems` (`SupplierItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=754 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (15,'Shampoo',3,'Restaurant',4,'Bottle',NULL,'Low Stock',10),(17,'Soap',4,'Restaurant',0,'Pack',NULL,'Out of Stock',10),(719,'Rice',505,'Restaurant',0,'Sack',NULL,'Good',10),(720,'Chicken Breast',506,'Restaurant',0,'Pack',NULL,'Good',5),(721,'Beef Shank',507,'Restaurant',0,'Pack',NULL,'Good',5),(722,'Pork Leg',508,'Restaurant',0,'Pack',NULL,'Good',3),(723,'Shrimp',509,'Restaurant',0,'Pack',NULL,'Good',2),(724,'Squid',510,'Restaurant',0,'Pack',NULL,'Good',2),(725,'Tuna',511,'Restaurant',0,'Pack',NULL,'Good',2),(726,'Mussels',512,'Restaurant',0,'Pack',NULL,'Good',1),(727,'Lettuce',513,'Restaurant',0,'Pack',NULL,'Good',1),(728,'Tomatoes',514,'Restaurant',0,'Pack',NULL,'Good',1),(729,'Onions',515,'Restaurant',0,'Pack',NULL,'Good',2),(730,'Garlic',516,'Restaurant',0,'Pack',NULL,'Good',1),(731,'Milk',517,'Restaurant',0,'Bottle',NULL,'Good',2),(732,'Eggs',518,'Restaurant',0,'Sets',NULL,'Good',20),(733,'Cheese',519,'Restaurant',0,'Pack',NULL,'Good',1),(734,'Cream',520,'Restaurant',0,'Bottle',NULL,'Good',1),(735,'Bacon',521,'Restaurant',4,'Pack','2026-07-23','Low Stock',1),(736,'Ham',522,'Restaurant',0,'Pack',NULL,'Good',1),(737,'Peanut Sauce',523,'Restaurant',0,'Bottle',NULL,'Good',1),(738,'Chocolate',524,'Restaurant',0,'Pack',NULL,'Good',1),(739,'Matcha Powder',525,'Restaurant',0,'Pack',NULL,'Good',1),(740,'Coffee Beans',526,'Restaurant',0,'Pack',NULL,'Good',1),(741,'Tapioca Pearls',527,'Restaurant',0,'Pack',NULL,'Good',1),(742,'Flour',528,'Restaurant',0,'Sack',NULL,'Good',5),(743,'Sugar',529,'Restaurant',0,'Sack',NULL,'Good',5),(744,'Salt',530,'Restaurant',0,'Pack',NULL,'Good',2),(745,'Oil',531,'Restaurant',0,'Bottle',NULL,'Good',3),(746,'Soy Sauce',532,'Restaurant',0,'Bottle','2026-05-21','Out of Stock',1),(747,'Vinegar',533,'Restaurant',0,'Bottle',NULL,'Good',1),(748,'Pineapple',534,'Restaurant',0,'Pcs',NULL,'Good',5),(749,'Watermelon',535,'Restaurant',0,'Pcs',NULL,'Good',3),(750,'Lemon',536,'Restaurant',0,'Pcs',NULL,'Good',10),(751,'Dragon Fruit',537,'Restaurant',0,'Pcs',NULL,'Good',5),(752,'Cola Syrup',538,'Restaurant',0,'Bottle',NULL,'Good',1),(753,'Ice',539,'Restaurant',0,'Sack',NULL,'Good',10);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

-- --------------------------------------------------------------------------------
-- users
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
	`UserID` int NOT NULL AUTO_INCREMENT,
	`username` varchar(100) NOT NULL,
	`Role` enum('Admin','Manager','Staff') NOT NULL,
	`Location` enum('Restaurant','Room','admin') DEFAULT 'Restaurant',
	`Password` varchar(100) NOT NULL,
	`NAME` varchar(150) DEFAULT NULL,
	`Status` varchar(20) DEFAULT 'Active',
	PRIMARY KEY (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','Admin',NULL,'$2y$10$Kju3pwjM6nAy9g4en1K.Euh2gJQkKCrhKxQq5PA1BkNKUO.aJR9tm','jomar','Active'),(2,'staff','Staff','Restaurant','$2y$10$dBd3rsBiyXqemYvFiy9dfOgnjOQs8KP6syWWxHarOogiewBZMUzoi','rosela','Active'),(3,'manager','Manager','Restaurant','manager','irish','Active'),(4,'gelo','Staff','Restaurant','$2y$10$hyBXecDALCQXkwYt0KQPzOkTaP4bgQIJggsVymlIYnG.D9YgMRGhq','michael angelo acerdin','Inactive'),(5,'staff2','Staff','Room','$2y$10$caPNWs4D9/zJyq2XYtRN..9p.35xpY8lkE/WcLL7fZ0UkEEGQ28qi','michael angelo acerdin','Active');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

-- --------------------------------------------------------------------------------
-- orders
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
	`OrderID` int NOT NULL AUTO_INCREMENT,
	`SupplierID` int NOT NULL,
	`OrderDate` date NOT NULL,
	`Status` varchar(50) NOT NULL DEFAULT 'Pending',
	PRIMARY KEY (`OrderID`),
	KEY `SupplierID` (`SupplierID`),
	CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (2,2,'2025-11-19','Received'),(6,73,'2025-12-02','Pending Approval'),(7,73,'2025-12-02','Received'),(8,72,'2025-12-02','Received');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

-- --------------------------------------------------------------------------------
-- orderdetails
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS `orderdetails`;
CREATE TABLE `orderdetails` (
	`OrderDetailID` int NOT NULL AUTO_INCREMENT,
	`OrderID` int NOT NULL,
	`SupplierItemID` int NOT NULL,
	`Quantity` int NOT NULL,
	`ReceivedQuantity` int DEFAULT '0',
	`Status` enum('Pending Approval','In Transit','Received','Shipped') DEFAULT 'Pending Approval',
	PRIMARY KEY (`OrderDetailID`),
	KEY `OrderID` (`OrderID`),
	KEY `SupplierItemID` (`SupplierItemID`),
	CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`),
	CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`SupplierItemID`) REFERENCES `supplieritems` (`SupplierItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `orderdetails` WRITE;
/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
INSERT INTO `orderdetails` VALUES (2,2,4,1,1,'Pending Approval'),(6,6,532,5,12,'Pending Approval'),(7,7,532,5,5,'Pending Approval'),(8,8,521,10,10,'Pending Approval');
/*!40000 ALTER TABLE `orderdetails` ENABLE KEYS */;
UNLOCK TABLES;

-- --------------------------------------------------------------------------------
-- transactions
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
	`TransactionID` int NOT NULL AUTO_INCREMENT,
	`ItemID` int NOT NULL,
	`Quantity` int NOT NULL,
	`Type` enum('Added Stock','Usage Stock') NOT NULL,
	`UserID` int NOT NULL,
	`SupplierID` int DEFAULT NULL,
	`DateTime` datetime DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`TransactionID`),
	KEY `ItemID` (`ItemID`),
	KEY `UserID` (`UserID`),
	KEY `SupplierID` (`SupplierID`),
	CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`ItemID`) REFERENCES `items` (`ItemID`),
	CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
	CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (8,746,5,'Added Stock',3,73,'2025-12-02 19:58:14'),(9,746,5,'Usage Stock',2,NULL,'2025-12-02 19:58:56'),(10,735,9,'Added Stock',3,72,'2025-12-02 20:00:41'),(11,735,5,'Usage Stock',2,NULL,'2025-12-02 20:01:30'),(12,15,1,'Usage Stock',5,NULL,'2025-12-02 20:22:13');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

-- --------------------------------------------------------------------------------
-- returns
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS `returns`;
CREATE TABLE `returns` (
	`ReturnID` int NOT NULL AUTO_INCREMENT,
	`ItemID` varchar(64) NOT NULL,
	`CreatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`Status` varchar(20) NOT NULL DEFAULT 'Pending',
	PRIMARY KEY (`ReturnID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `returns` WRITE;
/*!40000 ALTER TABLE `returns` DISABLE KEYS */;
INSERT INTO `returns` VALUES (1,'1','2025-11-18 11:36:58','Pending'),(2,'1','2025-11-18 11:36:59','Pending'),(3,'1','2025-11-18 11:45:25','Pending'),(4,'1','2025-11-18 11:45:28','Pending'),(5,'1','2025-11-18 12:08:42','Pending'),(6,'1','2025-11-18 12:08:43','Pending'),(7,'1','2025-11-18 12:08:45','Pending'),(8,'1','2025-11-18 12:08:47','Pending'),(9,'1','2025-11-18 12:08:49','Pending'),(10,'1','2025-11-18 12:08:51','Pending'),(11,'1','2025-11-18 14:09:38','Pending');
/*!40000 ALTER TABLE `returns` ENABLE KEYS */;
UNLOCK TABLES;

-- --------------------------------------------------------------------------------
-- issues
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS `issues`;
CREATE TABLE `issues` (
	`IssueID` int NOT NULL AUTO_INCREMENT,
	`ItemID` int NOT NULL,
	`ItemName` varchar(100) NOT NULL,
	`Location` enum('Restaurant','Room') NOT NULL,
	`Stock` int NOT NULL,
	`ExpiryDate` date DEFAULT NULL,
	`Conditions` enum('Expired','Out of Stock','Damaged') NOT NULL,
	`Reason` varchar(255) DEFAULT NULL,
	`QuantityAffected` int NOT NULL,
	PRIMARY KEY (`IssueID`),
	KEY `ItemID` (`ItemID`),
	CONSTRAINT `issues_ibfk_1` FOREIGN KEY (`ItemID`) REFERENCES `items` (`ItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `issues` WRITE;
/*!40000 ALTER TABLE `issues` DISABLE KEYS */;
INSERT INTO `issues` VALUES (1,17,'Soap','Restaurant',0,NULL,'Damaged','asd',1),(3,735,'Bacon','Restaurant',0,NULL,'Damaged','asd',1);
/*!40000 ALTER TABLE `issues` ENABLE KEYS */;
UNLOCK TABLES;

-- --------------------------------------------------------------------------------
-- alerts
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS `alerts`;
CREATE TABLE `alerts` (
	`AlertID` int NOT NULL AUTO_INCREMENT,
	`Type` varchar(50) NOT NULL,
	`ItemID` int NOT NULL,
	`Details` varchar(255) DEFAULT NULL,
	`Status` enum('Pending','Resolved') DEFAULT 'Pending',
	PRIMARY KEY (`AlertID`),
	KEY `ItemID` (`ItemID`),
	CONSTRAINT `alerts_ibfk_1` FOREIGN KEY (`ItemID`) REFERENCES `items` (`ItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
INSERT INTO `alerts` VALUES (4,'Low Stock',15,'Stock level is low: 4 remaining','Pending'),(176,'Low Stock',746,'Stock level is low: 5 remaining','Pending'),(177,'Low Stock',735,'Stock level is low: 4 remaining','Pending');
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

-- --------------------------------------------------------------------------------
-- notifications
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
	`id` int NOT NULL AUTO_INCREMENT,
	`title` varchar(255) NOT NULL,
	`message` text,
	`type` enum('pending','resolved','added') NOT NULL,
	`created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2626 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

-- --------------------------------------------------------------------------------
-- report_notes
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS `report_notes`;
CREATE TABLE `report_notes` (
	`NoteID` int NOT NULL AUTO_INCREMENT,
	`Note` text,
	`CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`NoteID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `report_notes` WRITE;
/*!40000 ALTER TABLE `report_notes` DISABLE KEYS */;
INSERT INTO `report_notes` VALUES (1,'asdadsad','2025-11-06 11:35:22');
/*!40000 ALTER TABLE `report_notes` ENABLE KEYS */;
UNLOCK TABLES;

-- --------------------------------------------------------------------------------
-- item_usage
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS `item_usage`;
CREATE TABLE `item_usage` (
	`UsageID` int NOT NULL AUTO_INCREMENT,
	`ItemID` varchar(50) NOT NULL,
	`Quantity` int NOT NULL,
	`UserID` varchar(50) NOT NULL,
	`Notes` text,
	`CreatedAt` datetime NOT NULL,
	`synced_to_restaurant` tinyint(1) DEFAULT '0',
	`synced_at` datetime DEFAULT NULL,
	PRIMARY KEY (`UsageID`),
	KEY `idx_item` (`ItemID`),
	KEY `idx_user` (`UserID`),
	KEY `idx_date` (`CreatedAt`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `item_usage` WRITE;
/*!40000 ALTER TABLE `item_usage` DISABLE KEYS */;
INSERT INTO `item_usage` VALUES (10,'18',10,'1','asd','2025-10-30 09:33:43',0,NULL),(29,'1',100,'1','','2025-11-18 12:18:01',0,NULL),(30,'1',15,'1','','2025-11-19 22:12:15',0,NULL),(31,'13',1,'4','','2025-11-19 22:59:08',0,NULL),(32,'12',12,'2','','2025-11-25 08:29:55',0,NULL),(41,'12',1,'2','','2025-11-28 21:32:54',0,NULL),(42,'18',12,'2','','2025-11-30 23:25:09',0,NULL),(43,'746',5,'2','','2025-12-02 19:58:56',0,NULL),(44,'735',5,'2','','2025-12-02 20:01:30',0,NULL),(45,'15',1,'5','','2025-12-02 20:22:13',0,NULL);
/*!40000 ALTER TABLE `item_usage` ENABLE KEYS */;
UNLOCK TABLES;

-- --------------------------------------------------------------------------------
-- item_ingredient_mapping
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS `item_ingredient_mapping`;
CREATE TABLE `item_ingredient_mapping` (
	`mapping_id` int NOT NULL AUTO_INCREMENT,
	`inventory_item_id` int NOT NULL,
	`restaurant_ingredient_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
	`conversion_factor` decimal(10,4) DEFAULT '1.0000',
	`auto_sync_enabled` tinyint(1) DEFAULT '1',
	`created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`mapping_id`),
	UNIQUE KEY `uk_inventory_item` (`inventory_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `item_ingredient_mapping` WRITE;
/*!40000 ALTER TABLE `item_ingredient_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_ingredient_mapping` ENABLE KEYS */;
UNLOCK TABLES;

-- --------------------------------------------------------------------------------
-- routines (events/procs)
-- --------------------------------------------------------------------------------
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

/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `daily_expiration_check` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `daily_expiration_check` ON SCHEDULE EVERY 1 DAY STARTS '2025-11-14 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN

		DECLARE done INT DEFAULT FALSE;

		DECLARE v_item_id INT;

		DECLARE v_expiry_date DATE;

		DECLARE days_until_expiry INT;

    

		DECLARE cur CURSOR FOR 

				SELECT ItemID, ExpiryDate 

				FROM items 

				WHERE ExpiryDate IS NOT NULL;

    

		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    

		OPEN cur;

    

		read_loop: LOOP

				FETCH cur INTO v_item_id, v_expiry_date;

				IF done THEN

						LEAVE read_loop;

				END IF;

        

				SET days_until_expiry = DATEDIFF(v_expiry_date, CURDATE());

        

				IF days_until_expiry < 0 THEN

						UPDATE alerts 

						SET Status = 'Resolved'

						WHERE ItemID = v_item_id 

						AND Type = 'Expiry Soon' 

						AND Status = 'Pending';

            

						INSERT INTO alerts (Type, ItemID, Details, Status)

						SELECT 'Expired', v_item_id,

									 CONCAT('Item expired on ', DATE_FORMAT(v_expiry_date, '%Y-%m-%d'), '. Remove from inventory immediately.'),

									 'Pending'

						WHERE NOT EXISTS (

								SELECT 1 FROM alerts 

								WHERE ItemID = v_item_id 

								AND Type = 'Expired' 

								AND Status = 'Pending'

						);

            

				ELSEIF days_until_expiry >= 0 AND days_until_expiry <= 30 THEN

						INSERT INTO alerts (Type, ItemID, Details, Status)

						SELECT 'Expiry Soon', v_item_id,

									 CONCAT('Item will expire on ', DATE_FORMAT(v_expiry_date, '%Y-%m-%d'), '. Use within ', days_until_expiry, ' days.'),

									 'Pending'

						WHERE NOT EXISTS (

								SELECT 1 FROM alerts 

								WHERE ItemID = v_item_id 

								AND Type IN ('Expiry Soon', 'Expired')

								AND Status = 'Pending'

						);

            

				ELSE

						UPDATE alerts 

						SET Status = 'Resolved'

						WHERE ItemID = v_item_id 

						AND Type IN ('Expiry Soon', 'Expired')

						AND Status = 'Pending';

				END IF;

        

		END LOOP;

    

		CLOSE cur;
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `ev_check_expiry` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `ev_check_expiry` ON SCHEDULE EVERY 1 DAY STARTS '2025-09-28 23:07:58' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
		-- Expired items
		INSERT INTO notifications (title, message, type)
		SELECT 'Expired Item',
					 CONCAT('Expired: ', i.ItemName, ' (', i.ExpiryDate, ')'),
					 'pending'
		FROM items i
		WHERE i.ExpiryDate IS NOT NULL AND i.ExpiryDate < CURRENT_DATE();

		-- Expiring soon (within 30 days)
		INSERT INTO notifications (title, message, type)
		SELECT 'Expiring Soon',
					 CONCAT('Expiring soon: ', i.ItemName, ' (', i.ExpiryDate, ')'),
					 'pending'
		FROM items i
		WHERE i.ExpiryDate IS NOT NULL
			AND i.ExpiryDate BETWEEN CURRENT_DATE() AND (CURRENT_DATE() + INTERVAL 30 DAY);
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `ev_expiring_soon_alerts` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `ev_expiring_soon_alerts` ON SCHEDULE EVERY 1 DAY STARTS '2025-09-18 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
		INSERT INTO Alerts (ItemID, Type, Details, Status)
		SELECT i.ItemID, 'Expiring Soon',
					 CONCAT(s.ItemName, ' will expire on ', DATE_FORMAT(i.ExpiryDate, '%Y-%m-%d')),
					 'Pending'
		FROM Items i
		JOIN SupplierItems s ON i.SupplierItemID = s.SupplierItemID
		WHERE s.HasExpiry = 1
			AND i.ExpiryDate BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)
			AND i.Stock > 0
			AND NOT EXISTS (
					 SELECT 1 FROM Alerts a
					 WHERE a.ItemID = i.ItemID
						 AND a.Type = 'Expiring Soon'
						 AND a.Status = 'Pending'
			);
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `ev_low_stock_alerts` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `ev_low_stock_alerts` ON SCHEDULE EVERY 1 DAY STARTS '2025-09-17 22:55:39' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
		-- Insert low stock alerts for items below 10
		INSERT INTO Alerts (ItemID, Type, Details, Status)
		SELECT i.ItemID, 'Low Stock', 
					 CONCAT(i.ItemName, ' stock is below 10'), 
					 'Pending'
		FROM Items i
		WHERE i.Stock < i.minstock
			AND i.Conditions = 'Good'
			AND NOT EXISTS (
					SELECT 1 FROM Alerts a
					WHERE a.ItemID = i.ItemID 
						AND a.Type = 'Low Stock' 
						AND a.Status = 'Pending'
			);
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `ev_move_expired_items` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `ev_move_expired_items` ON SCHEDULE EVERY 1 DAY STARTS '2025-09-19 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
		-- Move expired items into Issues
		INSERT INTO Issues (ItemID, ItemName, Location, Stock, ExpiryDate, Conditions, QuantityAffected)
		SELECT i.ItemID, si.ItemName, 'Restaurant', i.Stock, i.ExpiryDate, 'Expired', i.Stock
		FROM Items i
		JOIN SupplierItems si ON i.SupplierItemID = si.SupplierItemID
		WHERE i.ExpiryDate IS NOT NULL AND i.ExpiryDate < CURDATE() AND i.Stock > 0;

		-- Reset expired items stock to 0
		UPDATE Items
		SET Stock = 0
		WHERE ExpiryDate IS NOT NULL AND ExpiryDate < CURDATE();
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

/*!50003 DROP PROCEDURE IF EXISTS `check_all_expirations` */;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_all_expirations`()
BEGIN

		DECLARE done INT DEFAULT FALSE;

		DECLARE v_item_id INT;

		DECLARE v_expiry_date DATE;

		DECLARE days_until_expiry INT;

    

		DECLARE cur CURSOR FOR 

				SELECT ItemID, ExpiryDate 

				FROM items 

				WHERE ExpiryDate IS NOT NULL;

    

		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    

		OPEN cur;

    

		read_loop: LOOP

				FETCH cur INTO v_item_id, v_expiry_date;

				IF done THEN

						LEAVE read_loop;

				END IF;

        

				SET days_until_expiry = DATEDIFF(v_expiry_date, CURDATE());

        

				IF days_until_expiry < 0 THEN

						UPDATE alerts 

						SET Status = 'Resolved'

						WHERE ItemID = v_item_id 

						AND Type = 'Expiry Soon' 

						AND Status = 'Pending';

            

						INSERT INTO alerts (Type, ItemID, Details, Status)

						SELECT 'Expired', v_item_id,

									 CONCAT('Item expired on ', DATE_FORMAT(v_expiry_date, '%Y-%m-%d'), '. Remove from inventory immediately.'),

									 'Pending'

						WHERE NOT EXISTS (

								SELECT 1 FROM alerts 

								WHERE ItemID = v_item_id 

								AND Type = 'Expired' 

								AND Status = 'Pending'

						);

            

				ELSEIF days_until_expiry >= 0 AND days_until_expiry <= 30 THEN

						INSERT INTO alerts (Type, ItemID, Details, Status)

						SELECT 'Expiry Soon', v_item_id,

									 CONCAT('Item will expire on ', DATE_FORMAT(v_expiry_date, '%Y-%m-%d'), '. Use within ', days_until_expiry, ' days.'),

									 'Pending'

						WHERE NOT EXISTS (

								SELECT 1 FROM alerts 

								WHERE ItemID = v_item_id 

								AND Type IN ('Expiry Soon', 'Expired')

								AND Status = 'Pending'

						);

            

				ELSE

						UPDATE alerts 

						SET Status = 'Resolved'

						WHERE ItemID = v_item_id 

						AND Type IN ('Expiry Soon', 'Expired')

						AND Status = 'Pending';

				END IF;

        

		END LOOP;

    

		CLOSE cur;
END ;;
DELIMITER ;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
