SELECT to_char(tab1.pm_date, 'yyyymmdd') DDATE,
       tab1.LNCEL_ENB_ID AS ENB_ID,
       tab1.LNBTS_ENB_NAME AS eNodeB名称,
       tab1.LNCEL_LCR_ID AS CELL_ID,
       tab1.LNCEL_ENB_ID * 100 + tab1.LNCEL_LCR_ID as ECI,
       (CASE
                   WHEN ( tab1.区域 = 'BaojiFDD' ) THEN '宝鸡FDD'
                   WHEN ( tab1.区域 = 'BaojiTDD' ) THEN '宝鸡TDD'
                   WHEN ( tab1.区域 = 'XianFDD' ) THEN '西安FDD'
                   WHEN ( tab1.区域 = 'XianTDD' ) THEN '西安TDD'    
                   WHEN ( tab1.区域 = 'XianyangFDD' ) THEN '咸阳FDD'
                   WHEN ( tab1.区域 = 'YananTDD' ) THEN '延安FDD' 
                   WHEN ( tab1.区域 = 'YulinTDD' ) THEN '榆林FDD'                   
                   ELSE NULL
               END) as 区域,
       基站数,
       小区数,
       sum(tab1.LTE小区可用率分子) as LTE小区可用率分子,
       sum(tab1.LTE小区可用率分母) as LTE小区可用率分母,
       round(decode(sum(tab1.LTE小区可用率分母),
                    0,
                    0,
                    sum(tab1.LTE小区可用率分子) / sum(tab1.LTE小区可用率分母) * 100),
             2) as LTE小区可用率,
       round(avg(tab1.LTE小区退服时长), 2) as LTE小区平均退服时长s,
       round(sum(tab1.LTE小区退服时长), 2) as LTE小区总退服时长s,
       round((decode(sum(tab2.RRC连接建立请求次数),
                     0,
                     0,
                     sum(tab2.RRC连接建立成功次数) / sum(tab2.RRC连接建立请求次数))) *
             (decode(SUM(tab3.ERAB建立请求个数),
                     0,
                     0,
                     sum(tab3.ERAB建立成功个数) / SUM(tab3.ERAB建立请求个数))) * 100,
             2) AS 无线接通率,
       round(decode(sum(tab2.RRC连接建立请求次数),
                    0,
                    0,
                    sum(tab2.RRC连接建立成功次数) / sum(tab2.RRC连接建立请求次数)) * 100,
             2) AS RRC连接建立成功率,
       sum(tab2.RRC连接建立请求次数) AS RRC连接建立请求次数,
       sum(tab2.RRC连接建立成功次数) AS RRC连接建立成功次数,
      ROUND(avg(RRC建立平均时延),0) AS RRC建立平均时延,
      ROUND(max(RRC建立最大时延),0) AS RRC建立最大时延,
      sum(Setup_comp_miss无应答) AS Setup_comp_miss无应答,
      sum(Setup_comp_error小区拒绝) AS Setup_comp_error小区拒绝,
      sum(Reject_RRM_RAC资源分配失) AS Reject_RRM_RAC资源分配失,
      round(avg(RRC重建成功率),2) as RRC重建成功率,
      sum(RRC重建次数) as RRC重建次数,
      sum(RRC重建成功次数) as RRC重建成功次数,
      sum(RRC重建尝试因HO原因) as RRC重建尝试因HO原因,
      sum(RRC重建成功因HO原因) as RRC重建成功因HO原因,
      sum(RRC重建尝试因other原因) as RRC重建尝试因other原因,
      sum(RRC重建成功因other原因) as RRC重建成功因other原因,
      
       round(decode(SUM(tab3.ERAB建立请求个数),
                    0,
                    0,
                    sum(tab3.ERAB建立成功个数) / SUM(tab3.ERAB建立请求个数)) * 100,
             2) AS ERAB建立成功率,
       sum(tab3.ERAB建立请求个数) AS ERAB建立请求个数,
       sum(tab3.ERAB建立成功个数) AS ERAB建立成功个数,
       ROUND(avg(E_RAB建立平均时延),0) AS E_RAB建立平均时延,
       ROUND(max(E_RAB建立最大时延),0) AS E_RAB建立最大时延,
       sum(无线资源拥塞次数) AS  ERAB拥塞_无线资源受限,
       sum(传输资源拥塞次数) AS ERAB失败_传输层,
       sum(ERAB建立失败_UE无响应) AS ERAB建立失败_UE无响应,
       sum(ERAB建立失败_配置) AS ERAB建立失败_安全模式,
       ROUND(avg(E_RAB建立失败_核心网),0) AS E_RAB建立失败_核心网,
       ROUND(avg(E_RAB建立失败_无线层),0) AS E_RAB建立失败_无线层,
       round(decode(sum(tab3.LTE业务释放次数),
                    0,
                    0,
                    sum(tab3.LTE业务掉线次数) / sum(tab3.LTE业务释放次数)) * 100,
             2) as LTE业务掉线率,
       sum(tab3.LTE业务释放次数) AS LTE业务释放次数,
       sum(tab3.LTE业务掉线次数) AS LTE业务掉线次数,
       sum(tab3.EPC_EPS_BEARER_REL_REQ_RNL) as MME释放的ERAB数网络层,
       sum(tab3.ENB_EPS_BEARER_REL_REQ_RNL) as eNB释放的ERAB数网络层,
       sum(tab3.ENB_EPS_BEARER_REL_REQ_OTH) as eNB释放的ERAB数other,
       sum(tab3.ENB_EPS_BEARER_REL_REQ_TNL) as eNB释放的ERAB数传输层,
       ROUND(AVG(EPC_EPS_BEAR_REL_REQ_R_QCI1),0) AS  E_RAB异常释放_网络拥塞, 
       round(sum(tab4.空口上行业务字节数) / 1024, 2) as 空口上行业务字节数MB, ---MByte 单位
       round(decode(sum(tab4.ACTIVE_TTI_UL),
                    0,
                    0,
                    (sum(tab4.空口上行业务字节数) * 1000 * 8) /
                    sum(tab4.ACTIVE_TTI_UL) / 1024),
             2) as 空口上行业务平均速率, ---Mbps单位
       round(sum(tab4.空口下行业务字节数) / 1024, 2) as 空口下行业务字节数MB, ---MKByte 单位
       round(decode(sum(tab4.ACTIVE_TTI_DL),
                    0,
                    0,
                    (sum(tab4.空口下行业务字节数) * 1000 * 8) /
                    sum(tab4.ACTIVE_TTI_DL) / 1024),
             2) as 空口下行业务平均速率, ---Mbps单位
       round(avg(tab5.上行PRB平均利用率) * 100, 2) as 上行PRB平均利用率,
       round(avg(tab5.下行PRB平均利用率) * 100, 2) as 下行PRB平均利用率,
       round(avg(tab6.平均RRC连接数_avg), 2) 平均RRC连接数_avg,
       round(sum(tab6.平均RRC连接数_sum), 2) 平均RRC连接数_sum,
       max(tab6.最大RRC连接数_max) 最大RRC连接数_max,
       max(tab6.最大RRC连接数_sum) 最大RRC连接数_sum,
      round(sum(tab5.上行PRB可用数),2) as 上行PRB可用总数,
 			round(sum(tab5.上行PRB占用平均数),2) as 上行PRB占用总数,
 			round(avg(tab5.上行PRB占用平均数),2) as 上行PRB占用平均数,
 			round(sum(tab5.下行PRB可用数),2) as 下行PRB可用总数,
 			round(sum(tab5.下行PRB占用平均数),2) as 下行PRB占用总数, 
 			round(avg(tab5.下行PRB占用平均数),2) as 下行PRB占用平均数, 
 			round(avg(tab5.上行PRB平均利用率)/0.9/0.6/0.5*100,2) as 上行无线资源利用率,
 			round(avg(tab5.下行PRB平均利用率)/0.9/0.6/0.5*100,2) as 下行无线资源利用率, 
      round(sum(tab6.平均激活用户数), 0) as 平均激活用户数,
      round(sum(tab6.最大激活用户数), 0) as 最大激活用户数,
       round(avg(平均E_RAB数), 2) as 平均E_RAB数,
 round(avg(每用户平均E_RAB数), 2) as 每用户平均E_RAB数,
 round(avg(上行激活E_RAB数), 2) as 上行激活E_RAB数,
 round(avg(下行激活E_RAB数), 2) as 下行激活E_RAB数,
 round(sum(上行PRB资源使用个数),0) as 上行PRB资源使用个数,
 round(sum(下行PRB资源使用个数),0) as 下行PRB资源使用个数, 
 round(avg(CCE占用),2) as CCE占用,
 round(avg(CCE可用),2) as CCE可用,
 round(avg(小区平均发射功率),2) as 小区平均发射功率,
 round(max(小区最大发射功率),0) as 小区最大发射功率 
  from 
        (select c.lnbtsid as Lncel_Enb_Id,
       c.lncel_lcr_id as lncel_lcr_id,
       c.lnbts_name as LNCEL_CELL_NAME,
       c.lnbts_name as LNBTS_ENB_NAME,
               noklte_PS_lcelav_lncel_day.PERIOD_START_TIME pm_date,
       c.city||c.netmodel as  区域,
               ROUND(DECODE(SUM(DENOM_CELL_AVAIL),
                            0,
                            0,
                            100 * SUM(SAMPLES_CELL_AVAIL) /
                            SUM(DENOM_CELL_AVAIL)),
                     2) AS LTE小区可用率,
               SUM(SAMPLES_CELL_AVAIL) LTE小区可用率分子,
               SUM(DENOM_CELL_AVAIL) LTE小区可用率分母,
               SUM(DENOM_CELL_AVAIL - SAMPLES_CELL_AVAIL) * 10 AS LTE小区退服时长
        
          from 
               noklte_PS_lcelav_lncel_day 
          inner join c_lte_custom c on noklte_PS_lcelav_lncel_day.LNCEL_ID = c.lncel_objid
         where 
               noklte_PS_lcelav_lncel_day.PERIOD_START_TIME >=
               to_date(&start_datetime, 'yyyymmddhh24')
           and noklte_PS_lcelav_lncel_day.PERIOD_START_TIME <
               to_date(&end_datetime, 'yyyymmddhh24')
         group by c.lnbtsid,
                  c.lncel_lcr_id,
                  c.lnbts_name,
                  c.city||c.netmodel,
                  noklte_PS_lcelav_lncel_day.PERIOD_START_TIME
         ) tab1,
       (select c.lnbtsid as Lncel_Enb_Id,
                c.lncel_lcr_id as lncel_lcr_id,
               noklte_PS_luest_lncel_day.PERIOD_START_TIME pm_date,
               DECODE(sum(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_S +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MT +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_D +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_OTHERS +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_EMG +
                          decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL,
                                 '',
                                 0,
                                 noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL) +
                          decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO,
                                 '',
                                 0,
                                 noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO)),
                      0,
                      0,
                      sum(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_COMP) /
                      sum(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_S +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MT +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_D +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_OTHERS +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_EMG +
                          decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL,
                                 '',
                                 0,
                                 noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL) +
                          decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO,
                                 '',
                                 0,
                                 noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO))) *
               DECODE(sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_ATTEMPTS),
                      0,
                      0,
                      sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_COMPLETIONS) /
                      sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_ATTEMPTS)) 无线接通率,
               DECODE(sum(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_S +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MT +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_D +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_OTHERS +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_EMG +
                          decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL,
                                 '',
                                 0,
                                 noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL) +
                          decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO,
                                 '',
                                 0,
                                 noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO)),
                      0,
                      0,
                      sum(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_COMP) /
                      sum(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_S +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MT +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_D +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_OTHERS +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_EMG +
                          decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL,
                                 '',
                                 0,
                                 noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL) +
                          decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO,
                                 '',
                                 0,
                                 noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO))) RRC连接建立成功率,
               sum(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_S +
                   noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MT +
                   noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_D +
                   noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_OTHERS +
                   noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_EMG +
                   decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL,
                          '',
                          0,
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL) +
                   decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO,
                          '',
                          0,
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO)) RRC连接建立请求次数,
               sum(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_COMP) RRC连接建立成功次数,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_RESOUR +
                   noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_TRPORT) ERAB建立拥塞次数,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_RESOUR) 无线资源拥塞次数,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_TRPORT) 传输资源拥塞次数,
               Sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_RNL) ERAB建立失败_UE无响应,
               Sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_OTH) ERAB建立失败_配置,
               AVG(noklte_PS_lepsb_lncel_day.ERAB_ADD_SETUP_FAIL_UP) AS E_RAB建立失败_核心网,
               AVG(noklte_PS_lepsb_lncel_day.ERAB_INI_SETUP_FAIL_RNL_RIP +
               noklte_PS_lepsb_lncel_day.ERAB_ADD_SETUP_FAIL_RNL_RIP) AS E_RAB建立失败_无线层 
          from noklte_PS_luest_lncel_day,
               noklte_PS_lepsb_lncel_day
          left join c_lte_custom c on noklte_PS_lepsb_lncel_day.lncel_id = c.lncel_objid     
         where  noklte_PS_luest_lncel_day.PERIOD_START_TIME = noklte_PS_lepsb_lncel_day.PERIOD_START_TIME
         and noklte_PS_luest_lncel_day.lncel_id= noklte_PS_lepsb_lncel_day.lncel_id
           and noklte_PS_luest_lncel_day.PERIOD_START_TIME >=
               to_date(&start_datetime, 'yyyymmddhh24')
           and noklte_PS_luest_lncel_day.PERIOD_START_TIME <
               to_date(&end_datetime, 'yyyymmddhh24')
         group by c.lnbtsid ,
                c.lncel_lcr_id,
                  noklte_PS_luest_lncel_day.PERIOD_START_TIME) tab2,
       (select c.lnbtsid as Lncel_Enb_Id,
       c.lncel_lcr_id as lncel_lcr_id,
               noklte_PS_lepsb_lncel_day.PERIOD_START_TIME pm_date,
               decode(sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_ATTEMPTS),
                      0,
                      0,
                      sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_COMPLETIONS) /
                      sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_ATTEMPTS)) ERAB建立成功率,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_COMPLETIONS) ERAB建立成功个数,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_ATTEMPTS) ERAB建立请求个数,
               DECODE(sum(EPC_EPS_BEARER_REL_REQ_RNL +
                          EPC_EPS_BEAR_REL_REQ_R_QCI1 + PRE_EMPT_GBR_BEARER +
                          PRE_EMPT_NON_GBR_BEARER +
                          ENB_EPS_BEARER_REL_REQ_RNL +
                          ENB_EPS_BEARER_REL_REQ_TNL +
                          ENB_EPS_BEARER_REL_REQ_OTH +
                          ENB_EPS_BEARER_REL_REQ_NORM +
                          ENB_EPSBEAR_REL_REQ_RNL_REDIR +
                          EPC_EPS_BEARER_REL_REQ_NORM +
                          EPC_EPS_BEARER_REL_REQ_DETACH +
                          ERAB_REL_ENB_ACT_NON_GBR),
                      0,
                      0,
                      round(100 *
                            sum(EPC_EPS_BEARER_REL_REQ_RNL +
                                EPC_EPS_BEAR_REL_REQ_R_QCI1 +
                                PRE_EMPT_GBR_BEARER + PRE_EMPT_NON_GBR_BEARER +
                                ENB_EPS_BEARER_REL_REQ_RNL +
                                ENB_EPS_BEARER_REL_REQ_TNL +
                                ENB_EPS_BEARER_REL_REQ_OTH) /
                            sum(EPC_EPS_BEARER_REL_REQ_RNL +
                                EPC_EPS_BEAR_REL_REQ_R_QCI1 +
                                PRE_EMPT_GBR_BEARER + PRE_EMPT_NON_GBR_BEARER +
                                ENB_EPS_BEARER_REL_REQ_RNL +
                                ENB_EPS_BEARER_REL_REQ_TNL +
                                ENB_EPS_BEARER_REL_REQ_OTH +
                                ENB_EPS_BEARER_REL_REQ_NORM +
                                ENB_EPSBEAR_REL_REQ_RNL_REDIR +
                                EPC_EPS_BEARER_REL_REQ_NORM +
                                EPC_EPS_BEARER_REL_REQ_DETACH +
                                ERAB_REL_ENB_ACT_NON_GBR),
                            8)) LTE业务掉线率,
               sum(EPC_EPS_BEARER_REL_REQ_RNL + EPC_EPS_BEAR_REL_REQ_R_QCI1 +
                   PRE_EMPT_GBR_BEARER + PRE_EMPT_NON_GBR_BEARER +
                   ENB_EPS_BEARER_REL_REQ_RNL + ENB_EPS_BEARER_REL_REQ_TNL +
                   ENB_EPS_BEARER_REL_REQ_OTH) LTE业务掉线次数,
               sum(noklte_PS_lepsb_lncel_day.EPC_EPS_BEARER_REL_REQ_RNL) EPC_EPS_BEARER_REL_REQ_RNL,
               sum(noklte_PS_lepsb_lncel_day.EPC_EPS_BEARER_REL_REQ_OTH) EPC_EPS_BEARER_REL_REQ_OTH,
               sum(noklte_PS_lepsb_lncel_day.ENB_EPS_BEARER_REL_REQ_RNL) ENB_EPS_BEARER_REL_REQ_RNL,
               sum(noklte_PS_lepsb_lncel_day.ENB_EPS_BEARER_REL_REQ_TNL) ENB_EPS_BEARER_REL_REQ_TNL,
               sum(noklte_PS_lepsb_lncel_day.ENB_EPS_BEARER_REL_REQ_OTH) ENB_EPS_BEARER_REL_REQ_OTH,
               sum(noklte_PS_lepsb_lncel_day.EPC_EPS_BEAR_REL_REQ_R_QCI1) EPC_EPS_BEAR_REL_REQ_R_QCI1,
               sum(EPC_EPS_BEARER_REL_REQ_RNL + EPC_EPS_BEAR_REL_REQ_R_QCI1 +
                   PRE_EMPT_GBR_BEARER + PRE_EMPT_NON_GBR_BEARER +
                   ENB_EPS_BEARER_REL_REQ_RNL + ENB_EPS_BEARER_REL_REQ_TNL +
                   ENB_EPS_BEARER_REL_REQ_OTH + ENB_EPS_BEARER_REL_REQ_NORM +
                   ENB_EPSBEAR_REL_REQ_RNL_REDIR +
                   EPC_EPS_BEARER_REL_REQ_NORM +
                   EPC_EPS_BEARER_REL_REQ_DETACH + ERAB_REL_ENB_ACT_NON_GBR) LTE业务释放次数
          from 
                noklte_PS_lepsb_lncel_day
                left join c_lte_custom c on noklte_PS_lepsb_lncel_day.LNCEL_ID = c.lncel_objid 
         where  
               noklte_PS_lepsb_lncel_day.PERIOD_START_TIME >=
               to_date(&start_datetime, 'yyyymmddhh24')
           and noklte_PS_lepsb_lncel_day.PERIOD_START_TIME <
               to_date(&end_datetime, 'yyyymmddhh24')
         group by c.lnbtsid, 
                  c.lncel_lcr_id,
                  noklte_PS_lepsb_lncel_day.PERIOD_START_TIME) tab3,
       (select c.lnbtsid as Lncel_Enb_Id,
                c.lncel_lcr_id as lncel_lcr_id,
               noklte_PS_lcellt_lncel_day.PERIOD_START_TIME pm_date,
               decode(sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_UL),
                      0,
                      0,
                      sum(NOKLTE_PS_LCELLT_LNCEL_day.PDCP_SDU_VOL_UL) * 8 * 1000 /
                      sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_UL * 1024)) as 空口上行业务平均速率,
               SUM(PDCP_SDU_VOL_UL) / 1024 as 空口上行业务字节数,
               sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_UL) as ACTIVE_TTI_UL,
               decode(sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_DL),
                      0,
                      0,
                      sum(NOKLTE_PS_LCELLT_LNCEL_day.PDCP_SDU_VOL_DL) * 8 * 1000 /
                      sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_DL * 1024)) as 空口下行业务平均速率,
               SUM(PDCP_SDU_VOL_DL) / 1024 as 空口下行业务字节数,
               sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_DL) as ACTIVE_TTI_DL
          from 
                noklte_PS_lcellt_lncel_day
                inner join c_lte_custom c on noklte_PS_lcellt_lncel_day.LNCEL_ID = c.lncel_objid
         where 
               noklte_PS_lcellt_lncel_day.PERIOD_START_TIME >=
               to_date(&start_datetime, 'yyyymmddhh24')
           and noklte_PS_lcellt_lncel_day.PERIOD_START_TIME <
               to_date(&end_datetime, 'yyyymmddhh24')
         group by c.lnbtsid ,
                   c.lncel_lcr_id,
                  noklte_PS_lcellt_lncel_day.PERIOD_START_TIME) tab4,
       (
       select lncel.lncel_enb_id,
               lncel.lncel_lcr_id,
               NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_START_TIME pm_date,
               decode((sum(decode(lncel.LNCEL_CH_BW,
                                  '',
                                  0,
                                  lncel.LNCEL_CH_BW) +
                           decode(lncel.LNCEL_UL_CH_BW,
                                  '',
                                  0,
                                  lncel.LNCEL_UL_CH_BW)) / 2),
                      0,
                      0,
                      decode(sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000),
                             0,
                             0,
                             sum(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_PUSCH) /
                             sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000)) /
                      (sum(decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                           decode(lncel.LNCEL_TDD_FRAME_CONF, 1, 0.4, 0.2) +
                           decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) / 35 +
                           decode(lncel.LNCEL_UL_CH_BW,
                                  '',
                                  0,
                                  lncel.LNCEL_UL_CH_BW)) / 2)) 上行PRB平均利用率,
               sum(decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                   decode(lncel.LNCEL_TDD_FRAME_CONF, 1, 0.4, 0.2) +
                   decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) / 35 +
                   decode(lncel.LNCEL_UL_CH_BW, '', 0, lncel.LNCEL_UL_CH_BW)) / 2 上行PRB可用数,
               decode(sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000),
                      0,
                      0,
                      sum(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_PUSCH) /
                      sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000)) as 上行PRB占用平均数,
               decode((sum(decode(lncel.LNCEL_CH_BW,
                                  '',
                                  0,
                                  lncel.LNCEL_CH_BW) +
                           decode(lncel.LNCEL_DL_CH_BW,
                                  '',
                                  0,
                                  lncel.LNCEL_DL_CH_BW)) / 2),
                      0,
                      0,
                      decode(sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000),
                             0,
                             0,
                             sum(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_PDSCH) /
                             sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000)) /
                      (sum(decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                           decode(lncel.LNCEL_TDD_FRAME_CONF, 1, 0.4, 0.6) +
                           decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                           decode(lncel.LNCEL_TSSC_296, 5, 0.0428, 0.1428) +
                           decode(lncel.LNCEL_DL_CH_BW,
                                  '',
                                  0,
                                  lncel.LNCEL_DL_CH_BW)) / 2)) 下行PRB平均利用率,
               sum(decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                   decode(lncel.LNCEL_TDD_FRAME_CONF, 1, 0.4, 0.6) +
                   decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                   decode(lncel.LNCEL_TSSC_296, 5, 0.0428, 0.1428) +
                   decode(lncel.LNCEL_DL_CH_BW, '', 0, lncel.LNCEL_DL_CH_BW)) / 2 AS 下行PRB可用数,
               decode(sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000),
                      0,
                      0,
                      sum(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_PDSCH) /
                      sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000)) as 下行PRB占用平均数,
                      SUM(NOKLTE_PS_LCELLR_LNCEL_day.AGG1_USED_PDCCH+2*NOKLTE_PS_LCELLR_LNCEL_day.AGG2_USED_PDCCH+4*NOKLTE_PS_LCELLR_LNCEL_day.AGG4_USED_PDCCH+8*NOKLTE_PS_LCELLR_LNCEL_day.AGG8_USED_PDCCH) as CCE占用,
        SUM(84*1000*60*NOKLTE_PS_LCELLR_LNCEL_day.period_duration)  as CCE可用,
        SUM(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_DL_TOTAL/(NOKLTE_PS_LCELLR_LNCEL_day.period_duration*60000)) AS  下行PRB资源使用个数,
        SUM(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_UL_TOTAL/(NOKLTE_PS_LCELLR_LNCEL_day.period_duration*60000)) AS  上行PRB资源使用个数
          from c_lte_lncel lncel,
               NOKLTE_PS_LCELLR_LNCEL_day,
               NOKLTE_PS_LCELLT_LNCEL_day
         where NOKLTE_PS_LCELLR_LNCEL_day.LNCEL_ID(+) = lncel.obj_gid
           and NOKLTE_PS_LCELLT_LNCEL_day.LNCEL_ID(+) = lncel.obj_gid
           and NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_START_TIME =
               NOKLTE_PS_LCELLT_LNCEL_day.PERIOD_START_TIME
           and lncel.conf_id = 1
           and NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_START_TIME >=
               to_date(&start_datetime, 'yyyymmddhh24')
           and NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_START_TIME <
               to_date(&end_datetime, 'yyyymmddhh24')
         group by LNCEL.Lncel_Enb_Id,
                  lncel.lncel_lcr_id,
                  NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_START_TIME
       
       ) tab5,
       (select c.lnbtsid as Lncel_Enb_Id,
                c.lncel_lcr_id as lncel_lcr_id,

               noklte_PS_lcelld_lncel_day.PERIOD_START_TIME pm_date,
               SUM(CELL_LOAD_ACT_UE_AVG) 平均激活用户数,
               MAX(CELL_LOAD_ACT_UE_MAX) 最大激活用户数,
               avg(RRC_CONN_UE_AVG) 平均RRC连接数_avg,
               sum(RRC_CONN_UE_AVG) 平均RRC连接数_sum,
               max(RRC_CONN_UE_MAX) 最大RRC连接数_max,
               sum(RRC_CONN_UE_MAX) 最大RRC连接数_sum
          from  
               noklte_PS_lcelld_lncel_day
               inner join c_lte_custom c on noklte_PS_lcelld_lncel_day.LNCEL_ID = c.lncel_objid
         where   noklte_PS_lcelld_lncel_day.PERIOD_START_TIME >=
               to_date(&start_datetime, 'yyyymmddhh24')
           and noklte_PS_lcelld_lncel_day.PERIOD_START_TIME <
               to_date(&end_datetime, 'yyyymmddhh24')
         group by c.lnbtsid,
                  c.lncel_lcr_id,
                  noklte_PS_lcelld_lncel_day.PERIOD_START_TIME
                ) tab6,
       (select c.lnbtsid as Lncel_Enb_Id,
               c.lncel_lcr_id as lncel_lcr_id,

               NOKLTE_PS_LUEST_LNCEL_Day.PERIOD_START_TIME pm_date,
               sum(NOKLTE_PS_LUEST_LNCEL_Day.SIGN_EST_F_RRCCOMPL_MISSING) as Setup_comp_miss无应答,
               sum(NOKLTE_PS_LUEST_LNCEL_Day.SIGN_EST_F_RRCCOMPL_ERROR) as Setup_comp_error小区拒绝,
               sum(NOKLTE_PS_LUEST_LNCEL_Day.SIGN_CONN_ESTAB_FAIL_RRMRAC) as Reject_RRM_RAC资源分配失
          from  
               NOKLTE_PS_LUEST_LNCEL_Day
               inner join c_lte_custom c on NOKLTE_PS_LUEST_LNCEL_Day.LNCEL_ID = c.lncel_objid
         where  
               NOKLTE_PS_LUEST_LNCEL_Day.PERIOD_START_TIME >=
               to_date(&start_datetime, 'yyyymmddhh24')
           and NOKLTE_PS_LUEST_LNCEL_Day.PERIOD_START_TIME <
               to_date(&end_datetime, 'yyyymmddhh24')
         group by c.lnbtsid,
                c.lncel_lcr_id,
                  NOKLTE_PS_LUEST_LNCEL_Day.PERIOD_START_TIME
                  ) tab7,
       (select c.lnbtsid as Lncel_Enb_Id,
                c.lncel_lcr_id as lncel_lcr_id,
               p.PERIOD_START_TIME pm_date,
               decode(sum(p.rrc_con_re_estab_att),
                      0,
                      0,
                      sum(p.rrc_con_re_estab_succ) /
                      sum(p.rrc_con_re_estab_att)) RRC重建成功率， 
                      sum(p.rrc_con_re_estab_att) RRC重建次数,
               sum(p.rrc_con_re_estab_succ) RRC重建成功次数,
               sum(p.RRC_CON_RE_ESTAB_ATT_HO_FAIL) RRC重建尝试因HO原因,
               sum(p.RRC_CON_RE_ESTAB_SUCC_HO_FAIL) RRC重建成功因HO原因,
               sum(p.RRC_CON_RE_ESTAB_ATT_OTHER) RRC重建尝试因other原因,
               sum(p.RRC_CON_RE_ESTAB_SUCC_OTHER) RRC重建成功因other原因,
               avg(p.RRC_CON_STP_TIM_MEAN) AS RRC建立平均时延, 
               max(p.RRC_CON_STP_TIM_MAX) AS RRC建立最大时延
          from  
               NOKLTE_PS_LRRC_LNCEL_day p
               inner join c_lte_custom c on p.LNCEL_ID = c.lncel_objid
         where 
               p.PERIOD_START_TIME >=
               to_date(&start_datetime, 'yyyymmddhh24')
           and p.PERIOD_START_TIME < to_date(&end_datetime, 'yyyymmddhh24')
         group by c.lnbtsid  ,
                  c.lncel_lcr_id  ,
                  p.PERIOD_START_TIME
                  ) tab9,
                  
 (select c.lnbtsid as Lncel_Enb_Id,
         c.lncel_lcr_id as lncel_lcr_id,
         p.PERIOD_START_TIME pm_date, 
       avg(p.ERAB_SETUP_TIME_MEAN) AS E_RAB建立平均时延, 
       max(p.ERAB_SETUP_TIME_MAX) AS E_RAB建立最大时延
     from 
        NOKLTE_PS_LRDB_LNCEL_day p
        inner join c_lte_custom c on p.LNCEL_ID = c.lncel_objid
   where 
        p.PERIOD_START_TIME >= to_date(&start_datetime, 'yyyymmdd')
   and p.PERIOD_START_TIME < to_date(&end_datetime, 'yyyymmdd')
 group by 
        c.lnbtsid,  
         c.lncel_lcr_id ,
          p.PERIOD_START_TIME)tab12,                 
                  
 (select 
        c.lnbtsid as Lncel_Enb_Id,
         c.lncel_lcr_id as lncel_lcr_id,
        lepsb.PERIOD_START_TIME pm_date, 
        ROUND(DECODE(AVG(lepsb.DENOM_SUM_SIMUL_ERAB),0,NULL, AVG(lepsb.SUM_SIMUL_ERAB_QCI_1 + lepsb.SUM_SIMUL_ERAB_QCI_2 + lepsb.SUM_SIMUL_ERAB_QCI_3 + lepsb.SUM_SIMUL_ERAB_QCI_4 +   lepsb.SUM_SIMUL_ERAB_QCI_5 + lepsb.SUM_SIMUL_ERAB_QCI_6 +  lepsb.SUM_SIMUL_ERAB_QCI_7 + lepsb.SUM_SIMUL_ERAB_QCI_8 +   lepsb.SUM_SIMUL_ERAB_QCI_9) / AVG(lepsb.DENOM_SUM_SIMUL_ERAB)),8) AS  平均E_RAB数,
        ROUND(DECODE(AVG(lepsb.DENOM_SUM_SIMUL_ERAB * lcelld.CELL_LOAD_ACT_UE_AVG),0,NULL, AVG(lepsb.SUM_SIMUL_ERAB_QCI_1 + lepsb.SUM_SIMUL_ERAB_QCI_2 + lepsb.SUM_SIMUL_ERAB_QCI_3 + lepsb.SUM_SIMUL_ERAB_QCI_4 + lepsb.SUM_SIMUL_ERAB_QCI_5 + lepsb.SUM_SIMUL_ERAB_QCI_6 + lepsb.SUM_SIMUL_ERAB_QCI_7 + lepsb.SUM_SIMUL_ERAB_QCI_8 +   lepsb.SUM_SIMUL_ERAB_QCI_9) / AVG(lepsb.DENOM_SUM_SIMUL_ERAB * lcelld.CELL_LOAD_ACT_UE_AVG)),8)  AS  每用户平均E_RAB数,
        ROUND(decode(AVG(lcelld.DENOM_ACTIVE_UE_DATA_UL),0,null,AVG(lcelld.SUM_ACTIVE_UE_DATA_UL)/AVG(lcelld.DENOM_ACTIVE_UE_DATA_UL)),8) AS 上行激活E_RAB数,
        ROUND(decode(AVG(lcelld.DENOM_ACTIVE_UE_DATA_DL),0,null,AVG(lcelld.SUM_ACTIVE_UE_DATA_DL)/AVG(lcelld.DENOM_ACTIVE_UE_DATA_DL)),8) AS 下行激活E_RAB数
        FROM
        NOKLTE_PS_LEPSB_LNCEL_day lepsb         
        INNER JOIN NOKLTE_PS_LCELLD_LNCEL_day lcelld ON lepsb.lncel_id = lcelld.lncel_id  
        and  lepsb.period_start_time = lcelld.period_start_time  
        and  lcelld.PERIOD_START_TIME >=To_Date(&start_datetime, 'yyyymmdd')
        and  lcelld.PERIOD_START_TIME <To_Date(&end_datetime, 'yyyymmdd') 
        left join c_lte_custom c on lepsb.LNCEL_ID = c.lncel_objid       
    WHERE
    lepsb.PERIOD_START_TIME >=To_Date(&start_datetime, 'yyyymmdd')
    and lepsb.PERIOD_START_TIME <To_Date(&end_datetime, 'yyyymmdd') 
    group by 
    
          c.lnbtsid  ,
         c.lncel_lcr_id ,
          lepsb.PERIOD_START_TIME ) tab10,
          
          
 ( SELECT 
        c.lnbtsid as Lncel_Enb_Id,
         c.lncel_lcr_id as lncel_lcr_id,
       p.PERIOD_START_TIME pm_date,          
        decode(AVG(p.AVG_TRANS_PWR),0,0,10*log(10,AVG(p.AVG_TRANS_PWR))) AS 小区平均发射功率, 
        decode(MAX(p.MAX_TRANS_PWR),0,0,10*log(10,MAX(p.MAX_TRANS_PWR))) AS 小区最大发射功率     
   FROM
         NOKLTE_PS_LPQDL_LNCEL_day p
         left join c_lte_custom c on p.LNCEL_ID = c.lncel_objid 
   WHERE 
       p.PERIOD_START_TIME >= to_date(&start_datetime, 'yyyymmdd')
   and p.PERIOD_START_TIME < to_date(&end_datetime, 'yyyymmdd')        
   GROUP BY 
   
          c.lnbtsid,
          c.lncel_lcr_id ,
          p.PERIOD_START_TIME
                ) tab11,                 
                  
                  
                  
                  
                  
                  
       (select         count(distinct c.lnbtsid) as 基站数,
               count(distinct c.lnbtsid * c.lncel_lcr_id) as 小区数,
               noklte_PS_lcelav_lncel_day.PERIOD_START_TIME as pm_date,
               c.city||c.netmodel as 区域
      
         from
               noklte_PS_lcelav_lncel_day
               inner join c_lte_custom c on noklte_PS_lcelav_lncel_day.LNCEL_ID = c.lncel_objid
         where
         
               noklte_PS_lcelav_lncel_day.PERIOD_START_TIME >=to_date(&start_datetime, 'yyyymmddhh24')
           and noklte_PS_lcelav_lncel_day.PERIOD_START_TIME < to_date(&end_datetime, 'yyyymmddhh24')
           
         group by
               c.city||c.netmodel,
               noklte_PS_lcelav_lncel_day.PERIOD_START_TIME) tab8                
           
 where tab1.Lncel_Enb_Id = tab2.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab2.lncel_lcr_id(+)
   and tab1.pm_date = tab2.pm_date(+)
   and tab1.Lncel_Enb_Id = tab3.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab3.lncel_lcr_id(+)
   and tab1.pm_date = tab3.pm_date(+)
   and tab1.Lncel_Enb_Id = tab4.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab4.lncel_lcr_id(+)
   and tab1.pm_date = tab4.pm_date(+)
   and tab1.Lncel_Enb_Id = tab5.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab5.lncel_lcr_id(+)
   and tab1.pm_date = tab5.pm_date(+)
   and tab1.Lncel_Enb_Id = tab6.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab6.lncel_lcr_id(+)
   and tab1.pm_date = tab6.pm_date(+)
   and tab1.Lncel_Enb_Id = tab7.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab7.lncel_lcr_id(+)
   and tab1.pm_date = tab7.pm_date(+)
   and tab1.Lncel_Enb_Id = tab9.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab9.lncel_lcr_id(+)
   and tab1.pm_date = tab9.pm_date(+)
   and tab1.Lncel_Enb_Id = tab12.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab12.lncel_lcr_id(+)
   and tab1.pm_date = tab12.pm_date(+)   
   and tab1.Lncel_Enb_Id = tab10.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab10.lncel_lcr_id(+)
   and tab1.pm_date = tab10.pm_date(+)  
   and tab1.Lncel_Enb_Id = tab11.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab11.lncel_lcr_id(+)
   and tab1.pm_date = tab11.pm_date(+) 
   and tab1.区域 = tab8.区域
   and tab1.pm_date = tab8.pm_date(+)
 group by 
    to_char(tab1.pm_date, 'yyyymmdd'),       
          tab1.LNCEL_ENB_ID,
          tab1.LNBTS_ENB_NAME,
          tab1.LNCEL_LCR_ID,
          (CASE
                   WHEN ( tab1.区域 = 'BaojiFDD' ) THEN '宝鸡FDD'
                   WHEN ( tab1.区域 = 'BaojiTDD' ) THEN '宝鸡TDD'
                   WHEN ( tab1.区域 = 'XianFDD' ) THEN '西安FDD'
                   WHEN ( tab1.区域 = 'XianTDD' ) THEN '西安TDD'    
                   WHEN ( tab1.区域 = 'XianyangFDD' ) THEN '咸阳FDD'
                   WHEN ( tab1.区域 = 'YananTDD' ) THEN '延安FDD' 
                   WHEN ( tab1.区域 = 'YulinTDD' ) THEN '榆林FDD'                   
                   ELSE NULL
          END),
          基站数,小区数
