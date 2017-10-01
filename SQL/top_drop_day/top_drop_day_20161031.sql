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
       sum(ERAB建立拥塞次数) AS ERAB拥塞_无线资源受限,
       sum(无线资源拥塞次数) AS ERAB拥塞_传输资源拥塞,
       sum(ERAB建立失败_UE无响应) AS ERAB建立失败_UE无响应,
       sum(ERAB建立失败_配置) AS ERAB建立失败_配置原因,
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
       round(sum(tab6.平均激活用户数), 0) as 平均激活用户数,
       round(sum(tab6.最大激活用户数), 0) as 最大激活用户数
  from (select c.lnbtsid as Lncel_Enb_Id,
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
               Sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_OTH) ERAB建立失败_配置
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
                      sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000)) as 下行PRB占用平均数
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
                      sum(p.rrc_con_re_estab_att)) RRC重建成功率， sum(p.rrc_con_re_estab_att) RRC重建次数,
               sum(p.rrc_con_re_estab_succ) RRC重建成功次数,
               sum(p.RRC_CON_RE_ESTAB_ATT_HO_FAIL) RRC重建尝试因HO原因,
               sum(p.RRC_CON_RE_ESTAB_SUCC_HO_FAIL) RRC重建成功因HO原因,
               sum(p.RRC_CON_RE_ESTAB_ATT_OTHER) RRC重建尝试因other原因,
               sum(p.RRC_CON_RE_ESTAB_SUCC_OTHER) RRC重建成功因other原因
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
   and tab1.区域 = tab8.区域
   and tab1.pm_date = tab8.pm_date(+)
 group by to_char(tab1.pm_date, 'yyyymmdd'),
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
          基站数,
          小区数
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
       sum(ERAB建立拥塞次数) AS ERAB拥塞_无线资源受限,
       sum(无线资源拥塞次数) AS ERAB拥塞_传输资源拥塞,
       sum(ERAB建立失败_UE无响应) AS ERAB建立失败_UE无响应,
       sum(ERAB建立失败_配置) AS ERAB建立失败_配置原因,
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
       round(sum(tab6.平均激活用户数), 0) as 平均激活用户数,
       round(sum(tab6.最大激活用户数), 0) as 最大激活用户数
  from (select c.lnbtsid as Lncel_Enb_Id,
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
               Sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_OTH) ERAB建立失败_配置
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
                      sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000)) as 下行PRB占用平均数
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
                      sum(p.rrc_con_re_estab_att)) RRC重建成功率， sum(p.rrc_con_re_estab_att) RRC重建次数,
               sum(p.rrc_con_re_estab_succ) RRC重建成功次数,
               sum(p.RRC_CON_RE_ESTAB_ATT_HO_FAIL) RRC重建尝试因HO原因,
               sum(p.RRC_CON_RE_ESTAB_SUCC_HO_FAIL) RRC重建成功因HO原因,
               sum(p.RRC_CON_RE_ESTAB_ATT_OTHER) RRC重建尝试因other原因,
               sum(p.RRC_CON_RE_ESTAB_SUCC_OTHER) RRC重建成功因other原因
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
   and tab1.区域 = tab8.区域
   and tab1.pm_date = tab8.pm_date(+)
 group by to_char(tab1.pm_date, 'yyyymmdd'),
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
          基站数,
          小区数
having round(decode(sum(tab3.LTE业务释放次数), 0, 0, sum(tab3.LTE业务掉线次数) / sum(tab3.LTE业务释放次数)) * 100, 2) >= 0.5
 and sum(tab3.LTE业务掉线次数) > = 100
  