UPDATE b_4g_jiankongzhibiao_budabiao_six a,
(SELECT * FROM b_4g_jiankongzhibiao_budabiao_one WHERE marate < 97) b  
SET a.`设备完好率小于97%` = b.marate
WHERE a.lncel_enb_id = b.lncel_enb_id
AND a.lncel_lcr_id = b.lncel_lcr_id;


UPDATE b_4g_jiankongzhibiao_budabiao_six a,
(SELECT * FROM b_4g_jiankongzhibiao_budabiao_one WHERE CQI4 >20) b  
SET a.`CQI≤4占比大于20%` = b.CQI4
WHERE a.lncel_enb_id = b.lncel_enb_id
AND a.lncel_lcr_id = b.lncel_lcr_id;


UPDATE b_4g_jiankongzhibiao_budabiao_six a,
(SELECT * FROM b_4g_jiankongzhibiao_budabiao_two WHERE maxRRC >200) b  
SET a.`RRC链接用户数大于200` = b.maxRRC
WHERE a.lncel_enb_id = b.lncel_enb_id
AND a.lncel_lcr_id = b.lncel_lcr_id;


UPDATE b_4g_jiankongzhibiao_budabiao_six a,
(SELECT * FROM b_4g_jiankongzhibiao_budabiao_three WHERE rscp >=-105) b  
SET a.`平均噪声干扰区间≥-105dbm` = b.rscp
WHERE a.lncel_enb_id = b.lncel_enb_id
AND a.lncel_lcr_id = b.lncel_lcr_id;


UPDATE b_4g_jiankongzhibiao_budabiao_six a,
(SELECT * FROM b_4g_jiankongzhibiao_budabiao_four WHERE zb >=30) b  
SET a.`4G至3G重定向率大于30%` = b.zb 
WHERE a.lncel_enb_id = b.lncel_enb_id
AND a.lncel_lcr_id = b.lncel_lcr_id;


UPDATE b_4g_jiankongzhibiao_budabiao_six a,
(SELECT * FROM b_4g_jiankongzhibiao_budabiao_five WHERE radiorate >=90) b  
SET a.`下行无线资源利用率≥90%` = b.radiorate 
WHERE a.lncel_enb_id = b.lncel_enb_id
AND a.lncel_lcr_id = b.lncel_lcr_id;


 UPDATE b_4g_jiankongzhibiao_budabiao_six a,stationdata b
 SET a.chname = b.chname
 WHERE a.lncel_enb_id = b.enodbid;	
 

DELETE FROM `b_4g_jiankongzhibiao_budabiao_six` 
	WHERE `设备完好率小于97%` IS NULL AND 
	`CQI≤4占比大于20%`  IS NULL  AND 
	`RRC链接用户数大于200` IS NULL  AND 
	`平均噪声干扰区间≥-105dbm` IS NULL  AND 
	`4G至3G重定向率大于30%` IS NULL  AND 
	`下行无线资源利用率≥90%` IS NULL ; 
	
	

	