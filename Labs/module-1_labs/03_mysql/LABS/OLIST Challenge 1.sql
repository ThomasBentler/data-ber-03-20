

-- Lab | SQL - OLIST
Use olist;
-- 1
SELECT MAX(price), MIN(price)
FROM olist.order_items;

-- 2 # summertime????
SELECT MIN(shipping_limit_date), max(shipping_limit_date)
FROM olist.order_items;

-- 3
SELECT COUNT(customer_unique_id) as CC, customer_state
FROM olist.customers
GROUP BY customer_state
ORDER BY CC DESC
LIMIT 3;

-- 4
SELECT customer_city
FROM olist.customers
WHERE customer_state = 'SP'
GROUP BY customer_city
ORDER BY COUNT(customer_unique_id) DESC
LIMIT 3;

-- 5
SELECT COUNT(DISTINCT business_segment)
FROM olist.closed_deals;

-- 6
SELECT business_segment
FROM olist.closed_deals
GROUP BY business_segment
ORDER BY SUM(declared_monthly_revenue) DESC
Limit 3;

-- 7
SELECT COUNT(DISTINCT(review_score))
FROM olist.order_reviews;

-- 8 --
SELECT 
	review_id, order_id, review_score,
	CASE 
		WHEN review_score = 1 THEN 'bad'
		WHEN review_score = 2 THEN 'mediorcre'
        WHEN review_score = 3 THEN 'ok'
        WHEN review_score = 4 THEN 'good'
        Else 'very good' 
	END AS review_score_decription
FROM olist.order_reviews
LIMIT 100;


-- 9 --
SELECT review_score, COUNT(*)
FROM olist.order_reviews
GROUP BY review_score
ORDER BY review_score DESC
Limit 1;
