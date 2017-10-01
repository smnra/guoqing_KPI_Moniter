TRUNCATE TABLE b_4g_jiankongzhibiao_result_three;
INSERT INTO b_4g_jiankongzhibiao_result_three
SELECT tab1.city,zb1,zb2,zb3 FROM 
( 
 (SELECT city, 100*(SELECT COUNT(*) FROM b_4g_jiankongzhibiao_three b
 WHERE maxrrc <=20 AND b.city = a.city)/(SELECT COUNT(*) FROM b_4g_jiankongzhibiao_three
  c WHERE c.city = a.city) zb1
 FROM b_4g_jiankongzhibiao_three a 
 GROUP BY city ) tab1 LEFT JOIN 
 ( 
 SELECT city,100*(SELECT COUNT(*) FROM b_4g_jiankongzhibiao_three b
 WHERE maxrrc <=200 AND maxrrc >20 AND b.city = a.city)/(SELECT COUNT(*) FROM b_4g_jiankongzhibiao_three
  c WHERE c.city = a.city) zb2  FROM b_4g_jiankongzhibiao_three a 
 GROUP BY city
 ) tab2
 ON tab1.city = tab2.city
 LEFT JOIN 
 ( 
 SELECT city,100*(SELECT COUNT(*) FROM b_4g_jiankongzhibiao_three b
 WHERE maxrrc >200  AND b.city = a.city)/(SELECT COUNT(*) FROM b_4g_jiankongzhibiao_three
  c WHERE c.city = a.city) zb3  FROM b_4g_jiankongzhibiao_three a 
 GROUP BY city
 ) tab3
 ON tab1.city = tab3.city
 ) 