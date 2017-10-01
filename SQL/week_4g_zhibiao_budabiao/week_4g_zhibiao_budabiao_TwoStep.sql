select  lncel_enb_id,lncel_lcr_id,max(maxRRC) from 
(select To_Char(NOKLTE_PS_LCELLD_MNC1_RAW.PERIOD_START_TIME, 'yyyy-mm-dd') dday, 
 lncel.lncel_enb_id,
 lncel.lncel_lcr_id,
 max(RRC_CONN_UE_MAX) maxRRC 
  from c_lte_lncel lncel,NOKLTE_PS_LCELLD_MNC1_RAW
 where NOKLTE_PS_LCELLD_MNC1_RAW.LNCEL_ID(+) = lncel.obj_gid
   and NOKLTE_PS_LCELLD_MNC1_RAW.LNCEL_ID(+) = lncel.obj_gid
   and lncel.conf_id = 1
   and NOKLTE_PS_LCELLD_MNC1_RAW.PERIOD_START_TIME >=
       to_date(&start_datetime, 'yyyymmddhh24')
   and NOKLTE_PS_LCELLD_MNC1_RAW.PERIOD_START_TIME <
       to_date(&end_datetime, 'yyyymmddhh24')
group by    
 To_Char(NOKLTE_PS_LCELLD_MNC1_RAW.PERIOD_START_TIME, 'yyyy-mm-dd') ,
 lncel.lncel_enb_id,lncel.lncel_lcr_id
  having sum(RRC_CONN_UE_MAX) > 200
 )
 group by lncel_enb_id,lncel_lcr_id
