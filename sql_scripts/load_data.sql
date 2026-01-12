-- Normalized data for Greenspot Grocer (3NF Version)
USE `greenspot_db`;

-- 1. Insert Item Types
INSERT INTO `ItemTypes` (`type_name`) VALUES ('Dairy'), ('Produce'), ('Canned');

-- 2. Insert Units (Eliminating duplicates and inconsistencies)
INSERT INTO `Units` (`unit_name`) VALUES ('dozen'), ('bunch'), ('12 oz can'), ('36 oz can');

-- 3. Insert Vendors
INSERT INTO `Vendors` (`vendor_name`, `vendor_address`) VALUES 
('Bennet Farms', 'Rt. 17 Evansville, IL 55446'),
('Freshness, Inc.', '202 E. Maple St., St. Joseph, MO 45678'),
('Ruby Redd Produce, LLC', '1212 Milam St., Kenosha, AL 34567');

-- 4. Insert Products (Linking to ItemTypes and Units)
-- unit_id: 1=dozen, 2=bunch, 3=12oz, 4=36oz
INSERT INTO `Products` (`item_num`, `description`, `quantity_on_hand`, `current_price`, `location_code`, `item_type_id`, `unit_id`) VALUES 
(1000, 'Bennet Farm free-range eggs', 21, 5.49, 'D12', 1, 1),
(2000, 'Ruby\'s Kale', 26, 3.99, 'P12', 2, 2),
(1100, 'Freshness White beans', 41, 1.49, 'A2', 3, 3),
(1222, 'Freshness Green beans', 47, 1.29, 'A3', 3, 3),
(1223, 'Freshness Green beans', 17, 3.49, 'A7', 3, 4),
(1224, 'Freshness Wax beans', 23, 1.55, 'A3', 3, 3),
(2001, 'Ruby\'s Organic Kale', 7, 6.99, 'PO2', 2, 2);

-- 5. Insert Customers
INSERT INTO `Customers` (`customer_id`) VALUES (198765), (202900), (196777), (277177), (111000), (100988);

-- 6. Insert Vendor Purchases
INSERT INTO `VendorPurchases` (`item_num`, `vendor_id`, `purchase_date`, `cost_per_unit`, `quantity_purchased`) VALUES 
(1000, 1, '2022-02-01', 2.35, 25),
(1100, 2, '2022-02-02', 0.69, 40),
(1222, 2, '2022-02-10', 0.59, 40),
(1223, 2, '2022-02-10', 1.75, 10),
(1224, 2, '2022-02-10', 0.65, 30),
(2000, 3, '2022-02-12', 1.29, 25),
(2001, 3, '2022-02-12', 2.19, 20),
(1223, 2, '2022-02-15', 1.80, 10);

-- 7. Insert Customer Sales
INSERT INTO `CustomerSales` (`item_num`, `customer_id`, `date_sold`, `actual_sale_price`, `quantity_sold`) VALUES 
(1000, 198765, '2022-02-02', 5.49, 2),
(2000, 111000, '2022-02-02', 3.99, 2),
(1100, 202900, '2022-02-02', 1.49, 2),
(1000, 196777, '2022-02-04', 5.99, 2),
(1100, 198765, '2022-02-07', 1.49, 8),
(1000, 277177, '2022-02-11', 5.49, 4),
(1222, 111000, '2022-02-12', 1.29, 12),
(1223, 198765, '2022-02-13', 3.49, 5),
(2001, 100988, '2022-02-13', 6.99, 1),
(2001, 202900, '2022-02-14', 6.99, 12),
(2000, 111000, '2022-02-15', 3.99, 2);

