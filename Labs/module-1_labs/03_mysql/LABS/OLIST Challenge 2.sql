-- OLIST Challenge 2


-- 1 
SELECT MIN(DATE(first_contact_date)), MAX(DATE(first_contact_date))
FROM olist.marketing_qualified_leads;

-- 2
SELECT DATE(first_contact_date), origin
FROM olist.marketing_qualified_leads
WHERE DATE(first_contact_date) >= "2018-01-01" AND DATE(first_contact_date) <="2018-12-31"
GROUP BY origin
ORDER BY COUNT(origin) DESC
LIMIT 3;

-- 3
SELECT first_contact_date, COUNT(mql_id)
FROM olist.marketing_qualified_leads
GROUP BY first_contact_date
ORDER BY COUNT(mql_id) DESC
Limit 1;

-- 4
SELECT product_category_name, COUNT(product_id)
FROM olist.products
GROUP BY product_category_name
ORDER BY COUNT(product_id) DESC
LIMIT 2;

-- 5
SELECT product_category_name, product_weight_g
FROM olist.products
ORDER BY product_weight_g DESC
LIMIT 1;

-- 6
SELECT product_category_name, product_length_cm + product_height_cm + product_width_cm AS Sum_Dim 
FROM olist.products
-- GROUP BY product_category_name
ORDER BY Sum_Dim DESC
LIMIT 1;

-- 7
SELECT payment_type, COUNT(*)
FROM olist.order_payments
GROUP BY payment_type
ORDER BY COUNT(order_id) DESC
LIMIT 1;

-- 8
SELECT payment_value
FROM olist.order_payments
GROUP BY order_id
ORDER BY payment_value DESC
LIMIT 1;

