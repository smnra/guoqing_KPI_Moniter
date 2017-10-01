with busyhour AS (
    SELECT 
        m1.lncel_id,
        mm.pm_date AS pm_date_hour
    FROM
        (select 
            lncel_id,
            to_char(to_date(pm_date,'yyyymmddhh24'), 'yyyymmdd') as pm_date,

            max(最大业务量) AS 最大业务量
        from    
                (SELECT 
            lcellt.lncel_id AS lncel_id,
            to_char(lcellt.period_start_time, 'yyyymmddhh24') pm_date,
            SUM(PDCP_SDU_VOL_UL + PDCP_SDU_VOL_DL)  AS 最大业务量
            
        FROM 
            NOKLTE_PS_LCELLT_LNCEL_HOUR lcellt
        WHERE 
                lcellt.period_start_time >= to_date(&start_date, 'yyyy-mm-dd')
            AND lcellt.period_start_time < to_date(&end_date, 'yyyy-mm-dd')


        GROUP BY 
            lcellt.lncel_id,
            to_char(lcellt.period_start_time, 'yyyymmddhh24')
            )
        group by 
            lncel_id,
            to_char(to_date(pm_date,'yyyymmddhh24'), 'yyyymmdd')
        ) m1
        
    left JOIN 
            
        (SELECT 
            lcellt.lncel_id AS lncel_id,
            to_char(lcellt.period_start_time, 'yyyymmddhh24') pm_date,
            SUM(PDCP_SDU_VOL_UL + PDCP_SDU_VOL_DL)  AS 最大业务量
            
        FROM 
            NOKLTE_PS_LCELLT_LNCEL_HOUR lcellt
        WHERE 
                lcellt.period_start_time >= to_date(&start_date, 'yyyy-mm-dd')
            AND lcellt.period_start_time < to_date(&end_date, 'yyyy-mm-dd')


        GROUP BY 
            lcellt.lncel_id,
            to_char(lcellt.period_start_time, 'yyyymmddhh24')
        )   mm ON m1.lncel_id = mm.lncel_id  AND m1.最大业务量 = mm.最大业务量 AND mm.最大业务量<>0
    
    ORDER BY 
    m1.lncel_id
    )


    
    


select
    c.city,
  --c.lnbtsid,
  --c.lncel_lcr_id,
    --to_char(lcellt.PERIOD_START_TIME,'yyyy-mm-dd') as PERIOD_START_TIME,
    lcellt.PERIOD_START_TIME,
    round(sum(lcellt.空口业务字节数)/1024/1024/1024,4) as 空口业务字节数_GB,
    round(sum(lcellt.空口上行业务字节数)/1024/1024/1024,4)  as 空口上行业务字节数_GB,
    round(sum(lcellt.空口下行业务字节数)/1024/1024/1024,4)  as 空口下行业务字节数_GB,

    sum(lcelld.最大RRC连接用户数) as 最大RRC连接用户数,
    
    --无线接通率
    round(decode(sum(luest.RRC连接建立请求次数),0,null,sum(luest.RRC连接建立成功次数)/sum(luest.RRC连接建立请求次数))* decode(sum(luest.ERAB建立请求个数),0,null,sum(luest.ERAB建立成功个数)/sum(luest.ERAB建立请求个数))*100,2) as 无线接通率,
    
    sum(luest.RRC连接建立请求次数) as RRC连接建立请求次数,
    sum(luest.RRC连接建立成功次数) as RRC连接建立成功次数,

    sum(luest.ERAB建立请求个数) as ERAB建立请求个数,
    sum(luest.ERAB建立成功个数) as ERAB建立成功个数,
    
    --掉话率
    round(decode(sum(luest.LTE业务释放次数),0,null,sum(luest.LTE业务掉线次数)/sum(luest.LTE业务释放次数))*100,2) as 掉话率,
    sum(luest.LTE业务释放次数) as LTE业务释放次数,
    sum(luest.LTE业务掉线次数) as LTE业务掉线次数,

    --下行PRB平均利用率
    --sum(lcellr.下行PRB可用数) as 下行PRB可用数,
    --sum(lcellr.下行PRB占用平均数) as 下行PRB占用平均数,
    
    round(AVG(lcellr.下行PRB平均利用率)*100,2) AS 下行PRB平均利用率,
    
    --RRC拥塞率
    round(decode(sum(luest.RRC连接建立请求次数),0,null,sum(luest.RRC建立拥塞次数)/sum(luest.RRC连接建立请求次数))*100,2) as RRC拥塞率,
    sum(luest.RRC连接建立请求次数) as RRC连接建立请求次数,
    sum(luest.RRC建立拥塞次数) as RRC建立拥塞次数,
    
    
    --同频切换成功率
    round(decode(sum(lienbho.同频切换请求次数),0,null,sum(lienbho.同频切换成功次数)/sum(lienbho.同频切换请求次数))*100,2) as 同频切换成功率,
    sum(lienbho.同频切换请求次数) as 同频切换请求次数,
    sum(lienbho.同频切换成功次数) as 同频切换成功次数,

	
    --异频切换出成功率
    round(decode(sum(lienbho.异频切换请求次数),0,null,sum(lienbho.异频切换出成功次数)/sum(lienbho.异频切换请求次数))*100,2) as 异频切换成功率,
    sum(lienbho.异频切换请求次数) as 异频切换请求次数,
    sum(lienbho.异频切换出成功次数) as 异频切换出成功次数



 

