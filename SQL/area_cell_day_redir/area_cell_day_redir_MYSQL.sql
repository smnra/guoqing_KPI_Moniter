 SELECT 
 	`����`, 
	`����`, 
	`����`, 
	a.`lncel_enb_id`, 
	c.chname,
	a.`lncel_lcr_id`, 
	(SUM(m815)-SUM(`���Ǵ������ض���WCDMA���ܴ���`)) `���Ǵ������ض���WCDMA���ܴ���`,
	SUM(`E-RAB�����ɹ�����`) `E-RAB�����ɹ�����`,
  100*(SUM(m815)-SUM(`���Ǵ������ض���WCDMA���ܴ���`))/SUM(`E-RAB�����ɹ�����`) ���ڸ����ض�����WCDMAռ��
  FROM b_4g_area_cell_day_redir_fm  a, b_4g_area_cell_day_redir_fz b,stationdata c
 WHERE a.lncel_enb_id = b.lncel_enb_id 
  AND a.lncel_lcr_id = b.lncel_lcr_id
  AND a.lncel_enb_id = c.enodbid
 GROUP BY 
 	`����`, 
	`����`, 
	`����`, 
	a.`lncel_enb_id`, 
	a.`lncel_lcr_id`