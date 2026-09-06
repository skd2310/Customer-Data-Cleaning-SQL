-- Customer Data Cleaning Project
-- Tool: MySQL
-- Database: sql1_db
-- Table: customers
-- Cleaned table: customers_cleaned

USE sql1_db;

-- =========================================================
-- 1. View Original Customer Data
-- =========================================================

SELECT *
FROM customers;


-- =========================================================
-- 2. Remove Extra Spaces from Customer Names
-- =========================================================

SELECT
    customer_name,
    TRIM(customer_name) AS cleaned_name
FROM customers;


-- =========================================================
-- 3. Standardize Customer Names
-- =========================================================

SELECT
    customer_name,
    LOWER(TRIM(customer_name)) AS cleaned_name
FROM customers;


-- =========================================================
-- 4. Standardize City Names
-- =========================================================

SELECT
    city,
    UPPER(TRIM(city)) AS standardized_city
FROM customers;


-- =========================================================
-- 5. Detect Duplicate Emails
-- =========================================================

SELECT
    email,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;


-- =========================================================
-- 6. Detect Duplicate Customer Name + Email Records
-- =========================================================

SELECT
    customer_name,
    email,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_name, email
HAVING COUNT(*) > 1;


-- =========================================================
-- 7. Detect Duplicates After Email Standardization
-- =========================================================

SELECT
    LOWER(TRIM(email)) AS cleaned_email,
    COUNT(*) AS total_records
FROM customers
GROUP BY LOWER(TRIM(email))
HAVING COUNT(*) > 1;


-- =========================================================
-- 8. Check Missing Values
-- =========================================================

SELECT
    COUNT(*) AS total_missing
FROM customers
WHERE customer_name IS NULL
   OR email IS NULL
   OR city IS NULL;


-- =========================================================
-- 9. Check Basic Invalid Emails
-- =========================================================

SELECT
    customer_id,
    email
FROM customers
WHERE email NOT LIKE '%@%';


-- =========================================================
-- 10. Standardize Email Addresses
-- =========================================================

SELECT
    email,
    LOWER(TRIM(email)) AS cleaned_email
FROM customers;


-- =========================================================
-- 11. Clean and Standardize Cities
-- =========================================================

SELECT
    city,
    UPPER(TRIM(city)) AS cleaned_city
FROM customers;


-- =========================================================
-- 12. Combined Cleaning Preview
-- =========================================================

SELECT
    customer_id,
    LOWER(TRIM(customer_name)) AS cleaned_name,
    LOWER(TRIM(email)) AS cleaned_email,
    UPPER(TRIM(city)) AS cleaned_city
FROM customers;


-- =========================================================
-- 13. Create Cleaned Customer Table
-- =========================================================

CREATE TABLE customers_cleaned AS
SELECT
    customer_id,
    LOWER(TRIM(customer_name)) AS customer_name,
    LOWER(TRIM(email)) AS email,
    UPPER(TRIM(city)) AS city
FROM customers;


-- =========================================================
-- 14. View Final Cleaned Data
-- =========================================================

SELECT *
FROM customers_cleaned;
