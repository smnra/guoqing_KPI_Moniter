 TRUNCATE TABLE b_4g_jiankongzhibiao_result_five;
 INSERT INTO b_4g_jiankongzhibiao_result_five
 SELECT tab1.city, zb1,zb2 FROM ( 
 SELECT city, 100*(SELECT COUNT(*) FROM b_4g_jiankongzhibiao_five b
 WHERE rscp >=-100 AND b.city = a.city)/(SELECT COUNT(*) FROM b_4g_jiankongzhibiao_five c WHERE c.city = a.city) zb1
 FROM b_4g_jiankongzhibiao_five a 
 WHERE city <> 'A'
 GROUP BY city) tab1,
 ( 
 SELECT city, 100*(SELECT COUNT(*) FROM b_4g_jiankongzhibiao_five b
 WHERE rscp >=-105 AND rscp <-100 AND b.city = a.city)/
 (SELECT COUNT(*) FROM b_4g_jiankongzhibiao_five c WHERE c.city = a.city) zb2
 FROM b_4g_jiankongzhibiao_five a 
 WHERE city <> 'A'
 GROUP BY city) tab2
 WHERE tab1.city = tab2.city
 
  
