SELECT user_id, date FROM (SELECT 
	*,
	COUNT(*) OVER (PARTITION BY user_id ORDER BY user_id) as num_purchases,
	ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY date) as power_date
FROM transaction_date
ORDER BY user_id) sub
WHERE power_date = 10;