USE bank

-- 1
SELECT district_id,COUNT(client_id)
FROM client
GROUP BY district_id
ORDER BY district_id
LIMIT 9;

-- 2
SELECT COUNT(*) as "#cards", type
FROM card
GROUP BY type
ORDER BY "#cards" DESC
LIMIT 3;

-- 3
SELECT account_id, SUM(amount) as AMT
FROM loan
GROUP BY account_id
ORDER BY AMT DESC
LIMIT 10;

-- 4
SELECT COUNT(*) as loans_issued, date
FROM loan
WHERE date<930907
GROUP BY date
ORDER BY date DESC;

-- 5
SELECT date, duration, COUNT(*) AS number_of_loans
FROM loan
WHERE date<980101 AND date>=971201
GROUP BY date, Duration
ORDER BY date, duration;