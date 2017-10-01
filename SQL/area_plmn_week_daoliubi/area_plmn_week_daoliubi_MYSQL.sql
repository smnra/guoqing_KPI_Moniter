SELECT 
  '陕西' 省份,
	a.`地市`,  
	(SUM(m815)-SUM(`4G重定向到3G的请求次数`)) `4G重定向到3G的请求次数`	 
, SUM(`4G E-RAB建立总次数`) `4G E-RAB建立总次数`,
  round(100*(SUM(m815)-SUM(`4G重定向到3G的请求次数`))/SUM(`4G E-RAB建立总次数`),2) `4G倒流次数比%`
  FROM b_4g_area_plmn_week_daoliubi_fm  a, b_4g_area_plmn_week_daoliubi_fz b
 WHERE a.地市= b.地市
 GROUP BY '陕西', 
	a.`地市`