from
    (SELECT
        lcellt.lncel_id,
        to_char(lcellt.PERIOD_START_TIME,'yyyy-mm-dd') as PERIOD_START_TIME,
        SUM(lcellt.PDCP_SDU_VOL_UL + lcellt.PDCP_SDU_VOL_DL) AS 空口业务字节数,
        SUM(lcellt.PDCP_SDU_VOL_UL )  AS 空口上行业务字节数,
        SUM(lcellt.PDCP_SDU_VOL_DL )  AS 空口下行业务字节数
    FROM
            NOKLTE_PS_LCELLT_LNCEL_HOUR lcellt
        --inner join busyhour on lcellt.lncel_id = busyhour.lncel_id
        --and to_char(lcellt.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour
        
    WHERE
            lcellt.period_start_time >= To_Date(&start_date, 'yyyy-mm-dd')
        AND lcellt.period_start_time <  To_Date(&end_date, 'yyyy-mm-dd')

    GROUP BY
        lcellt.lncel_id,
        to_char(lcellt.PERIOD_START_TIME,'yyyy-mm-dd')
    ) lcellt


   
    
inner join   
    (SELECT
        lcelld.lncel_id,
        to_char(lcelld.PERIOD_START_TIME,'yyyy-mm-dd') as PERIOD_START_TIME,
        round(sum(lcelld.RRC_CONN_UE_MAX),2) as 最大RRC连接用户数

    FROM
        NOKLTE_PS_LCELLD_LNCEL_HOUR lcelld
        inner join busyhour on lcelld.lncel_id = busyhour.lncel_id
              and to_char(lcelld.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour
        
    WHERE
            lcelld.period_start_time >= To_Date(&start_date, 'yyyy-mm-dd')
        AND lcelld.period_start_time <  To_Date(&end_date, 'yyyy-mm-dd')

    GROUP BY
        lcelld.lncel_id,
        to_char(lcelld.PERIOD_START_TIME,'yyyy-mm-dd')
        
    ) lcelld on lcelld.lncel_id = lcellt.lncel_id and lcelld.PERIOD_START_TIME = lcellt.PERIOD_START_TIME 
    
  
    
    
inner join   
    (    SELECT
        luest.lncel_id,
        to_char(luest.PERIOD_START_TIME,'yyyy-mm-dd') as PERIOD_START_TIME,

        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0,luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode( luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO)),sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_OTHERS + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0, luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode(luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO))) AS RRC连接建立请求次数,
        
        sum(luest.SIGN_CONN_ESTAB_COMP) AS RRC连接建立成功次数,

        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_FAIL_PUCCH),sum(luest.SIGN_CONN_ESTAB_FAIL_RRMRAC)) AS RRC建立拥塞次数,

        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum( lepsb.ERAB_INI_SETUP_FAIL_RNL_RRNA + lepsb.ERAB_ADD_SETUP_FAIL_RNL_RRNA),sum(lepsb.EPS_BEARER_SETUP_FAIL_RESOUR)) AS 无线资源拥塞次数,
        
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS - lepsb.EPS_BEARER_SETUP_COMPLETIONS - lepsb.ERAB_INI_SETUP_FAIL_RNL_UEL - lepsb.ERAB_ADD_SETUP_FAIL_RNL_UEL - lepsb.ERAB_INI_SETUP_FAIL_TNL_TRU - lepsb.ERAB_ADD_SETUP_FAIL_TNL_TRU - lepsb.ERAB_INI_SETUP_FAIL_RNL_RRNA - lepsb.ERAB_ADD_SETUP_FAIL_RNL_RRNA - lepsb.ERAB_INI_SETUP_FAIL_RNL_RIP - lepsb.ERAB_ADD_SETUP_FAIL_RNL_RIP - lepsb.ERAB_ADD_SETUP_FAIL_UP - lepsb.ERAB_ADD_SETUP_FAIL_RNL_MOB),sum(lepsb.EPS_BEARER_SETUP_FAIL_TRPORT)) AS 传输资源拥塞次数,
        
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM(lepsb.ERAB_INI_SETUP_FAIL_RNL_UEL + lepsb.ERAB_ADD_SETUP_FAIL_RNL_UEL ),Sum(lepsb.EPS_BEARER_SETUP_FAIL_RNL)) ERAB建立失败_UE无响应,
        
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM(lepsb.ERAB_ADD_SETUP_FAIL_UP),Sum(lepsb.EPS_BEARER_SETUP_FAIL_OTH)) AS ERAB建立失败_配置,
        
        sum(luest.SIGN_EST_F_RRCCOMPL_MISSING) AS Setup_comp_miss无应答,
        
        sum(luest.SIGN_EST_F_RRCCOMPL_ERROR) AS Setup_comp_error小区拒绝,
        
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_FAIL_PUCCH),sum(luest.SIGN_CONN_ESTAB_FAIL_RRMRAC)) AS Reject_RRM_RAC资源分配失,
        
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_FAIL_MAXRRC),'') AS SIGN_CONN_ESTAB_FAIL_MAXRRC, --LN7.0无此指标
        
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(lepsb.ERAB_ADD_SETUP_FAIL_UP),'') AS E_RAB建立失败_核心网, 
        --LN7.0无此指标
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(lepsb.ERAB_INI_SETUP_FAIL_RNL_RIP + lepsb.ERAB_ADD_SETUP_FAIL_RNL_RIP),'') AS E_RAB建立失败_无线层, --LN7.0无此指标
        
        round(decode(sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS),0,0, sum(lepsb.EPS_BEARER_SETUP_COMPLETIONS) / sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS))*100,2) AS ERAB建立成功率,

        sum(lepsb.EPS_BEARER_SETUP_COMPLETIONS) AS ERAB建立成功个数,
        
        sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS) AS ERAB建立请求个数,
        
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(lepsb.ERAB_INI_SETUP_FAIL_RNL_RRNA + lepsb.ERAB_INI_SETUP_FAIL_TNL_TRU + lepsb.ERAB_ADD_SETUP_FAIL_RNL_RRNA + lepsb.ERAB_ADD_SETUP_FAIL_TNL_TRU),SUM( lepsb.EPS_BEARER_SETUP_FAIL_TRPORT + lepsb.EPS_BEARER_SETUP_FAIL_RESOUR )) AS ERAB建立拥塞次数，
        
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM( lepsb.EPC_EPS_BEARER_REL_REQ_RNL  + lepsb.ERAB_REL_ENB_RNL_UEL + lepsb.ERAB_REL_ENB_RNL_EUGR + lepsb.ERAB_REL_ENB_TNL_TRU + lepsb.ERAB_REL_HO_PART + lepsb.ERAB_REL_EPC_PATH_SWITCH ) ,SUM( lepsb.EPC_EPS_BEARER_REL_REQ_RNL + lepsb.EPC_EPS_BEAR_REL_REQ_R_QCI1 + lepsb.PRE_EMPT_GBR_BEARER + lepsb.PRE_EMPT_NON_GBR_BEARER + lepsb.ENB_EPS_BEARER_REL_REQ_RNL + lepsb.ENB_EPS_BEARER_REL_REQ_TNL + lepsb.ENB_EPS_BEARER_REL_REQ_OTH))  AS LTE业务掉线次数,

        
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum( lepsb.EPC_EPS_BEARER_REL_REQ_RNL  + lepsb.ERAB_REL_ENB_RNL_UEL + lepsb.ERAB_REL_ENB_RNL_EUGR + lepsb.ERAB_REL_ENB_TNL_TRU + lepsb.ERAB_REL_HO_PART + lepsb.ERAB_REL_EPC_PATH_SWITCH + lepsb.ERAB_REL_ENB_RNL_INA + lepsb.ERAB_REL_ENB_RNL_RED + lepsb.ERAB_REL_ENB_RNL_RRNA + lepsb.EPC_EPS_BEARER_REL_REQ_NORM + lepsb.EPC_EPS_BEARER_REL_REQ_DETACH ) ,sum( lepsb.EPC_EPS_BEARER_REL_REQ_NORM + lepsb.EPC_EPS_BEARER_REL_REQ_DETACH + lepsb.EPC_EPS_BEARER_REL_REQ_RNL + lepsb.ERAB_REL_ENB_ACT_NON_GBR + lepsb.ENB_EPSBEAR_REL_REQ_RNL_REDIR + lepsb.ENB_EPS_BEARER_REL_REQ_NORM + lepsb.ENB_EPS_BEARER_REL_REQ_RNL + lepsb.ENB_EPS_BEARER_REL_REQ_TNL + lepsb.ENB_EPS_BEARER_REL_REQ_OTH + lepsb.EPC_EPS_BEAR_REL_REQ_R_QCI1 + lepsb.PRE_EMPT_GBR_BEARER + lepsb.PRE_EMPT_NON_GBR_BEARER)) AS LTE业务释放次数

    FROM
        NOKLTE_PS_LUEST_LNCEL_HOUR luest
        
        inner join busyhour 
            on luest.lncel_id = busyhour.lncel_id
            and to_char(luest.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour
                
        INNER JOIN NOKLTE_PS_LEPSB_LNCEL_HOUR lepsb 
            ON lepsb.lncel_id = luest.lncel_id
            AND lepsb.period_start_time = luest.period_start_time
            and luest.lncel_id = busyhour.lncel_id
            and to_char(lepsb.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour


        RIGHT JOIN C_LTE_CUSTOM c 
            ON c.lncel_objid = luest.lncel_id
        
    WHERE
        luest.period_start_time >= To_Date(&start_date, 'yyyy-mm-dd')
        AND luest.period_start_time <  To_Date(&end_date, 'yyyy-mm-dd')

    GROUP BY
        luest.lncel_id,
        to_char(luest.PERIOD_START_TIME,'yyyy-mm-dd'),
        c.version
        
    ) luest on luest.lncel_id = lcellt.lncel_id and luest.PERIOD_START_TIME = lcellt.PERIOD_START_TIME 
       
    
    
    
    
inner join 
    (SELECT 
        to_char(lcellr.PERIOD_START_TIME,'yyyy-mm-dd') AS period_start_time,
        lcellr.lncel_id,
        decode((sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)+decode(lncel.LNCEL_UL_CH_BW,'',0,lncel.LNCEL_UL_CH_BW))/2),0,0, decode(sum(lcellr.PERIOD_DURATION*60*1000),0,0,sum(lcellr.PRB_USED_PUSCH)/sum(lcellr.PERIOD_DURATION*60*1000))/        (sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*decode(lncel.LNCEL_TDD_FRAME_CONF,1,0.4,0.2)+ decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)/35+decode(lncel.LNCEL_UL_CH_BW,'',0, lncel.LNCEL_UL_CH_BW))/2)) AS 上行PRB平均利用率,

        sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*decode(lncel.LNCEL_TDD_FRAME_CONF,1,0.4,0.2)+decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)/35+ decode(lncel.LNCEL_UL_CH_BW,'',0,lncel.LNCEL_UL_CH_BW))/2  AS 上行PRB可用数,  
        
        decode(sum(lcellr.PERIOD_DURATION*60*1000),0,0,sum(lcellr.PRB_USED_PUSCH)/sum(lcellr.PERIOD_DURATION*60*1000)) AS 上行PRB占用平均数,
        
        decode((sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)+decode(lncel.LNCEL_DL_CH_BW,'',0,lncel.LNCEL_DL_CH_BW))/2),0,0,decode(sum(lcellr.PERIOD_DURATION*60*1000),0,0, sum(lcellr.PRB_USED_PDSCH) /sum(lcellr.PERIOD_DURATION*60*1000))/(sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)* decode(lncel.LNCEL_TDD_FRAME_CONF,1,0.4,0.6)+decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*decode(lncel.LNCEL_TSSC_296,5,0.0428,0.1428)+ decode(lncel.LNCEL_DL_CH_BW,'',0,lncel.LNCEL_DL_CH_BW))/2)) AS 下行PRB平均利用率,
        
        sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*decode(lncel.LNCEL_TDD_FRAME_CONF,1,0.4,0.6)+decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*decode(lncel.LNCEL_TSSC_296,5,0.0428,0.1428)+ decode(lncel.LNCEL_DL_CH_BW,'',0,lncel.LNCEL_DL_CH_BW))/2  AS 下行PRB可用数,
        
        decode(sum(lcellr.PERIOD_DURATION*60*1000),0,0, sum(lcellr.PRB_USED_PDSCH) / sum(lcellr.PERIOD_DURATION*60*1000)) AS 下行PRB占用平均数

    FROM 
        NOKLTE_PS_LCELLR_LNCEL_HOUR lcellr
        
        inner join busyhour 
            on lcellr.lncel_id = busyhour.lncel_id
            and to_char(lcellr.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour   
        
        inner JOIN c_lte_lncel lncel 
            ON lcellr.lncel_id = lncel.obj_gid
            and busyhour.lncel_id = lncel.obj_gid

    WHERE 
            lcellr.period_start_time >=to_date(&start_date, 'yyyy-mm-dd')
        AND lcellr.period_start_time < to_date(&end_date, 'yyyy-mm-dd')
        
    GROUP BY 
        to_char(lcellr.PERIOD_START_TIME,'yyyy-mm-dd'),
        lcellr.lncel_id

    ) lcellr on lcellr.lncel_id = lcellt.lncel_id and lcellr.PERIOD_START_TIME = lcellt.PERIOD_START_TIME 

