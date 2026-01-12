-- Database Verification Queries for Greenspot Grocer
-- Proves that data can be retrieved from multiple tables via JOINs

USE `greenspot_db`;

-- 1. Query to view all sales with customer, product, and category details
-- (Answers business question: "Show me all sales history with detailed product info")
SELECT 
    s.sale_id,
    s.date_sold,
    c.customer_id,
    p.description AS item_name,
    it.type_name AS category,
    s.quantity_sold,
    s.sale_price,
    (s.quantity_sold * s.sale_price) AS total_sale_amount
FROM CustomerSales s
JOIN Customers c ON s.customer_id = c.customer_id
JOIN Products p ON s.item_num = p.item_num
JOIN ItemTypes it ON p.item_type_id = it.item_type_id
ORDER BY s.date_sold;

-- 2. Query to view inventory status and associated vendors
-- (Answers business question: "Which vendor do we buy this low-stock item from?")
SELECT 
    p.item_num,
    p.description,
    p.quantity_on_hand,
    it.type_name,
    v.vendor_name,
    vp.purchase_date AS last_purchased
FROM Products p
JOIN ItemTypes it ON p.item_type_id = it.item_type_id
LEFT JOIN VendorPurchases vp ON p.item_num = vp.item_num
LEFT JOIN Vendors v ON vp.vendor_id = v.vendor_id
WHERE p.quantity_on_hand < 50;

-- 3. Query to retrieve data from ALL tables in a single query
-- (Demonstrates full database connectivity)
SELECT 
    p.item_num,
    p.description,
    it.type_name,
    v.vendor_name,
    vp.cost AS purchase_cost,
    s.sale_price,
    c.customer_id,
    s.date_sold
FROM Products p
JOIN ItemTypes it ON p.item_type_id = it.item_type_id
JOIN VendorPurchases vp ON p.item_num = vp.item_num
JOIN Vendors v ON vp.vendor_id = v.vendor_id
JOIN CustomerSales s ON p.item_num = s.item_num
JOIN Customers c ON s.customer_id = c.customer_id
LIMIT 10;
