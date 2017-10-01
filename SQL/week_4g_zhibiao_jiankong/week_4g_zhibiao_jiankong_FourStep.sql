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
       decode(sum(fm),0,0, sum(fz)/sum(fm)) zb 
       from (select lncel.lncel_enb_id,
 lncel.lncel_lcr_id,sum(NOKLTE_PS_LIENBHO_MNC1_RAW.att_inter_enb_ho) fz,
 sum(NOKLTE_PS_LIENBHO_MNC1_RAW.att_inter_enb_ho)+sum(NOKLTE_PS_LIENBHO_MNC1_RAW.inter_enb_s1_ho_att) fm
from c_lte_lncel lncel,NOKLTE_PS_LIENBHO_MNC1_RAW
where NOKLTE_PS_LIENBHO_MNC1_RAW.LNCEL_ID(+) = lncel.obj_gid
   and NOKLTE_PS_LIENBHO_MNC1_RAW.LNCEL_ID(+) = lncel.obj_gid
   and lncel.conf_id = 1
   and NOKLTE_PS_LIENBHO_MNC1_RAW.PERIOD_START_TIME >=
       to_date(&start_datetime, 'yyyymmddhh24')
   and NOKLTE_PS_LIENBHO_MNC1_RAW.PERIOD_START_TIME <
       to_date(&end_datetime, 'yyyymmddhh24')
group by lncel.lncel_enb_id, lncel.lncel_lcr_id)  
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
