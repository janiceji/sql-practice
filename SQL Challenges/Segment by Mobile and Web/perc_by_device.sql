SELECT 100*SUM(CASE WHEN m.user_id is null THEN 1 ELSE 0 END)/COUNT(*) as web_only,
       100*SUM(CASE WHEN w.user_id is null THEN 1 ELSE 0 END)/COUNT(*) as mobile_only,
       100*SUM(CASE WHEN m.user_id is not null and w.user_id is not null THEN 1 ELSE 0 END)/COUNT(*) as mobile_web
FROM 
(SELECT distinct user_id FROM data_mobile) as m 
FULL OUTER JOIN
(SELECT distinct user_id FROM data_web) as w
ON m.user_id = w.user_id