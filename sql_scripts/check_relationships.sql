-- Script to verify database relationships (Foreign Keys)
-- Proves that all tables are correctly linked

USE `greenspot_db`;

-- Test 1: Check connectivity between Products, Categories, and Units
-- (Proves 3NF structure for basic item definition)
SELECT 
    p.item_num,
    p.description,
    it.type_name AS category,
    u.unit_name AS measurement_unit
FROM Products p
INNER JOIN ItemTypes it ON p.item_type_id = it.item_type_id
INNER JOIN Units u ON p.unit_id = u.unit_id;

-- Test 2: Check connectivity between Products and Vendor Purchases
-- (Proves that we can track which items come from which vendors)
SELECT 
    v.vendor_name,
    p.description,
    vp.purchase_date,
    vp.cost_per_unit
FROM VendorPurchases vp
JOIN Vendors v ON vp.vendor_id = v.vendor_id
JOIN Products p ON vp.item_num = p.item_num;
