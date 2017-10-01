select 省份,pm_date,sum(基站数1) 基站数TDD, sum(小区数1) 小区数TDD
from( 
       select  '陕西' as 省份, count(distinct lncel.lncel_enb_id) 基站数1,
        count(distinct lncel.lncel_enb_id*lncel.lncel_lcr_id) 小区数1,               
               noklte_PS_lcelav_lncel_day.PERIOD_START_TIME pm_date,
               (CASE          
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
       END) 地市        
          from c_lte_lncel                lncel,
               c_lte_lnbts                lnbts,
               noklte_PS_lcelav_lncel_day
         where noklte_PS_lcelav_lncel_day.LNCEL_ID = lncel.obj_gid
           and noklte_PS_lcelav_lncel_day.LNBTS_ID = lnbts.obj_gid
           and lncel.conf_id = 1
           and lnbts.CONF_ID = 1
           and noklte_PS_lcelav_lncel_day.PERIOD_START_TIME >=
               to_date(&start_datetime, 'yyyymmddhh24')
           and noklte_PS_lcelav_lncel_day.PERIOD_START_TIME <
               to_date(&end_datetime, 'yyyymmddhh24')
         group by '陕西', (CASE          
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
       END), noklte_PS_lcelav_lncel_day.PERIOD_START_TIME                  
 )
 where 地市  <> 'A'
 group by 省份,pm_date