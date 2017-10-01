select  substr(&start_datetime,0,8)
  ||'-'|| substr(&end_datetime,0,8)  as 日期,
'诺基亚' 厂家,
substr((CASE
         WHEN (LNCEL_ENB_ID >= 783593 and LNCEL_ENB_ID <= 783615) THEN
          '宝鸡' --23个站点
         WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN '宝鸡FDD'
         WHEN (LNCEL_ENB_ID >= 788460 and LNCEL_ENB_ID <= 788479) THEN
          '汉中' --20个站点
         WHEN (LNCEL_ENB_ID >= 789499 and LNCEL_ENB_ID <= 789503) THEN
          '商洛' --5个站点
         WHEN (LNCEL_ENB_ID >= 787448 and LNCEL_ENB_ID <= 787455) THEN
          '铜川' --8个站点
         WHEN (LNCEL_ENB_ID >= 778100 and LNCEL_ENB_ID <= 778239) THEN
          '西安' --40个站点
         WHEN (LNCEL_ENB_ID >= 786416 and LNCEL_ENB_ID <= 786431) THEN
          '延安' --16个站点
         WHEN (LNCEL_ENB_ID >= 782323 and LNCEL_ENB_ID <= 782335) THEN
          '榆林' --13个站点
         ELSE
          'A'
       END),0,2) 地市,
lncel_enb_id, lncel_lcr_id,
sum(nvl(ENB_EPSBEAR_REL_REQ_RNL_REDIR,0)) mc815,
sum(nvl(EPS_BEARER_SETUP_COMPLETIONS,0)) sumcompletions from 
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
         WHEN (LNCEL_ENB_ID >= 783593 and LNCEL_ENB_ID <= 783615) THEN
          '宝鸡' --23个站点
         WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN '宝鸡FDD'
         WHEN (LNCEL_ENB_ID >= 788460 and LNCEL_ENB_ID <= 788479) THEN
          '汉中' --20个站点
         WHEN (LNCEL_ENB_ID >= 789499 and LNCEL_ENB_ID <= 789503) THEN
          '商洛' --5个站点
         WHEN (LNCEL_ENB_ID >= 787448 and LNCEL_ENB_ID <= 787455) THEN
          '铜川' --8个站点
         WHEN (LNCEL_ENB_ID >= 778100 and LNCEL_ENB_ID <= 778239) THEN
          '西安' --40个站点
         WHEN (LNCEL_ENB_ID >= 786416 and LNCEL_ENB_ID <= 786431) THEN
          '延安' --16个站点
         WHEN (LNCEL_ENB_ID >= 782323 and LNCEL_ENB_ID <= 782335) THEN
          '榆林' --13个站点
         ELSE
          'A'
       END),0,2),lncel.lncel_enb_id,
       lncel.lncel_lcr_id 