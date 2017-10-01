select  substr(&start_datetime,0,8)
  ||'-'|| substr(&end_datetime,0,8)  as 日期,
'诺基亚' 厂家,
substr((CASE
         WHEN (LNCEL_ENB_ID >= 782337 and LNCEL_ENB_ID <= 783592) THEN
          '宝鸡FDD' --663个站点
         WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN '宝鸡FDD'
         WHEN (LNCEL_ENB_ID >= 772600 and LNCEL_ENB_ID <= 774144) THEN
          '西安FDD' --544个站点
         WHEN (LNCEL_ENB_ID >= 778240 and LNCEL_ENB_ID <= 780287) THEN
          '咸阳FDD' --860个站点 
      WHEN (lncel.lncel_enb_id>=783593 and lncel.lncel_enb_id<=783615) THEN '宝鸡TDD'   --23个站点
      WHEN (lncel.lncel_enb_id>=788460 and lncel.lncel_enb_id<=788479) THEN '汉中TDD'   --20个站点
      WHEN (lncel.lncel_enb_id>=789499 and lncel.lncel_enb_id<=789503) THEN '商洛TDD'   --5个站点
      WHEN (lncel.lncel_enb_id>=787448 and lncel.lncel_enb_id<=787455) THEN '铜川TDD'    --8个站点
      WHEN (lncel.lncel_enb_id>=778100 and lncel.lncel_enb_id<=778239) THEN '西安TDD'   --40个站点
      WHEN (lncel.lncel_enb_id>=786416 and lncel.lncel_enb_id<=786431) THEN '延安TDD'   --16个站点
      WHEN (lncel.lncel_enb_id>=782323 and lncel.lncel_enb_id<=782335) THEN '榆林TDD'   --13个站点  
         ELSE
           'A'        
       END),0,2) 地市,
sum(nvl(ENB_EPSBEAR_REL_REQ_RNL_REDIR,0)) mc815,
sum(nvl(EPS_BEARER_SETUP_ATTEMPTS,0)) sumcompletions from  
c_lte_lncel lncel,
noklte_PS_lepsb_lncel_day lepsb 
WHERE lepsb.LNCEL_ID = lncel.obj_gid
and lncel.conf_id = 1
and lepsb.PERIOD_START_TIME >=
    to_date(&start_datetime, 'yyyymmddhh24')
    and lepsb.PERIOD_START_TIME <
    to_date(&end_datetime, 'yyyymmddhh24')    
-- And ((lncel.lncel_enb_id between (782337)and (783592))--FDD
--or (lncel.lncel_enb_id between (772600)and (774144))--FDD
--or (lncel.lncel_enb_id between (778240)and (780287)))--FDD

GROUP BY  substr((CASE
         WHEN (LNCEL_ENB_ID >= 782337 and LNCEL_ENB_ID <= 783592) THEN
          '宝鸡FDD' --663个站点
         WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN '宝鸡FDD'
         WHEN (LNCEL_ENB_ID >= 772600 and LNCEL_ENB_ID <= 774144) THEN
          '西安FDD' --544个站点
         WHEN (LNCEL_ENB_ID >= 778240 and LNCEL_ENB_ID <= 780287) THEN
          '咸阳FDD' --860个站点   
         WHEN (lncel.lncel_enb_id>=783593 and lncel.lncel_enb_id<=783615) THEN '宝鸡TDD'   --23个站点
      WHEN (lncel.lncel_enb_id>=788460 and lncel.lncel_enb_id<=788479) THEN '汉中TDD'   --20个站点
      WHEN (lncel.lncel_enb_id>=789499 and lncel.lncel_enb_id<=789503) THEN '商洛TDD'   --5个站点
      WHEN (lncel.lncel_enb_id>=787448 and lncel.lncel_enb_id<=787455) THEN '铜川TDD'    --8个站点
      WHEN (lncel.lncel_enb_id>=778100 and lncel.lncel_enb_id<=778239) THEN '西安TDD'   --40个站点
      WHEN (lncel.lncel_enb_id>=786416 and lncel.lncel_enb_id<=786431) THEN '延安TDD'   --16个站点
      WHEN (lncel.lncel_enb_id>=782323 and lncel.lncel_enb_id<=782335) THEN '榆林TDD'   --13个站点
         ELSE
           'A'        
       END),0,2) 