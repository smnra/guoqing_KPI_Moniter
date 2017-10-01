SELECT
    tab1.DDATE,
    tab1.TTIME,
    tab1.区域,
    tab9.基站数,
    tab9.小区数,
    tab1.LTE小区可用率分子,
    tab1.LTE小区可用率分母,
    tab1.LTE小区可用率, 
    tab1.LTE小区平均退服时长s,
    tab1.LTE小区总退服时长s,
    tab6.PRACH成功率,
    tab6.随机接入冲突解决次数,
    tab6.cell收随机前导数竞争,
    tab6.cell收随机前导数非竞,
    tab2.无线接通率,
    tab2.RRC连接建立成功率,
    tab2.RRC连接建立请求次数,
    tab2.RRC连接建立成功次数,
    tab7.RRC建立平均时延,
    tab7.RRC建立最大时延,
    tab2.Setup_comp_miss无应答,
    tab2.Setup_comp_error小区拒绝,
    tab2.Reject_RRM_RAC资源分配失,
    tab2.SIGN_CONN_ESTAB_FAIL_MAXRRC,
    tab7.RRC重建成功率,
    tab7.RRC重建次数,
    tab7.RRC重建成功次数,
    tab7.RRC重建尝试因HO原因,
    tab7.RRC重建成功因HO原因,
    tab7.RRC重建尝试因other原因,
    tab7.RRC重建成功因other原因,
    tab2.ERAB建立成功率,
    tab2.ERAB建立请求个数,
    tab2.ERAB建立成功个数,
    tab8.E_RAB建立平均时延,
    tab8.E_RAB建立最大时延,
    tab2.无线资源拥塞次数,
    tab2.ERAB失败_传输层,
    tab2.ERAB建立失败_UE无响应,    
    tab2.ERAB建立失败_安全模式, 
    tab2.E_RAB建立失败_核心网,
    tab2.E_RAB建立失败_无线层,
    tab2.LTE业务掉线率,
    tab2.LTE业务释放次数,
    tab2.LTE业务掉线次数,
    tab2.MME释放的ERAB数网络层,
    tab2.eNB释放的ERAB数网络层,
    tab2.eNB释放的ERAB数other,
    tab2.eNB释放的ERAB数传输层,
    tab2.E_RAB异常释放_网络拥塞,  
    tab4.空口上行业务字节数MB,---MByte 单位
    tab4.空口上行业务平均速率,---Mbps单位
    tab4.空口下行业务字节数MB,---MByte 单位
    tab4.空口下行业务平均速率,---Mbps单位
    --tab5.上行PRB平均利用率,
    --tab5.下行PRB平均利用率, 
    tab5.上行PRB平均利用率,
    tab5.下行PRB平均利用率,
    tab6.平均RRC连接数_avg,
    tab6.平均RRC连接数_sum,
    tab6.最大RRC连接数_sum,
    tab6.最大RRC连接数_max,
    tab5.上行PRB可用总数,
    tab5.上行PRB占用总数,    
    tab5.上行PRB占用平均数,
    tab5.下行PRB可用总数,
    tab5.下行PRB占用总数,    
    tab5.下行PRB占用平均数,
    tab5.上行无线资源利用率,
    tab5.下行无线资源利用率, 
    tab6.平均激活用户数,
    tab6.最大激活用户数,
    tab10.平均E_RAB数,
    tab10.每用户平均E_RAB数,
    tab10.上行激活E_RAB数,
    tab10.下行激活E_RAB数,
    tab5.上行PRB资源使用个数,
    tab5.下行PRB资源使用个数, 
    tab5.CCE占用,
    tab5.CCE可用,
    tab11.小区平均发射功率,
    tab11.小区最大发射功率 

