-- Script to add a new product following 3NF rules
-- We need to ensure parent records exist or create them

USE `greenspot_db`;

-- 1. Add a new category if it doesn't exist
INSERT INTO `ItemTypes` (`type_name`) VALUES ('Bakery');

-- 2. Add a new unit if it doesn't exist
INSERT INTO `Units` (`unit_name`) VALUES ('Loaf');

-- 3. Add the new product using the IDs from above
-- Assuming Bakery is ID 4 and Loaf is ID 5 (based on previous load_data.sql)
INSERT INTO `Products` (`item_num`, `description`, `quantity_on_hand`, `current_price`, `location_code`, `item_type_id`, `unit_id`) 
VALUES (3001, 'Whole Wheat Bread', 50, 4.50, 'B01', 4, 5);

-- 4. Record the initial purchase from a vendor (e.g., Bennet Farms - ID 1)
INSERT INTO `VendorPurchases` (`item_num`, `vendor_id`, `purchase_date`, `cost_per_unit`, `quantity_purchased`)
VALUES (3001, 1, CURDATE(), 2.10, 50);

-- Verify the addition
SELECT * FROM Products WHERE item_num = 3001;
