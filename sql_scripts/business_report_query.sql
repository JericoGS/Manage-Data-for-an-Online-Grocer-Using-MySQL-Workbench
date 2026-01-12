-- Business Query: Full Sales and Profitability Report
-- Demonstrates retrieval from all related tables in a single query

USE `greenspot_db`;

SELECT 
    s.date_sold,
    p.description AS Product,
    it.type_name AS Category,
    u.unit_name AS Unit,
    s.quantity_sold,
    s.actual_sale_price AS Sales_Price,
    vp.cost_per_unit AS Last_Purchase_Cost,
    (s.actual_sale_price - vp.cost_per_unit) AS Profit_Per_Unit,
    ((s.actual_sale_price - vp.cost_per_unit) * s.quantity_sold) AS Total_Profit
FROM CustomerSales s
JOIN Products p ON s.item_num = p.item_num
JOIN ItemTypes it ON p.item_type_id = it.item_type_id
JOIN Units u ON p.unit_id = u.unit_id
-- We use a subquery or join to get the most recent cost for that product
JOIN VendorPurchases vp ON p.item_num = vp.item_num
WHERE vp.purchase_id = (
    SELECT MAX(purchase_id) 
    FROM VendorPurchases 
    WHERE item_num = p.item_num
)
ORDER BY s.date_sold DESC;
