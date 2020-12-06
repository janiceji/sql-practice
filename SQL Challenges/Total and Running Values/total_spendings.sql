-- total spendings in March and April
SELECT distinct user_id, SUM(transaction_amount) OVER (PARTITION BY user_id) as total FROM (SELECT user_id, transaction_amount FROM data_march
UNION ALL SELECT user_id, transaction_amount FROM data_april
ORDER BY user_id) temp
ORDER BY user_id