FROM
    (SELECT 
        to_char(tab1.pm_date,'yyyymmdd') AS DDATE,
        to_char(tab1.pm_date,'hh24') AS TTIME,
        tab1.区域 AS 区域,
        sum(tab1.LTE小区可用率分子) AS LTE小区可用率分子,
        sum(tab1.LTE小区可用率分母) AS LTE小区可用率分母,
        round(decode(sum(tab1.LTE小区可用率分母),0,0,sum(tab1.LTE小区可用率分子)/sum(tab1.LTE小区可用率分母)*100),2) AS LTE小区可用率, 
        round(avg(tab1.LTE小区退服时长),2) AS LTE小区平均退服时长s,
        round(sum(tab1.LTE小区退服时长),2) AS LTE小区总退服时长s
          
    FROM 
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            c.lncel_lcr_id AS lncel_lcr_id,
            lcelav.period_start_time AS pm_date,
            (CASE 
                WHEN (c.city = 'Baoji' AND c.netmodel = 'FDD') THEN '宝鸡FDD'
                WHEN (c.city = 'Baoji' AND c.netmodel = 'TDD') THEN '宝鸡TDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'FDD') THEN '西安FDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'TDD') THEN '西安TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'FDD') THEN '咸阳FDD'
                WHEN (c.city = 'Hanzhong' AND c.netmodel = 'TDD') THEN '汉中TDD'
                WHEN (c.city = 'Yulin' AND c.netmodel = 'TDD') THEN '榆林TDD'
                WHEN (c.city = 'Yanan' AND c.netmodel = 'TDD') THEN '延安TDD'
                WHEN (c.city = 'Tongchuan' AND c.netmodel = 'TDD') THEN '铜川TDD'
                WHEN (c.city = 'Shangluo' AND c.netmodel = 'TDD') THEN '商洛TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'TDD') THEN '咸阳TDD'            
            ELSE NULL END) 区域,
            ROUND(DECODE(SUM(DENOM_CELL_AVAIL),0,0,100 * SUM(SAMPLES_CELL_AVAIL) / SUM(DENOM_CELL_AVAIL)),2) AS LTE小区可用率,
            SUM(SAMPLES_CELL_AVAIL) LTE小区可用率分子,
            SUM(DENOM_CELL_AVAIL) LTE小区可用率分母,
            SUM(DENOM_CELL_AVAIL - SAMPLES_CELL_AVAIL) * 10 AS LTE小区退服时长
            
        FROM 
            NOKLTE_PS_LCELAV_LNCEL_HOUR lcelav
            INNER JOIN C_LTE_CUSTOM c ON c.lncel_objid = lcelav.lncel_id

        WHERE 

                lcelav.period_start_time >= to_date(&start_datetime,'yyyymmdd')
            AND lcelav.period_start_time <  to_date(&end_datetime,'yyyymmdd')
        
        GROUP BY
            lcelav.period_start_time，
            c.lnbtsid,
            c.lncel_lcr_id,
            c.city,
            c.netmodel
            
        ) tab1

    GROUP BY
        to_char(tab1.pm_date,'yyyymmdd'),
        to_char(tab1.pm_date,'hh24'),
        tab1.区域
        
    ) tab1,


    (SELECT 
        to_char(tab2.pm_date,'yyyymmdd') AS DDATE,
        to_char(tab2.pm_date,'hh24') AS TTIME,
        tab2.区域 AS 区域,
        round((decode(sum(tab2.RRC连接建立请求次数),0,0,sum(tab2.RRC连接建立成功次数)/sum(tab2.RRC连接建立请求次数)))*(decode(SUM(tab2.ERAB建立请求个数),0,0,sum(tab2.ERAB建立成功个数)/SUM(tab2.ERAB建立请求个数)))*100,2) AS 无线接通率,
        round(decode(sum(tab2.RRC连接建立请求次数),0,0,sum(tab2.RRC连接建立成功次数)/sum(tab2.RRC连接建立请求次数))*100,2) AS RRC连接建立成功率,
        sum(tab2.RRC连接建立请求次数) AS RRC连接建立请求次数,
        sum(tab2.RRC连接建立成功次数) AS RRC连接建立成功次数,
        sum(tab2.Setup_comp_miss无应答) AS Setup_comp_miss无应答,
        sum(tab2.Setup_comp_error小区拒绝) AS Setup_comp_error小区拒绝,
        sum(tab2.Reject_RRM_RAC资源分配失) AS Reject_RRM_RAC资源分配失,
        sum(tab2.SIGN_CONN_ESTAB_FAIL_MAXRRC) as SIGN_CONN_ESTAB_FAIL_MAXRRC,
        round(decode(SUM(tab2.ERAB建立请求个数),0,0,sum(tab2.ERAB建立成功个数)/SUM(tab2.ERAB建立请求个数))*100,2) AS ERAB建立成功率,
        sum(tab2.ERAB建立请求个数) AS ERAB建立请求个数,
        sum(tab2.ERAB建立成功个数) AS ERAB建立成功个数,
        sum(tab2.无线资源拥塞次数) AS 无线资源拥塞次数,
        sum(tab2.传输资源拥塞次数) AS ERAB失败_传输层,
        sum(tab2.ERAB建立失败_UE无响应) AS ERAB建立失败_UE无响应,    
        sum(tab2.ERAB建立失败_配置) AS ERAB建立失败_安全模式, 
        ROUND(avg(tab2.E_RAB建立失败_核心网),0) AS E_RAB建立失败_核心网,
        ROUND(avg(tab2.E_RAB建立失败_无线层),0) AS E_RAB建立失败_无线层,
        round(decode(sum(tab2.LTE业务释放次数),0,0,sum(tab2.LTE业务掉线次数)/sum(tab2.LTE业务释放次数))*100,2) AS LTE业务掉线率,
        sum(tab2.LTE业务释放次数) AS LTE业务释放次数,
        sum(tab2.LTE业务掉线次数) AS LTE业务掉线次数,
        sum(tab2.EPC_EPS_BEARER_REL_REQ_RNL) AS MME释放的ERAB数网络层,
        sum(tab2.ENB_EPS_BEARER_REL_REQ_RNL) AS eNB释放的ERAB数网络层,
        sum(tab2.ENB_EPS_BEARER_REL_REQ_OTH) AS eNB释放的ERAB数other,
        sum(tab2.ENB_EPS_BEARER_REL_REQ_TNL) AS eNB释放的ERAB数传输层,
        sum(tab2.EPC_EPS_BEAR_REL_REQ_R_QCI1) AS  E_RAB异常释放_网络拥塞

    FROM 
        (SELECT
            c.lnbtsid AS lncel_enb_id,
            c.lncel_lcr_id AS lncel_lcr_id,
            luest.period_start_time AS pm_date,
            (CASE 
                WHEN (c.city = 'Baoji' AND c.netmodel = 'FDD') THEN '宝鸡FDD'
                WHEN (c.city = 'Baoji' AND c.netmodel = 'TDD') THEN '宝鸡TDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'FDD') THEN '西安FDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'TDD') THEN '西安TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'FDD') THEN '咸阳FDD'
                WHEN (c.city = 'Hanzhong' AND c.netmodel = 'TDD') THEN '汉中TDD'
                WHEN (c.city = 'Yulin' AND c.netmodel = 'TDD') THEN '榆林TDD'
                WHEN (c.city = 'Yanan' AND c.netmodel = 'TDD') THEN '延安TDD'
                WHEN (c.city = 'Tongchuan' AND c.netmodel = 'TDD') THEN '铜川TDD'
                WHEN (c.city = 'Shangluo' AND c.netmodel = 'TDD') THEN '商洛TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'TDD') THEN '咸阳TDD'            
            ELSE NULL END) 区域,
            round(DECODE(decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0,luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode( luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO)),sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_OTHERS + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0, luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode(luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO))), 0, 0, sum(luest.SIGN_CONN_ESTAB_COMP) / decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0,luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode( luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO)),sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_OTHERS + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0, luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode(luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO))))
                * DECODE(sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS),0,0,sum(lepsb.EPS_BEARER_SETUP_COMPLETIONS)/sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS))*100,2) 无线接通率,
            round(DECODE(decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0,luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode( luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO)),sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_OTHERS + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0, luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode(luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO))), 0, 0, sum(luest.SIGN_CONN_ESTAB_COMP) / decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0,luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode( luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO)),sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_OTHERS + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0, luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode(luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO))))*100,2) AS RRC连接建立成功率,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0,luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode( luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO)),sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_OTHERS + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0, luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode(luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO))) AS RRC连接建立请求次数,
            sum(luest.SIGN_CONN_ESTAB_COMP) AS RRC连接建立成功次数,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum( lepsb.ERAB_INI_SETUP_FAIL_RNL_RRNA + lepsb.ERAB_ADD_SETUP_FAIL_RNL_RRNA),sum(lepsb.EPS_BEARER_SETUP_FAIL_RESOUR)) AS 无线资源拥塞次数,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS - lepsb.EPS_BEARER_SETUP_COMPLETIONS - lepsb.ERAB_INI_SETUP_FAIL_RNL_UEL - lepsb.ERAB_ADD_SETUP_FAIL_RNL_UEL - lepsb.ERAB_INI_SETUP_FAIL_TNL_TRU - lepsb.ERAB_ADD_SETUP_FAIL_TNL_TRU - lepsb.ERAB_INI_SETUP_FAIL_RNL_RRNA - lepsb.ERAB_ADD_SETUP_FAIL_RNL_RRNA - lepsb.ERAB_INI_SETUP_FAIL_RNL_RIP - lepsb.ERAB_ADD_SETUP_FAIL_RNL_RIP - lepsb.ERAB_ADD_SETUP_FAIL_UP - lepsb.ERAB_ADD_SETUP_FAIL_RNL_MOB),sum(lepsb.EPS_BEARER_SETUP_FAIL_TRPORT)) AS 传输资源拥塞次数,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM(lepsb.ERAB_INI_SETUP_FAIL_RNL_UEL + lepsb.ERAB_ADD_SETUP_FAIL_RNL_UEL ),Sum(lepsb.EPS_BEARER_SETUP_FAIL_RNL)) ERAB建立失败_UE无响应,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM(lepsb.ERAB_ADD_SETUP_FAIL_UP),Sum(lepsb.EPS_BEARER_SETUP_FAIL_OTH)) AS ERAB建立失败_配置,
            sum(luest.SIGN_EST_F_RRCCOMPL_MISSING) AS Setup_comp_miss无应答,
            sum(luest.SIGN_EST_F_RRCCOMPL_ERROR) AS Setup_comp_error小区拒绝,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_FAIL_PUCCH),sum(luest.SIGN_CONN_ESTAB_FAIL_RRMRAC)) AS Reject_RRM_RAC资源分配失,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_FAIL_MAXRRC),'') AS SIGN_CONN_ESTAB_FAIL_MAXRRC, --LN7.0无此指标
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(lepsb.ERAB_ADD_SETUP_FAIL_UP),'') AS E_RAB建立失败_核心网, --LN7.0无此指标
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(lepsb.ERAB_INI_SETUP_FAIL_RNL_RIP + lepsb.ERAB_ADD_SETUP_FAIL_RNL_RIP),'') AS E_RAB建立失败_无线层, --LN7.0无此指标
            round(decode(sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS),0,0, sum(lepsb.EPS_BEARER_SETUP_COMPLETIONS) / sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS))*100,2) AS ERAB建立成功率,
            sum(lepsb.EPS_BEARER_SETUP_COMPLETIONS) AS ERAB建立成功个数,
            sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS) AS ERAB建立请求个数,               
            round(DECODE(decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum( lepsb.EPC_EPS_BEARER_REL_REQ_RNL  + lepsb.ERAB_REL_ENB_RNL_UEL + lepsb.ERAB_REL_ENB_RNL_EUGR + lepsb.ERAB_REL_ENB_TNL_TRU + lepsb.ERAB_REL_HO_PART + lepsb.ERAB_REL_EPC_PATH_SWITCH + lepsb.ERAB_REL_ENB_RNL_INA + lepsb.ERAB_REL_ENB_RNL_RED + lepsb.ERAB_REL_ENB_RNL_RRNA + lepsb.EPC_EPS_BEARER_REL_REQ_NORM + lepsb.EPC_EPS_BEARER_REL_REQ_DETACH ) ,sum( lepsb.EPC_EPS_BEARER_REL_REQ_NORM + lepsb.EPC_EPS_BEARER_REL_REQ_DETACH + lepsb.EPC_EPS_BEARER_REL_REQ_RNL + lepsb.ERAB_REL_ENB_ACT_NON_GBR + lepsb.ENB_EPSBEAR_REL_REQ_RNL_REDIR + lepsb.ENB_EPS_BEARER_REL_REQ_NORM + lepsb.ENB_EPS_BEARER_REL_REQ_RNL + lepsb.ENB_EPS_BEARER_REL_REQ_TNL + lepsb.ENB_EPS_BEARER_REL_REQ_OTH + lepsb.EPC_EPS_BEAR_REL_REQ_R_QCI1 + lepsb.PRE_EMPT_GBR_BEARER + lepsb.PRE_EMPT_NON_GBR_BEARER )), 0, 0, decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM( lepsb.EPC_EPS_BEARER_REL_REQ_RNL + lepsb.ERAB_REL_ENB_RNL_UEL + lepsb.ERAB_REL_ENB_RNL_EUGR + lepsb.ERAB_REL_ENB_TNL_TRU + lepsb.ERAB_REL_HO_PART + lepsb.ERAB_REL_EPC_PATH_SWITCH ) ,SUM( lepsb.EPC_EPS_BEARER_REL_REQ_RNL + lepsb.EPC_EPS_BEAR_REL_REQ_R_QCI1 + lepsb.PRE_EMPT_GBR_BEARER + lepsb.PRE_EMPT_NON_GBR_BEARER + lepsb.ENB_EPS_BEARER_REL_REQ_RNL + lepsb.ENB_EPS_BEARER_REL_REQ_TNL + lepsb.ENB_EPS_BEARER_REL_REQ_OTH ))/ decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum( lepsb.EPC_EPS_BEARER_REL_REQ_RNL + lepsb.ERAB_REL_ENB_RNL_UEL + lepsb.ERAB_REL_ENB_RNL_EUGR + lepsb.ERAB_REL_ENB_TNL_TRU + lepsb.ERAB_REL_HO_PART + lepsb.ERAB_REL_EPC_PATH_SWITCH + lepsb.ERAB_REL_ENB_RNL_INA + lepsb.ERAB_REL_ENB_RNL_RED + lepsb.ERAB_REL_ENB_RNL_RRNA + lepsb.EPC_EPS_BEARER_REL_REQ_NORM + lepsb.EPC_EPS_BEARER_REL_REQ_DETACH ) ,sum( lepsb.EPC_EPS_BEARER_REL_REQ_NORM + lepsb.EPC_EPS_BEARER_REL_REQ_DETACH + lepsb.EPC_EPS_BEARER_REL_REQ_RNL + lepsb.ERAB_REL_ENB_ACT_NON_GBR + lepsb.ENB_EPSBEAR_REL_REQ_RNL_REDIR + lepsb.ENB_EPS_BEARER_REL_REQ_NORM + lepsb.ENB_EPS_BEARER_REL_REQ_RNL + lepsb.ENB_EPS_BEARER_REL_REQ_TNL + lepsb.ENB_EPS_BEARER_REL_REQ_OTH + lepsb.EPC_EPS_BEAR_REL_REQ_R_QCI1 + lepsb.PRE_EMPT_GBR_BEARER + lepsb.PRE_EMPT_NON_GBR_BEARER )) )*100,2) AS LTE业务掉话率, 
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM( lepsb.EPC_EPS_BEARER_REL_REQ_RNL  + lepsb.ERAB_REL_ENB_RNL_UEL + lepsb.ERAB_REL_ENB_RNL_EUGR + lepsb.ERAB_REL_ENB_TNL_TRU + lepsb.ERAB_REL_HO_PART + lepsb.ERAB_REL_EPC_PATH_SWITCH ) ,SUM( lepsb.EPC_EPS_BEARER_REL_REQ_RNL + lepsb.EPC_EPS_BEAR_REL_REQ_R_QCI1 + lepsb.PRE_EMPT_GBR_BEARER + lepsb.PRE_EMPT_NON_GBR_BEARER + lepsb.ENB_EPS_BEARER_REL_REQ_RNL + lepsb.ENB_EPS_BEARER_REL_REQ_TNL + lepsb.ENB_EPS_BEARER_REL_REQ_OTH))  AS LTE业务掉线次数,
            sum(lepsb.EPC_EPS_BEARER_REL_REQ_RNL) EPC_EPS_BEARER_REL_REQ_RNL,
            sum(lepsb.EPC_EPS_BEARER_REL_REQ_OTH) EPC_EPS_BEARER_REL_REQ_OTH,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM(lepsb.ERAB_REL_HO_PART + lepsb.ERAB_REL_EPC_PATH_SWITCH),Sum(lepsb.ENB_EPS_BEARER_REL_REQ_OTH)) ENB_EPS_BEARER_REL_REQ_OTH,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM(lepsb.ERAB_REL_ENB_RNL_UEL),Sum(lepsb.ENB_EPS_BEARER_REL_REQ_RNL)) ENB_EPS_BEARER_REL_REQ_RNL,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM(lepsb.ERAB_REL_ENB_TNL_TRU),Sum(lepsb.ENB_EPS_BEARER_REL_REQ_TNL)) ENB_EPS_BEARER_REL_REQ_TNL,        
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM(lepsb.ERAB_REL_ENB_RNL_EUGR),Sum(lepsb.EPC_EPS_BEAR_REL_REQ_R_QCI1)) EPC_EPS_BEAR_REL_REQ_R_QCI1,
            AVG(lepsb.EPC_EPS_BEAR_REL_REQ_R_QCI1) avgEPC_EPS_BEAR_REL_REQ_R_QCI1,  
            sum(lepsb.PRE_EMPT_GBR_BEARER) PRE_EMPT_GBR_BEARER,
            sum(lepsb.PRE_EMPT_NON_GBR_BEARER) PRE_EMPT_NON_GBR_BEARER,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum( lepsb.EPC_EPS_BEARER_REL_REQ_RNL  + lepsb.ERAB_REL_ENB_RNL_UEL + lepsb.ERAB_REL_ENB_RNL_EUGR + lepsb.ERAB_REL_ENB_TNL_TRU + lepsb.ERAB_REL_HO_PART + lepsb.ERAB_REL_EPC_PATH_SWITCH + lepsb.ERAB_REL_ENB_RNL_INA + lepsb.ERAB_REL_ENB_RNL_RED + lepsb.ERAB_REL_ENB_RNL_RRNA + lepsb.EPC_EPS_BEARER_REL_REQ_NORM + lepsb.EPC_EPS_BEARER_REL_REQ_DETACH ) ,sum( lepsb.EPC_EPS_BEARER_REL_REQ_NORM + lepsb.EPC_EPS_BEARER_REL_REQ_DETACH + lepsb.EPC_EPS_BEARER_REL_REQ_RNL + lepsb.ERAB_REL_ENB_ACT_NON_GBR + lepsb.ENB_EPSBEAR_REL_REQ_RNL_REDIR + lepsb.ENB_EPS_BEARER_REL_REQ_NORM + lepsb.ENB_EPS_BEARER_REL_REQ_RNL + lepsb.ENB_EPS_BEARER_REL_REQ_TNL + lepsb.ENB_EPS_BEARER_REL_REQ_OTH + lepsb.EPC_EPS_BEAR_REL_REQ_R_QCI1 + lepsb.PRE_EMPT_GBR_BEARER + lepsb.PRE_EMPT_NON_GBR_BEARER)) AS LTE业务释放次数
     
        FROM 
            NOKLTE_PS_LUEST_LNCEL_HOUR luest
            INNER JOIN NOKLTE_PS_LEPSB_LNCEL_HOUR lepsb ON lepsb.lncel_id = luest.lncel_id
                   AND lepsb.period_start_time = luest.period_start_time
                   AND lepsb.period_start_time >=to_date(&start_datetime, 'yyyymmdd')
                   AND lepsb.period_start_time < to_date(&end_datetime, 'yyyymmdd')
            RIGHT JOIN C_LTE_CUSTOM c ON c.lncel_objid = luest.lncel_id
            
        WHERE
                luest.period_start_time >=to_date(&start_datetime, 'yyyymmdd')
            AND luest.period_start_time < to_date(&end_datetime, 'yyyymmdd')
             
        GROUP BY
            luest.period_start_time,
            c.lnbtsid,
            c.lncel_lcr_id,
            c.city,
            c.netmodel,
            c.version
            
        ) tab2

    GROUP BY
        tab2.pm_date,       
        tab2.区域
    ) tab2,
        
        
        
        
    (SELECT 
        to_char(tab4.pm_date,'yyyymmdd') AS DDATE,
        to_char(tab4.pm_date,'hh24') AS TTIME,
        tab4.区域 AS 区域,
        round(sum(tab4.空口上行业务字节数MB)/1024,2) AS 空口上行业务字节数MB,---MByte 单位
        round(decode(sum(tab4.ACTIVE_TTI_UL),0,0,(sum(tab4.空口上行业务字节数MB)*1000*8)/sum(tab4.ACTIVE_TTI_UL)/1024),2) AS 空口上行业务平均速率,---Mbps单位
        round(sum(tab4.空口下行业务字节数MB)/1024,2) AS 空口下行业务字节数MB,---MByte 单位
        round(decode(sum(tab4.ACTIVE_TTI_DL),0,0,(sum(tab4.空口下行业务字节数MB)*1000*8)/sum(tab4.ACTIVE_TTI_DL)/1024),2) AS 空口下行业务平均速率---Mbps单位
      
    FROM 
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            c.lncel_lcr_id AS lncel_lcr_id,
            lcellt.period_start_time AS pm_date,
            (CASE 
                WHEN (c.city = 'Baoji' AND c.netmodel = 'FDD') THEN '宝鸡FDD'
                WHEN (c.city = 'Baoji' AND c.netmodel = 'TDD') THEN '宝鸡TDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'FDD') THEN '西安FDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'TDD') THEN '西安TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'FDD') THEN '咸阳FDD'
                WHEN (c.city = 'Hanzhong' AND c.netmodel = 'TDD') THEN '汉中TDD'
                WHEN (c.city = 'Yulin' AND c.netmodel = 'TDD') THEN '榆林TDD'
                WHEN (c.city = 'Yanan' AND c.netmodel = 'TDD') THEN '延安TDD'
                WHEN (c.city = 'Tongchuan' AND c.netmodel = 'TDD') THEN '铜川TDD'
                WHEN (c.city = 'Shangluo' AND c.netmodel = 'TDD') THEN '商洛TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'TDD') THEN '咸阳TDD'            
            ELSE NULL END) 区域,
            decode(sum(lcellt.ACTIVE_TTI_UL),0,0,sum(lcellt.PDCP_SDU_VOL_UL) * 8 * 1000 /
                sum(lcellt.ACTIVE_TTI_UL*1024)) AS 空口上行业务平均速率,
            SUM(PDCP_SDU_VOL_UL) / 1024 AS 空口上行业务字节数MB,
            sum(lcellt.ACTIVE_TTI_UL)  AS ACTIVE_TTI_UL,
            decode(sum(lcellt.ACTIVE_TTI_DL), 0, 0,sum(lcellt.PDCP_SDU_VOL_DL) * 8 * 1000 /
                sum(lcellt.ACTIVE_TTI_DL*1024)) AS 空口下行业务平均速率,
            SUM(PDCP_SDU_VOL_DL) / 1024 AS 空口下行业务字节数MB,
            sum(lcellt.ACTIVE_TTI_DL) AS ACTIVE_TTI_DL
            
        FROM 
            NOKLTE_PS_LCELLT_LNCEL_HOUR lcellt
            INNER JOIN C_LTE_CUSTOM c ON c.lncel_objid = lcellt.lncel_id

        WHERE 
                lcellt.period_start_time >= to_date(&start_datetime, 'yyyymmdd')
            AND lcellt.period_start_time < to_date(&end_datetime, 'yyyymmdd')
            
        GROUP BY 
            lcellt.period_start_time,
            c.lnbtsid,
            c.lncel_lcr_id,
            c.city,
            c.netmodel

            ) tab4

    GROUP BY
        tab4.pm_date,
        tab4.区域
        
    ) tab4,    
        
        
        
    (SELECT 
        to_char(tab5.pm_date,'yyyymmdd') AS DDATE,
        to_char(tab5.pm_date,'hh24') AS TTIME,
        tab5.区域 AS 区域,
        -- round(avg(tab5.上行PRB平均利用率)*100,2) AS 上行PRB平均利用率,
        -- round(avg(tab5.下行PRB平均利用率)*100,2) AS 下行PRB平均利用率, 
        round(sum(tab5.上行PRB可用数),2) AS 上行PRB可用总数,
        round(sum(tab5.上行PRB占用平均数),2) AS 上行PRB占用总数,
        round(avg(tab5.上行PRB平均利用率)*100,2) AS 上行PRB平均利用率,
        round(avg(tab5.上行PRB占用平均数),2) AS 上行PRB占用平均数,
        round(sum(tab5.下行PRB可用数),2) AS 下行PRB可用总数,
        round(sum(tab5.下行PRB占用平均数),2) AS 下行PRB占用总数,
        round(avg(tab5.下行PRB平均利用率)*100,2) AS 下行PRB平均利用率,
        round(avg(tab5.下行PRB占用平均数),2) AS 下行PRB占用平均数,
        round(avg(tab5.上行PRB平均利用率)/0.9/0.6/0.5*100,2) AS 上行无线资源利用率,
        round(avg(tab5.下行PRB平均利用率)/0.9/0.6/0.5*100,2) AS 下行无线资源利用率, 
        round(sum(tab5.上行PRB资源使用个数),0) AS 上行PRB资源使用个数,
        round(sum(tab5.下行PRB资源使用个数),0) AS 下行PRB资源使用个数, 
        round(avg(tab5.CCE占用),2) AS CCE占用,
        round(avg(tab5.CCE可用),2) AS CCE可用
        
    FROM 
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            c.lncel_lcr_id AS lncel_lcr_id,
            lcellr.period_start_time AS pm_date,
            (CASE 
                WHEN (c.city = 'Baoji' AND c.netmodel = 'FDD') THEN '宝鸡FDD'
                WHEN (c.city = 'Baoji' AND c.netmodel = 'TDD') THEN '宝鸡TDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'FDD') THEN '西安FDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'TDD') THEN '西安TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'FDD') THEN '咸阳FDD'
                WHEN (c.city = 'Hanzhong' AND c.netmodel = 'TDD') THEN '汉中TDD'
                WHEN (c.city = 'Yulin' AND c.netmodel = 'TDD') THEN '榆林TDD'
                WHEN (c.city = 'Yanan' AND c.netmodel = 'TDD') THEN '延安TDD'
                WHEN (c.city = 'Tongchuan' AND c.netmodel = 'TDD') THEN '铜川TDD'
                WHEN (c.city = 'Shangluo' AND c.netmodel = 'TDD') THEN '商洛TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'TDD') THEN '咸阳TDD'            
            ELSE NULL END) 区域,
            decode((sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)+decode(lncel.LNCEL_UL_CH_BW,'',0,lncel.LNCEL_UL_CH_BW))/2),0,0,
                decode(sum(lcellr.PERIOD_DURATION*60*1000),0,0,sum(lcellr.PRB_USED_PUSCH)/sum(lcellr.PERIOD_DURATION*60*1000))/
                (sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*decode(lncel.LNCEL_TDD_FRAME_CONF,1,0.4,0.2)+
                decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)/35+decode(lncel.LNCEL_UL_CH_BW,'',0,
                lncel.LNCEL_UL_CH_BW))/2)) AS 上行PRB平均利用率,
            sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*decode(lncel.LNCEL_TDD_FRAME_CONF,1,0.4,0.2)+decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)/35+
                decode(lncel.LNCEL_UL_CH_BW,'',0,lncel.LNCEL_UL_CH_BW))/2 上行PRB可用数,  
            decode(sum(lcellr.PERIOD_DURATION*60*1000),0,0,sum(lcellr.PRB_USED_PUSCH)/
                sum(lcellr.PERIOD_DURATION*60*1000)) AS 上行PRB占用平均数,
            decode((sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)+decode(lncel.LNCEL_DL_CH_BW,'',0,lncel.LNCEL_DL_CH_BW))/2),0,0,decode(sum(lcellr.PERIOD_DURATION*60*1000),
                0,0, sum(lcellr.PRB_USED_PDSCH) /sum(lcellr.PERIOD_DURATION*60*1000))/(sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*
                decode(lncel.LNCEL_TDD_FRAME_CONF,1,0.4,0.6)+decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*decode(lncel.LNCEL_TSSC_296,5,0.0428,0.1428)+
                decode(lncel.LNCEL_DL_CH_BW,'',0,lncel.LNCEL_DL_CH_BW))/2)) AS 下行PRB平均利用率,
            sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*decode(lncel.LNCEL_TDD_FRAME_CONF,1,0.4,0.6)+decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*decode(lncel.LNCEL_TSSC_296,5,0.0428,0.1428)+
                decode(lncel.LNCEL_DL_CH_BW,'',0,lncel.LNCEL_DL_CH_BW))/2  AS 下行PRB可用数,
            decode(sum(lcellr.PERIOD_DURATION*60*1000),0,0, sum(lcellr.PRB_USED_PDSCH) /
                sum(lcellr.PERIOD_DURATION*60*1000)) AS 下行PRB占用平均数,
            SUM(lcellr.AGG1_USED_PDCCH+2*lcellr.AGG2_USED_PDCCH+4*lcellr.AGG4_USED_PDCCH+8*lcellr.AGG8_USED_PDCCH) AS CCE占用,
            SUM(84*1000*60*lcellr.period_duration) AS CCE可用,
            SUM(lcellr.PRB_USED_DL_TOTAL/(lcellr.period_duration*60000)) AS  下行PRB资源使用个数,
            SUM(lcellr.PRB_USED_UL_TOTAL/(lcellr.period_duration*60000)) AS  上行PRB资源使用个数
            
        FROM 
            NOKLTE_PS_LCELLR_LNCEL_HOUR lcellr
            RIGHT JOIN c_lte_lncel lncel ON lncel.obj_gid = lcellr.lncel_id 
            RIGHT JOIN C_LTE_CUSTOM c ON c.lncel_objid = lcellr.lncel_id
                   AND lncel.obj_gid = c.lncel_objid

        WHERE 
                lcellr.period_start_time >=to_date(&start_datetime, 'yyyymmdd')
            AND lcellr.period_start_time < to_date(&end_datetime, 'yyyymmdd')
            
        GROUP BY 
            lcellr.period_start_time,
            c.lnbtsid,
            c.lncel_lcr_id,
             c.city,
            c.netmodel
            
        ) tab5

    GROUP BY
        tab5.pm_date,
        tab5.区域

    ) tab5,
        
        
        
        
    (SELECT 
        to_char(tab6.pm_date,'yyyymmdd') AS DDATE,
        to_char(tab6.pm_date,'hh24') AS TTIME,
        tab6.区域 AS 区域,
        round(avg(tab6.平均RRC连接数_avg),2) 平均RRC连接数_avg,
        round(sum(tab6.平均RRC连接数_sum),2) 平均RRC连接数_sum,
        sum(tab6.最大RRC连接数_sum) 最大RRC连接数_sum,
        max(tab6.最大RRC连接数_max) 最大RRC连接数_max,
        sum(tab6.随机接入冲突解决次数) as 随机接入冲突解决次数,
        sum(tab6.cell收随机前导数竞争) as cell收随机前导数竞争,
        sum(tab6.cell收随机前导数非竞) as cell收随机前导数非竞,
        round(decode(sum(tab6.cell收随机前导数竞争+tab6.cell收随机前导数非竞),0,0,sum(tab6.随机接入冲突解决次数)/sum(tab6.cell收随机前导数竞争+tab6.cell收随机前导数非竞))*100,2) AS PRACH成功率,
        round(sum(tab6.平均激活用户数),0) AS 平均激活用户数,
        round(sum(tab6.最大激活用户数),0) AS 最大激活用户数
        
    FROM 
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            c.lncel_lcr_id AS lncel_lcr_id,
            lcelld.period_start_time AS pm_date,
            (CASE 
                WHEN (c.city = 'Baoji' AND c.netmodel = 'FDD') THEN '宝鸡FDD'
                WHEN (c.city = 'Baoji' AND c.netmodel = 'TDD') THEN '宝鸡TDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'FDD') THEN '西安FDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'TDD') THEN '西安TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'FDD') THEN '咸阳FDD'
                WHEN (c.city = 'Hanzhong' AND c.netmodel = 'TDD') THEN '汉中TDD'
                WHEN (c.city = 'Yulin' AND c.netmodel = 'TDD') THEN '榆林TDD'
                WHEN (c.city = 'Yanan' AND c.netmodel = 'TDD') THEN '延安TDD'
                WHEN (c.city = 'Tongchuan' AND c.netmodel = 'TDD') THEN '铜川TDD'
                WHEN (c.city = 'Shangluo' AND c.netmodel = 'TDD') THEN '商洛TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'TDD') THEN '咸阳TDD'            
            ELSE NULL END) 区域,
            round(SUM(lcelld.CELL_LOAD_ACT_UE_AVG),8) AS 平均激活用户数,
            MAX(lcelld.CELL_LOAD_ACT_UE_MAX) AS 最大激活用户数,
            round(avg(lcelld.RRC_CONN_UE_AVG),8) AS 平均RRC连接数_avg,
            round(sum(lcelld.RRC_CONN_UE_AVG),8) AS 平均RRC连接数_sum,
            sum(lcelld.RACH_STP_COMPLETIONS) as 随机接入冲突解决次数,
            sum(lcelld.RACH_STP_ATT_SMALL_MSG+lcelld.RACH_STP_ATT_LARGE_MSG) as cell收随机前导数竞争,
            sum(lcelld.RACH_STP_ATT_DEDICATED) as cell收随机前导数非竞,
            round(decode(sum(lcelld.RACH_STP_ATT_SMALL_MSG+lcelld.RACH_STP_ATT_LARGE_MSG+lcelld.RACH_STP_ATT_DEDICATED),0,0,sum(lcelld.RACH_STP_COMPLETIONS)/sum(lcelld.RACH_STP_ATT_SMALL_MSG+lcelld.RACH_STP_ATT_LARGE_MSG+lcelld.RACH_STP_ATT_DEDICATED))*100,2) AS PRACH成功率,
            sum(lcelld.RRC_CONN_UE_MAX) AS 最大RRC连接数_sum,
            max(lcelld.RRC_CONN_UE_MAX) AS 最大RRC连接数_max    
            
        FROM
            NOKLTE_PS_LCELLD_LNCEL_HOUR lcelld
            INNER JOIN C_LTE_CUSTOM c ON c.lncel_objid = lcelld.lncel_id
            
        WHERE 
                lcelld.period_start_time >=to_date(&start_datetime, 'yyyymmdd')
            AND lcelld.period_start_time <to_date(&end_datetime, 'yyyymmdd')
            
        GROUP BY
            lcelld.period_start_time,
            c.lnbtsid,
            c.lncel_lcr_id,
            c.city,
            c.netmodel
     
        ) tab6
        
    GROUP BY
        tab6.pm_date,
        tab6.区域
        
    ) tab6,   
     
        

        
    (SELECT 
        to_char(tab7.pm_date,'yyyymmdd') AS DDATE,
        to_char(tab7.pm_date,'hh24') AS TTIME,
        tab7.区域 AS 区域,
        ROUND(avg(tab7.RRC建立平均时延),0) AS RRC建立平均时延,
        ROUND(max(tab7.RRC建立最大时延),0) AS RRC建立最大时延,
        round(decode(sum(tab7.RRC重建次数),0,0,sum(tab7.RRC重建成功次数)/sum(tab7.RRC重建次数)*100),2) AS RRC重建成功率,
        sum(tab7.RRC重建次数) AS RRC重建次数,
        sum(tab7.RRC重建成功次数) AS RRC重建成功次数,
        sum(tab7.RRC重建尝试因HO原因) AS RRC重建尝试因HO原因,
        sum(tab7.RRC重建成功因HO原因) AS RRC重建成功因HO原因,
        sum(tab7.RRC重建尝试因other原因) AS RRC重建尝试因other原因,
        sum(tab7.RRC重建成功因other原因) AS RRC重建成功因other原因

    FROM 
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            c.lncel_lcr_id AS lncel_lcr_id,
            lrrc.period_start_time AS pm_date,
            (CASE 
                WHEN (c.city = 'Baoji' AND c.netmodel = 'FDD') THEN '宝鸡FDD'
                WHEN (c.city = 'Baoji' AND c.netmodel = 'TDD') THEN '宝鸡TDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'FDD') THEN '西安FDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'TDD') THEN '西安TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'FDD') THEN '咸阳FDD'
                WHEN (c.city = 'Hanzhong' AND c.netmodel = 'TDD') THEN '汉中TDD'
                WHEN (c.city = 'Yulin' AND c.netmodel = 'TDD') THEN '榆林TDD'
                WHEN (c.city = 'Yanan' AND c.netmodel = 'TDD') THEN '延安TDD'
                WHEN (c.city = 'Tongchuan' AND c.netmodel = 'TDD') THEN '铜川TDD'
                WHEN (c.city = 'Shangluo' AND c.netmodel = 'TDD') THEN '商洛TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'TDD') THEN '咸阳TDD'            
            ELSE NULL END) 区域, 
            round(decode(sum(lrrc.rrc_con_re_estab_att),
                0,0,sum(lrrc.rrc_con_re_estab_succ)/sum(lrrc.rrc_con_re_estab_att))*100,2) AS RRC重建成功率，
            sum(lrrc.rrc_con_re_estab_att) AS RRC重建次数,
            sum(lrrc.rrc_con_re_estab_succ) AS RRC重建成功次数,
            sum(lrrc.RRC_CON_RE_ESTAB_ATT_HO_FAIL) AS RRC重建尝试因HO原因,
            sum(lrrc.RRC_CON_RE_ESTAB_SUCC_HO_FAIL) AS RRC重建成功因HO原因,
            sum(lrrc.RRC_CON_RE_ESTAB_ATT_OTHER) AS RRC重建尝试因other原因,
            sum(lrrc.RRC_CON_RE_ESTAB_SUCC_OTHER) AS RRC重建成功因other原因,
            round(avg(lrrc.RRC_CON_STP_TIM_MEAN),2) AS RRC建立平均时延, 
            max(lrrc.RRC_CON_STP_TIM_MAX) AS RRC建立最大时延
            
        FROM 
            NOKLTE_PS_LRRC_LNCEL_HOUR lrrc
            INNER JOIN C_LTE_CUSTOM c ON c.lncel_objid = lrrc.lncel_id
            
        WHERE 
                lrrc.period_start_time >= to_date(&start_datetime, 'yyyymmdd')
            AND lrrc.period_start_time < to_date(&end_datetime, 'yyyymmdd')
            
        GROUP BY
            lrrc.period_start_time,
            c.lnbtsid,
            c.lncel_lcr_id,
            c.city,
            c.netmodel
      
        ) tab7

    GROUP BY
        tab7.pm_date,
        tab7.区域    
        
    ) tab7,    
        
        
        

        
    (SELECT 
        to_char(tab8.pm_date,'yyyymmdd') AS DDATE,
        to_char(tab8.pm_date,'hh24') AS TTIME,
        tab8.区域 AS 区域,
        ROUND(avg(tab8.E_RAB建立平均时延),0) AS E_RAB建立平均时延,
        ROUND(max(tab8.E_RAB建立最大时延),0) AS E_RAB建立最大时延
        
    FROM 
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            c.lncel_lcr_id AS lncel_lcr_id,
            lrdb.period_start_time AS pm_date,
            (CASE 
                WHEN (c.city = 'Baoji' AND c.netmodel = 'FDD') THEN '宝鸡FDD'
                WHEN (c.city = 'Baoji' AND c.netmodel = 'TDD') THEN '宝鸡TDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'FDD') THEN '西安FDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'TDD') THEN '西安TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'FDD') THEN '咸阳FDD'
                WHEN (c.city = 'Hanzhong' AND c.netmodel = 'TDD') THEN '汉中TDD'
                WHEN (c.city = 'Yulin' AND c.netmodel = 'TDD') THEN '榆林TDD'
                WHEN (c.city = 'Yanan' AND c.netmodel = 'TDD') THEN '延安TDD'
                WHEN (c.city = 'Tongchuan' AND c.netmodel = 'TDD') THEN '铜川TDD'
                WHEN (c.city = 'Shangluo' AND c.netmodel = 'TDD') THEN '商洛TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'TDD') THEN '咸阳TDD'            
            ELSE NULL END) 区域,          
            round(avg(lrdb.ERAB_SETUP_TIME_MEAN),4) AS E_RAB建立平均时延, 
            max(lrdb.ERAB_SETUP_TIME_MAX) AS E_RAB建立最大时延
            
        FROM 
            NOKLTE_PS_LRDB_LNCEL_HOUR lrdb
            INNER JOIN C_LTE_CUSTOM c ON c.lncel_objid = lrdb.lncel_id
            
        WHERE
                lrdb.period_start_time >= to_date(&start_datetime, 'yyyymmdd')
            AND lrdb.period_start_time < to_date(&end_datetime, 'yyyymmdd')
            
        GROUP BY
            lrdb.period_start_time,
            c.lnbtsid,
            c.lncel_lcr_id,
            c.city,
            c.netmodel

        ) tab8
        
    GROUP BY
        tab8.pm_date,       
        tab8.区域

    ) tab8,   
        
        
        
        
    (SELECT     
        to_char(lcelav.period_start_time,'yyyymmdd') AS DDATE,
        to_char(lcelav.period_start_time,'hh24') AS TTIME,
        (CASE 
            WHEN (c.city = 'Baoji' AND c.netmodel = 'FDD') THEN '宝鸡FDD'
            WHEN (c.city = 'Baoji' AND c.netmodel = 'TDD') THEN '宝鸡TDD'
            WHEN (c.city = 'Xian' AND c.netmodel = 'FDD') THEN '西安FDD'
            WHEN (c.city = 'Xian' AND c.netmodel = 'TDD') THEN '西安TDD'
            WHEN (c.city = 'Xianyang' AND c.netmodel = 'FDD') THEN '咸阳FDD'
            WHEN (c.city = 'Hanzhong' AND c.netmodel = 'TDD') THEN '汉中TDD'
            WHEN (c.city = 'Yulin' AND c.netmodel = 'TDD') THEN '榆林TDD'
            WHEN (c.city = 'Yanan' AND c.netmodel = 'TDD') THEN '延安TDD'
            WHEN (c.city = 'Tongchuan' AND c.netmodel = 'TDD') THEN '铜川TDD'
            WHEN (c.city = 'Shangluo' AND c.netmodel = 'TDD') THEN '商洛TDD'
            WHEN (c.city = 'Xianyang' AND c.netmodel = 'TDD') THEN '咸阳TDD'        
        ELSE NULL END) AS 区域,
        count(distinct c.lnbtsid) 基站数,
        count(distinct c.lnbtsid*c.lncel_lcr_id) AS 小区数
        
    FROM 
        noklte_PS_lcelav_lncel_HOUR lcelav
        INNER JOIN C_LTE_CUSTOM c ON c.lncel_objid = lcelav.lncel_id
        
    WHERE 
            lcelav.period_start_time >=to_date(&start_datetime, 'yyyymmdd')
        AND lcelav.period_start_time < to_date(&end_datetime, 'yyyymmdd')
        
    GROUP BY  
        c.city,
        c.netmodel,
        lcelav.period_start_time

    
        
    ) tab9,
        
        
        
        
        
    (SELECT 
        to_char(tab10.pm_date,'yyyymmdd') AS DDATE,
        to_char(tab10.pm_date,'hh24') AS TTIME,
        tab10.区域 AS 区域,
        round(avg(tab10.平均E_RAB数), 2) AS 平均E_RAB数,
        round(avg(tab10.每用户平均E_RAB数), 2) AS 每用户平均E_RAB数,
        round(avg(tab10.上行激活E_RAB数), 2) AS 上行激活E_RAB数,
        round(avg(tab10.下行激活E_RAB数), 2) AS 下行激活E_RAB数
        
    FROM 
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            c.lncel_lcr_id AS lncel_lcr_id,
            lepsb.period_start_time AS pm_date, 
            (CASE 
                WHEN (c.city = 'Baoji' AND c.netmodel = 'FDD') THEN '宝鸡FDD'
                WHEN (c.city = 'Baoji' AND c.netmodel = 'TDD') THEN '宝鸡TDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'FDD') THEN '西安FDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'TDD') THEN '西安TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'FDD') THEN '咸阳FDD'
                WHEN (c.city = 'Hanzhong' AND c.netmodel = 'TDD') THEN '汉中TDD'
                WHEN (c.city = 'Yulin' AND c.netmodel = 'TDD') THEN '榆林TDD'
                WHEN (c.city = 'Yanan' AND c.netmodel = 'TDD') THEN '延安TDD'
                WHEN (c.city = 'Tongchuan' AND c.netmodel = 'TDD') THEN '铜川TDD'
                WHEN (c.city = 'Shangluo' AND c.netmodel = 'TDD') THEN '商洛TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'TDD') THEN '咸阳TDD'            
            ELSE NULL END) 区域,
            ROUND(DECODE(AVG(lepsb.DENOM_SUM_SIMUL_ERAB),0,NULL, AVG(lepsb.SUM_SIMUL_ERAB_QCI_1 + lepsb.SUM_SIMUL_ERAB_QCI_2 + lepsb.SUM_SIMUL_ERAB_QCI_3 + lepsb.SUM_SIMUL_ERAB_QCI_4 +   lepsb.SUM_SIMUL_ERAB_QCI_5 + lepsb.SUM_SIMUL_ERAB_QCI_6 +  lepsb.SUM_SIMUL_ERAB_QCI_7 + lepsb.SUM_SIMUL_ERAB_QCI_8 +   lepsb.SUM_SIMUL_ERAB_QCI_9) / AVG(lepsb.DENOM_SUM_SIMUL_ERAB)),8) AS  平均E_RAB数,
            ROUND(DECODE(AVG(lepsb.DENOM_SUM_SIMUL_ERAB * lcelld.CELL_LOAD_ACT_UE_AVG),0,NULL, AVG(lepsb.SUM_SIMUL_ERAB_QCI_1 + lepsb.SUM_SIMUL_ERAB_QCI_2 + lepsb.SUM_SIMUL_ERAB_QCI_3 + lepsb.SUM_SIMUL_ERAB_QCI_4 + lepsb.SUM_SIMUL_ERAB_QCI_5 + lepsb.SUM_SIMUL_ERAB_QCI_6 + lepsb.SUM_SIMUL_ERAB_QCI_7 + lepsb.SUM_SIMUL_ERAB_QCI_8 +   lepsb.SUM_SIMUL_ERAB_QCI_9) / AVG(lepsb.DENOM_SUM_SIMUL_ERAB * lcelld.CELL_LOAD_ACT_UE_AVG)),8)  AS  每用户平均E_RAB数,
            ROUND(decode(AVG(lcelld.DENOM_ACTIVE_UE_DATA_UL),0,null,AVG(lcelld.SUM_ACTIVE_UE_DATA_UL)/AVG(lcelld.DENOM_ACTIVE_UE_DATA_UL)),8) AS 上行激活E_RAB数,
            ROUND(decode(AVG(lcelld.DENOM_ACTIVE_UE_DATA_DL),0,null,AVG(lcelld.SUM_ACTIVE_UE_DATA_DL)/AVG(lcelld.DENOM_ACTIVE_UE_DATA_DL)),8) AS 下行激活E_RAB数
        FROM
            NOKLTE_PS_LEPSB_LNCEL_HOUR lepsb         
            INNER JOIN NOKLTE_PS_LCELLD_LNCEL_HOUR lcelld ON lepsb.lncel_id = lcelld.lncel_id  
                   AND lepsb.period_start_time = lcelld.period_start_time
                   AND lcelld.period_start_time >=To_Date(&start_datetime, 'yyyymmdd')
                   AND lcelld.period_start_time < To_Date(&end_datetime, 'yyyymmdd') 
            RIGHT JOIN C_LTE_CUSTOM c ON c.lncel_objid = lepsb.lncel_id
            
        WHERE
                lepsb.period_start_time >=To_Date(&start_datetime, 'yyyymmdd')
            AND lepsb.period_start_time < To_Date(&end_datetime, 'yyyymmdd')
            
        GROUP BY
            lepsb.period_start_time,
            c.lnbtsid,
            c.lncel_lcr_id,
             c.city,
            c.netmodel

        ) tab10
        
    GROUP BY
        tab10.pm_date,
        tab10.区域

    ) tab10,

        
        
        
    (SELECT 
        to_char(tab11.pm_date,'yyyymmdd') AS DDATE,
        to_char(tab11.pm_date,'hh24') AS TTIME,
        tab11.区域 AS 区域,
        round(avg(tab11.小区平均发射功率),2) AS 小区平均发射功率,
        round(max(tab11.小区最大发射功率),0) AS 小区最大发射功率
        
    FROM 
        (SELECT
            c.lnbtsid AS lncel_enb_id,
            c.lncel_lcr_id AS lncel_lcr_id,
            lpqdl.period_start_time AS pm_date,  
            (CASE 
                WHEN (c.city = 'Baoji' AND c.netmodel = 'FDD') THEN '宝鸡FDD'
                WHEN (c.city = 'Baoji' AND c.netmodel = 'TDD') THEN '宝鸡TDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'FDD') THEN '西安FDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'TDD') THEN '西安TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'FDD') THEN '咸阳FDD'
                WHEN (c.city = 'Hanzhong' AND c.netmodel = 'TDD') THEN '汉中TDD'
                WHEN (c.city = 'Yulin' AND c.netmodel = 'TDD') THEN '榆林TDD'
                WHEN (c.city = 'Yanan' AND c.netmodel = 'TDD') THEN '延安TDD'
                WHEN (c.city = 'Tongchuan' AND c.netmodel = 'TDD') THEN '铜川TDD'
                WHEN (c.city = 'Shangluo' AND c.netmodel = 'TDD') THEN '商洛TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'TDD') THEN '咸阳TDD'            
            ELSE NULL END) 区域,
            --此两个指标LN7.0和FL16 指标公式不一致，LNBTS 无此指标。
            decode(AVG(lpqdl.AVG_TRANS_PWR),0,0,10*log(10,AVG(lpqdl.AVG_TRANS_PWR))) AS 小区平均发射功率, 
            decode(MAX(lpqdl.MAX_TRANS_PWR),0,0,10*log(10,MAX(lpqdl.MAX_TRANS_PWR))) AS 小区最大发射功率    
            
        FROM
            NOKLTE_PS_LPQDL_LNCEL_HOUR lpqdl
            INNER JOIN C_LTE_CUSTOM c ON c.lncel_objid = lpqdl.lncel_id
            
        WHERE
                lpqdl.period_start_time >= to_date(&start_datetime, 'yyyymmdd')
            AND lpqdl.period_start_time < to_date(&end_datetime, 'yyyymmdd')
            
        GROUP BY 
            lpqdl.period_start_time,
            c.lnbtsid,
            c.lncel_lcr_id,
            c.city,
            c.netmodel
            
        ) tab11
        
    GROUP BY
        tab11.pm_date,
        tab11.区域

    ) tab11    
    
    
    
    
    
