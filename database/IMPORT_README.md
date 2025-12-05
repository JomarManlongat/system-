# Database Import Guide - MySQL Workbench

## 📋 What You Need

**Just 2 SQL files in this folder:**
1. `COMPLETE_RESTAURANT_RESET.sql` - Restaurant database (complete with CREATE statements)
2. `inventory_managementdb.sql` - Inventory database (complete with CREATE statements)

**That's it!** All other files have been removed. Each SQL file contains everything needed:
- CREATE DATABASE statements
- CREATE TABLE statements for all tables
- INSERT statements with sample/initial data
- CREATE PROCEDURE/FUNCTION statements
- Complete setup from scratch on a fresh machine

---

## 🚀 Import Steps (MySQL Workbench)

### Step 1: Copy Project to New Computer
1. Copy the entire `system` folder to `c:\xampp\htdocs\` on the new machine
2. Install XAMPP if not already installed
3. Start MySQL service in XAMPP Control Panel

### Step 2: Open MySQL Workbench
1. Launch MySQL Workbench
2. Connect to your local MySQL instance (usually `localhost:3306`)
3. Use `root` user (default XAMPP user with no password)

### Step 3: Import Restaurant Database

1. In Workbench menu: **Server → Data Import**
2. Select **"Import from Self-Contained File"**
3. Click **[...]** and browse to: `c:\xampp\htdocs\system\database\COMPLETE_RESTAURANT_RESET.sql`
4. Under **"Default Target Schema"**, select **"<New...>"** and type: `hotel_restaurant`
   - (Or select `hotel_restaurant` if it already exists)
5. **IMPORTANT:** Check the box **"Dump Structure and Data"**
6. Click **"Start Import"** at the bottom
7. Wait for completion (usually 10-30 seconds)
8. You should see: ✓ Database created, ✓ 9 tables created, ✓ Data inserted, ✓ Procedures created

### Step 4: Import Inventory Database

1. In Workbench menu: **Server → Data Import**
2. Select **"Import from Self-Contained File"**
3. Click **[...]** and browse to: `c:\xampp\htdocs\system\database\inventory_managementdb.sql`
4. Under **"Default Target Schema"**, select **"<New...>"** and type: `inventory_managementdb`
   - (Or select `inventory_managementdb` if it already exists)
5. **IMPORTANT:** Check the box **"Dump Structure and Data"**
6. Click **"Start Import"**
7. Wait for completion (usually 10-30 seconds)
8. You should see: ✓ Database created, ✓ 14+ tables created, ✓ Data inserted, ✓ Events created

---

## ✅ Verify Import

After both imports complete, run this in Workbench SQL editor:

```sql
-- Check restaurant database
SELECT 'Menu Items' AS Item, COUNT(*) AS Count FROM hotel_restaurant.menu
UNION ALL
SELECT 'Ingredients', COUNT(*) FROM hotel_restaurant.current_ingredients_stock
UNION ALL
SELECT 'Menu Mappings', COUNT(*) FROM hotel_restaurant.menu_ingredients
UNION ALL
-- Check inventory database
SELECT 'Suppliers', COUNT(*) FROM inventory_managementdb.suppliers
UNION ALL
SELECT 'Items', COUNT(*) FROM inventory_managementdb.items
UNION ALL
SELECT 'Users', COUNT(*) FROM inventory_managementdb.users;
```

**Expected results:**
- Menu Items: ~32
- Ingredients: ~35
- Menu Mappings: 280+
- Suppliers: 5
- Items: 35+
- Users: 5

---

## ⚙️ Update PHP Credentials (IMPORTANT!)

If your MySQL password is different from the default, update these files:

**Restaurant system:**
- `HotelLuneraRestaurant\connection.php`
- `HotelLuneraRestaurant\admin\connection.php`

**Restaurant system:**
- `HotelLuneraRestaurant\connection.php`
- `HotelLuneraRestaurant\admin\connection.php`

**Inventory system:**
- `main_inventory_system\login\database-account.php`

**Shared/Bridge:**
- `shared\dual_connection.php`

Search for `$password = "Jojenjusjmjai09";` and replace with your MySQL password.

---

## 🌐 Access the System

1. Ensure XAMPP Apache and MySQL are running
2. Open browser and go to:
   - **Restaurant:** `http://localhost/system/HotelLuneraRestaurant/`
   - **Inventory:** `http://localhost/system/main_inventory_system/`

**Default login credentials:**
- Restaurant: username `ryan`, password `password`
- Inventory: username `admin`, password `admin`

---

## 🛠️ Troubleshooting

### Workbench import fails with "DELIMITER" error
- This can happen with stored procedures/events
- **Solution:** Use "Import from Dump Project Folder" instead, or import via command line:
  ```
  C:\xampp\mysql\bin\mysql.exe -u root -p hotel_restaurant < "c:\xampp\htdocs\system\database\COMPLETE_RESTAURANT_RESET.sql"
  C:\xampp\mysql\bin\mysql.exe -u root -p inventory_managementdb < "c:\xampp\htdocs\system\database\inventory_managementdb.sql"
  ```

### "Access denied" or "Cannot create routine"
- Ensure you're using `root` user
- Your MySQL user needs `CREATE ROUTINE`, `EVENT`, and `TRIGGER` privileges

### App shows "Table doesn't exist"
- Verify databases exist in Workbench
- Re-import the SQL files
- Check PHP connection credentials match your MySQL password

### Session/login problems
- Clear browser cookies and cache
- Verify both databases imported successfully

---

## 📦 What's Included

**COMPLETE_RESTAURANT_RESET.sql contains:**
- `menu` table - 32 menu items
- `menu_ingredients` - 280+ ingredient mappings
- `current_ingredients_stock` - 35 ingredients with FIFO batches
- `orders`, `order_items` - Order history
- `profits` - Profit tracking
- `login` - Restaurant user accounts
- Stored procedures for smart ingredient deduction
- Events for stock expiration and auto-transfers

**inventory_managementdb.sql contains:**
- `suppliers` - 5 suppliers (restaurant/room/both)
- `supplieritems` - 35 supplier items
- `items` - Inventory items with stock tracking
- `users` - 5 user accounts (admin, manager, staff)
- `orders`, `orderdetails` - Purchase orders
- `transactions` - All stock movements
- `alerts`, `issues`, `notifications` - Monitoring system
- `item_usage` - Usage tracking
- Events for low stock and expiration alerts
- Procedures for expiration checks

---

## ✅ Final Checklist

After import:
- [ ] Both databases visible in Workbench navigator
- [ ] Restaurant has 32 menu items and 35 ingredients
- [ ] Inventory has 5 suppliers and 35+ items
- [ ] Can log into restaurant system (ryan / password)
- [ ] Can log into inventory system (admin / admin)
- [ ] No PHP errors on homepage
- [ ] Menu items show properly in restaurant interface