inner join 
    (SELECT
        lianbho.lncel_id,
        to_char(lianbho.PERIOD_START_TIME,'yyyy-mm-dd') AS period_start_time,

        --round(DECODE(SUM(lianbho.ATT_INTRA_ENB_HO+lienbho.ATT_INTER_ENB_HO+lienbho.INTER_ENB_S1_HO_ATT-lho.HO_INTFREQ_ATT),0,0,SUM(lianbho.SUCC_INTRA_ENB_HO+lienbho.SUCC_INTER_ENB_HO+LIENBHO.INTER_ENB_S1_HO_SUCC-LHO.HO_INTFREQ_SUCC)/SUM(lianbho.ATT_INTRA_ENB_HO+lienbho.ATT_INTER_ENB_HO+lienbho.INTER_ENB_S1_HO_ATT-lho.HO_INTFREQ_ATT))*100,2) AS 同频切换成功率，
        
        SUM(lianbho.ATT_INTRA_ENB_HO+lienbho.ATT_INTER_ENB_HO+lienbho.INTER_ENB_S1_HO_ATT-lho.HO_INTFREQ_ATT) AS 同频切换请求次数,
        
        SUM(lianbho.SUCC_INTRA_ENB_HO+lienbho.SUCC_INTER_ENB_HO+LIENBHO.INTER_ENB_S1_HO_SUCC-LHO.HO_INTFREQ_SUCC) AS 同频切换成功次数,
        
        --round(decode(SUM(lho.HO_INTFREQ_ATT),0,0,SUM(lho.HO_INTFREQ_SUCC)/SUM(lho.HO_INTFREQ_ATT))*100,2) AS 异频切换成功率，
        
        SUM(lho.HO_INTFREQ_ATT) AS 异频切换请求次数,
        
        SUM(lho.HO_INTFREQ_SUCC) AS 异频切换出成功次数

    FROM
        NOKLTE_PS_LIENBHO_LNCEL_HOUR lienbho
        
        inner join busyhour 
            on lienbho.lncel_id = busyhour.lncel_id
            and to_char(lienbho.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour   
            
        INNER JOIN NOKLTE_PS_LIANBHO_LNCEL_HOUR lianbho 
            ON lienbho.lncel_id = lianbho.lncel_id
            AND lienbho.period_start_time = lianbho.period_start_time
            and busyhour.lncel_id = lianbho.lncel_id
            and busyhour.pm_date_hour = to_char(lianbho.period_start_time, 'yyyymmddhh24') 

        INNER JOIN NOKLTE_PS_LHO_LNCEL_HOUR lho 
            ON lienbho.lncel_id = lho.lncel_id
            AND lienbho.period_start_time = lho.period_start_time 
            and busyhour.lncel_id = lho.lncel_id
            and busyhour.pm_date_hour = to_char(lho.period_start_time, 'yyyymmddhh24')
            
    WHERE
            lienbho.period_start_time >= To_Date(&start_date, 'yyyy-mm-dd')
        AND lienbho.period_start_time <  To_Date(&end_date, 'yyyy-mm-dd')


    GROUP BY
        lianbho.lncel_id,
        to_char(lianbho.PERIOD_START_TIME,'yyyy-mm-dd')

    ) lienbho on lienbho.lncel_id = lcellt.lncel_id and lienbho.PERIOD_START_TIME = lcellt.PERIOD_START_TIME 

inner join c_lte_custom c on c.lncel_objid = lcellt.lncel_id

group by
    c.city,
    --c.lnbtsid,
    --c.lncel_lcr_id,
    --to_char(lcellt.PERIOD_START_TIME,'yyyy-mm-dd')
     lcellt.PERIOD_START_TIME  
    

    