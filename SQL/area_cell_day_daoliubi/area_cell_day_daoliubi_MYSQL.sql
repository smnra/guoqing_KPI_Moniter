 SELECT 
 	REPLACE(`����`,YEAR(NOW()),'') `����`, 
	`����`, 
	`����`, 
	a.`lncel_enb_id`,
	c.chname,
	CONCAT(a.`lncel_enb_id`,a.`lncel_lcr_id`) `С��ID`,
	(SUM(m815)-SUM(`4G�ض���3G���������`)) `4G�ض���3G���������`	 
, SUM(`4G E-RAB�����ܴ���`) `4G E-RAB�����ܴ���`,
  ROUND(100*(SUM(m815)-SUM(`4G�ض���3G���������`))/SUM(`4G E-RAB�����ܴ���`),2) `4G����������%`
  FROM b_4g_area_cell_day_daoliubi_fm  a, b_4g_area_cell_day_daoliubi_fz b,stationdata c
 WHERE a.lncel_enb_id = b.lncel_enb_id 
  AND a.lncel_lcr_id = b.lncel_lcr_id
   and a.lncel_enb_id = c.enodbid
 GROUP BY 
 	`����`, 
	`����`, 
	`����`, 
	CONCAT(a.`lncel_enb_id`,a.`lncel_lcr_id`)