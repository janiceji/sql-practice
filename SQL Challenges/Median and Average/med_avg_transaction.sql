SELECT
	AVG(transaction_amount) as average,
	AVG(CASE WHEN row_num_asc BETWEEN row_num_desc-1 and row_num_desc+1 THEN transaction_amount ELSE NULL END) as median
FROM
(SELECT
	*,
	ROW_NUMBER() OVER (ORDER BY transaction_amount) as row_num_asc, 
	COUNT(*) OVER() - ROW_NUMBER() OVER(ORDER BY transaction_amount) + 1 as row_num_desc
FROM
(SELECT * 
 FROM transaction_table
 INNER JOIN signup_date
 ON date(transaction_table.transaction_date) = signup_date.sign_up_date 
 and transaction_table.user_id = signup_date.user_id) sub1) sub2