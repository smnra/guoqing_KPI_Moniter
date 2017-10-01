select substr((CASE
         WHEN (LNCEL_ENB_ID >= 782337 and LNCEL_ENB_ID <= 783592) THEN
          '宝鸡FDD' --663个站点
		 WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN
          '宝鸡FDD' 
         WHEN (LNCEL_ENB_ID >= 772600 and LNCEL_ENB_ID <= 774144) THEN
          '西安FDD' --544个站点
         WHEN (LNCEL_ENB_ID >= 778240 and LNCEL_ENB_ID <= 780287) THEN
          '咸阳FDD' --860个站点   
         ELSE
           'A'        
       END),0,2) 地市,
sum(NOKLTE_PS_LISHO_MNC1_RAW.CSFB_REDIR_CR_ATT)+sum(NOKLTE_PS_LISHO_MNC1_RAW.CSFB_REDIR_CR_CMODE_ATT) zh
 from 
c_lte_lncel lncel,NOKLTE_PS_LISHO_MNC1_RAW
where NOKLTE_PS_LISHO_MNC1_RAW.LNCEL_ID(+) = lncel.obj_gid
   and NOKLTE_PS_LISHO_MNC1_RAW.LNCEL_ID(+) = lncel.obj_gid
   and lncel.conf_id = 1
   and NOKLTE_PS_LISHO_MNC1_RAW.PERIOD_START_TIME >=
       to_date(&start_datetime, 'yyyymmddhh24')
   and NOKLTE_PS_LISHO_MNC1_RAW.PERIOD_START_TIME <
       to_date(&end_datetime, 'yyyymmddhh24')
group by substr((CASE
         WHEN (LNCEL_ENB_ID >= 782337 and LNCEL_ENB_ID <= 783592) THEN
          '宝鸡FDD' --663个站点
		 WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN
          '宝鸡FDD' 
         WHEN (LNCEL_ENB_ID >= 772600 and LNCEL_ENB_ID <= 774144) THEN
          '西安FDD' --544个站点
         WHEN (LNCEL_ENB_ID >= 778240 and LNCEL_ENB_ID <= 780287) THEN
          '咸阳FDD' --860个站点   
         ELSE
           'A'        
       END),0,2)