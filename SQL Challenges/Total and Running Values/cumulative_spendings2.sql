SELECT 
	user_id,
	date,
	sum(transaction_amount) OVER (PARTITION BY user_id order by date) as total_amt --accumulation
FROM
(SELECT * FROM data_march
UNION ALL 
SElECT * FROM data_april
ORDER BY user_id, date) temp
