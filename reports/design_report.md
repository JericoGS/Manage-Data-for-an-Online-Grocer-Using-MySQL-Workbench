# Greenspot Grocer Database Design Report

## 1. Analysis of Current Data (CSV)

The original dataset in `GreenspotDataset.csv` presents several issues common in flat-file storage that hinder scalability and data integrity:

### Identified Anomalies and Issues

- **Data Redundancy:** Vendor information (names and addresses) is repeated every time a purchase is made. This wastes space and increases the risk of data entry errors.
- **Update Anomalies:** If a vendor changes their address, we have to update multiple rows. If we miss one, the data becomes inconsistent.
- **Insertion Anomalies:** We cannot store a new vendor's information without having a specific product purchase associated with them in the same row.
- **Deletion Anomalies:** If we delete a product record, we might lose the only record of a vendor or a customer.
- **Mixed Concerns:** The file mixes inventory data (quantity on hand), purchase data (from vendors), and sales data (to customers) in a single row, which is logically confusing and difficult to query.
- **Inconsistent Formatting:** The "Unit" column has variations (e.g., "12 ounce can" vs "12 oz can").

## 2. Proposed Relational Design

To resolve these issues, the data will be normalized into the following tables:

### Tables and Relationships

1.  **`Vendors` Table:**
    - Stores vendor identification and contact details.
    - **Primary Key:** `vendor_id` (Auto-increment).
2.  **`ItemTypes` Table:**
    - Categorizes products (e.g., Dairy, Produce).
    - **Primary Key:** `item_type_id`.
3.  **`Products` Table:**
    - Stores product definitions, current price, and stock levels.
    - **Primary Key:** `item_num`.
    - **Foreign Key:** `item_type_id` (refers to `ItemTypes`).
4.  **`Customers` Table:**
    - Stores customer identification.
    - **Primary Key:** `customer_id`.
5.  **`VendorPurchases` Table:**
    - Records replenishment from vendors.
    - **Primary Key:** `purchase_id`.
    - **Foreign Keys:** `item_num` (refers to `Products`), `vendor_id` (refers to `Vendors`).
6.  **`CustomerSales` Table:**
    - Records sales to customers.
    - **Primary Key:** `sale_id`.
    - **Foreign Keys:** `item_num` (refers to `Products`), `customer_id` (refers to `Customers`).

## 3. Scalability and Benefits

- **Integrity:** Foreign keys ensure that we cannot have a sale for a non-existent product or customer.
- **Efficiency:** Data is stored once. Updates to a vendor's address are done in one place.
- **Growth:** The system can easily accommodate new features like employee tracking, store locations, or discount codes by adding new tables and relationships without affecting existing data structures.

---

_Note: The EER Diagram will be represented via the SQL schema implementation._
