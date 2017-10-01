SELECT
    a.DDATE,
    a.TTIME,
    a.ENB_ID,
    lnbts.LNBTS_ENB_NAME AS eNodeB名称,
   -- a.lnbts_objid,
    a.version,
    a.区域,
    a.基站数,
    a.小区数,
    a.LTE小区可用率分子,
    a.LTE小区可用率分母,
    a.LTE小区可用率, 
    a.LTE小区平均退服时长s,
    a.LTE小区总退服时长s,
    a.PRACH成功率,
    a.随机接入冲突解决次数,
    a.cell收随机前导数竞争,
    a.cell收随机前导数非竞,
    a.无线接通率,
    a.RRC连接建立成功率,
    a.RRC连接建立请求次数,
    a.RRC连接建立成功次数,
    a.RRC建立平均时延,
    a.RRC建立最大时延,
    a.Setup_comp_miss无应答,
    a.Setup_comp_error小区拒绝,
    a.Reject_RRM_RAC资源分配失,
    a.SIGN_CONN_ESTAB_FAIL_MAXRRC,
    a.RRC重建成功率,
    a.RRC重建次数,
    a.RRC重建成功次数,
    a.RRC重建尝试因HO原因,
    a.RRC重建成功因HO原因,
    a.RRC重建尝试因other原因,
    a.RRC重建成功因other原因,
    a.ERAB建立成功率,
    a.ERAB建立请求个数,
    a.ERAB建立成功个数,
    a.E_RAB建立平均时延,
    a.E_RAB建立最大时延,
    a.无线资源拥塞次数,
    a.ERAB失败_传输层,
    a.ERAB建立失败_UE无响应,    
    a.ERAB建立失败_安全模式, 
    a.E_RAB建立失败_核心网,
    a.E_RAB建立失败_无线层,
    a.LTE业务掉线率,
    a.LTE业务释放次数,
    a.LTE业务掉线次数,
    a.MME释放的ERAB数网络层,
    a.eNB释放的ERAB数网络层,
    a.eNB释放的ERAB数other,
    a.eNB释放的ERAB数传输层,
    a.E_RAB异常释放_网络拥塞,  
    a.空口上行业务字节数MB,---MByte 单位
    a.空口上行业务平均速率,---Mbps单位
    a.空口下行业务字节数MB,---MByte 单位
    a.空口下行业务平均速率,---Mbps单位
    --a.上行PRB平均利用率,
    --a.下行PRB平均利用率, 
    a.上行PRB可用总数,
    a.上行PRB占用总数,
    a.上行PRB平均利用率,
    a.上行PRB占用平均数,
    a.下行PRB可用总数,
    a.下行PRB占用总数,
    a.下行PRB平均利用率,
    a.下行PRB占用平均数,
    a.上行无线资源利用率,
    a.下行无线资源利用率, 
    a.平均RRC连接数_avg,
    a.平均RRC连接数_sum,
    a.最大RRC连接数_sum,
    a.最大RRC连接数_max,
    a.平均激活用户数,
    a.最大激活用户数,
    a.平均E_RAB数,
    a.每用户平均E_RAB数,
    a.上行激活E_RAB数,
    a.下行激活E_RAB数,
    a.上行PRB资源使用个数,
    a.下行PRB资源使用个数, 
    a.CCE占用,
    a.CCE可用,
    a.小区平均发射功率,
    a.小区最大发射功率 

