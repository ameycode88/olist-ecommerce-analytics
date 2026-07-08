-- ==========================================
-- 1. Monthly Revenue Growth
-- ==========================================

WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', order_purchase_timestamp) AS month,
        SUM(price) AS revenue
    FROM fct_orders
    WHERE order_status = 'delivered'
    GROUP BY DATE_TRUNC('month', order_purchase_timestamp)
)

SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue,
    ROUND(
        ((revenue - LAG(revenue) OVER (ORDER BY month))
        / LAG(revenue) OVER (ORDER BY month)) * 100,
        2
    ) AS growth_percent
FROM monthly_revenue
ORDER BY month;

-- ==========================================
-- 2. Customer Lifetime Value Ranking
-- ==========================================

WITH customer_ltv AS (
    SELECT
        customer_id,
        SUM(price) AS lifetime_value
    FROM fct_orders
    GROUP BY customer_id
)

SELECT
    customer_id,
    lifetime_value,
    RANK() OVER (ORDER BY lifetime_value DESC) AS customer_rank
FROM customer_ltv
ORDER BY customer_rank;

-- ==========================================
-- 3. Delivery Performance Bucket
-- ==========================================

SELECT
    order_id,
    order_status,
    order_delivered_customer_date,
    order_estimated_delivery_date,

    CASE
        WHEN order_delivered_customer_date <= order_estimated_delivery_date
            THEN 'On Time'

        WHEN order_delivered_customer_date <= order_estimated_delivery_date + INTERVAL '7 days'
            THEN 'Late'

        ELSE 'Very Late'
    END AS delivery_bucket

FROM fct_orders
WHERE order_status = 'delivered';

-- ==========================================
-- 4. Seller Performance Summary View
-- ==========================================

CREATE OR REPLACE VIEW seller_performance_summary AS

SELECT
    f.seller_id,

    COUNT(DISTINCT f.order_id) AS total_orders,

    SUM(f.price) AS total_revenue,

    ROUND(AVG(r.review_score),2) AS average_rating,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN f.order_delivered_customer_date > f.order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        )
        / COUNT(*),
        2
    ) AS late_delivery_percent

FROM fct_orders f

LEFT JOIN stg_order_reviews r
ON f.order_id = r.order_id

GROUP BY f.seller_id;

select * from seller_performance_summary ORDER BY total_revenue DESC;

-- ==========================================
-- 5. Top 10 Cities by Revenue
-- ==========================================

WITH city_revenue AS (

    SELECT

        c.customer_city,

        SUM(f.price) AS revenue

    FROM fct_orders f

    JOIN dim_customers c
    ON f.customer_id = c.customer_id

    GROUP BY c.customer_city

)

SELECT

    customer_city,

    revenue,

    ROUND(

        revenue /

        SUM(revenue) OVER () * 100,

        2

    ) AS national_revenue_percent

FROM city_revenue

ORDER BY revenue DESC

LIMIT 10;
