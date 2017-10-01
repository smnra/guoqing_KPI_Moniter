select 
lncel_enb_id, lncel_lcr_id,
sum(nvl(CSFB_REDIR_CR_ATT,0)) fz from 
c_lte_lncel lncel,
NOKLTE_PS_LISHO_lncel_day lepsb 
WHERE lepsb.LNCEL_ID = lncel.obj_gid
and lncel.conf_id = 1
and lepsb.PERIOD_START_TIME >=
    to_date(&start_datetime, 'yyyymmddhh24')
    and lepsb.PERIOD_START_TIME <
    to_date(&end_datetime, 'yyyymmddhh24')    
-- And ((lncel.lncel_enb_id between (782337)and (783592))--FDD
-- or (lncel.lncel_enb_id between (772600)and (774144))--FDD
-- or (lncel.lncel_enb_id between (778240)and (780287)))--FDD
GROUP BY lncel.lncel_enb_id,
       lncel.lncel_lcr_id 