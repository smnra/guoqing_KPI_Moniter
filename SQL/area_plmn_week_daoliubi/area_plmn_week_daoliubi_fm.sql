select  substr(&start_datetime,0,8)
  ||'-'|| substr(&end_datetime,0,8)  as ����,
'ŵ����' ����,
substr((CASE
         WHEN (LNCEL_ENB_ID >= 782337 and LNCEL_ENB_ID <= 783592) THEN
          '����FDD' --663��վ��
         WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN '����FDD'
         WHEN (LNCEL_ENB_ID >= 772600 and LNCEL_ENB_ID <= 774144) THEN
          '����FDD' --544��վ��
         WHEN (LNCEL_ENB_ID >= 778240 and LNCEL_ENB_ID <= 780287) THEN
          '����FDD' --860��վ�� 
      WHEN (lncel.lncel_enb_id>=783593 and lncel.lncel_enb_id<=783615) THEN '����TDD'   --23��վ��
      WHEN (lncel.lncel_enb_id>=788460 and lncel.lncel_enb_id<=788479) THEN '����TDD'   --20��վ��
      WHEN (lncel.lncel_enb_id>=789499 and lncel.lncel_enb_id<=789503) THEN '����TDD'   --5��վ��
      WHEN (lncel.lncel_enb_id>=787448 and lncel.lncel_enb_id<=787455) THEN 'ͭ��TDD'    --8��վ��
      WHEN (lncel.lncel_enb_id>=778100 and lncel.lncel_enb_id<=778239) THEN '����TDD'   --40��վ��
      WHEN (lncel.lncel_enb_id>=786416 and lncel.lncel_enb_id<=786431) THEN '�Ӱ�TDD'   --16��վ��
      WHEN (lncel.lncel_enb_id>=782323 and lncel.lncel_enb_id<=782335) THEN '����TDD'   --13��վ��  
         ELSE
           'A'        
       END),0,2) ����,
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
          '����FDD' --663��վ��
         WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN '����FDD'
         WHEN (LNCEL_ENB_ID >= 772600 and LNCEL_ENB_ID <= 774144) THEN
          '����FDD' --544��վ��
         WHEN (LNCEL_ENB_ID >= 778240 and LNCEL_ENB_ID <= 780287) THEN
          '����FDD' --860��վ��   
         WHEN (lncel.lncel_enb_id>=783593 and lncel.lncel_enb_id<=783615) THEN '����TDD'   --23��վ��
      WHEN (lncel.lncel_enb_id>=788460 and lncel.lncel_enb_id<=788479) THEN '����TDD'   --20��վ��
      WHEN (lncel.lncel_enb_id>=789499 and lncel.lncel_enb_id<=789503) THEN '����TDD'   --5��վ��
      WHEN (lncel.lncel_enb_id>=787448 and lncel.lncel_enb_id<=787455) THEN 'ͭ��TDD'    --8��վ��
      WHEN (lncel.lncel_enb_id>=778100 and lncel.lncel_enb_id<=778239) THEN '����TDD'   --40��վ��
      WHEN (lncel.lncel_enb_id>=786416 and lncel.lncel_enb_id<=786431) THEN '�Ӱ�TDD'   --16��վ��
      WHEN (lncel.lncel_enb_id>=782323 and lncel.lncel_enb_id<=782335) THEN '����TDD'   --13��վ��
         ELSE
           'A'        
       END),0,2) 