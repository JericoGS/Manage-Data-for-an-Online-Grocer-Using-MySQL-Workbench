-- Greenspot Grocer Database - 3NF Optimized Version
-- Author: Antigravity AI
-- Date: 2026-01-12

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `greenspot_db` DEFAULT CHARACTER SET utf8mb4;
USE `greenspot_db`;

-- 1. Table `ItemTypes` (Categories) - Optimized to TINYINT
CREATE TABLE IF NOT EXISTS `ItemTypes` (
  `item_type_id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`item_type_id`))
ENGINE = InnoDB;

-- 2. New Table `Units` - Ensures data consistency for units (dozen, bunch, etc.)
CREATE TABLE IF NOT EXISTS `Units` (
  `unit_id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `unit_name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`unit_id`))
ENGINE = InnoDB;

-- 3. Table `Vendors` - Optimized lengths
CREATE TABLE IF NOT EXISTS `Vendors` (
  `vendor_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `vendor_name` VARCHAR(100) NOT NULL,
  `vendor_address` VARCHAR(150) NULL,
  PRIMARY KEY (`vendor_id`))
ENGINE = InnoDB;

-- 4. Table `Products` - 3NF and Type Optimization
CREATE TABLE IF NOT EXISTS `Products` (
  `item_num` INT UNSIGNED NOT NULL,
  `description` VARCHAR(150) NOT NULL,
  `quantity_on_hand` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `current_price` DECIMAL(8,2) UNSIGNED NOT NULL,
  `location_code` VARCHAR(5) NULL,
  `item_type_id` TINYINT UNSIGNED NOT NULL,
  `unit_id` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`item_num`),
  CONSTRAINT `fk_Products_ItemTypes` FOREIGN KEY (`item_type_id`) REFERENCES `ItemTypes` (`item_type_id`),
  CONSTRAINT `fk_Products_Units` FOREIGN KEY (`unit_id`) REFERENCES `Units` (`unit_id`))
ENGINE = InnoDB;

-- 5. Table `Customers` - IDs are kept as requested by source
CREATE TABLE IF NOT EXISTS `Customers` (
  `customer_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;

-- 6. Table `VendorPurchases` - Records replenishment costs
CREATE TABLE IF NOT EXISTS `VendorPurchases` (
  `purchase_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_num` INT UNSIGNED NOT NULL,
  `vendor_id` SMALLINT UNSIGNED NOT NULL,
  `purchase_date` DATE NOT NULL,
  `cost_per_unit` DECIMAL(8,2) UNSIGNED NOT NULL,
  `quantity_purchased` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`purchase_id`),
  CONSTRAINT `fk_Purchases_Products` FOREIGN KEY (`item_num`) REFERENCES `Products` (`item_num`),
  CONSTRAINT `fk_Purchases_Vendors` FOREIGN KEY (`vendor_id`) REFERENCES `Vendors` (`vendor_id`))
ENGINE = InnoDB;

-- 7. Table `CustomerSales` - Records historical sale prices
CREATE TABLE IF NOT EXISTS `CustomerSales` (
  `sale_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_num` INT UNSIGNED NOT NULL,
  `customer_id` INT UNSIGNED NOT NULL,
  `date_sold` DATE NOT NULL,
  `actual_sale_price` DECIMAL(8,2) UNSIGNED NOT NULL,
  `quantity_sold` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`sale_id`),
  CONSTRAINT `fk_Sales_Products` FOREIGN KEY (`item_num`) REFERENCES `Products` (`item_num`),
  CONSTRAINT `fk_Sales_Customers` FOREIGN KEY (`customer_id`) REFERENCES `Customers` (`customer_id`))
ENGINE = InnoDB;

