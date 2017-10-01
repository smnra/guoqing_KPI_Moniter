select 
            substr((CASE
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
            sum(decode(lepsb.ENB_EPSBEAR_REL_REQ_RNL_REDIR,'',0,lepsb.ENB_EPSBEAR_REL_REQ_RNL_REDIR)) M8006C15,
            sum(decode(lepsb.ENB_EPS_BEARER_REL_REQ_NORM,'',0,lepsb.ENB_EPS_BEARER_REL_REQ_NORM)) + 
            sum(decode(lepsb.ENB_EPSBEAR_REL_REQ_RNL_REDIR,'',0,lepsb.ENB_EPSBEAR_REL_REQ_RNL_REDIR)) +
            sum(decode(lepsb.EPC_EPS_BEARER_REL_REQ_NORM,'',0,lepsb.EPC_EPS_BEARER_REL_REQ_NORM)) +
            sum(decode(lepsb.EPC_EPS_BEARER_REL_REQ_DETACH,'',0,lepsb.EPC_EPS_BEARER_REL_REQ_DETACH))+
            sum(decode(lepsb.ERAB_REL_ENB_ACT_NON_GBR,'',0,lepsb.ERAB_REL_ENB_ACT_NON_GBR)) fm
           
from 
c_lte_lncel lncel,
NOKLTE_PS_LEPSB_LNCEL_day lepsb 
WHERE
 lepsb.LNCEL_ID = lncel.obj_gid
and lncel.conf_id = 1
and lepsb.PERIOD_START_TIME >=
    to_date(&start_datetime, 'yyyymmddhh24')
    and lepsb.PERIOD_START_TIME <
    to_date(&end_datetime, 'yyyymmddhh24')    
 And ((lncel.lncel_enb_id between (782337)and (783592))--FDD

or (lncel.lncel_enb_id between (772600)and (774144))--FDD

or (lncel.lncel_enb_id between (775936)and (776286))--FDD

or (lncel.lncel_enb_id between (778240)and (780287)))--FDD

GROUP BY  substr((CASE
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
 
