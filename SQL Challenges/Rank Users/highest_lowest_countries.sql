-- country with largest and smallest number of users
SELECT
	country,
	count
FROM	
(SELECT
	country,
	sub1.count,
	ROW_NUMBER() OVER (ORDER BY count asc) as count_asc,
	ROW_NUMBER() OVER (ORDER BY count desc) as count_desc
FROM
(SELECT
	*,
	COUNT(*) OVER (PARTITION BY country ORDER BY country)
FROM created_date) sub1
GROUP BY sub1.country, sub1.count) sub2
WHERE count_asc = 1 or count_desc = 1