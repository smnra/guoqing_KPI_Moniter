 SELECT 
 	`日期`, 
	`厂家`, 
	`地市`, 
	a.`lncel_enb_id`, 
	c.chname,
	a.`lncel_lcr_id`, 
	(SUM(m815)-SUM(`覆盖触发的重定向到WCDMA的总次数`)) `覆盖触发的重定向到WCDMA的总次数`,
	SUM(`E-RAB建立成功个数`) `E-RAB建立成功个数`,
  100*(SUM(m815)-SUM(`覆盖触发的重定向到WCDMA的总次数`))/SUM(`E-RAB建立成功个数`) 基于覆盖重定向至WCDMA占比
  FROM b_4g_area_cell_day_redir_fm  a, b_4g_area_cell_day_redir_fz b,stationdata c
 WHERE a.lncel_enb_id = b.lncel_enb_id 
  AND a.lncel_lcr_id = b.lncel_lcr_id
  AND a.lncel_enb_id = c.enodbid
 GROUP BY 
 	`日期`, 
	`厂家`, 
	`地市`, 
	a.`lncel_enb_id`, 
	a.`lncel_lcr_id`