SELECT 
	ROUND(100*(SUM(web_only)/COUNT(*)),2) as perc_web_only, 
	ROUND(100*(SUM(mobile_only)/COUNT(*)), 2) as perc_mobile_only,
	ROUND(100*(SUM(both_web_mobile)/COUNT(*)),2 ) as perc_both 
FROM (SELECT distinct 
	  	data_web.user_id, 
		data_mobile.user_id,
		SUM(CASE WHEN data_mobile.user_id IS NULL THEN 1 ELSE 0 END) as web_only,
		SUM(CASE WHEN data_web.user_id IS NULL THEN 1 ELSE 0 END) as mobile_only,
		SUM(CASE WHEN data_web.user_id IS NOT NULL AND data_mobile.user_id IS NOT NULL THEN 1 ELSE 0 END) as both_web_mobile
FROM data_web
FULL OUTER JOIN data_mobile
ON data_web.user_id = data_mobile.user_id
GROUP BY data_mobile.user_id, data_web.user_id, data_mobile.page, data_web.page
ORDER BY data_web.user_id, data_mobile.user_id) temp