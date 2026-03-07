/*
----- Gold Layer Quality Checks -----

Script Purpose:
    This script performs basic data quality checks on the Gold layer
    to ensure the integrity of the dimensional model.

Actions Performed:
    1. Validates uniqueness of surrogate keys in dimension views:
        - gold.dim_customers
        - gold.dim_products
    2. Checks referential integrity between:
        - gold.fact_sales
        - gold.dim_customers
        - gold.dim_products
    3. Identifies potential data issues such as duplicate keys
       or missing dimension references in the fact table.
*/


-- Check for Uniqueness of Customer Key in gold.dim_customers
-- Expectation: No results 
SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;


-- Check for Uniqueness of Product Key in gold.dim_products
-- Expectation: No results 
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;


-- Check the data model connectivity between fact and dimensions
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL  