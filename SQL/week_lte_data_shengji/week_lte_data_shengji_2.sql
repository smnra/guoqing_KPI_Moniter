select ʡ��,pm_date,sum(��վ��1) ��վ��TDD, sum(С����1) С����TDD
from( 
       select  '����' as ʡ��, count(distinct lncel.lncel_enb_id) ��վ��1,
        count(distinct lncel.lncel_enb_id*lncel.lncel_lcr_id) С����1,               
               noklte_PS_lcelav_lncel_day.PERIOD_START_TIME pm_date,
               (CASE          
         WHEN (LNCEL_ENB_ID >= 783593 and LNCEL_ENB_ID <= 783615) THEN
          '����' --23��վ��
         WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN '����FDD'
         WHEN (LNCEL_ENB_ID >= 788460 and LNCEL_ENB_ID <= 788479) THEN
          '����' --20��վ��
         WHEN (LNCEL_ENB_ID >= 789499 and LNCEL_ENB_ID <= 789503) THEN
          '����' --5��վ��
         WHEN (LNCEL_ENB_ID >= 787448 and LNCEL_ENB_ID <= 787455) THEN
          'ͭ��' --8��վ��
         WHEN (LNCEL_ENB_ID >= 778100 and LNCEL_ENB_ID <= 778239) THEN
          '����' --40��վ��
         WHEN (LNCEL_ENB_ID >= 786416 and LNCEL_ENB_ID <= 786431) THEN
          '�Ӱ�' --16��վ��
         WHEN (LNCEL_ENB_ID >= 782323 and LNCEL_ENB_ID <= 782335) THEN
          '����' --13��վ��
         ELSE
          'A'
       END) ����        
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
         group by '����', (CASE          
         WHEN (LNCEL_ENB_ID >= 783593 and LNCEL_ENB_ID <= 783615) THEN
          '����' --23��վ��
         WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN '����FDD'
         WHEN (LNCEL_ENB_ID >= 788460 and LNCEL_ENB_ID <= 788479) THEN
          '����' --20��վ��
         WHEN (LNCEL_ENB_ID >= 789499 and LNCEL_ENB_ID <= 789503) THEN
          '����' --5��վ��
         WHEN (LNCEL_ENB_ID >= 787448 and LNCEL_ENB_ID <= 787455) THEN
          'ͭ��' --8��վ��
         WHEN (LNCEL_ENB_ID >= 778100 and LNCEL_ENB_ID <= 778239) THEN
          '����' --40��վ��
         WHEN (LNCEL_ENB_ID >= 786416 and LNCEL_ENB_ID <= 786431) THEN
          '�Ӱ�' --16��վ��
         WHEN (LNCEL_ENB_ID >= 782323 and LNCEL_ENB_ID <= 782335) THEN
          '����' --13��վ��
         ELSE
          'A'
       END), noklte_PS_lcelav_lncel_day.PERIOD_START_TIME                  
 )
 where ����  <> 'A'
 group by ʡ��,pm_date