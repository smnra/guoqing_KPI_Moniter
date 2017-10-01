select 地市,
       lncel_enb_id,
       lncel_lcr_id,
       round(max(下行PRB平均利用率)/0.9/0.6/0.5*100,2) radiorate from 
(select substr((CASE
         WHEN (LNCEL_ENB_ID >= 782337 and LNCEL_ENB_ID <= 783592) THEN
          '宝鸡FDD' --663个站点
		 WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN '宝鸡FDD'  
         WHEN (LNCEL_ENB_ID >= 772600 and LNCEL_ENB_ID <= 774144) THEN
          '西安FDD' --544个站点
         WHEN (LNCEL_ENB_ID >= 778240 and LNCEL_ENB_ID <= 780287) THEN
          '咸阳FDD' --860个站点   
         ELSE
           'A'        
       END),0,2) 地市,
       lncel.lncel_enb_id,
       lncel.lncel_lcr_id,
       To_Date(To_Char(NOKLTE_PS_LCELLR_LNCEL_hour.PERIOD_START_TIME, 'yyyy-mm-dd'), 'yyyy-mm-dd') As day,
       Cast(To_Char(NOKLTE_PS_LCELLR_LNCEL_hour.PERIOD_START_TIME, 'hh24') As Number) As hour,
       decode((sum(decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) +
                   decode(lncel.LNCEL_DL_CH_BW, '', 0, lncel.LNCEL_DL_CH_BW)) / 2),
              0,
              0,
              decode(sum(NOKLTE_PS_LCELLR_LNCEL_hour.PERIOD_DURATION * 60 * 1000),
                     0,
                     0,
                     sum(NOKLTE_PS_LCELLR_LNCEL_hour.PRB_USED_DL_TOTAL) /
                     sum(NOKLTE_PS_LCELLR_LNCEL_hour.PERIOD_DURATION * 60 * 1000)) /
              (sum(decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                   decode(lncel.LNCEL_TDD_FRAME_CONF, 1, 0.4, 0.6) +
                   decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                   decode(lncel.LNCEL_TSSC_296, 5, 0.0428, 0.1428) +
                   decode(lncel.LNCEL_DL_CH_BW, '', 0, lncel.LNCEL_DL_CH_BW)) / 2)) 下行PRB平均利用率 
                   from c_lte_lncel lncel,
       NOKLTE_PS_LCELLR_LNCEL_hour,
       NOKLTE_PS_LCELLT_LNCEL_hour
 where NOKLTE_PS_LCELLR_LNCEL_hour.LNCEL_ID(+) = lncel.obj_gid
   and NOKLTE_PS_LCELLT_LNCEL_hour.LNCEL_ID(+) = lncel.obj_gid
   and NOKLTE_PS_LCELLR_LNCEL_hour.PERIOD_START_TIME =
       NOKLTE_PS_LCELLT_LNCEL_hour.PERIOD_START_TIME      
   and lncel.conf_id = 1
   and NOKLTE_PS_LCELLR_LNCEL_hour.PERIOD_START_TIME >=
       to_date(&start_datetime, 'yyyymmddhh24')
   and NOKLTE_PS_LCELLR_LNCEL_hour.PERIOD_START_TIME <
       to_date(&end_datetime, 'yyyymmddhh24')
   and to_char(NOKLTE_PS_LCELLR_LNCEL_hour.PERIOD_START_TIME, 'hh24') in('11','22')    
 group by substr((CASE
            WHEN (LNCEL_ENB_ID >= 782337 and LNCEL_ENB_ID <= 783592) THEN
             '宝鸡FDD' --663个站点
			WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN '宝鸡FDD'
            WHEN (LNCEL_ENB_ID >= 772600 and LNCEL_ENB_ID <= 774144) THEN
             '西安FDD' --544个站点
            WHEN (LNCEL_ENB_ID >= 778240 and LNCEL_ENB_ID <= 780287) THEN
             '咸阳FDD' --860个站点   
             ELSE
              'A'          
          END),0,2), lncel.lncel_enb_id,
       lncel.lncel_lcr_id,
       To_Date(To_Char(NOKLTE_PS_LCELLR_LNCEL_hour.PERIOD_START_TIME, 'yyyy-mm-dd'), 'yyyy-mm-dd') ,
       Cast(To_Char(NOKLTE_PS_LCELLR_LNCEL_hour.PERIOD_START_TIME, 'hh24') As Number) 
 )
 where 地市 <> 'A'
 group by 地市,
       lncel_enb_id,
       lncel_lcr_id
 having round(max(下行PRB平均利用率)/0.9/0.6/0.5*100,2)  >= 90        