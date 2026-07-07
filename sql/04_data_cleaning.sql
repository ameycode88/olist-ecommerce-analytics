-- ==========================================
-- Data Cleaning: Create clean_products Table
-- Translate Portuguese Product Categories to English
-- ==========================================

CREATE TABLE clean_products AS
SELECT
p.product_id,
COALESCE(
t.product_category_name_english,
'Unknown'
) AS category,
p.product_weight_g,
p.product_length_cm,
p.product_height_cm,
p.product_width_cm
FROM stg_products p
LEFT JOIN stg_product_category_name_translation t
ON p.product_category_name=t.product_category_name;

select * from clean_products;
