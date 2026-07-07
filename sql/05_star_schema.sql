-- ==========================================
-- Create Customer Dimension
-- ==========================================

CREATE TABLE dim_customers (
    customer_id TEXT PRIMARY KEY,
    customer_unique_id TEXT,
    customer_city TEXT,
    customer_state TEXT
);

INSERT INTO dim_customers
SELECT DISTINCT
    customer_id,
    customer_unique_id,
    customer_city,
    customer_state
FROM stg_customers;

COMMENT ON TABLE dim_customers IS
'Customer dimension table.';

select * from dim_customers;

-- ==========================================
-- Create Products Dimension
-- ==========================================

CREATE TABLE dim_products (
    product_id TEXT PRIMARY KEY,
    category TEXT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

INSERT INTO dim_products
SELECT
    product_id,
    category,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM clean_products;

COMMENT ON TABLE dim_products IS
'Product dimension table.';

select * from dim_products;

-- ==========================================
-- Create Seller Dimension
-- ==========================================

CREATE TABLE dim_sellers (
    seller_id TEXT PRIMARY KEY,
    seller_city TEXT,
    seller_state TEXT
);

INSERT INTO dim_sellers
SELECT DISTINCT
    seller_id,
    seller_city,
    seller_state
FROM stg_sellers;

COMMENT ON TABLE dim_sellers IS
'Seller dimension table.';

select * from dim_sellers;

-- ==========================================
-- Create Date Dimension
-- ==========================================

CREATE TABLE dim_date (
    order_date DATE PRIMARY KEY,
    year INT,
    month INT,
    day INT,
    month_name TEXT
);

INSERT INTO dim_date
SELECT DISTINCT
    order_purchase_timestamp::DATE,
    EXTRACT(YEAR FROM order_purchase_timestamp)::INT,
    EXTRACT(MONTH FROM order_purchase_timestamp)::INT,
    EXTRACT(DAY FROM order_purchase_timestamp)::INT,
    TO_CHAR(order_purchase_timestamp,'Month')
FROM stg_orders;

COMMENT ON TABLE dim_date IS
'Date dimension table.';

select * from dim_date;

-- ==========================================
-- Create Orders Fact Table
-- ==========================================

CREATE TABLE fct_orders (
    order_id TEXT,
	order_item_id INT,
    customer_id TEXT,
    product_id TEXT,
    seller_id TEXT,
    price NUMERIC,
    freight_value NUMERIC,
    payment_value NUMERIC,
    order_status TEXT,
    order_purchase_timestamp TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    PRIMARY KEY(order_id, order_item_id),
    FOREIGN KEY(customer_id)
        REFERENCES dim_customers(customer_id),
    FOREIGN KEY(product_id)
        REFERENCES dim_products(product_id),
    FOREIGN KEY(seller_id)
        REFERENCES dim_sellers(seller_id)
);

WITH payment_summary AS (
    SELECT
        order_id,
        SUM(payment_value) AS payment_value
    FROM stg_order_payments
    GROUP BY order_id
)
INSERT INTO fct_orders
SELECT
    oi.order_id,
    oi.order_item_id,
    o.customer_id,
    oi.product_id,
    oi.seller_id,
    oi.price,
    oi.freight_value,
    ps.payment_value,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date
FROM stg_order_items oi
JOIN stg_orders o
    ON oi.order_id = o.order_id
LEFT JOIN payment_summary ps
    ON oi.order_id = ps.order_id;

COMMENT ON TABLE fct_orders IS
'Fact table storing order-level transactions.';

select * from fct_orders;
