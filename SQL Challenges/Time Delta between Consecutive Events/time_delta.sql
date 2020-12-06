SELECT 
	user_id,
	unix_timestamp,
	previous_time,
	CAST(unix_timestamp as int) - cast(previous_time as int) AS delta
FROM (SELECT
		user_id,
	  	unix_timestamp,
	  	LAG(unix_timestamp, 1) OVER (PARTITION BY user_id ORDER BY unix_timestamp) AS previous_time, -- the time before current
	  	ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY unix_timestamp DESC) AS order_desc -- row 1: most recent entry
	  FROM page_visit
) curr_prev
WHERE order_desc = 1 and previous_time is not null
ORDER BY user_id asc
LIMIT 20;
