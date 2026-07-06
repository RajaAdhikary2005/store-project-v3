-- ===== SQL Script for Store Website =====
-- Run this in MySQL Shell

-- Step 1: Use the store database (already created)
USE store_db;

-- Step 2: Create product table
CREATE TABLE IF NOT EXISTS product_list (
    name VARCHAR(100) PRIMARY KEY,
    price INT,
    quantity INT
);

-- Step 3: Insert 3 products
INSERT INTO product_list (name, price, quantity) VALUES ('Mobile Phone', 20000, 10);
INSERT INTO product_list (name, price, quantity) VALUES ('Computer (Laptop)', 50000, 5);
INSERT INTO product_list (name, price, quantity) VALUES ('Printer (Coloured)', 25000, 15);

-- Step 4: Create orders table (for Order Form)
CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    cust_name VARCHAR(100),
    cust_addr VARCHAR(200),
    prod_name VARCHAR(100),
    prod_qty INT
);