WHERE
        tab1.DDATE = tab2.DDATE AND tab1.区域 = tab2.区域 AND tab1.TTIME = tab2.TTIME
    AND tab1.DDATE = tab4.DDATE AND tab1.区域 = tab4.区域 AND tab1.TTIME = tab4.TTIME
    AND tab1.DDATE = tab5.DDATE AND tab1.区域 = tab5.区域 AND tab1.TTIME = tab5.TTIME
    AND tab1.DDATE = tab6.DDATE AND tab1.区域 = tab6.区域 AND tab1.TTIME = tab6.TTIME
    AND tab1.DDATE = tab7.DDATE AND tab1.区域 = tab7.区域 AND tab1.TTIME = tab7.TTIME
    AND tab1.DDATE = tab8.DDATE AND tab1.区域 = tab8.区域 AND tab1.TTIME = tab8.TTIME
    AND tab1.DDATE = tab9.DDATE AND tab1.区域 = tab9.区域 AND tab1.TTIME = tab9.TTIME
    AND tab1.DDATE = tab10.DDATE AND tab1.区域 = tab10.区域 AND tab1.TTIME = tab10.TTIME
    AND tab1.DDATE = tab11.DDATE AND tab1.区域 = tab11.区域 AND tab1.TTIME = tab11.TTIME
    
    
    
    
    
