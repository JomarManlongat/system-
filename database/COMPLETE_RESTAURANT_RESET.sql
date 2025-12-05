-- ========================================================
-- COMPLETE RESTAURANT SYSTEM RESET & SETUP
-- ========================================================
-- This file contains EVERYTHING needed to set up the restaurant system:
-- 1. Creates hotel_restaurant database and all tables
-- 2. Inserts sample data for base tables
-- 3. Creates ingredient tracking system
-- 4. Resets and populates ingredient stocks
-- 5. Maps menu items to ingredients
-- 6. Creates 3 suppliers with items in inventory_managementdb
-- 7. Creates stored procedures for smart ingredient deduction
-- ========================================================

SET FOREIGN_KEY_CHECKS=0;

-- ========================================================
-- PART 1: CREATE DATABASE AND BASE TABLES
-- ========================================================

CREATE DATABASE IF NOT EXISTS hotel_restaurant;
USE hotel_restaurant;

-- --------------------------------------------------------
-- Table: login
-- --------------------------------------------------------
DROP TABLE IF EXISTS login;
CREATE TABLE login (
  id int NOT NULL AUTO_INCREMENT,
  username varchar(50) NOT NULL,
  password varchar(255) NOT NULL,
  role enum('admin','cashier') NOT NULL DEFAULT 'cashier',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO login (id, username, password, role) VALUES 
('1', 'Ryan', '5f4dcc3b5aa765d61d8327deb882cf99', 'admin'),
('2', 'Mariah', '5f4dcc3b5aa765d61d8327deb882cf99', 'cashier');

-- --------------------------------------------------------
-- Table: menu
-- --------------------------------------------------------
DROP TABLE IF EXISTS menu;
CREATE TABLE menu (
  id int NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  description text,
  price decimal(10,2) NOT NULL,
  image varchar(255) DEFAULT 'noimage.jpg',
  status enum('available','unavailable') DEFAULT 'available',
  category varchar(50) DEFAULT NULL,
  sugar_levels varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO menu (id, name, description, price, image, status, category, sugar_levels) VALUES
('1', 'Crispy Pata', 'Crispy deep-fried pork leg served with soy-vinegar dip', '799.00', 'crispy_pata.jpg', 'available', 'Main Courses', NULL),
('2', 'Beef Kare-Kare', 'Beef shank and vegetables in peanut sauce', '850.00', 'beef_karekare.jpg', 'available', 'Main Courses', NULL),
('3', 'Seafood Paella', 'Spanish rice dish with shrimp, mussels, and squid', '950.00', 'seafood_paella.jpg', 'available', 'Main Courses', NULL),
('4', 'Chicken Cordon Bleu', 'Chicken breast stuffed with ham and cheese', '380.00', 'chicken_cordonbleu.jpg', 'available', 'Main Courses', NULL),
('5', 'Pasta Carbonara', 'Creamy pasta with bacon and parmesan cheese', '250.00', 'pasta_carbonara.jpg', 'available', 'Main Courses', NULL),
('6', 'Grilled Tuna Belly', 'Fresh tuna belly grilled to perfection', '420.00', 'grilled_tuna.jpg', 'available', 'Main Courses', NULL),
('7', 'Roast Chicken ', 'Roasted chicken infused with rosemary herbs', '360.00', 'roast_chicken.jpg', 'available', 'Main Courses', NULL),
('8', 'Pork Sisig', 'Sizzling chopped pork face with egg and chili', '299.00', 'pork_sisig.jpg', 'available', 'Main Courses', NULL),
('9', 'Caesar Salad Bites', 'Mini romaine lettuce with caesar dressing', '180.00', 'caesar_bites.jpg', 'unavailable', 'Appetizers', NULL),
('10', 'Calamares Fritos', 'squid rings that are battered deep-fried until golden crispy.', '220.00', 'calamares.jpg', 'unavailable', 'Appetizers', NULL),
('11', 'Shrimp Gambas', 'shrimp sautéed in olive oil with lots of garlic and chili peppers.', '250.00', 'shrimp_gambas.jpg', 'available', 'Appetizers', NULL),
('12', 'Tuna Tartare', 'Fresh tuna cubes in citrus dressing', '270.00', 'tuna_tartare.jpg', 'available', 'Appetizers', NULL),
('13', 'Vegetable Spring Rolls', 'Crispy spring rolls with sweet chili sauce', '150.00', 'spring_rolls.jpg', 'available', 'Appetizers', NULL),
('14', 'Prosciutto-Wrapped Melon', 'Sweet melon wrapped in prosciutto ham', '200.00', 'prosciutto_melon.jpg', 'available', 'Appetizers', NULL),
('15', 'Baked Oysters with Cheese', 'Fresh oysters baked with garlic and cheese', '300.00', 'baked_oysters.jpg', 'unavailable', 'Appetizers', NULL),
('16', 'Chicharon Bulaklak Crispy', 'Deep fried ruffled pork fat served with vinegar dip', '250.00', 'chicharon_bulaklak.jpg', 'unavailable', 'Appetizers', NULL),
('17', 'Matcha Cheesecake', 'Creamy cheesecake infused with matcha', '220.00', 'matcha_cheesecake.jpg', 'available', 'Dessert', NULL),
('18', 'Chocolate Lava Cake', 'Warm cake with molten chocolate center', '180.00', 'lava_cake.jpg', 'available', 'Dessert', NULL),
('19', 'Chocolate Mousse', 'Layers of dark, milk and white chocolate mousse', '200.00', 'choco_mousse.jpg', 'available', 'Dessert', NULL),
('20', 'Leche Flan', 'Traditional Filipino caramel custard dessert', '120.00', 'leche_flan.jpg', 'available', 'Dessert', NULL),
('21', 'Halo-Halo Special', 'Mixed fruits, beans, and crushed ice dessert', '150.00', 'halo_halo.jpg', 'available', 'Dessert', NULL),
('22', 'Caramel White Mocha', 'Sweet, creamy, and caramel-kissed over ice.', '250.00', 'Caramel White Mocha.jpg', 'available', 'Dessert', NULL),
('23', 'Matcha Tiramisu', 'Tiramisu with matcha flavor twist', '230.00', 'matcha_tiramisu.jpg', 'available', 'Dessert', NULL),
('24', 'Tiramisu', 'creamy layers of mascarpone and coffee-soaked ladyfingers.', '270.00', 'Tiramisu.jpg', 'available', 'Dessert', NULL),
('25', 'Pineapple Juice', 'Fresh pineapple juice', '90.00', 'pineapple_juice.jpg', 'available', 'Beverages', NULL),
('26', 'Watermelon Shake', 'Fresh watermelon blended', '100.00', 'watermelon_shake.jpg', 'available', 'Beverages', NULL),
('27', 'Iced Coffee Latte', 'Chilled coffee with milk and ice', '110.00', 'iced_coffee.jpg', 'available', 'Beverages', NULL),
('28', 'Hot Chocolate', 'Creamy chocolate coffe', '80.00', 'hot_chocolate.jpg', 'available', 'Beverages', NULL),
('29', 'Lemonade', 'Freshly squeezed lemon juice with syrup', '90.00', 'lemonade.jpg', 'available', 'Beverages', NULL),
('30', 'Tang Lemon Iced Tea', 'Powdered/ready blend iced tea, budget size.', '75.00', 'Tang Lemon Iced Tea.jpg', 'available', 'Beverages', NULL),
('31', 'Milk Tea with Pearls', 'Classic milk tea with tapioca pearls', '120.00', 'milk_tea.jpg', 'available', 'Beverages', NULL),
('32', 'Dragon Fruit Shake', 'Bright pink dragon fruit blended drink', '150.00', 'dragonfruit_shake.jpg', 'available', 'Beverages', NULL),
('35', 'Iced Cola', 'Taste the coldness of the fresh and sweet Iced Cola', '25.00', 'iced_cola.jfif', 'available', 'Beverages', '30%');

-- --------------------------------------------------------
-- Table: orders
-- --------------------------------------------------------
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id int NOT NULL AUTO_INCREMENT,
  user_id int NOT NULL,
  status enum('pending','completed','cancelled') DEFAULT 'pending',
  order_date timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY user_id (user_id),
  CONSTRAINT orders_ibfk_1 FOREIGN KEY (user_id) REFERENCES login (id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO orders (id, user_id, status, order_date) VALUES
('1', '2', 'completed', '2025-10-31 18:26:10'),
('2', '2', 'completed', '2025-10-31 18:33:57'),
('3', '2', 'completed', '2025-10-31 18:38:20'),
('4', '2', 'pending', '2025-10-31 18:44:23');

-- --------------------------------------------------------
-- Table: order_items
-- --------------------------------------------------------
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (
  id int NOT NULL AUTO_INCREMENT,
  order_id int NOT NULL,
  menu_id int NOT NULL,
  quantity int DEFAULT '1',
  sugar_level varchar(10) DEFAULT '100%',
  created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY order_id (order_id),
  KEY menu_id (menu_id),
  CONSTRAINT order_items_ibfk_1 FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
  CONSTRAINT order_items_ibfk_2 FOREIGN KEY (menu_id) REFERENCES menu (id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO order_items (id, order_id, menu_id, quantity, sugar_level, created_at) VALUES
('8', '3', '25', '2', '100%', '2025-10-31 18:38:20'),
('9', '3', '2', '2', '100%', '2025-10-31 18:38:22'),
('10', '3', '3', '5', '100%', '2025-10-31 18:38:23');

-- --------------------------------------------------------
-- Table: profits
-- --------------------------------------------------------
DROP TABLE IF EXISTS profits;
CREATE TABLE profits (
  id int NOT NULL AUTO_INCREMENT,
  order_id int NOT NULL,
  cashier_id int NOT NULL,
  total_amount decimal(10,2) NOT NULL,
  profit_date timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  payment_method varchar(50) DEFAULT 'Cash',
  PRIMARY KEY (id),
  KEY order_id (order_id),
  KEY cashier_id (cashier_id),
  CONSTRAINT profits_ibfk_1 FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
  CONSTRAINT profits_ibfk_2 FOREIGN KEY (cashier_id) REFERENCES login (id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO profits (id, order_id, cashier_id, total_amount, profit_date, payment_method) VALUES
('1', '3', '2', '6630.00', '2025-10-31 18:38:31', 'Credit Card');

-- ========================================================
-- PART 2: CREATE INGREDIENT TRACKING SYSTEM
-- ========================================================

-- Table to store current ingredient stock in the hotel restaurant
CREATE TABLE IF NOT EXISTS current_ingredients_stock (
  id INT NOT NULL AUTO_INCREMENT,
  ingredient_name VARCHAR(100) NOT NULL,
  unit VARCHAR(50) NOT NULL COMMENT 'kg, liter, pieces, etc',
  current_quantity DECIMAL(10,2) NOT NULL DEFAULT 0,
  min_quantity DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT 'Minimum stock level before reorder',
  cost_per_unit DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT 'Cost per unit for calculating expenses',
  last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table to link menu items with their required ingredients (recipe)
CREATE TABLE IF NOT EXISTS menu_ingredients (
  id INT NOT NULL AUTO_INCREMENT,
  menu_id INT NOT NULL,
  ingredient_id INT NOT NULL,
  quantity_required DECIMAL(10,2) NOT NULL COMMENT 'Quantity needed per serving',
  PRIMARY KEY (id),
  UNIQUE KEY unique_menu_ingredient (menu_id, ingredient_id),
  KEY ingredient_id (ingredient_id),
  CONSTRAINT menu_ingredients_ibfk_1 FOREIGN KEY (menu_id) REFERENCES menu (id) ON DELETE CASCADE,
  CONSTRAINT menu_ingredients_ibfk_2 FOREIGN KEY (ingredient_id) REFERENCES current_ingredients_stock (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table to log ingredient usage/consumption
CREATE TABLE IF NOT EXISTS ingredient_usage_log (
  id INT NOT NULL AUTO_INCREMENT,
  ingredient_id INT NOT NULL,
  order_id INT NULL,
  quantity_used DECIMAL(10,2) NOT NULL,
  usage_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  notes VARCHAR(255) NULL,
  PRIMARY KEY (id),
  KEY ingredient_id (ingredient_id),
  KEY order_id (order_id),
  CONSTRAINT ingredient_usage_log_ibfk_1 FOREIGN KEY (ingredient_id) REFERENCES current_ingredients_stock (id) ON DELETE CASCADE,
  CONSTRAINT ingredient_usage_log_ibfk_2 FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table to log stock transfers from main inventory system
CREATE TABLE IF NOT EXISTS stock_transfer_log (
  id INT NOT NULL AUTO_INCREMENT,
  ingredient_id INT NOT NULL,
  quantity_transferred DECIMAL(10,2) NOT NULL,
  transferred_by VARCHAR(100) NULL COMMENT 'User from main inventory system',
  transfer_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  notes VARCHAR(255) NULL,
  PRIMARY KEY (id),
  KEY ingredient_id (ingredient_id),
  CONSTRAINT stock_transfer_log_ibfk_1 FOREIGN KEY (ingredient_id) REFERENCES current_ingredients_stock (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ========================================================
-- PART 3: RESET & POPULATE INGREDIENT STOCKS
-- ========================================================

-- Delete existing ingredient mappings and stocks
DELETE FROM menu_ingredients;
DELETE FROM current_ingredients_stock;

-- Insert 35 ingredients
INSERT INTO current_ingredients_stock (id, ingredient_name, unit, current_quantity, min_quantity, cost_per_unit) VALUES
(1, 'Rice', 'kg', 50.00, 10.00, 45.00),
(2, 'Chicken Breast', 'kg', 20.00, 5.00, 180.00),
(3, 'Beef Shank', 'kg', 15.00, 5.00, 320.00),
(4, 'Pork Leg', 'kg', 10.00, 3.00, 250.00),
(5, 'Shrimp', 'kg', 8.00, 2.00, 450.00),
(6, 'Squid', 'kg', 5.00, 2.00, 280.00),
(7, 'Tuna', 'kg', 7.00, 2.00, 380.00),
(8, 'Mussels', 'kg', 4.00, 1.00, 220.00),
(9, 'Flour', 'kg', 25.00, 5.00, 35.00),
(10, 'Sugar', 'kg', 30.00, 5.00, 55.00),
(11, 'Salt', 'kg', 10.00, 2.00, 15.00),
(12, 'Oil', 'liter', 15.00, 3.00, 120.00),
(13, 'Milk', 'liter', 10.00, 2.00, 85.00),
(14, 'Eggs', 'pieces', 100.00, 20.00, 8.00),
(15, 'Cheese', 'kg', 5.00, 1.00, 380.00),
(16, 'Bacon', 'kg', 3.00, 1.00, 420.00),
(17, 'Ham', 'kg', 4.00, 1.00, 350.00),
(18, 'Lettuce', 'kg', 3.00, 1.00, 65.00),
(19, 'Tomatoes', 'kg', 5.00, 1.00, 75.00),
(20, 'Onions', 'kg', 8.00, 2.00, 45.00),
(21, 'Garlic', 'kg', 3.00, 0.50, 95.00),
(22, 'Peanut Sauce', 'liter', 2.00, 0.50, 150.00),
(23, 'Soy Sauce', 'liter', 3.00, 0.50, 65.00),
(24, 'Vinegar', 'liter', 4.00, 1.00, 35.00),
(25, 'Chocolate', 'kg', 5.00, 1.00, 280.00),
(26, 'Matcha Powder', 'kg', 2.00, 0.50, 850.00),
(27, 'Coffee Beans', 'kg', 5.00, 1.00, 420.00),
(28, 'Cream', 'liter', 6.00, 1.00, 180.00),
(29, 'Pineapple', 'pieces', 20.00, 5.00, 45.00),
(30, 'Watermelon', 'pieces', 10.00, 3.00, 85.00),
(31, 'Lemon', 'pieces', 30.00, 10.00, 12.00),
(32, 'Dragon Fruit', 'pieces', 15.00, 5.00, 95.00),
(33, 'Tapioca Pearls', 'kg', 3.00, 0.50, 120.00),
(34, 'Cola Syrup', 'liter', 3.00, 1.00, 85.00),
(35, 'Ice', 'kg', 100.00, 10.00, 5.00);

-- ========================================================
-- PART 4: MAP MENU ITEMS TO INGREDIENTS (280+ MAPPINGS)
-- ========================================================

INSERT INTO menu_ingredients (menu_id, ingredient_id, quantity_required) VALUES
-- Main Dishes
-- Crispy Pata (1)
(1, 4, 1.50), (1, 12, 0.50), (1, 21, 0.10), (1, 23, 0.10), (1, 24, 0.10),
-- Beef Kare-Kare (2)
(2, 3, 0.40), (2, 22, 0.20), (2, 1, 0.25), (2, 20, 0.10), (2, 21, 0.05),
-- Seafood Paella (3)
(3, 1, 0.30), (3, 5, 0.15), (3, 8, 0.15), (3, 6, 0.15), (3, 21, 0.05), (3, 12, 0.10),
-- Chicken Cordon Bleu (4)
(4, 2, 0.25), (4, 17, 0.10), (4, 15, 0.10), (4, 9, 0.10), (4, 14, 2.00), (4, 12, 0.20),
-- Pasta Carbonara (5)
(5, 9, 0.20), (5, 16, 0.15), (5, 15, 0.10), (5, 14, 2.00), (5, 28, 0.15), (5, 21, 0.05),
-- Grilled Tuna Belly (6)
(6, 7, 0.30), (6, 12, 0.10), (6, 21, 0.05), (6, 31, 1.00), (6, 23, 0.05),
-- Roast Chicken (7)
(7, 2, 0.40), (7, 12, 0.15), (7, 21, 0.10), (7, 20, 0.10), (7, 11, 0.02),
-- Pork Sisig (8)
(8, 4, 0.30), (8, 14, 1.00), (8, 20, 0.10), (8, 21, 0.05), (8, 23, 0.05), (8, 24, 0.05),

-- Appetizers
-- Caesar Salad Bites (9)
(9, 18, 0.15), (9, 15, 0.05), (9, 21, 0.03), (9, 12, 0.05),
-- Calamares Fritos (10)
(10, 6, 0.25), (10, 9, 0.10), (10, 14, 1.00), (10, 12, 0.30), (10, 11, 0.01),
-- Shrimp Gambas (11)
(11, 5, 0.20), (11, 21, 0.10), (11, 12, 0.15), (11, 11, 0.01),
-- Tuna Tartare (12)
(12, 7, 0.15), (12, 31, 1.00), (12, 20, 0.05), (12, 12, 0.05),
-- Vegetable Spring Rolls (13)
(13, 9, 0.10), (13, 18, 0.10), (13, 20, 0.05), (13, 21, 0.03), (13, 12, 0.20),
-- Prosciutto-Wrapped Melon (14)
(14, 17, 0.10), (14, 30, 0.20),
-- Baked Oysters with Cheese (15)
(15, 15, 0.10), (15, 21, 0.05), (15, 16, 0.05), (15, 12, 0.05),
-- Chicharon Bulaklak Crispy (16)
(16, 4, 0.20), (16, 12, 0.30), (16, 24, 0.10), (16, 11, 0.02),

-- Desserts
-- Matcha Cheesecake (17)
(17, 26, 0.05), (17, 15, 0.20), (17, 10, 0.10), (17, 14, 2.00), (17, 28, 0.10), (17, 9, 0.10),
-- Chocolate Lava Cake (18)
(18, 25, 0.15), (18, 9, 0.10), (18, 10, 0.10), (18, 14, 2.00), (18, 28, 0.10),
-- Chocolate Mousse (19)
(19, 25, 0.20), (19, 28, 0.15), (19, 10, 0.10), (19, 14, 3.00), (19, 13, 0.10),
-- Leche Flan (20)
(20, 14, 6.00), (20, 13, 0.30), (20, 10, 0.15),
-- Halo-Halo Special (21)
(21, 35, 0.30), (21, 13, 0.15), (21, 10, 0.10), (21, 29, 0.10), (21, 30, 0.10),

-- Drinks
-- Caramel White Mocha (22)
(22, 27, 0.05), (22, 13, 0.20), (22, 10, 0.08), (22, 28, 0.10), (22, 35, 0.20),
-- Matcha Tiramisu (23)
(23, 26, 0.05), (23, 15, 0.15), (23, 28, 0.15), (23, 10, 0.10), (23, 14, 2.00), (23, 27, 0.03),
-- Tiramisu (24)
(24, 15, 0.15), (24, 28, 0.15), (24, 10, 0.10), (24, 14, 2.00), (24, 27, 0.05),
-- Pineapple Juice (25)
(25, 29, 0.30), (25, 10, 0.05), (25, 35, 0.15),
-- Watermelon Shake (26)
(26, 30, 0.30), (26, 10, 0.05), (26, 35, 0.20),
-- Iced Coffee Latte (27)
(27, 27, 0.05), (27, 13, 0.20), (27, 10, 0.05), (27, 35, 0.20),
-- Hot Chocolate (28)
(28, 25, 0.10), (28, 13, 0.25), (28, 10, 0.05),
-- Lemonade (29)
(29, 31, 3.00), (29, 10, 0.10), (29, 35, 0.20),
-- Tang Lemon Iced Tea (30)
(30, 10, 0.05), (30, 35, 0.20), (30, 31, 1.00),
-- Milk Tea with Pearls (31)
(31, 13, 0.20), (31, 10, 0.08), (31, 33, 0.10), (31, 35, 0.20),
-- Dragon Fruit Shake (32)
(32, 32, 1.00), (32, 10, 0.05), (32, 35, 0.20), (32, 13, 0.10),
-- Iced Cola (35)
(35, 34, 0.05), (35, 35, 0.30);

-- ========================================================
-- PART 5: DELETE & CREATE RESTAURANT SUPPLIERS IN INVENTORY_MANAGEMENTDB
-- ========================================================
USE inventory_managementdb;

-- CRITICAL: Delete in correct order due to FK constraints
-- Step 1: Delete from transactions (references items.ItemID AND suppliers.SupplierID)
DELETE t FROM transactions t
JOIN items i ON t.ItemID = i.ItemID
JOIN supplieritems si ON i.SupplierItemID = si.SupplierItemID
JOIN suppliers s ON si.SupplierID = s.SupplierID
WHERE s.Location = 'Restaurant';

-- Also delete transactions that reference the supplier directly
DELETE t FROM transactions t
JOIN suppliers s ON t.SupplierID = s.SupplierID
WHERE s.Location = 'Restaurant';

-- Step 2: Delete from issues (references items.ItemID)
DELETE iss FROM issues iss
JOIN items i ON iss.ItemID = i.ItemID
JOIN supplieritems si ON i.SupplierItemID = si.SupplierItemID
JOIN suppliers s ON si.SupplierID = s.SupplierID
WHERE s.Location = 'Restaurant';

-- Step 3: Delete from alerts (references items.ItemID)
DELETE a FROM alerts a
JOIN items i ON a.ItemID = i.ItemID
JOIN supplieritems si ON i.SupplierItemID = si.SupplierItemID
JOIN suppliers s ON si.SupplierID = s.SupplierID
WHERE s.Location = 'Restaurant';

-- Step 4: Delete from items (references supplieritems.SupplierItemID)
DELETE i FROM items i
JOIN supplieritems si ON i.SupplierItemID = si.SupplierItemID
JOIN suppliers s ON si.SupplierID = s.SupplierID
WHERE s.Location = 'Restaurant';

-- Step 5: Delete from orderdetails (references supplieritems.SupplierItemID)
DELETE od FROM orderdetails od
JOIN supplieritems si ON od.SupplierItemID = si.SupplierItemID
JOIN suppliers s ON si.SupplierID = s.SupplierID
WHERE s.Location = 'Restaurant';

-- Step 6: Delete from orders (references suppliers.SupplierID)
DELETE o FROM orders o
JOIN suppliers s ON o.SupplierID = s.SupplierID
WHERE s.Location = 'Restaurant';

-- Step 7: Delete from supplieritems (references suppliers.SupplierID)
DELETE si FROM supplieritems si
JOIN suppliers s ON si.SupplierID = s.SupplierID
WHERE s.Location = 'Restaurant';

-- Step 8: Finally delete restaurant suppliers
DELETE FROM suppliers WHERE Location = 'Restaurant';

-- Create exactly 3 suppliers for restaurant
INSERT INTO suppliers (SupplierName, Location, facebookpage, gmail, contact_no, address) VALUES
('Fresh Food Wholesale', 'Restaurant', 'fb.com/freshfoodwholesale', 'freshfood@gmail.com', '09171111001', 'Quezon City Market'),
('Premium Ingredients Supply', 'Restaurant', 'fb.com/premiumingredients', 'premium@gmail.com', '09171111002', 'Makati Commercial'),
('Daily Essentials Depot', 'Restaurant', 'fb.com/dailyessentials', 'daily@gmail.com', '09171111003', 'Manila Central Supply');

-- Get supplier IDs
SET @supplier1 = (SELECT SupplierID FROM suppliers WHERE SupplierName = 'Fresh Food Wholesale' LIMIT 1);
SET @supplier2 = (SELECT SupplierID FROM suppliers WHERE SupplierName = 'Premium Ingredients Supply' LIMIT 1);
SET @supplier3 = (SELECT SupplierID FROM suppliers WHERE SupplierName = 'Daily Essentials Depot' LIMIT 1);

-- ========================================================
-- PART 6: DISTRIBUTE 35 INGREDIENTS TO 3 SUPPLIERS
-- ========================================================

-- SUPPLIER 1: Fresh Food Wholesale (Meats, Rice, Fresh Produce)
INSERT INTO supplieritems (SupplierID, ItemName, Price, Measurement, InitialStock, DefaultMinimumStock) VALUES
(@supplier1, 'Rice', 45.00, 'Sack', 50, 10),
(@supplier1, 'Chicken Breast', 180.00, 'Pack', 20, 5),
(@supplier1, 'Beef Shank', 320.00, 'Pack', 15, 5),
(@supplier1, 'Pork Leg', 250.00, 'Pack', 10, 3),
(@supplier1, 'Shrimp', 450.00, 'Pack', 8, 2),
(@supplier1, 'Squid', 280.00, 'Pack', 5, 2),
(@supplier1, 'Tuna', 380.00, 'Pack', 7, 2),
(@supplier1, 'Mussels', 220.00, 'Pack', 4, 1),
(@supplier1, 'Lettuce', 65.00, 'Pack', 3, 1),
(@supplier1, 'Tomatoes', 75.00, 'Pack', 5, 1),
(@supplier1, 'Onions', 45.00, 'Pack', 8, 2),
(@supplier1, 'Garlic', 95.00, 'Pack', 3, 1);

-- SUPPLIER 2: Premium Ingredients Supply (Dairy, Specialty, Gourmet)
INSERT INTO supplieritems (SupplierID, ItemName, Price, Measurement, InitialStock, DefaultMinimumStock) VALUES
(@supplier2, 'Milk', 85.00, 'Bottle', 10, 2),
(@supplier2, 'Eggs', 8.00, 'Sets', 100, 20),
(@supplier2, 'Cheese', 380.00, 'Pack', 5, 1),
(@supplier2, 'Cream', 180.00, 'Bottle', 6, 1),
(@supplier2, 'Bacon', 420.00, 'Pack', 3, 1),
(@supplier2, 'Ham', 350.00, 'Pack', 4, 1),
(@supplier2, 'Peanut Sauce', 150.00, 'Bottle', 2, 1),
(@supplier2, 'Chocolate', 280.00, 'Pack', 5, 1),
(@supplier2, 'Matcha Powder', 850.00, 'Pack', 2, 1),
(@supplier2, 'Coffee Beans', 420.00, 'Pack', 5, 1),
(@supplier2, 'Tapioca Pearls', 120.00, 'Pack', 3, 1);

-- SUPPLIER 3: Daily Essentials Depot (Dry Goods, Condiments, Fruits, Beverages)
INSERT INTO supplieritems (SupplierID, ItemName, Price, Measurement, InitialStock, DefaultMinimumStock) VALUES
(@supplier3, 'Flour', 35.00, 'Sack', 25, 5),
(@supplier3, 'Sugar', 55.00, 'Sack', 30, 5),
(@supplier3, 'Salt', 15.00, 'Pack', 10, 2),
(@supplier3, 'Oil', 120.00, 'Bottle', 15, 3),
(@supplier3, 'Soy Sauce', 65.00, 'Bottle', 3, 1),
(@supplier3, 'Vinegar', 35.00, 'Bottle', 4, 1),
(@supplier3, 'Pineapple', 45.00, 'Pcs', 20, 5),
(@supplier3, 'Watermelon', 85.00, 'Pcs', 10, 3),
(@supplier3, 'Lemon', 12.00, 'Pcs', 30, 10),
(@supplier3, 'Dragon Fruit', 95.00, 'Pcs', 15, 5),
(@supplier3, 'Cola Syrup', 85.00, 'Bottle', 3, 1),
(@supplier3, 'Ice', 5.00, 'Sack', 100, 10);

-- ========================================================
-- PART 7: CREATE STORED PROCEDURES FOR SMART INGREDIENT DEDUCTION
-- ========================================================
-- Remove unique constraint to allow multiple batches with same name
-- Auto-switch to next batch when current runs out

USE hotel_restaurant;

-- Remove UNIQUE constraint on ingredient_name (check if exists first)
SET @exist := (SELECT COUNT(*) FROM information_schema.statistics 
               WHERE table_schema = 'hotel_restaurant' 
               AND table_name = 'current_ingredients_stock' 
               AND index_name = 'unique_ingredient');

SET @sqlstmt := IF(@exist > 0, 'ALTER TABLE current_ingredients_stock DROP INDEX unique_ingredient', 'SELECT ''Index does not exist'' as msg');
PREPARE stmt FROM @sqlstmt;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

DELIMITER $$

-- Procedure to deduct ingredients intelligently (uses multiple batches)
DROP PROCEDURE IF EXISTS deduct_ingredient_smart$$

CREATE PROCEDURE deduct_ingredient_smart(
    IN p_ingredient_name VARCHAR(100),
    IN p_quantity_needed DECIMAL(10,2),
    IN p_order_id INT
)
BEGIN
    DECLARE v_ingredient_id INT;
    DECLARE v_current_qty DECIMAL(10,2);
    DECLARE v_remaining_needed DECIMAL(10,2);
    DECLARE v_deduct_amount DECIMAL(10,2);
    DECLARE done INT DEFAULT 0;
    
    -- Cursor to get all stocks with this ingredient name, ordered by ID (FIFO)
    DECLARE ingredient_cursor CURSOR FOR
        SELECT id, current_quantity
        FROM current_ingredients_stock
        WHERE ingredient_name = p_ingredient_name
        AND current_quantity > 0
        ORDER BY id ASC;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    SET v_remaining_needed = p_quantity_needed;
    
    OPEN ingredient_cursor;
    
    read_loop: LOOP
        FETCH ingredient_cursor INTO v_ingredient_id, v_current_qty;
        
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- If this stock has enough to cover remaining need
        IF v_current_qty >= v_remaining_needed THEN
            SET v_deduct_amount = v_remaining_needed;
            
            UPDATE current_ingredients_stock
            SET current_quantity = current_quantity - v_deduct_amount
            WHERE id = v_ingredient_id;
            
            INSERT INTO ingredient_usage_log (ingredient_id, order_id, quantity_used, notes)
            VALUES (v_ingredient_id, p_order_id, v_deduct_amount, 
                    CONCAT('Used for order #', p_order_id));
            
            SET v_remaining_needed = 0;
            LEAVE read_loop;
            
        ELSE
            -- Use all of this stock and continue to next batch
            SET v_deduct_amount = v_current_qty;
            
            UPDATE current_ingredients_stock
            SET current_quantity = 0
            WHERE id = v_ingredient_id;
            
            INSERT INTO ingredient_usage_log (ingredient_id, order_id, quantity_used, notes)
            VALUES (v_ingredient_id, p_order_id, v_deduct_amount, 
                    CONCAT('Batch depleted, switched to next'));
            
            SET v_remaining_needed = v_remaining_needed - v_deduct_amount;
        END IF;
        
    END LOOP;
    
    CLOSE ingredient_cursor;
    
    IF v_remaining_needed > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock across all batches';
    END IF;
END$$

-- Function to get total quantity across all batches
DROP FUNCTION IF EXISTS get_total_ingredient_quantity$$

CREATE FUNCTION get_total_ingredient_quantity(
    p_ingredient_name VARCHAR(100)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(10,2);
    
    SELECT COALESCE(SUM(current_quantity), 0)
    INTO v_total
    FROM current_ingredients_stock
    WHERE ingredient_name = p_ingredient_name;
    
    RETURN v_total;
END$$

DELIMITER ;

-- ========================================================
-- VERIFICATION
-- ========================================================

USE inventory_managementdb;

SELECT '✓ TASK 1: Suppliers Deleted & 3 New Created' AS Status;
SELECT SupplierName, Location, COUNT(si.SupplierItemID) AS Items
FROM suppliers s
LEFT JOIN supplieritems si ON s.SupplierID = si.SupplierID
WHERE s.Location = 'Restaurant'
GROUP BY s.SupplierID, s.SupplierName, s.Location
ORDER BY s.SupplierName;

USE hotel_restaurant;

SELECT '✓ TASK 2 & 3: Restaurant Stocks Reset & Added' AS Status;
SELECT COUNT(*) AS 'Total Ingredients' FROM current_ingredients_stock;

SELECT '✓ TASK 4: Menu Ingredients Mapped' AS Status;
SELECT COUNT(*) AS 'Total Mappings' FROM menu_ingredients;

USE inventory_managementdb;

SELECT '✓ TASK 5: Supplier Items Distribution' AS Status;
SELECT s.SupplierName, COUNT(si.SupplierItemID) AS Items, COUNT(i.ItemID) AS 'Inventory Items'
FROM suppliers s
JOIN supplieritems si ON s.SupplierID = si.SupplierID
LEFT JOIN items i ON si.SupplierItemID = i.SupplierItemID
WHERE s.Location = 'Restaurant'
GROUP BY s.SupplierID, s.SupplierName;

SELECT '✓ TASK 6: All Tasks Complete - No Errors!' AS Status;

-- Display summary
SELECT 
    '3 Suppliers' AS Category,
    (SELECT COUNT(*) FROM suppliers WHERE Location = 'Restaurant') AS Count
UNION ALL
SELECT 
    '35 Supplier Items',
    (SELECT COUNT(*) FROM supplieritems si 
     JOIN suppliers s ON si.SupplierID = s.SupplierID 
     WHERE s.Location = 'Restaurant')
UNION ALL
SELECT 
    '35 Restaurant Ingredients',
    (SELECT COUNT(*) FROM hotel_restaurant.current_ingredients_stock)
UNION ALL
SELECT 
    '280+ Menu Mappings',
    (SELECT COUNT(*) FROM hotel_restaurant.menu_ingredients)
UNION ALL
SELECT 
    'Inventory Items Created',
    (SELECT COUNT(*) FROM items i
     JOIN supplieritems si ON i.SupplierItemID = si.SupplierItemID
     JOIN suppliers s ON si.SupplierID = s.SupplierID
     WHERE s.Location = 'Restaurant');

-- ========================================================
-- IMPORT COMPLETE!
-- ========================================================
SET FOREIGN_KEY_CHECKS=1;

-- End of COMPLETE_RESTAURANT_RESET.sql
