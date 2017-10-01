 SELECT 
 	REPLACE(`日期`,YEAR(NOW()),'') `日期`, 
	`厂家`, 
	`地市`, 
	a.`lncel_enb_id`,
	c.chname,
	CONCAT(a.`lncel_enb_id`,a.`lncel_lcr_id`) `小区ID`,
	(SUM(m815)-SUM(`4G重定向到3G的请求次数`)) `4G重定向到3G的请求次数`	 
, SUM(`4G E-RAB建立总次数`) `4G E-RAB建立总次数`,
  ROUND(100*(SUM(m815)-SUM(`4G重定向到3G的请求次数`))/SUM(`4G E-RAB建立总次数`),2) `4G倒流次数比%`
  FROM b_4g_area_cell_day_daoliubi_fm  a, b_4g_area_cell_day_daoliubi_fz b,stationdata c
 WHERE a.lncel_enb_id = b.lncel_enb_id 
  AND a.lncel_lcr_id = b.lncel_lcr_id
   and a.lncel_enb_id = c.enodbid
 GROUP BY 
 	`日期`, 
	`厂家`, 
	`地市`, 
	CONCAT(a.`lncel_enb_id`,a.`lncel_lcr_id`)