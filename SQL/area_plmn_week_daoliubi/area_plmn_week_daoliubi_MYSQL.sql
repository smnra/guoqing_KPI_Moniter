SELECT 
  '����' ʡ��,
	a.`����`,  
	(SUM(m815)-SUM(`4G�ض���3G���������`)) `4G�ض���3G���������`	 
, SUM(`4G E-RAB�����ܴ���`) `4G E-RAB�����ܴ���`,
  round(100*(SUM(m815)-SUM(`4G�ض���3G���������`))/SUM(`4G E-RAB�����ܴ���`),2) `4G����������%`
  FROM b_4g_area_plmn_week_daoliubi_fm  a, b_4g_area_plmn_week_daoliubi_fz b
 WHERE a.����= b.����
 GROUP BY '����', 
	a.`����`