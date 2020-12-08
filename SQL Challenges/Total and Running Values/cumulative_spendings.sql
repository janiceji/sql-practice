SELECT 
	user_id,
	date,
	sum(amt) OVER (PARTITION BY user_id order by date) as total_amt
FROM
(SELECT user_id, date, sum(transaction_amount) as amt FROM data_march
GROUP BY user_id, date
UNION ALL 
SElECT user_id, date, sum(transaction_amount) as amt FROM data_april
GROUP BY user_id, date
ORDER BY user_id) temp
ORDER BY user_id, date