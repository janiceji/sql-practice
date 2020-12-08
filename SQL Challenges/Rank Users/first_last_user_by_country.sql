-- first and last user by country
SELECT
	user_id,
	created_at,
	country
FROM
(SELECT 
	*,
	ROW_NUMBER() OVER (PARTITION BY country order by created_at) as count_asc,
	ROW_NUMBER() OVER (PARTITION BY country order by created_at desc) as count_desc
FROM created_date) sub1
WHERE count_asc = 1 or count_desc = 1