FROM
    (SELECT 
        to_char(tab1.pm_date,'yyyymmdd') DDATE,
        to_char(tab1.pm_date,'hh24') AS TTIME,
           tab1.LNCEL_ENB_ID AS ENB_ID,
           --tab1.LNCEL_LCR_ID AS CELL_ID,
           tab1.lnbts_objid AS lnbts_objid,
           --tab1.LNCEL_ENB_ID * 100 + tab1.LNCEL_LCR_ID as ECI,
           tab1.version,
        tab1.区域,
        tab9.基站数,
        tab9.小区数,
        sum(tab1.LTE小区可用率分子) AS LTE小区可用率分子,
        sum(tab1.LTE小区可用率分母) AS LTE小区可用率分母,
        round(decode(sum(tab1.LTE小区可用率分母),0,0,sum(tab1.LTE小区可用率分子)/sum(tab1.LTE小区可用率分母)*100),2) AS LTE小区可用率, 
        round(avg(tab1.LTE小区退服时长),2) AS LTE小区平均退服时长s,
        round(sum(tab1.LTE小区退服时长),2) AS LTE小区总退服时长s,
        round((decode(sum(tab2.RRC连接建立请求次数),0,0,sum(tab2.RRC连接建立成功次数)/sum(tab2.RRC连接建立请求次数)))*(decode(SUM(tab3.ERAB建立请求个数),0,0,sum(tab3.ERAB建立成功个数)/SUM(tab3.ERAB建立请求个数)))*100,2) AS 无线接通率,
        round(decode(sum(tab2.RRC连接建立请求次数),0,0,sum(tab2.RRC连接建立成功次数)/sum(tab2.RRC连接建立请求次数))*100,2) AS RRC连接建立成功率,
        sum(tab2.RRC连接建立请求次数) AS RRC连接建立请求次数,
        sum(tab2.RRC连接建立成功次数) AS RRC连接建立成功次数,
        ROUND(avg(tab7.RRC建立平均时延),0) AS RRC建立平均时延,
        ROUND(max(tab7.RRC建立最大时延),0) AS RRC建立最大时延,
        sum(tab2.Setup_comp_miss无应答) AS Setup_comp_miss无应答,
        sum(tab2.Setup_comp_error小区拒绝) AS Setup_comp_error小区拒绝,
        sum(tab2.Reject_RRM_RAC资源分配失) AS Reject_RRM_RAC资源分配失,
        sum(tab2.SIGN_CONN_ESTAB_FAIL_MAXRRC) AS SIGN_CONN_ESTAB_FAIL_MAXRRC, 
        round(decode(sum(tab7.RRC重建次数),0,0,sum(tab7.RRC重建成功次数)/sum(tab7.RRC重建次数)*100),2) AS RRC重建成功率,
        sum(tab7.RRC重建次数) AS RRC重建次数,
        sum(tab7.RRC重建成功次数) AS RRC重建成功次数,
        sum(tab7.RRC重建尝试因HO原因) AS RRC重建尝试因HO原因,
        sum(tab7.RRC重建成功因HO原因) AS RRC重建成功因HO原因,
        sum(tab7.RRC重建尝试因other原因) AS RRC重建尝试因other原因,
        sum(tab7.RRC重建成功因other原因) AS RRC重建成功因other原因,
        round(decode(SUM(tab3.ERAB建立请求个数),0,0,sum(tab3.ERAB建立成功个数)/SUM(tab3.ERAB建立请求个数))*100,2) AS ERAB建立成功率,
        sum(tab3.ERAB建立请求个数) AS ERAB建立请求个数,
        sum(tab3.ERAB建立成功个数) AS ERAB建立成功个数,
        ROUND(avg(tab8.E_RAB建立平均时延),0) AS E_RAB建立平均时延,
        ROUND(max(tab8.E_RAB建立最大时延),0) AS E_RAB建立最大时延,
        sum(tab2.无线资源拥塞次数) AS 无线资源拥塞次数,
        sum(tab2.传输资源拥塞次数) AS ERAB失败_传输层,
        sum(tab2.ERAB建立失败_UE无响应) AS ERAB建立失败_UE无响应,    
        sum(tab2.ERAB建立失败_配置) AS ERAB建立失败_安全模式, 
        ROUND(avg(tab2.E_RAB建立失败_核心网),0) AS E_RAB建立失败_核心网,
        ROUND(avg(tab2.E_RAB建立失败_无线层),0) AS E_RAB建立失败_无线层,
        round(decode(sum(tab3.LTE业务释放次数),0,0,sum(tab3.LTE业务掉线次数)/sum(tab3.LTE业务释放次数))*100,2) AS LTE业务掉线率,
        sum(tab3.LTE业务释放次数) AS LTE业务释放次数,
        sum(tab3.LTE业务掉线次数) AS LTE业务掉线次数,
        sum(tab3.EPC_EPS_BEARER_REL_REQ_RNL) AS MME释放的ERAB数网络层,
        sum(tab3.ENB_EPS_BEARER_REL_REQ_RNL) AS eNB释放的ERAB数网络层,
        sum(tab3.ENB_EPS_BEARER_REL_REQ_OTH) AS eNB释放的ERAB数other,
        sum(tab3.ENB_EPS_BEARER_REL_REQ_TNL) AS eNB释放的ERAB数传输层,
        sum(tab3.EPC_EPS_BEAR_REL_REQ_R_QCI1) AS  E_RAB异常释放_网络拥塞,  
        round(sum(tab4.空口上行业务字节数MB)/1024,2) AS 空口上行业务字节数MB,---MByte 单位
        round(decode(sum(tab4.ACTIVE_TTI_UL),0,0,(sum(tab4.空口上行业务字节数MB)*1000*8)/sum(tab4.ACTIVE_TTI_UL)/1024),2) AS 空口上行业务平均速率,---Mbps单位
        round(sum(tab4.空口下行业务字节数MB)/1024,2) AS 空口下行业务字节数MB,---MByte 单位
        round(decode(sum(tab4.ACTIVE_TTI_DL),0,0,(sum(tab4.空口下行业务字节数MB)*1000*8)/sum(tab4.ACTIVE_TTI_DL)/1024),2) AS 空口下行业务平均速率,---Mbps单位
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
        round(avg(tab6.平均RRC连接数_avg),2) 平均RRC连接数_avg,
        round(sum(tab6.平均RRC连接数_sum),2) 平均RRC连接数_sum,
        sum(tab6.最大RRC连接数_sum) 最大RRC连接数_sum,
        max(tab6.最大RRC连接数_max) 最大RRC连接数_max,
        sum(tab6.随机接入冲突解决次数) as 随机接入冲突解决次数,
        sum(tab6.cell收随机前导数竞争) as cell收随机前导数竞争,
        sum(tab6.cell收随机前导数非竞) as cell收随机前导数非竞,
        round(decode(sum(tab6.cell收随机前导数竞争+tab6.cell收随机前导数非竞),0,0,sum(tab6.随机接入冲突解决次数)/sum(tab6.cell收随机前导数竞争+tab6.cell收随机前导数非竞))*100,2) AS PRACH成功率,

        round(sum(tab6.平均激活用户数),0) AS 平均激活用户数,
        round(sum(tab6.最大激活用户数),0) AS 最大激活用户数,
        round(avg(tab10.平均E_RAB数), 2) AS 平均E_RAB数,
        round(avg(tab10.每用户平均E_RAB数), 2) AS 每用户平均E_RAB数,
        round(avg(tab10.上行激活E_RAB数), 2) AS 上行激活E_RAB数,
        round(avg(tab10.下行激活E_RAB数), 2) AS 下行激活E_RAB数,
        round(sum(tab5.上行PRB资源使用个数),0) AS 上行PRB资源使用个数,
        round(sum(tab5.下行PRB资源使用个数),0) AS 下行PRB资源使用个数, 
        round(avg(tab5.CCE占用),2) AS CCE占用,
        round(avg(tab5.CCE可用),2) AS CCE可用,
        round(avg(tab11.小区平均发射功率),2) AS 小区平均发射功率,
        round(max(tab11.小区最大发射功率),0) AS 小区最大发射功率 
        
    FROM 
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            ----c.lncel_lcr_id AS lncel_lcr_id,
            c.lnbts_objid AS lnbts_objid,
            lcelav.period_start_time pm_date,
            c.version,
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
            NOKLTE_PS_LCELAV_LNBTS_HOUR lcelav
            INNER JOIN C_LTE_CUSTOM c ON c.lnbts_objid = lcelav.lnbts_id

        WHERE 

                lcelav.period_start_time >= to_date(&start_datetime,'yyyymmdd')
            AND lcelav.period_start_time <  to_date(&end_datetime,'yyyymmdd')
        
        GROUP BY
            lcelav.period_start_time，
            c.lnbtsid,
            ----c.lncel_lcr_id,
            c.lnbts_objid,
            c.city,
            c.netmodel,
            c.version
           
        ) tab1,
           
        (SELECT
            c.lnbtsid AS lncel_enb_id,
            ----c.lncel_lcr_id AS lncel_lcr_id,
            luest.period_start_time pm_date,
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
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(lepsb.ERAB_INI_SETUP_FAIL_RNL_RIP + lepsb.ERAB_ADD_SETUP_FAIL_RNL_RIP),'') AS E_RAB建立失败_无线层 --LN7.0无此指标
        
        FROM 
            NOKLTE_PS_LUEST_LNBTS_HOUR luest
            INNER JOIN NOKLTE_PS_LEPSB_LNBTS_HOUR lepsb ON lepsb.lnbts_id = luest.lnbts_id
                   AND lepsb.period_start_time = luest.period_start_time
                   AND lepsb.period_start_time >=to_date(&start_datetime, 'yyyymmdd')
                   AND lepsb.period_start_time < to_date(&end_datetime, 'yyyymmdd')
            RIGHT JOIN C_LTE_CUSTOM c ON c.lnbts_objid = luest.lnbts_id
            
        WHERE
                luest.period_start_time >=to_date(&start_datetime, 'yyyymmdd')
            AND luest.period_start_time < to_date(&end_datetime, 'yyyymmdd')
             
        GROUP BY
            luest.period_start_time,
            c.lnbtsid,
            ----c.lncel_lcr_id,
            c.version
            
        ) tab2,
           
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            ----c.lncel_lcr_id AS lncel_lcr_id,
            lepsb.period_start_time pm_date,
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
            NOKLTE_PS_LEPSB_LNBTS_HOUR lepsb
            INNER JOIN C_LTE_CUSTOM c ON c.lnbts_objid = lepsb.lnbts_id
            
        WHERE 
                lepsb.period_start_time >=to_date(&start_datetime, 'yyyymmdd')
            AND lepsb.period_start_time < to_date(&end_datetime, 'yyyymmdd')
            
        GROUP BY
            lepsb.period_start_time,
            c.lnbtsid,
            ----c.lncel_lcr_id,
            c.version
       
        ) tab3,
           
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            ----c.lncel_lcr_id AS lncel_lcr_id,
            lcellt.period_start_time pm_date,
            decode(sum(lcellt.ACTIVE_TTI_UL),0,0,sum(lcellt.PDCP_SDU_VOL_UL) * 8 * 1000 /
                sum(lcellt.ACTIVE_TTI_UL*1024)) AS 空口上行业务平均速率,
            SUM(PDCP_SDU_VOL_UL) / 1024 AS 空口上行业务字节数MB,
            sum(lcellt.ACTIVE_TTI_UL)  AS ACTIVE_TTI_UL,
            decode(sum(lcellt.ACTIVE_TTI_DL), 0, 0,sum(lcellt.PDCP_SDU_VOL_DL) * 8 * 1000 /
                sum(lcellt.ACTIVE_TTI_DL*1024)) AS 空口下行业务平均速率,
            SUM(PDCP_SDU_VOL_DL) / 1024 AS 空口下行业务字节数MB,
            sum(lcellt.ACTIVE_TTI_DL) AS ACTIVE_TTI_DL
            
        FROM 
            NOKLTE_PS_LCELLT_LNBTS_HOUR lcellt
            INNER JOIN C_LTE_CUSTOM c ON c.lnbts_objid = lcellt.lnbts_id

        WHERE 
                lcellt.period_start_time >= to_date(&start_datetime, 'yyyymmdd')
            AND lcellt.period_start_time < to_date(&end_datetime, 'yyyymmdd')
            
        GROUP BY 
            lcellt.period_start_time,
            c.lnbtsid
            ----c.lncel_lcr_id
            
            ) tab4,
           
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            ----c.lncel_lcr_id AS lncel_lcr_id,
            lcellr.period_start_time pm_date,
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
            NOKLTE_PS_LCELLR_LNBTS_HOUR lcellr
            RIGHT JOIN c_lte_lncel lncel ON lncel.obj_gid = lcellr.lnbts_id 
            RIGHT JOIN C_LTE_CUSTOM c ON c.lnbts_objid = lcellr.lnbts_id
                   AND lncel.obj_gid = c.lnbts_objid

        WHERE 
                lcellr.period_start_time >=to_date(&start_datetime, 'yyyymmdd')
            AND lcellr.period_start_time < to_date(&end_datetime, 'yyyymmdd')
            
        GROUP BY 
            lcellr.period_start_time,
            c.lnbtsid
            ----c.lncel_lcr_id
            
        ) tab5,
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            ----c.lncel_lcr_id AS lncel_lcr_id,
            lcelld.period_start_time AS pm_date,
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
            NOKLTE_PS_LCELLD_LNBTS_HOUR lcelld
            INNER JOIN C_LTE_CUSTOM c ON c.lnbts_objid = lcelld.lnbts_id
            
        WHERE 
                lcelld.period_start_time >=to_date(&start_datetime, 'yyyymmdd')
            AND lcelld.period_start_time <to_date(&end_datetime, 'yyyymmdd')
        GROUP BY
            lcelld.period_start_time,
            c.lnbtsid
            ----c.lncel_lcr_id
     
        ) tab6,
        
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            ----c.lncel_lcr_id AS lncel_lcr_id,
            lrrc.period_start_time AS pm_date,
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
            NOKLTE_PS_LRRC_LNBTS_HOUR lrrc
            INNER JOIN C_LTE_CUSTOM c ON c.lnbts_objid = lrrc.lnbts_id
            
        WHERE 
                lrrc.period_start_time >= to_date(&start_datetime, 'yyyymmdd')
            AND lrrc.period_start_time < to_date(&end_datetime, 'yyyymmdd')
        GROUP BY
            lrrc.period_start_time,
            c.lnbtsid
            --c.lncel_lcr_id

        ) tab7,  
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            --c.lncel_lcr_id AS lncel_lcr_id,
            lrdb.period_start_time AS pm_date, 
            round(avg(lrdb.ERAB_SETUP_TIME_MEAN),4) AS E_RAB建立平均时延, 
            max(lrdb.ERAB_SETUP_TIME_MAX) AS E_RAB建立最大时延
            
        FROM 
            NOKLTE_PS_LRDB_LNBTS_HOUR lrdb
            INNER JOIN C_LTE_CUSTOM c ON c.lnbts_objid = lrdb.lnbts_id
            
        WHERE
                lrdb.period_start_time >= to_date(&start_datetime, 'yyyymmdd')
            AND lrdb.period_start_time < to_date(&end_datetime, 'yyyymmdd')
            
        GROUP BY
            lrdb.period_start_time,
            c.lnbtsid
            --c.lncel_lcr_id

        ) tab8,
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            --c.lncel_lcr_id AS lncel_lcr_id,
            lepsb.period_start_time AS pm_date, 
            ROUND(DECODE(AVG(lepsb.DENOM_SUM_SIMUL_ERAB),0,NULL, AVG(lepsb.SUM_SIMUL_ERAB_QCI_1 + lepsb.SUM_SIMUL_ERAB_QCI_2 + lepsb.SUM_SIMUL_ERAB_QCI_3 + lepsb.SUM_SIMUL_ERAB_QCI_4 +   lepsb.SUM_SIMUL_ERAB_QCI_5 + lepsb.SUM_SIMUL_ERAB_QCI_6 +  lepsb.SUM_SIMUL_ERAB_QCI_7 + lepsb.SUM_SIMUL_ERAB_QCI_8 +   lepsb.SUM_SIMUL_ERAB_QCI_9) / AVG(lepsb.DENOM_SUM_SIMUL_ERAB)),8) AS  平均E_RAB数,
            ROUND(DECODE(AVG(lepsb.DENOM_SUM_SIMUL_ERAB * lcelld.CELL_LOAD_ACT_UE_AVG),0,NULL, AVG(lepsb.SUM_SIMUL_ERAB_QCI_1 + lepsb.SUM_SIMUL_ERAB_QCI_2 + lepsb.SUM_SIMUL_ERAB_QCI_3 + lepsb.SUM_SIMUL_ERAB_QCI_4 + lepsb.SUM_SIMUL_ERAB_QCI_5 + lepsb.SUM_SIMUL_ERAB_QCI_6 + lepsb.SUM_SIMUL_ERAB_QCI_7 + lepsb.SUM_SIMUL_ERAB_QCI_8 +   lepsb.SUM_SIMUL_ERAB_QCI_9) / AVG(lepsb.DENOM_SUM_SIMUL_ERAB * lcelld.CELL_LOAD_ACT_UE_AVG)),8)  AS  每用户平均E_RAB数,
            ROUND(decode(AVG(lcelld.DENOM_ACTIVE_UE_DATA_UL),0,null,AVG(lcelld.SUM_ACTIVE_UE_DATA_UL)/AVG(lcelld.DENOM_ACTIVE_UE_DATA_UL)),8) AS 上行激活E_RAB数,
            ROUND(decode(AVG(lcelld.DENOM_ACTIVE_UE_DATA_DL),0,null,AVG(lcelld.SUM_ACTIVE_UE_DATA_DL)/AVG(lcelld.DENOM_ACTIVE_UE_DATA_DL)),8) AS 下行激活E_RAB数
        FROM
            NOKLTE_PS_LEPSB_LNBTS_HOUR lepsb         
            INNER JOIN NOKLTE_PS_LCELLD_LNBTS_HOUR lcelld ON lepsb.lnbts_id = lcelld.lnbts_id  
                   AND lepsb.period_start_time = lcelld.period_start_time
                   AND lcelld.period_start_time >=To_Date(&start_datetime, 'yyyymmdd')
                   AND lcelld.period_start_time < To_Date(&end_datetime, 'yyyymmdd') 
            RIGHT JOIN C_LTE_CUSTOM c ON c.lnbts_objid = lepsb.lnbts_id
            
        WHERE
                lepsb.period_start_time >=To_Date(&start_datetime, 'yyyymmdd')
            AND lepsb.period_start_time < To_Date(&end_datetime, 'yyyymmdd') 
            
        GROUP BY
            lepsb.period_start_time,
            c.lnbtsid
            --c.lncel_lcr_id

        ) tab10,
        
        (SELECT
            c.lnbtsid AS lncel_enb_id,
            --c.lncel_lcr_id AS lncel_lcr_id,
            lpqdl.period_start_time AS pm_date,  
            --此两个指标LN7.0和FL16 指标公式不一样 需要核对
            decode(AVG(lpqdl.AVG_TRANS_PWR),0,0,10*log(10,AVG(lpqdl.AVG_TRANS_PWR))) AS 小区平均发射功率, 
            decode(MAX(lpqdl.MAX_TRANS_PWR),0,0,10*log(10,MAX(lpqdl.MAX_TRANS_PWR))) AS 小区最大发射功率    
            
        FROM
            NOKLTE_PS_LPQDL_LNBTS_HOUR lpqdl
            INNER JOIN C_LTE_CUSTOM c ON c.lnbts_objid = lpqdl.lnbts_id
            
        WHERE
                lpqdl.period_start_time >= to_date(&start_datetime, 'yyyymmdd')
            AND lpqdl.period_start_time < to_date(&end_datetime, 'yyyymmdd')
            
        GROUP BY 
            lpqdl.period_start_time,
            c.lnbtsid
            --c.lncel_lcr_id
            
        ) tab11,
        
        (SELECT  
            count(distinct c.lnbtsid) AS 基站数,
            count(distinct c.lnbtsid*c.lncel_lcr_id) AS 小区数,               
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
        ELSE NULL END) AS 区域
            
        FROM 
            noklte_PS_lcelav_LNCEL_HOUR lcelav
            INNER JOIN C_LTE_CUSTOM c ON c.lnbts_objid = lcelav.lnbts_id
            
        WHERE 

                lcelav.period_start_time >=to_date(&start_datetime, 'yyyymmdd')
            AND lcelav.period_start_time < to_date(&end_datetime, 'yyyymmdd')
            
        GROUP BY  
            c.city,
            c.netmodel,
            lcelav.period_start_time
            
        )tab9   

    WHERE 
            tab1.Lncel_Enb_Id = tab2.Lncel_Enb_Id(+)
        --AND tab1.lncel_lcr_id = tab2.lncel_lcr_id(+)
        AND tab1.pm_date = tab2.pm_date(+)
        AND tab1.Lncel_Enb_Id = tab3.Lncel_Enb_Id(+)
        --AND tab1.lncel_lcr_id = tab3.lncel_lcr_id(+)
        AND tab1.pm_date = tab3.pm_date(+)
        AND tab1.Lncel_Enb_Id = tab4.Lncel_Enb_Id(+)
        --AND tab1.lncel_lcr_id = tab4.lncel_lcr_id(+)
        AND tab1.pm_date = tab4.pm_date(+)
        AND tab1.Lncel_Enb_Id = tab5.Lncel_Enb_Id(+)
        --AND tab1.lncel_lcr_id = tab5.lncel_lcr_id(+)
        AND tab1.pm_date = tab5.pm_date(+)
        AND tab1.Lncel_Enb_Id = tab6.Lncel_Enb_Id(+)
        --AND tab1.lncel_lcr_id = tab6.lncel_lcr_id(+)
        AND tab1.pm_date = tab6.pm_date(+)
        AND tab1.Lncel_Enb_Id = tab7.Lncel_Enb_Id(+)
        --AND tab1.lncel_lcr_id = tab7.lncel_lcr_id(+)
        AND tab1.pm_date = tab7.pm_date(+)
        AND tab1.Lncel_Enb_Id = tab8.Lncel_Enb_Id(+)
        --AND tab1.lncel_lcr_id = tab8.lncel_lcr_id(+)
        AND tab1.pm_date = tab8.pm_date(+)   
        AND tab1.Lncel_Enb_Id = tab10.Lncel_Enb_Id(+)
        --AND tab1.lncel_lcr_id = tab10.lncel_lcr_id(+)
        AND tab1.pm_date = tab10.pm_date(+)  
        AND tab1.Lncel_Enb_Id = tab11.Lncel_Enb_Id(+)
        --AND tab1.lncel_lcr_id = tab11.lncel_lcr_id(+)
        AND tab1.pm_date = tab11.pm_date(+)    
        AND tab1.pm_date = tab9.pm_date(+)
        AND tab1.区域 = tab9.区域

    GROUP BY
        tab1.pm_date,
           tab1.LNCEL_ENB_ID,
           --tab1.LNCEL_LCR_ID,
           --tab1.lnbts_name,
           tab1.lnbts_objid,
           tab1.version,
        tab1.区域,
        基站数,
        小区数
    ) a
LEFT JOIN c_lte_lnbts lnbts ON lnbts.obj_gid = a.lnbts_objid  
