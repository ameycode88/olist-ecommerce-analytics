-- Check 1: Missing delivery dates
SELECT
COUNT(*)
FROM stg_orders
WHERE order_delivered_customer_date IS NULL;
-- 2965
-- These rows were retained for revenue analysis but excluded from delivery-time calculations.

-- Check 2: Duplicate order IDs in order_items
SELECT order_id, COUNT(*)
FROM stg_order_items
GROUP BY order_id
HAVING COUNT(*) > 1;
-- 9803 rows
-- Duplicate order IDs are expected because one order may contain multiple items.

-- Check 3: Primary Key Duplicates
-- stg_customers table
SELECT
customer_id,
COUNT(*)
FROM stg_customers
GROUP BY customer_id
HAVING COUNT(*)>1;

-- stg_products table
select
product_id,
count(*)
from  stg_products
group by product_id
having count(*)>1;

-- stg_sellers table
select
seller_id,
count(*)
from  stg_sellers
group by seller_id
having count(*)>1;

-- stg_orders table
select
order_id,
count(*)
from  stg_orders
group by order_id
having count(*)>1;

-- 0 rows for all checks in check 3

-- Check 4: Orphan Products
SELECT oi.product_id
FROM stg_order_items oi
LEFT JOIN stg_products p
ON oi.product_id=p.product_id
WHERE p.product_id IS NULL;
-- 0 rows No orphan products available

-- Check 5: Portuguese Translation
SELECT
p.product_id,
t.product_category_name_english
FROM stg_products p
LEFT JOIN stg_product_category_name_translation t
ON p.product_category_name=t.product_category_name;