having round(decode(sum(tab3.LTE业务释放次数), 0, 0, sum(tab3.LTE业务掉线次数) / sum(tab3.LTE业务释放次数)) * 100, 2) >= 1.5 and sum(tab3.LTE业务掉线次数) > = 30 and sum(tab3.LTE业务掉线次数) < 100







union
SELECT to_char(tab1.pm_date, 'yyyymmdd') DDATE,
       tab1.LNCEL_ENB_ID AS ENB_ID,
       tab1.LNBTS_ENB_NAME AS eNodeB名称,
       tab1.LNCEL_LCR_ID AS CELL_ID,
       tab1.LNCEL_ENB_ID * 100 + tab1.LNCEL_LCR_ID as ECI,
       (CASE
                   WHEN ( tab1.区域 = 'BaojiFDD' ) THEN '宝鸡FDD'
                   WHEN ( tab1.区域 = 'BaojiTDD' ) THEN '宝鸡TDD'
                   WHEN ( tab1.区域 = 'XianFDD' ) THEN '西安FDD'
                   WHEN ( tab1.区域 = 'XianTDD' ) THEN '西安TDD'    
                   WHEN ( tab1.区域 = 'XianyangFDD' ) THEN '咸阳FDD'
                   WHEN ( tab1.区域 = 'YananTDD' ) THEN '延安FDD' 
                   WHEN ( tab1.区域 = 'YulinTDD' ) THEN '榆林FDD'                   
                   ELSE NULL
        END) as 区域,
       基站数,
       小区数,
       sum(tab1.LTE小区可用率分子) as LTE小区可用率分子,
       sum(tab1.LTE小区可用率分母) as LTE小区可用率分母,
       round(decode(sum(tab1.LTE小区可用率分母),
                    0,
                    0,
                    sum(tab1.LTE小区可用率分子) / sum(tab1.LTE小区可用率分母) * 100),
             2) as LTE小区可用率,
       round(avg(tab1.LTE小区退服时长), 2) as LTE小区平均退服时长s,
       round(sum(tab1.LTE小区退服时长), 2) as LTE小区总退服时长s,
       round((decode(sum(tab2.RRC连接建立请求次数),
                     0,
                     0,
                     sum(tab2.RRC连接建立成功次数) / sum(tab2.RRC连接建立请求次数))) *
             (decode(SUM(tab3.ERAB建立请求个数),
                     0,
                     0,
                     sum(tab3.ERAB建立成功个数) / SUM(tab3.ERAB建立请求个数))) * 100,
             2) AS 无线接通率,
       round(decode(sum(tab2.RRC连接建立请求次数),
                    0,
                    0,
                    sum(tab2.RRC连接建立成功次数) / sum(tab2.RRC连接建立请求次数)) * 100,
             2) AS RRC连接建立成功率,
       sum(tab2.RRC连接建立请求次数) AS RRC连接建立请求次数,
       sum(tab2.RRC连接建立成功次数) AS RRC连接建立成功次数,
      ROUND(avg(RRC建立平均时延),0) AS RRC建立平均时延,
      ROUND(max(RRC建立最大时延),0) AS RRC建立最大时延,
      sum(Setup_comp_miss无应答) AS Setup_comp_miss无应答,
      sum(Setup_comp_error小区拒绝) AS Setup_comp_error小区拒绝,
      sum(Reject_RRM_RAC资源分配失) AS Reject_RRM_RAC资源分配失,
      round(avg(RRC重建成功率),2) as RRC重建成功率,
      sum(RRC重建次数) as RRC重建次数,
      sum(RRC重建成功次数) as RRC重建成功次数,
      sum(RRC重建尝试因HO原因) as RRC重建尝试因HO原因,
      sum(RRC重建成功因HO原因) as RRC重建成功因HO原因,
      sum(RRC重建尝试因other原因) as RRC重建尝试因other原因,
      sum(RRC重建成功因other原因) as RRC重建成功因other原因,
      
       round(decode(SUM(tab3.ERAB建立请求个数),
                    0,
                    0,
                    sum(tab3.ERAB建立成功个数) / SUM(tab3.ERAB建立请求个数)) * 100,
             2) AS ERAB建立成功率,
       sum(tab3.ERAB建立请求个数) AS ERAB建立请求个数,
       sum(tab3.ERAB建立成功个数) AS ERAB建立成功个数,
       ROUND(avg(E_RAB建立平均时延),0) AS E_RAB建立平均时延,
       ROUND(max(E_RAB建立最大时延),0) AS E_RAB建立最大时延,
       sum(无线资源拥塞次数) AS  ERAB拥塞_无线资源受限,
       sum(传输资源拥塞次数) AS ERAB失败_传输层,
       sum(ERAB建立失败_UE无响应) AS ERAB建立失败_UE无响应,
       sum(ERAB建立失败_配置) AS ERAB建立失败_安全模式,
       ROUND(avg(E_RAB建立失败_核心网),0) AS E_RAB建立失败_核心网,
       ROUND(avg(E_RAB建立失败_无线层),0) AS E_RAB建立失败_无线层,
       round(decode(sum(tab3.LTE业务释放次数),
                    0,
                    0,
                    sum(tab3.LTE业务掉线次数) / sum(tab3.LTE业务释放次数)) * 100,
             2) as LTE业务掉线率,
       sum(tab3.LTE业务释放次数) AS LTE业务释放次数,
       sum(tab3.LTE业务掉线次数) AS LTE业务掉线次数,
       sum(tab3.EPC_EPS_BEARER_REL_REQ_RNL) as MME释放的ERAB数网络层,
       sum(tab3.ENB_EPS_BEARER_REL_REQ_RNL) as eNB释放的ERAB数网络层,
       sum(tab3.ENB_EPS_BEARER_REL_REQ_OTH) as eNB释放的ERAB数other,
       sum(tab3.ENB_EPS_BEARER_REL_REQ_TNL) as eNB释放的ERAB数传输层,
       ROUND(AVG(EPC_EPS_BEAR_REL_REQ_R_QCI1),0) AS  E_RAB异常释放_网络拥塞, 
       round(sum(tab4.空口上行业务字节数) / 1024, 2) as 空口上行业务字节数MB, ---MByte 单位
       round(decode(sum(tab4.ACTIVE_TTI_UL),
                    0,
                    0,
                    (sum(tab4.空口上行业务字节数) * 1000 * 8) /
                    sum(tab4.ACTIVE_TTI_UL) / 1024),
             2) as 空口上行业务平均速率, ---Mbps单位
       round(sum(tab4.空口下行业务字节数) / 1024, 2) as 空口下行业务字节数MB, ---MKByte 单位
       round(decode(sum(tab4.ACTIVE_TTI_DL),
                    0,
                    0,
                    (sum(tab4.空口下行业务字节数) * 1000 * 8) /
                    sum(tab4.ACTIVE_TTI_DL) / 1024),
             2) as 空口下行业务平均速率, ---Mbps单位
       round(avg(tab5.上行PRB平均利用率) * 100, 2) as 上行PRB平均利用率,
       round(avg(tab5.下行PRB平均利用率) * 100, 2) as 下行PRB平均利用率,
       round(avg(tab6.平均RRC连接数_avg), 2) 平均RRC连接数_avg,
       round(sum(tab6.平均RRC连接数_sum), 2) 平均RRC连接数_sum,
       max(tab6.最大RRC连接数_max) 最大RRC连接数_max,
       max(tab6.最大RRC连接数_sum) 最大RRC连接数_sum,
      round(sum(tab5.上行PRB可用数),2) as 上行PRB可用总数,
 			round(sum(tab5.上行PRB占用平均数),2) as 上行PRB占用总数,
 			round(avg(tab5.上行PRB占用平均数),2) as 上行PRB占用平均数,
 			round(sum(tab5.下行PRB可用数),2) as 下行PRB可用总数,
 			round(sum(tab5.下行PRB占用平均数),2) as 下行PRB占用总数, 
 			round(avg(tab5.下行PRB占用平均数),2) as 下行PRB占用平均数, 
 			round(avg(tab5.上行PRB平均利用率)/0.9/0.6/0.5*100,2) as 上行无线资源利用率,
 			round(avg(tab5.下行PRB平均利用率)/0.9/0.6/0.5*100,2) as 下行无线资源利用率, 
      round(sum(tab6.平均激活用户数), 0) as 平均激活用户数,
      round(sum(tab6.最大激活用户数), 0) as 最大激活用户数,
       round(avg(平均E_RAB数), 2) as 平均E_RAB数,
 round(avg(每用户平均E_RAB数), 2) as 每用户平均E_RAB数,
 round(avg(上行激活E_RAB数), 2) as 上行激活E_RAB数,
 round(avg(下行激活E_RAB数), 2) as 下行激活E_RAB数,
 round(sum(上行PRB资源使用个数),0) as 上行PRB资源使用个数,
 round(sum(下行PRB资源使用个数),0) as 下行PRB资源使用个数, 
 round(avg(CCE占用),2) as CCE占用,
 round(avg(CCE可用),2) as CCE可用,
 round(avg(小区平均发射功率),2) as 小区平均发射功率,
 round(max(小区最大发射功率),0) as 小区最大发射功率 
  from 
        (select c.lnbtsid as Lncel_Enb_Id,
       c.lncel_lcr_id as lncel_lcr_id,
       c.lnbts_name as LNCEL_CELL_NAME,
       c.lnbts_name as LNBTS_ENB_NAME,
               noklte_PS_lcelav_lncel_day.PERIOD_START_TIME pm_date,
       c.city||c.netmodel as  区域,
               ROUND(DECODE(SUM(DENOM_CELL_AVAIL),
                            0,
                            0,
                            100 * SUM(SAMPLES_CELL_AVAIL) /
                            SUM(DENOM_CELL_AVAIL)),
                     2) AS LTE小区可用率,
               SUM(SAMPLES_CELL_AVAIL) LTE小区可用率分子,
               SUM(DENOM_CELL_AVAIL) LTE小区可用率分母,
               SUM(DENOM_CELL_AVAIL - SAMPLES_CELL_AVAIL) * 10 AS LTE小区退服时长
        
          from 
               noklte_PS_lcelav_lncel_day 
          inner join c_lte_custom c on noklte_PS_lcelav_lncel_day.LNCEL_ID = c.lncel_objid
         where 
               noklte_PS_lcelav_lncel_day.PERIOD_START_TIME >=
               to_date(&start_datetime, 'yyyymmddhh24')
           and noklte_PS_lcelav_lncel_day.PERIOD_START_TIME <
               to_date(&end_datetime, 'yyyymmddhh24')
         group by c.lnbtsid,
                  c.lncel_lcr_id,
                  c.lnbts_name,
                  c.city||c.netmodel,
                  noklte_PS_lcelav_lncel_day.PERIOD_START_TIME
         ) tab1,
       (select c.lnbtsid as Lncel_Enb_Id,
                c.lncel_lcr_id as lncel_lcr_id,
               noklte_PS_luest_lncel_day.PERIOD_START_TIME pm_date,
               DECODE(sum(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_S +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MT +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_D +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_OTHERS +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_EMG +
                          decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL,
                                 '',
                                 0,
                                 noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL) +
                          decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO,
                                 '',
                                 0,
                                 noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO)),
                      0,
                      0,
                      sum(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_COMP) /
                      sum(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_S +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MT +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_D +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_OTHERS +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_EMG +
                          decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL,
                                 '',
                                 0,
                                 noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL) +
                          decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO,
                                 '',
                                 0,
                                 noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO))) *
               DECODE(sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_ATTEMPTS),
                      0,
                      0,
                      sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_COMPLETIONS) /
                      sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_ATTEMPTS)) 无线接通率,
               DECODE(sum(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_S +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MT +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_D +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_OTHERS +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_EMG +
                          decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL,
                                 '',
                                 0,
                                 noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL) +
                          decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO,
                                 '',
                                 0,
                                 noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO)),
                      0,
                      0,
                      sum(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_COMP) /
                      sum(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_S +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MT +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_D +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_OTHERS +
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_EMG +
                          decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL,
                                 '',
                                 0,
                                 noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL) +
                          decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO,
                                 '',
                                 0,
                                 noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO))) RRC连接建立成功率,
               sum(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_S +
                   noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MT +
                   noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_MO_D +
                   noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_OTHERS +
                   noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_EMG +
                   decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL,
                          '',
                          0,
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_DEL_TOL) +
                   decode(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO,
                          '',
                          0,
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO)) RRC连接建立请求次数,
               sum(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_COMP) RRC连接建立成功次数,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_RESOUR +
                   noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_TRPORT) ERAB建立拥塞次数,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_RESOUR) 无线资源拥塞次数,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_TRPORT) 传输资源拥塞次数,
               Sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_RNL) ERAB建立失败_UE无响应,
               Sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_OTH) ERAB建立失败_配置,
               AVG(noklte_PS_lepsb_lncel_day.ERAB_ADD_SETUP_FAIL_UP) AS E_RAB建立失败_核心网,
               AVG(noklte_PS_lepsb_lncel_day.ERAB_INI_SETUP_FAIL_RNL_RIP +
               noklte_PS_lepsb_lncel_day.ERAB_ADD_SETUP_FAIL_RNL_RIP) AS E_RAB建立失败_无线层 
          from noklte_PS_luest_lncel_day,
               noklte_PS_lepsb_lncel_day
          left join c_lte_custom c on noklte_PS_lepsb_lncel_day.lncel_id = c.lncel_objid     
         where  noklte_PS_luest_lncel_day.PERIOD_START_TIME = noklte_PS_lepsb_lncel_day.PERIOD_START_TIME
         and noklte_PS_luest_lncel_day.lncel_id= noklte_PS_lepsb_lncel_day.lncel_id
           and noklte_PS_luest_lncel_day.PERIOD_START_TIME >=
               to_date(&start_datetime, 'yyyymmddhh24')
           and noklte_PS_luest_lncel_day.PERIOD_START_TIME <
               to_date(&end_datetime, 'yyyymmddhh24')
         group by c.lnbtsid ,
                c.lncel_lcr_id,
                  noklte_PS_luest_lncel_day.PERIOD_START_TIME) tab2,
       (select c.lnbtsid as Lncel_Enb_Id,
       c.lncel_lcr_id as lncel_lcr_id,
               noklte_PS_lepsb_lncel_day.PERIOD_START_TIME pm_date,
               decode(sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_ATTEMPTS),
                      0,
                      0,
                      sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_COMPLETIONS) /
                      sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_ATTEMPTS)) ERAB建立成功率,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_COMPLETIONS) ERAB建立成功个数,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_ATTEMPTS) ERAB建立请求个数,
               DECODE(sum(EPC_EPS_BEARER_REL_REQ_RNL +
                          EPC_EPS_BEAR_REL_REQ_R_QCI1 + PRE_EMPT_GBR_BEARER +
                          PRE_EMPT_NON_GBR_BEARER +
                          ENB_EPS_BEARER_REL_REQ_RNL +
                          ENB_EPS_BEARER_REL_REQ_TNL +
                          ENB_EPS_BEARER_REL_REQ_OTH +
                          ENB_EPS_BEARER_REL_REQ_NORM +
                          ENB_EPSBEAR_REL_REQ_RNL_REDIR +
                          EPC_EPS_BEARER_REL_REQ_NORM +
                          EPC_EPS_BEARER_REL_REQ_DETACH +
                          ERAB_REL_ENB_ACT_NON_GBR),
                      0,
                      0,
                      round(100 *
                            sum(EPC_EPS_BEARER_REL_REQ_RNL +
                                EPC_EPS_BEAR_REL_REQ_R_QCI1 +
                                PRE_EMPT_GBR_BEARER + PRE_EMPT_NON_GBR_BEARER +
                                ENB_EPS_BEARER_REL_REQ_RNL +
                                ENB_EPS_BEARER_REL_REQ_TNL +
                                ENB_EPS_BEARER_REL_REQ_OTH) /
                            sum(EPC_EPS_BEARER_REL_REQ_RNL +
                                EPC_EPS_BEAR_REL_REQ_R_QCI1 +
                                PRE_EMPT_GBR_BEARER + PRE_EMPT_NON_GBR_BEARER +
                                ENB_EPS_BEARER_REL_REQ_RNL +
                                ENB_EPS_BEARER_REL_REQ_TNL +
                                ENB_EPS_BEARER_REL_REQ_OTH +
                                ENB_EPS_BEARER_REL_REQ_NORM +
                                ENB_EPSBEAR_REL_REQ_RNL_REDIR +
                                EPC_EPS_BEARER_REL_REQ_NORM +
                                EPC_EPS_BEARER_REL_REQ_DETACH +
                                ERAB_REL_ENB_ACT_NON_GBR),
                            8)) LTE业务掉线率,
               sum(EPC_EPS_BEARER_REL_REQ_RNL + EPC_EPS_BEAR_REL_REQ_R_QCI1 +
                   PRE_EMPT_GBR_BEARER + PRE_EMPT_NON_GBR_BEARER +
                   ENB_EPS_BEARER_REL_REQ_RNL + ENB_EPS_BEARER_REL_REQ_TNL +
                   ENB_EPS_BEARER_REL_REQ_OTH) LTE业务掉线次数,
               sum(noklte_PS_lepsb_lncel_day.EPC_EPS_BEARER_REL_REQ_RNL) EPC_EPS_BEARER_REL_REQ_RNL,
               sum(noklte_PS_lepsb_lncel_day.EPC_EPS_BEARER_REL_REQ_OTH) EPC_EPS_BEARER_REL_REQ_OTH,
               sum(noklte_PS_lepsb_lncel_day.ENB_EPS_BEARER_REL_REQ_RNL) ENB_EPS_BEARER_REL_REQ_RNL,
               sum(noklte_PS_lepsb_lncel_day.ENB_EPS_BEARER_REL_REQ_TNL) ENB_EPS_BEARER_REL_REQ_TNL,
               sum(noklte_PS_lepsb_lncel_day.ENB_EPS_BEARER_REL_REQ_OTH) ENB_EPS_BEARER_REL_REQ_OTH,
               sum(noklte_PS_lepsb_lncel_day.EPC_EPS_BEAR_REL_REQ_R_QCI1) EPC_EPS_BEAR_REL_REQ_R_QCI1,
               sum(EPC_EPS_BEARER_REL_REQ_RNL + EPC_EPS_BEAR_REL_REQ_R_QCI1 +
                   PRE_EMPT_GBR_BEARER + PRE_EMPT_NON_GBR_BEARER +
                   ENB_EPS_BEARER_REL_REQ_RNL + ENB_EPS_BEARER_REL_REQ_TNL +
                   ENB_EPS_BEARER_REL_REQ_OTH + ENB_EPS_BEARER_REL_REQ_NORM +
                   ENB_EPSBEAR_REL_REQ_RNL_REDIR +
                   EPC_EPS_BEARER_REL_REQ_NORM +
                   EPC_EPS_BEARER_REL_REQ_DETACH + ERAB_REL_ENB_ACT_NON_GBR) LTE业务释放次数
          from 
                noklte_PS_lepsb_lncel_day
                left join c_lte_custom c on noklte_PS_lepsb_lncel_day.LNCEL_ID = c.lncel_objid 
         where  
               noklte_PS_lepsb_lncel_day.PERIOD_START_TIME >=
               to_date(&start_datetime, 'yyyymmddhh24')
           and noklte_PS_lepsb_lncel_day.PERIOD_START_TIME <
               to_date(&end_datetime, 'yyyymmddhh24')
         group by c.lnbtsid, 
                  c.lncel_lcr_id,
                  noklte_PS_lepsb_lncel_day.PERIOD_START_TIME) tab3,
       (select c.lnbtsid as Lncel_Enb_Id,
                c.lncel_lcr_id as lncel_lcr_id,
               noklte_PS_lcellt_lncel_day.PERIOD_START_TIME pm_date,
               decode(sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_UL),
                      0,
                      0,
                      sum(NOKLTE_PS_LCELLT_LNCEL_day.PDCP_SDU_VOL_UL) * 8 * 1000 /
                      sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_UL * 1024)) as 空口上行业务平均速率,
               SUM(PDCP_SDU_VOL_UL) / 1024 as 空口上行业务字节数,
               sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_UL) as ACTIVE_TTI_UL,
               decode(sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_DL),
                      0,
                      0,
                      sum(NOKLTE_PS_LCELLT_LNCEL_day.PDCP_SDU_VOL_DL) * 8 * 1000 /
                      sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_DL * 1024)) as 空口下行业务平均速率,
               SUM(PDCP_SDU_VOL_DL) / 1024 as 空口下行业务字节数,
               sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_DL) as ACTIVE_TTI_DL
          from 
                noklte_PS_lcellt_lncel_day
                inner join c_lte_custom c on noklte_PS_lcellt_lncel_day.LNCEL_ID = c.lncel_objid
         where 
               noklte_PS_lcellt_lncel_day.PERIOD_START_TIME >=
               to_date(&start_datetime, 'yyyymmddhh24')
           and noklte_PS_lcellt_lncel_day.PERIOD_START_TIME <
               to_date(&end_datetime, 'yyyymmddhh24')
         group by c.lnbtsid ,
                   c.lncel_lcr_id,
                  noklte_PS_lcellt_lncel_day.PERIOD_START_TIME) tab4,
       (
       select lncel.lncel_enb_id,
               lncel.lncel_lcr_id,
               NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_START_TIME pm_date,
               decode((sum(decode(lncel.LNCEL_CH_BW,
                                  '',
                                  0,
                                  lncel.LNCEL_CH_BW) +
                           decode(lncel.LNCEL_UL_CH_BW,
                                  '',
                                  0,
                                  lncel.LNCEL_UL_CH_BW)) / 2),
                      0,
                      0,
                      decode(sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000),
                             0,
                             0,
                             sum(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_PUSCH) /
                             sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000)) /
                      (sum(decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                           decode(lncel.LNCEL_TDD_FRAME_CONF, 1, 0.4, 0.2) +
                           decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) / 35 +
                           decode(lncel.LNCEL_UL_CH_BW,
                                  '',
                                  0,
                                  lncel.LNCEL_UL_CH_BW)) / 2)) 上行PRB平均利用率,
               sum(decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                   decode(lncel.LNCEL_TDD_FRAME_CONF, 1, 0.4, 0.2) +
                   decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) / 35 +
                   decode(lncel.LNCEL_UL_CH_BW, '', 0, lncel.LNCEL_UL_CH_BW)) / 2 上行PRB可用数,
               decode(sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000),
                      0,
                      0,
                      sum(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_PUSCH) /
                      sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000)) as 上行PRB占用平均数,
               decode((sum(decode(lncel.LNCEL_CH_BW,
                                  '',
                                  0,
                                  lncel.LNCEL_CH_BW) +
                           decode(lncel.LNCEL_DL_CH_BW,
                                  '',
                                  0,
                                  lncel.LNCEL_DL_CH_BW)) / 2),
                      0,
                      0,
                      decode(sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000),
                             0,
                             0,
                             sum(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_PDSCH) /
                             sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000)) /
                      (sum(decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                           decode(lncel.LNCEL_TDD_FRAME_CONF, 1, 0.4, 0.6) +
                           decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                           decode(lncel.LNCEL_TSSC_296, 5, 0.0428, 0.1428) +
                           decode(lncel.LNCEL_DL_CH_BW,
                                  '',
                                  0,
                                  lncel.LNCEL_DL_CH_BW)) / 2)) 下行PRB平均利用率,
               sum(decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                   decode(lncel.LNCEL_TDD_FRAME_CONF, 1, 0.4, 0.6) +
                   decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                   decode(lncel.LNCEL_TSSC_296, 5, 0.0428, 0.1428) +
                   decode(lncel.LNCEL_DL_CH_BW, '', 0, lncel.LNCEL_DL_CH_BW)) / 2 AS 下行PRB可用数,
               decode(sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000),
                      0,
                      0,
                      sum(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_PDSCH) /
                      sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000)) as 下行PRB占用平均数,
                      SUM(NOKLTE_PS_LCELLR_LNCEL_day.AGG1_USED_PDCCH+2*NOKLTE_PS_LCELLR_LNCEL_day.AGG2_USED_PDCCH+4*NOKLTE_PS_LCELLR_LNCEL_day.AGG4_USED_PDCCH+8*NOKLTE_PS_LCELLR_LNCEL_day.AGG8_USED_PDCCH) as CCE占用,
        SUM(84*1000*60*NOKLTE_PS_LCELLR_LNCEL_day.period_duration)  as CCE可用,
        SUM(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_DL_TOTAL/(NOKLTE_PS_LCELLR_LNCEL_day.period_duration*60000)) AS  下行PRB资源使用个数,
        SUM(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_UL_TOTAL/(NOKLTE_PS_LCELLR_LNCEL_day.period_duration*60000)) AS  上行PRB资源使用个数
          from c_lte_lncel lncel,
               NOKLTE_PS_LCELLR_LNCEL_day,
               NOKLTE_PS_LCELLT_LNCEL_day
         where NOKLTE_PS_LCELLR_LNCEL_day.LNCEL_ID(+) = lncel.obj_gid
           and NOKLTE_PS_LCELLT_LNCEL_day.LNCEL_ID(+) = lncel.obj_gid
           and NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_START_TIME =
               NOKLTE_PS_LCELLT_LNCEL_day.PERIOD_START_TIME
           and lncel.conf_id = 1
           and NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_START_TIME >=
               to_date(&start_datetime, 'yyyymmddhh24')
           and NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_START_TIME <
               to_date(&end_datetime, 'yyyymmddhh24')
         group by LNCEL.Lncel_Enb_Id,
                  lncel.lncel_lcr_id,
                  NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_START_TIME
       
       ) tab5,
       (select c.lnbtsid as Lncel_Enb_Id,
                c.lncel_lcr_id as lncel_lcr_id,

               noklte_PS_lcelld_lncel_day.PERIOD_START_TIME pm_date,
               SUM(CELL_LOAD_ACT_UE_AVG) 平均激活用户数,
               MAX(CELL_LOAD_ACT_UE_MAX) 最大激活用户数,
               avg(RRC_CONN_UE_AVG) 平均RRC连接数_avg,
               sum(RRC_CONN_UE_AVG) 平均RRC连接数_sum,
               max(RRC_CONN_UE_MAX) 最大RRC连接数_max,
               sum(RRC_CONN_UE_MAX) 最大RRC连接数_sum
          from  
               noklte_PS_lcelld_lncel_day
               inner join c_lte_custom c on noklte_PS_lcelld_lncel_day.LNCEL_ID = c.lncel_objid
         where   noklte_PS_lcelld_lncel_day.PERIOD_START_TIME >=
               to_date(&start_datetime, 'yyyymmddhh24')
           and noklte_PS_lcelld_lncel_day.PERIOD_START_TIME <
               to_date(&end_datetime, 'yyyymmddhh24')
         group by c.lnbtsid,
                  c.lncel_lcr_id,
                  noklte_PS_lcelld_lncel_day.PERIOD_START_TIME
                ) tab6,
       (select c.lnbtsid as Lncel_Enb_Id,
               c.lncel_lcr_id as lncel_lcr_id,

               NOKLTE_PS_LUEST_LNCEL_Day.PERIOD_START_TIME pm_date,
               sum(NOKLTE_PS_LUEST_LNCEL_Day.SIGN_EST_F_RRCCOMPL_MISSING) as Setup_comp_miss无应答,
               sum(NOKLTE_PS_LUEST_LNCEL_Day.SIGN_EST_F_RRCCOMPL_ERROR) as Setup_comp_error小区拒绝,
               sum(NOKLTE_PS_LUEST_LNCEL_Day.SIGN_CONN_ESTAB_FAIL_RRMRAC) as Reject_RRM_RAC资源分配失
          from  
               NOKLTE_PS_LUEST_LNCEL_Day
               inner join c_lte_custom c on NOKLTE_PS_LUEST_LNCEL_Day.LNCEL_ID = c.lncel_objid
         where  
               NOKLTE_PS_LUEST_LNCEL_Day.PERIOD_START_TIME >=
               to_date(&start_datetime, 'yyyymmddhh24')
           and NOKLTE_PS_LUEST_LNCEL_Day.PERIOD_START_TIME <
               to_date(&end_datetime, 'yyyymmddhh24')
         group by c.lnbtsid,
                c.lncel_lcr_id,
                  NOKLTE_PS_LUEST_LNCEL_Day.PERIOD_START_TIME
                  ) tab7,
       (select c.lnbtsid as Lncel_Enb_Id,
                c.lncel_lcr_id as lncel_lcr_id,
               p.PERIOD_START_TIME pm_date,
               decode(sum(p.rrc_con_re_estab_att),
                      0,
                      0,
                      sum(p.rrc_con_re_estab_succ) /
                      sum(p.rrc_con_re_estab_att)) RRC重建成功率， 
                      sum(p.rrc_con_re_estab_att) RRC重建次数,
               sum(p.rrc_con_re_estab_succ) RRC重建成功次数,
               sum(p.RRC_CON_RE_ESTAB_ATT_HO_FAIL) RRC重建尝试因HO原因,
               sum(p.RRC_CON_RE_ESTAB_SUCC_HO_FAIL) RRC重建成功因HO原因,
               sum(p.RRC_CON_RE_ESTAB_ATT_OTHER) RRC重建尝试因other原因,
               sum(p.RRC_CON_RE_ESTAB_SUCC_OTHER) RRC重建成功因other原因,
               avg(p.RRC_CON_STP_TIM_MEAN) AS RRC建立平均时延, 
               max(p.RRC_CON_STP_TIM_MAX) AS RRC建立最大时延
          from  
               NOKLTE_PS_LRRC_LNCEL_day p
               inner join c_lte_custom c on p.LNCEL_ID = c.lncel_objid
         where 
               p.PERIOD_START_TIME >=
               to_date(&start_datetime, 'yyyymmddhh24')
           and p.PERIOD_START_TIME < to_date(&end_datetime, 'yyyymmddhh24')
         group by c.lnbtsid  ,
                  c.lncel_lcr_id  ,
                  p.PERIOD_START_TIME
                  ) tab9,
                  
 (select c.lnbtsid as Lncel_Enb_Id,
         c.lncel_lcr_id as lncel_lcr_id,
         p.PERIOD_START_TIME pm_date, 
       avg(p.ERAB_SETUP_TIME_MEAN) AS E_RAB建立平均时延, 
       max(p.ERAB_SETUP_TIME_MAX) AS E_RAB建立最大时延
     from 
        NOKLTE_PS_LRDB_LNCEL_day p
        inner join c_lte_custom c on p.LNCEL_ID = c.lncel_objid
   where 
        p.PERIOD_START_TIME >= to_date(&start_datetime, 'yyyymmdd')
   and p.PERIOD_START_TIME < to_date(&end_datetime, 'yyyymmdd')
 group by 
        c.lnbtsid,  
         c.lncel_lcr_id ,
          p.PERIOD_START_TIME)tab12,                 
                  
 (select 
        c.lnbtsid as Lncel_Enb_Id,
         c.lncel_lcr_id as lncel_lcr_id,
        lepsb.PERIOD_START_TIME pm_date, 
        ROUND(DECODE(AVG(lepsb.DENOM_SUM_SIMUL_ERAB),0,NULL, AVG(lepsb.SUM_SIMUL_ERAB_QCI_1 + lepsb.SUM_SIMUL_ERAB_QCI_2 + lepsb.SUM_SIMUL_ERAB_QCI_3 + lepsb.SUM_SIMUL_ERAB_QCI_4 +   lepsb.SUM_SIMUL_ERAB_QCI_5 + lepsb.SUM_SIMUL_ERAB_QCI_6 +  lepsb.SUM_SIMUL_ERAB_QCI_7 + lepsb.SUM_SIMUL_ERAB_QCI_8 +   lepsb.SUM_SIMUL_ERAB_QCI_9) / AVG(lepsb.DENOM_SUM_SIMUL_ERAB)),8) AS  平均E_RAB数,
        ROUND(DECODE(AVG(lepsb.DENOM_SUM_SIMUL_ERAB * lcelld.CELL_LOAD_ACT_UE_AVG),0,NULL, AVG(lepsb.SUM_SIMUL_ERAB_QCI_1 + lepsb.SUM_SIMUL_ERAB_QCI_2 + lepsb.SUM_SIMUL_ERAB_QCI_3 + lepsb.SUM_SIMUL_ERAB_QCI_4 + lepsb.SUM_SIMUL_ERAB_QCI_5 + lepsb.SUM_SIMUL_ERAB_QCI_6 + lepsb.SUM_SIMUL_ERAB_QCI_7 + lepsb.SUM_SIMUL_ERAB_QCI_8 +   lepsb.SUM_SIMUL_ERAB_QCI_9) / AVG(lepsb.DENOM_SUM_SIMUL_ERAB * lcelld.CELL_LOAD_ACT_UE_AVG)),8)  AS  每用户平均E_RAB数,
        ROUND(decode(AVG(lcelld.DENOM_ACTIVE_UE_DATA_UL),0,null,AVG(lcelld.SUM_ACTIVE_UE_DATA_UL)/AVG(lcelld.DENOM_ACTIVE_UE_DATA_UL)),8) AS 上行激活E_RAB数,
        ROUND(decode(AVG(lcelld.DENOM_ACTIVE_UE_DATA_DL),0,null,AVG(lcelld.SUM_ACTIVE_UE_DATA_DL)/AVG(lcelld.DENOM_ACTIVE_UE_DATA_DL)),8) AS 下行激活E_RAB数
        FROM
        NOKLTE_PS_LEPSB_LNCEL_day lepsb         
        INNER JOIN NOKLTE_PS_LCELLD_LNCEL_day lcelld ON lepsb.lncel_id = lcelld.lncel_id  
        and  lepsb.period_start_time = lcelld.period_start_time  
        and  lcelld.PERIOD_START_TIME >=To_Date(&start_datetime, 'yyyymmdd')
        and  lcelld.PERIOD_START_TIME <To_Date(&end_datetime, 'yyyymmdd') 
        left join c_lte_custom c on lepsb.LNCEL_ID = c.lncel_objid       
    WHERE
    lepsb.PERIOD_START_TIME >=To_Date(&start_datetime, 'yyyymmdd')
    and lepsb.PERIOD_START_TIME <To_Date(&end_datetime, 'yyyymmdd') 
    group by 
    
          c.lnbtsid  ,
         c.lncel_lcr_id ,
          lepsb.PERIOD_START_TIME ) tab10,
          
          
 ( SELECT 
        c.lnbtsid as Lncel_Enb_Id,
         c.lncel_lcr_id as lncel_lcr_id,
       p.PERIOD_START_TIME pm_date,          
        decode(AVG(p.AVG_TRANS_PWR),0,0,10*log(10,AVG(p.AVG_TRANS_PWR))) AS 小区平均发射功率, 
        decode(MAX(p.MAX_TRANS_PWR),0,0,10*log(10,MAX(p.MAX_TRANS_PWR))) AS 小区最大发射功率     
   FROM
         NOKLTE_PS_LPQDL_LNCEL_day p
         left join c_lte_custom c on p.LNCEL_ID = c.lncel_objid 
   WHERE 
       p.PERIOD_START_TIME >= to_date(&start_datetime, 'yyyymmdd')
   and p.PERIOD_START_TIME < to_date(&end_datetime, 'yyyymmdd')        
   GROUP BY 
   
          c.lnbtsid,
          c.lncel_lcr_id ,
          p.PERIOD_START_TIME
                ) tab11,                 
                  
                  
                  
                  
                  
                  
       (select         count(distinct c.lnbtsid) as 基站数,
               count(distinct c.lnbtsid * c.lncel_lcr_id) as 小区数,
               noklte_PS_lcelav_lncel_day.PERIOD_START_TIME as pm_date,
               c.city||c.netmodel as 区域
      
         from
               noklte_PS_lcelav_lncel_day
               inner join c_lte_custom c on noklte_PS_lcelav_lncel_day.LNCEL_ID = c.lncel_objid
         where
         
               noklte_PS_lcelav_lncel_day.PERIOD_START_TIME >=to_date(&start_datetime, 'yyyymmddhh24')
           and noklte_PS_lcelav_lncel_day.PERIOD_START_TIME < to_date(&end_datetime, 'yyyymmddhh24')
           
         group by
               c.city||c.netmodel,
               noklte_PS_lcelav_lncel_day.PERIOD_START_TIME) tab8                
           
 where tab1.Lncel_Enb_Id = tab2.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab2.lncel_lcr_id(+)
   and tab1.pm_date = tab2.pm_date(+)
   and tab1.Lncel_Enb_Id = tab3.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab3.lncel_lcr_id(+)
   and tab1.pm_date = tab3.pm_date(+)
   and tab1.Lncel_Enb_Id = tab4.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab4.lncel_lcr_id(+)
   and tab1.pm_date = tab4.pm_date(+)
   and tab1.Lncel_Enb_Id = tab5.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab5.lncel_lcr_id(+)
   and tab1.pm_date = tab5.pm_date(+)
   and tab1.Lncel_Enb_Id = tab6.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab6.lncel_lcr_id(+)
   and tab1.pm_date = tab6.pm_date(+)
   and tab1.Lncel_Enb_Id = tab7.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab7.lncel_lcr_id(+)
   and tab1.pm_date = tab7.pm_date(+)
   and tab1.Lncel_Enb_Id = tab9.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab9.lncel_lcr_id(+)
   and tab1.pm_date = tab9.pm_date(+)
   and tab1.Lncel_Enb_Id = tab12.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab12.lncel_lcr_id(+)
   and tab1.pm_date = tab12.pm_date(+)   
   and tab1.Lncel_Enb_Id = tab10.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab10.lncel_lcr_id(+)
   and tab1.pm_date = tab10.pm_date(+)  
   and tab1.Lncel_Enb_Id = tab11.Lncel_Enb_Id(+)
   and tab1.lncel_lcr_id = tab11.lncel_lcr_id(+)
   and tab1.pm_date = tab11.pm_date(+) 
   and tab1.区域 = tab8.区域
   and tab1.pm_date = tab8.pm_date(+)
 group by 
    to_char(tab1.pm_date, 'yyyymmdd'),       
          tab1.LNCEL_ENB_ID,
          tab1.LNBTS_ENB_NAME,
          tab1.LNCEL_LCR_ID,
          (CASE
                   WHEN ( tab1.区域 = 'BaojiFDD' ) THEN '宝鸡FDD'
                   WHEN ( tab1.区域 = 'BaojiTDD' ) THEN '宝鸡TDD'
                   WHEN ( tab1.区域 = 'XianFDD' ) THEN '西安FDD'
                   WHEN ( tab1.区域 = 'XianTDD' ) THEN '西安TDD'    
                   WHEN ( tab1.区域 = 'XianyangFDD' ) THEN '咸阳FDD'
                   WHEN ( tab1.区域 = 'YananTDD' ) THEN '延安FDD' 
                   WHEN ( tab1.区域 = 'YulinTDD' ) THEN '榆林FDD'                   
                   ELSE NULL
               END),
          基站数,小区数
having round(decode(sum(tab3.LTE业务释放次数), 0, 0, sum(tab3.LTE业务掉线次数) / sum(tab3.LTE业务释放次数)) * 100, 2) >= 0.5
 and sum(tab3.LTE业务掉线次数) > = 100
  