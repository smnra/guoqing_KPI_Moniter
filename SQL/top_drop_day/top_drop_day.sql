SELECT to_char(tab1.pm_date, 'yyyymmdd') DDATE,
       tab1.LNCEL_ENB_ID AS ENB_ID,
       tab1.LNBTS_ENB_NAME AS eNodeB����,
       tab1.LNCEL_LCR_ID AS CELL_ID,
       tab1.LNCEL_ENB_ID * 100 + tab1.LNCEL_LCR_ID as ECI,
       (CASE
                   WHEN ( tab1.���� = 'BaojiFDD' ) THEN '����FDD'
                   WHEN ( tab1.���� = 'BaojiTDD' ) THEN '����TDD'
                   WHEN ( tab1.���� = 'XianFDD' ) THEN '����FDD'
                   WHEN ( tab1.���� = 'XianTDD' ) THEN '����TDD'    
                   WHEN ( tab1.���� = 'XianyangFDD' ) THEN '����FDD'
                   WHEN ( tab1.���� = 'YananTDD' ) THEN '�Ӱ�FDD' 
                   WHEN ( tab1.���� = 'YulinTDD' ) THEN '����FDD'                   
                   ELSE NULL
               END) as ����,
       ��վ��,
       С����,
       sum(tab1.LTEС�������ʷ���) as LTEС�������ʷ���,
       sum(tab1.LTEС�������ʷ�ĸ) as LTEС�������ʷ�ĸ,
       round(decode(sum(tab1.LTEС�������ʷ�ĸ),
                    0,
                    0,
                    sum(tab1.LTEС�������ʷ���) / sum(tab1.LTEС�������ʷ�ĸ) * 100),
             2) as LTEС��������,
       round(avg(tab1.LTEС���˷�ʱ��), 2) as LTEС��ƽ���˷�ʱ��s,
       round(sum(tab1.LTEС���˷�ʱ��), 2) as LTEС�����˷�ʱ��s,
       round((decode(sum(tab2.RRC���ӽ����������),
                     0,
                     0,
                     sum(tab2.RRC���ӽ����ɹ�����) / sum(tab2.RRC���ӽ����������))) *
             (decode(SUM(tab3.ERAB�����������),
                     0,
                     0,
                     sum(tab3.ERAB�����ɹ�����) / SUM(tab3.ERAB�����������))) * 100,
             2) AS ���߽�ͨ��,
       round(decode(sum(tab2.RRC���ӽ����������),
                    0,
                    0,
                    sum(tab2.RRC���ӽ����ɹ�����) / sum(tab2.RRC���ӽ����������)) * 100,
             2) AS RRC���ӽ����ɹ���,
       sum(tab2.RRC���ӽ����������) AS RRC���ӽ����������,
       sum(tab2.RRC���ӽ����ɹ�����) AS RRC���ӽ����ɹ�����,
      ROUND(avg(RRC����ƽ��ʱ��),0) AS RRC����ƽ��ʱ��,
      ROUND(max(RRC�������ʱ��),0) AS RRC�������ʱ��,
      sum(Setup_comp_miss��Ӧ��) AS Setup_comp_miss��Ӧ��,
      sum(Setup_comp_errorС���ܾ�) AS Setup_comp_errorС���ܾ�,
      sum(Reject_RRM_RAC��Դ����ʧ) AS Reject_RRM_RAC��Դ����ʧ,
      round(avg(RRC�ؽ��ɹ���),2) as RRC�ؽ��ɹ���,
      sum(RRC�ؽ�����) as RRC�ؽ�����,
      sum(RRC�ؽ��ɹ�����) as RRC�ؽ��ɹ�����,
      sum(RRC�ؽ�������HOԭ��) as RRC�ؽ�������HOԭ��,
      sum(RRC�ؽ��ɹ���HOԭ��) as RRC�ؽ��ɹ���HOԭ��,
      sum(RRC�ؽ�������otherԭ��) as RRC�ؽ�������otherԭ��,
      sum(RRC�ؽ��ɹ���otherԭ��) as RRC�ؽ��ɹ���otherԭ��,
      
       round(decode(SUM(tab3.ERAB�����������),
                    0,
                    0,
                    sum(tab3.ERAB�����ɹ�����) / SUM(tab3.ERAB�����������)) * 100,
             2) AS ERAB�����ɹ���,
       sum(tab3.ERAB�����������) AS ERAB�����������,
       sum(tab3.ERAB�����ɹ�����) AS ERAB�����ɹ�����,
       ROUND(avg(E_RAB����ƽ��ʱ��),0) AS E_RAB����ƽ��ʱ��,
       ROUND(max(E_RAB�������ʱ��),0) AS E_RAB�������ʱ��,
       sum(������Դӵ������) AS  ERABӵ��_������Դ����,
       sum(������Դӵ������) AS ERABʧ��_�����,
       sum(ERAB����ʧ��_UE����Ӧ) AS ERAB����ʧ��_UE����Ӧ,
       sum(ERAB����ʧ��_����) AS ERAB����ʧ��_��ȫģʽ,
       ROUND(avg(E_RAB����ʧ��_������),0) AS E_RAB����ʧ��_������,
       ROUND(avg(E_RAB����ʧ��_���߲�),0) AS E_RAB����ʧ��_���߲�,
       round(decode(sum(tab3.LTEҵ���ͷŴ���),
                    0,
                    0,
                    sum(tab3.LTEҵ����ߴ���) / sum(tab3.LTEҵ���ͷŴ���)) * 100,
             2) as LTEҵ�������,
       sum(tab3.LTEҵ���ͷŴ���) AS LTEҵ���ͷŴ���,
       sum(tab3.LTEҵ����ߴ���) AS LTEҵ����ߴ���,
       sum(tab3.EPC_EPS_BEARER_REL_REQ_RNL) as MME�ͷŵ�ERAB�������,
       sum(tab3.ENB_EPS_BEARER_REL_REQ_RNL) as eNB�ͷŵ�ERAB�������,
       sum(tab3.ENB_EPS_BEARER_REL_REQ_OTH) as eNB�ͷŵ�ERAB��other,
       sum(tab3.ENB_EPS_BEARER_REL_REQ_TNL) as eNB�ͷŵ�ERAB�������,
       ROUND(AVG(EPC_EPS_BEAR_REL_REQ_R_QCI1),0) AS  E_RAB�쳣�ͷ�_����ӵ��, 
       round(sum(tab4.�տ�����ҵ���ֽ���) / 1024, 2) as �տ�����ҵ���ֽ���MB, ---MByte ��λ
       round(decode(sum(tab4.ACTIVE_TTI_UL),
                    0,
                    0,
                    (sum(tab4.�տ�����ҵ���ֽ���) * 1000 * 8) /
                    sum(tab4.ACTIVE_TTI_UL) / 1024),
             2) as �տ�����ҵ��ƽ������, ---Mbps��λ
       round(sum(tab4.�տ�����ҵ���ֽ���) / 1024, 2) as �տ�����ҵ���ֽ���MB, ---MKByte ��λ
       round(decode(sum(tab4.ACTIVE_TTI_DL),
                    0,
                    0,
                    (sum(tab4.�տ�����ҵ���ֽ���) * 1000 * 8) /
                    sum(tab4.ACTIVE_TTI_DL) / 1024),
             2) as �տ�����ҵ��ƽ������, ---Mbps��λ
       round(avg(tab5.����PRBƽ��������) * 100, 2) as ����PRBƽ��������,
       round(avg(tab5.����PRBƽ��������) * 100, 2) as ����PRBƽ��������,
       round(avg(tab6.ƽ��RRC������_avg), 2) ƽ��RRC������_avg,
       round(sum(tab6.ƽ��RRC������_sum), 2) ƽ��RRC������_sum,
       max(tab6.���RRC������_max) ���RRC������_max,
       max(tab6.���RRC������_sum) ���RRC������_sum,
      round(sum(tab5.����PRB������),2) as ����PRB��������,
 			round(sum(tab5.����PRBռ��ƽ����),2) as ����PRBռ������,
 			round(avg(tab5.����PRBռ��ƽ����),2) as ����PRBռ��ƽ����,
 			round(sum(tab5.����PRB������),2) as ����PRB��������,
 			round(sum(tab5.����PRBռ��ƽ����),2) as ����PRBռ������, 
 			round(avg(tab5.����PRBռ��ƽ����),2) as ����PRBռ��ƽ����, 
 			round(avg(tab5.����PRBƽ��������)/0.9/0.6/0.5*100,2) as ����������Դ������,
 			round(avg(tab5.����PRBƽ��������)/0.9/0.6/0.5*100,2) as ����������Դ������, 
      round(sum(tab6.ƽ�������û���), 0) as ƽ�������û���,
      round(sum(tab6.��󼤻��û���), 0) as ��󼤻��û���,
       round(avg(ƽ��E_RAB��), 2) as ƽ��E_RAB��,
 round(avg(ÿ�û�ƽ��E_RAB��), 2) as ÿ�û�ƽ��E_RAB��,
 round(avg(���м���E_RAB��), 2) as ���м���E_RAB��,
 round(avg(���м���E_RAB��), 2) as ���м���E_RAB��,
 round(sum(����PRB��Դʹ�ø���),0) as ����PRB��Դʹ�ø���,
 round(sum(����PRB��Դʹ�ø���),0) as ����PRB��Դʹ�ø���, 
 round(avg(CCEռ��),2) as CCEռ��,
 round(avg(CCE����),2) as CCE����,
 round(avg(С��ƽ�����书��),2) as С��ƽ�����书��,
 round(max(С������书��),0) as С������书�� 
  from 
        (select c.lnbtsid as Lncel_Enb_Id,
       c.lncel_lcr_id as lncel_lcr_id,
       c.lnbts_name as LNCEL_CELL_NAME,
       c.lnbts_name as LNBTS_ENB_NAME,
               noklte_PS_lcelav_lncel_day.PERIOD_START_TIME pm_date,
       c.city||c.netmodel as  ����,
               ROUND(DECODE(SUM(DENOM_CELL_AVAIL),
                            0,
                            0,
                            100 * SUM(SAMPLES_CELL_AVAIL) /
                            SUM(DENOM_CELL_AVAIL)),
                     2) AS LTEС��������,
               SUM(SAMPLES_CELL_AVAIL) LTEС�������ʷ���,
               SUM(DENOM_CELL_AVAIL) LTEС�������ʷ�ĸ,
               SUM(DENOM_CELL_AVAIL - SAMPLES_CELL_AVAIL) * 10 AS LTEС���˷�ʱ��
        
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
                      sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_ATTEMPTS)) ���߽�ͨ��,
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
                                 noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO))) RRC���ӽ����ɹ���,
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
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO)) RRC���ӽ����������,
               sum(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_COMP) RRC���ӽ����ɹ�����,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_RESOUR +
                   noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_TRPORT) ERAB����ӵ������,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_RESOUR) ������Դӵ������,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_TRPORT) ������Դӵ������,
               Sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_RNL) ERAB����ʧ��_UE����Ӧ,
               Sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_OTH) ERAB����ʧ��_����,
               AVG(noklte_PS_lepsb_lncel_day.ERAB_ADD_SETUP_FAIL_UP) AS E_RAB����ʧ��_������,
               AVG(noklte_PS_lepsb_lncel_day.ERAB_INI_SETUP_FAIL_RNL_RIP +
               noklte_PS_lepsb_lncel_day.ERAB_ADD_SETUP_FAIL_RNL_RIP) AS E_RAB����ʧ��_���߲� 
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
                      sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_ATTEMPTS)) ERAB�����ɹ���,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_COMPLETIONS) ERAB�����ɹ�����,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_ATTEMPTS) ERAB�����������,
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
                            8)) LTEҵ�������,
               sum(EPC_EPS_BEARER_REL_REQ_RNL + EPC_EPS_BEAR_REL_REQ_R_QCI1 +
                   PRE_EMPT_GBR_BEARER + PRE_EMPT_NON_GBR_BEARER +
                   ENB_EPS_BEARER_REL_REQ_RNL + ENB_EPS_BEARER_REL_REQ_TNL +
                   ENB_EPS_BEARER_REL_REQ_OTH) LTEҵ����ߴ���,
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
                   EPC_EPS_BEARER_REL_REQ_DETACH + ERAB_REL_ENB_ACT_NON_GBR) LTEҵ���ͷŴ���
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
                      sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_UL * 1024)) as �տ�����ҵ��ƽ������,
               SUM(PDCP_SDU_VOL_UL) / 1024 as �տ�����ҵ���ֽ���,
               sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_UL) as ACTIVE_TTI_UL,
               decode(sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_DL),
                      0,
                      0,
                      sum(NOKLTE_PS_LCELLT_LNCEL_day.PDCP_SDU_VOL_DL) * 8 * 1000 /
                      sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_DL * 1024)) as �տ�����ҵ��ƽ������,
               SUM(PDCP_SDU_VOL_DL) / 1024 as �տ�����ҵ���ֽ���,
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
                                  lncel.LNCEL_UL_CH_BW)) / 2)) ����PRBƽ��������,
               sum(decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                   decode(lncel.LNCEL_TDD_FRAME_CONF, 1, 0.4, 0.2) +
                   decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) / 35 +
                   decode(lncel.LNCEL_UL_CH_BW, '', 0, lncel.LNCEL_UL_CH_BW)) / 2 ����PRB������,
               decode(sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000),
                      0,
                      0,
                      sum(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_PUSCH) /
                      sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000)) as ����PRBռ��ƽ����,
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
                                  lncel.LNCEL_DL_CH_BW)) / 2)) ����PRBƽ��������,
               sum(decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                   decode(lncel.LNCEL_TDD_FRAME_CONF, 1, 0.4, 0.6) +
                   decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                   decode(lncel.LNCEL_TSSC_296, 5, 0.0428, 0.1428) +
                   decode(lncel.LNCEL_DL_CH_BW, '', 0, lncel.LNCEL_DL_CH_BW)) / 2 AS ����PRB������,
               decode(sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000),
                      0,
                      0,
                      sum(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_PDSCH) /
                      sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000)) as ����PRBռ��ƽ����,
                      SUM(NOKLTE_PS_LCELLR_LNCEL_day.AGG1_USED_PDCCH+2*NOKLTE_PS_LCELLR_LNCEL_day.AGG2_USED_PDCCH+4*NOKLTE_PS_LCELLR_LNCEL_day.AGG4_USED_PDCCH+8*NOKLTE_PS_LCELLR_LNCEL_day.AGG8_USED_PDCCH) as CCEռ��,
        SUM(84*1000*60*NOKLTE_PS_LCELLR_LNCEL_day.period_duration)  as CCE����,
        SUM(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_DL_TOTAL/(NOKLTE_PS_LCELLR_LNCEL_day.period_duration*60000)) AS  ����PRB��Դʹ�ø���,
        SUM(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_UL_TOTAL/(NOKLTE_PS_LCELLR_LNCEL_day.period_duration*60000)) AS  ����PRB��Դʹ�ø���
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
               SUM(CELL_LOAD_ACT_UE_AVG) ƽ�������û���,
               MAX(CELL_LOAD_ACT_UE_MAX) ��󼤻��û���,
               avg(RRC_CONN_UE_AVG) ƽ��RRC������_avg,
               sum(RRC_CONN_UE_AVG) ƽ��RRC������_sum,
               max(RRC_CONN_UE_MAX) ���RRC������_max,
               sum(RRC_CONN_UE_MAX) ���RRC������_sum
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
               sum(NOKLTE_PS_LUEST_LNCEL_Day.SIGN_EST_F_RRCCOMPL_MISSING) as Setup_comp_miss��Ӧ��,
               sum(NOKLTE_PS_LUEST_LNCEL_Day.SIGN_EST_F_RRCCOMPL_ERROR) as Setup_comp_errorС���ܾ�,
               sum(NOKLTE_PS_LUEST_LNCEL_Day.SIGN_CONN_ESTAB_FAIL_RRMRAC) as Reject_RRM_RAC��Դ����ʧ
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
                      sum(p.rrc_con_re_estab_att)) RRC�ؽ��ɹ��ʣ� 
                      sum(p.rrc_con_re_estab_att) RRC�ؽ�����,
               sum(p.rrc_con_re_estab_succ) RRC�ؽ��ɹ�����,
               sum(p.RRC_CON_RE_ESTAB_ATT_HO_FAIL) RRC�ؽ�������HOԭ��,
               sum(p.RRC_CON_RE_ESTAB_SUCC_HO_FAIL) RRC�ؽ��ɹ���HOԭ��,
               sum(p.RRC_CON_RE_ESTAB_ATT_OTHER) RRC�ؽ�������otherԭ��,
               sum(p.RRC_CON_RE_ESTAB_SUCC_OTHER) RRC�ؽ��ɹ���otherԭ��,
               avg(p.RRC_CON_STP_TIM_MEAN) AS RRC����ƽ��ʱ��, 
               max(p.RRC_CON_STP_TIM_MAX) AS RRC�������ʱ��
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
       avg(p.ERAB_SETUP_TIME_MEAN) AS E_RAB����ƽ��ʱ��, 
       max(p.ERAB_SETUP_TIME_MAX) AS E_RAB�������ʱ��
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
        ROUND(DECODE(AVG(lepsb.DENOM_SUM_SIMUL_ERAB),0,NULL, AVG(lepsb.SUM_SIMUL_ERAB_QCI_1 + lepsb.SUM_SIMUL_ERAB_QCI_2 + lepsb.SUM_SIMUL_ERAB_QCI_3 + lepsb.SUM_SIMUL_ERAB_QCI_4 +   lepsb.SUM_SIMUL_ERAB_QCI_5 + lepsb.SUM_SIMUL_ERAB_QCI_6 +  lepsb.SUM_SIMUL_ERAB_QCI_7 + lepsb.SUM_SIMUL_ERAB_QCI_8 +   lepsb.SUM_SIMUL_ERAB_QCI_9) / AVG(lepsb.DENOM_SUM_SIMUL_ERAB)),8) AS  ƽ��E_RAB��,
        ROUND(DECODE(AVG(lepsb.DENOM_SUM_SIMUL_ERAB * lcelld.CELL_LOAD_ACT_UE_AVG),0,NULL, AVG(lepsb.SUM_SIMUL_ERAB_QCI_1 + lepsb.SUM_SIMUL_ERAB_QCI_2 + lepsb.SUM_SIMUL_ERAB_QCI_3 + lepsb.SUM_SIMUL_ERAB_QCI_4 + lepsb.SUM_SIMUL_ERAB_QCI_5 + lepsb.SUM_SIMUL_ERAB_QCI_6 + lepsb.SUM_SIMUL_ERAB_QCI_7 + lepsb.SUM_SIMUL_ERAB_QCI_8 +   lepsb.SUM_SIMUL_ERAB_QCI_9) / AVG(lepsb.DENOM_SUM_SIMUL_ERAB * lcelld.CELL_LOAD_ACT_UE_AVG)),8)  AS  ÿ�û�ƽ��E_RAB��,
        ROUND(decode(AVG(lcelld.DENOM_ACTIVE_UE_DATA_UL),0,null,AVG(lcelld.SUM_ACTIVE_UE_DATA_UL)/AVG(lcelld.DENOM_ACTIVE_UE_DATA_UL)),8) AS ���м���E_RAB��,
        ROUND(decode(AVG(lcelld.DENOM_ACTIVE_UE_DATA_DL),0,null,AVG(lcelld.SUM_ACTIVE_UE_DATA_DL)/AVG(lcelld.DENOM_ACTIVE_UE_DATA_DL)),8) AS ���м���E_RAB��
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
        decode(AVG(p.AVG_TRANS_PWR),0,0,10*log(10,AVG(p.AVG_TRANS_PWR))) AS С��ƽ�����书��, 
        decode(MAX(p.MAX_TRANS_PWR),0,0,10*log(10,MAX(p.MAX_TRANS_PWR))) AS С������书��     
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
                  
                  
                  
                  
                  
                  
       (select         count(distinct c.lnbtsid) as ��վ��,
               count(distinct c.lnbtsid * c.lncel_lcr_id) as С����,
               noklte_PS_lcelav_lncel_day.PERIOD_START_TIME as pm_date,
               c.city||c.netmodel as ����
      
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
   and tab1.���� = tab8.����
   and tab1.pm_date = tab8.pm_date(+)
 group by 
    to_char(tab1.pm_date, 'yyyymmdd'),       
          tab1.LNCEL_ENB_ID,
          tab1.LNBTS_ENB_NAME,
          tab1.LNCEL_LCR_ID,
          (CASE
                   WHEN ( tab1.���� = 'BaojiFDD' ) THEN '����FDD'
                   WHEN ( tab1.���� = 'BaojiTDD' ) THEN '����TDD'
                   WHEN ( tab1.���� = 'XianFDD' ) THEN '����FDD'
                   WHEN ( tab1.���� = 'XianTDD' ) THEN '����TDD'    
                   WHEN ( tab1.���� = 'XianyangFDD' ) THEN '����FDD'
                   WHEN ( tab1.���� = 'YananTDD' ) THEN '�Ӱ�FDD' 
                   WHEN ( tab1.���� = 'YulinTDD' ) THEN '����FDD'                   
                   ELSE NULL
          END),
          ��վ��,С����
having round(decode(sum(tab3.LTEҵ���ͷŴ���), 0, 0, sum(tab3.LTEҵ����ߴ���) / sum(tab3.LTEҵ���ͷŴ���)) * 100, 2) >= 1.5 and sum(tab3.LTEҵ����ߴ���) > = 30 and sum(tab3.LTEҵ����ߴ���) < 100







union
SELECT to_char(tab1.pm_date, 'yyyymmdd') DDATE,
       tab1.LNCEL_ENB_ID AS ENB_ID,
       tab1.LNBTS_ENB_NAME AS eNodeB����,
       tab1.LNCEL_LCR_ID AS CELL_ID,
       tab1.LNCEL_ENB_ID * 100 + tab1.LNCEL_LCR_ID as ECI,
       (CASE
                   WHEN ( tab1.���� = 'BaojiFDD' ) THEN '����FDD'
                   WHEN ( tab1.���� = 'BaojiTDD' ) THEN '����TDD'
                   WHEN ( tab1.���� = 'XianFDD' ) THEN '����FDD'
                   WHEN ( tab1.���� = 'XianTDD' ) THEN '����TDD'    
                   WHEN ( tab1.���� = 'XianyangFDD' ) THEN '����FDD'
                   WHEN ( tab1.���� = 'YananTDD' ) THEN '�Ӱ�FDD' 
                   WHEN ( tab1.���� = 'YulinTDD' ) THEN '����FDD'                   
                   ELSE NULL
        END) as ����,
       ��վ��,
       С����,
       sum(tab1.LTEС�������ʷ���) as LTEС�������ʷ���,
       sum(tab1.LTEС�������ʷ�ĸ) as LTEС�������ʷ�ĸ,
       round(decode(sum(tab1.LTEС�������ʷ�ĸ),
                    0,
                    0,
                    sum(tab1.LTEС�������ʷ���) / sum(tab1.LTEС�������ʷ�ĸ) * 100),
             2) as LTEС��������,
       round(avg(tab1.LTEС���˷�ʱ��), 2) as LTEС��ƽ���˷�ʱ��s,
       round(sum(tab1.LTEС���˷�ʱ��), 2) as LTEС�����˷�ʱ��s,
       round((decode(sum(tab2.RRC���ӽ����������),
                     0,
                     0,
                     sum(tab2.RRC���ӽ����ɹ�����) / sum(tab2.RRC���ӽ����������))) *
             (decode(SUM(tab3.ERAB�����������),
                     0,
                     0,
                     sum(tab3.ERAB�����ɹ�����) / SUM(tab3.ERAB�����������))) * 100,
             2) AS ���߽�ͨ��,
       round(decode(sum(tab2.RRC���ӽ����������),
                    0,
                    0,
                    sum(tab2.RRC���ӽ����ɹ�����) / sum(tab2.RRC���ӽ����������)) * 100,
             2) AS RRC���ӽ����ɹ���,
       sum(tab2.RRC���ӽ����������) AS RRC���ӽ����������,
       sum(tab2.RRC���ӽ����ɹ�����) AS RRC���ӽ����ɹ�����,
      ROUND(avg(RRC����ƽ��ʱ��),0) AS RRC����ƽ��ʱ��,
      ROUND(max(RRC�������ʱ��),0) AS RRC�������ʱ��,
      sum(Setup_comp_miss��Ӧ��) AS Setup_comp_miss��Ӧ��,
      sum(Setup_comp_errorС���ܾ�) AS Setup_comp_errorС���ܾ�,
      sum(Reject_RRM_RAC��Դ����ʧ) AS Reject_RRM_RAC��Դ����ʧ,
      round(avg(RRC�ؽ��ɹ���),2) as RRC�ؽ��ɹ���,
      sum(RRC�ؽ�����) as RRC�ؽ�����,
      sum(RRC�ؽ��ɹ�����) as RRC�ؽ��ɹ�����,
      sum(RRC�ؽ�������HOԭ��) as RRC�ؽ�������HOԭ��,
      sum(RRC�ؽ��ɹ���HOԭ��) as RRC�ؽ��ɹ���HOԭ��,
      sum(RRC�ؽ�������otherԭ��) as RRC�ؽ�������otherԭ��,
      sum(RRC�ؽ��ɹ���otherԭ��) as RRC�ؽ��ɹ���otherԭ��,
      
       round(decode(SUM(tab3.ERAB�����������),
                    0,
                    0,
                    sum(tab3.ERAB�����ɹ�����) / SUM(tab3.ERAB�����������)) * 100,
             2) AS ERAB�����ɹ���,
       sum(tab3.ERAB�����������) AS ERAB�����������,
       sum(tab3.ERAB�����ɹ�����) AS ERAB�����ɹ�����,
       ROUND(avg(E_RAB����ƽ��ʱ��),0) AS E_RAB����ƽ��ʱ��,
       ROUND(max(E_RAB�������ʱ��),0) AS E_RAB�������ʱ��,
       sum(������Դӵ������) AS  ERABӵ��_������Դ����,
       sum(������Դӵ������) AS ERABʧ��_�����,
       sum(ERAB����ʧ��_UE����Ӧ) AS ERAB����ʧ��_UE����Ӧ,
       sum(ERAB����ʧ��_����) AS ERAB����ʧ��_��ȫģʽ,
       ROUND(avg(E_RAB����ʧ��_������),0) AS E_RAB����ʧ��_������,
       ROUND(avg(E_RAB����ʧ��_���߲�),0) AS E_RAB����ʧ��_���߲�,
       round(decode(sum(tab3.LTEҵ���ͷŴ���),
                    0,
                    0,
                    sum(tab3.LTEҵ����ߴ���) / sum(tab3.LTEҵ���ͷŴ���)) * 100,
             2) as LTEҵ�������,
       sum(tab3.LTEҵ���ͷŴ���) AS LTEҵ���ͷŴ���,
       sum(tab3.LTEҵ����ߴ���) AS LTEҵ����ߴ���,
       sum(tab3.EPC_EPS_BEARER_REL_REQ_RNL) as MME�ͷŵ�ERAB�������,
       sum(tab3.ENB_EPS_BEARER_REL_REQ_RNL) as eNB�ͷŵ�ERAB�������,
       sum(tab3.ENB_EPS_BEARER_REL_REQ_OTH) as eNB�ͷŵ�ERAB��other,
       sum(tab3.ENB_EPS_BEARER_REL_REQ_TNL) as eNB�ͷŵ�ERAB�������,
       ROUND(AVG(EPC_EPS_BEAR_REL_REQ_R_QCI1),0) AS  E_RAB�쳣�ͷ�_����ӵ��, 
       round(sum(tab4.�տ�����ҵ���ֽ���) / 1024, 2) as �տ�����ҵ���ֽ���MB, ---MByte ��λ
       round(decode(sum(tab4.ACTIVE_TTI_UL),
                    0,
                    0,
                    (sum(tab4.�տ�����ҵ���ֽ���) * 1000 * 8) /
                    sum(tab4.ACTIVE_TTI_UL) / 1024),
             2) as �տ�����ҵ��ƽ������, ---Mbps��λ
       round(sum(tab4.�տ�����ҵ���ֽ���) / 1024, 2) as �տ�����ҵ���ֽ���MB, ---MKByte ��λ
       round(decode(sum(tab4.ACTIVE_TTI_DL),
                    0,
                    0,
                    (sum(tab4.�տ�����ҵ���ֽ���) * 1000 * 8) /
                    sum(tab4.ACTIVE_TTI_DL) / 1024),
             2) as �տ�����ҵ��ƽ������, ---Mbps��λ
       round(avg(tab5.����PRBƽ��������) * 100, 2) as ����PRBƽ��������,
       round(avg(tab5.����PRBƽ��������) * 100, 2) as ����PRBƽ��������,
       round(avg(tab6.ƽ��RRC������_avg), 2) ƽ��RRC������_avg,
       round(sum(tab6.ƽ��RRC������_sum), 2) ƽ��RRC������_sum,
       max(tab6.���RRC������_max) ���RRC������_max,
       max(tab6.���RRC������_sum) ���RRC������_sum,
      round(sum(tab5.����PRB������),2) as ����PRB��������,
 			round(sum(tab5.����PRBռ��ƽ����),2) as ����PRBռ������,
 			round(avg(tab5.����PRBռ��ƽ����),2) as ����PRBռ��ƽ����,
 			round(sum(tab5.����PRB������),2) as ����PRB��������,
 			round(sum(tab5.����PRBռ��ƽ����),2) as ����PRBռ������, 
 			round(avg(tab5.����PRBռ��ƽ����),2) as ����PRBռ��ƽ����, 
 			round(avg(tab5.����PRBƽ��������)/0.9/0.6/0.5*100,2) as ����������Դ������,
 			round(avg(tab5.����PRBƽ��������)/0.9/0.6/0.5*100,2) as ����������Դ������, 
      round(sum(tab6.ƽ�������û���), 0) as ƽ�������û���,
      round(sum(tab6.��󼤻��û���), 0) as ��󼤻��û���,
       round(avg(ƽ��E_RAB��), 2) as ƽ��E_RAB��,
 round(avg(ÿ�û�ƽ��E_RAB��), 2) as ÿ�û�ƽ��E_RAB��,
 round(avg(���м���E_RAB��), 2) as ���м���E_RAB��,
 round(avg(���м���E_RAB��), 2) as ���м���E_RAB��,
 round(sum(����PRB��Դʹ�ø���),0) as ����PRB��Դʹ�ø���,
 round(sum(����PRB��Դʹ�ø���),0) as ����PRB��Դʹ�ø���, 
 round(avg(CCEռ��),2) as CCEռ��,
 round(avg(CCE����),2) as CCE����,
 round(avg(С��ƽ�����书��),2) as С��ƽ�����书��,
 round(max(С������书��),0) as С������书�� 
  from 
        (select c.lnbtsid as Lncel_Enb_Id,
       c.lncel_lcr_id as lncel_lcr_id,
       c.lnbts_name as LNCEL_CELL_NAME,
       c.lnbts_name as LNBTS_ENB_NAME,
               noklte_PS_lcelav_lncel_day.PERIOD_START_TIME pm_date,
       c.city||c.netmodel as  ����,
               ROUND(DECODE(SUM(DENOM_CELL_AVAIL),
                            0,
                            0,
                            100 * SUM(SAMPLES_CELL_AVAIL) /
                            SUM(DENOM_CELL_AVAIL)),
                     2) AS LTEС��������,
               SUM(SAMPLES_CELL_AVAIL) LTEС�������ʷ���,
               SUM(DENOM_CELL_AVAIL) LTEС�������ʷ�ĸ,
               SUM(DENOM_CELL_AVAIL - SAMPLES_CELL_AVAIL) * 10 AS LTEС���˷�ʱ��
        
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
                      sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_ATTEMPTS)) ���߽�ͨ��,
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
                                 noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO))) RRC���ӽ����ɹ���,
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
                          noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_ATT_HIPRIO)) RRC���ӽ����������,
               sum(noklte_PS_luest_lncel_day.SIGN_CONN_ESTAB_COMP) RRC���ӽ����ɹ�����,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_RESOUR +
                   noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_TRPORT) ERAB����ӵ������,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_RESOUR) ������Դӵ������,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_TRPORT) ������Դӵ������,
               Sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_RNL) ERAB����ʧ��_UE����Ӧ,
               Sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_FAIL_OTH) ERAB����ʧ��_����,
               AVG(noklte_PS_lepsb_lncel_day.ERAB_ADD_SETUP_FAIL_UP) AS E_RAB����ʧ��_������,
               AVG(noklte_PS_lepsb_lncel_day.ERAB_INI_SETUP_FAIL_RNL_RIP +
               noklte_PS_lepsb_lncel_day.ERAB_ADD_SETUP_FAIL_RNL_RIP) AS E_RAB����ʧ��_���߲� 
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
                      sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_ATTEMPTS)) ERAB�����ɹ���,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_COMPLETIONS) ERAB�����ɹ�����,
               sum(noklte_PS_lepsb_lncel_day.EPS_BEARER_SETUP_ATTEMPTS) ERAB�����������,
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
                            8)) LTEҵ�������,
               sum(EPC_EPS_BEARER_REL_REQ_RNL + EPC_EPS_BEAR_REL_REQ_R_QCI1 +
                   PRE_EMPT_GBR_BEARER + PRE_EMPT_NON_GBR_BEARER +
                   ENB_EPS_BEARER_REL_REQ_RNL + ENB_EPS_BEARER_REL_REQ_TNL +
                   ENB_EPS_BEARER_REL_REQ_OTH) LTEҵ����ߴ���,
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
                   EPC_EPS_BEARER_REL_REQ_DETACH + ERAB_REL_ENB_ACT_NON_GBR) LTEҵ���ͷŴ���
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
                      sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_UL * 1024)) as �տ�����ҵ��ƽ������,
               SUM(PDCP_SDU_VOL_UL) / 1024 as �տ�����ҵ���ֽ���,
               sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_UL) as ACTIVE_TTI_UL,
               decode(sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_DL),
                      0,
                      0,
                      sum(NOKLTE_PS_LCELLT_LNCEL_day.PDCP_SDU_VOL_DL) * 8 * 1000 /
                      sum(NOKLTE_PS_LCELLT_LNCEL_day.ACTIVE_TTI_DL * 1024)) as �տ�����ҵ��ƽ������,
               SUM(PDCP_SDU_VOL_DL) / 1024 as �տ�����ҵ���ֽ���,
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
                                  lncel.LNCEL_UL_CH_BW)) / 2)) ����PRBƽ��������,
               sum(decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                   decode(lncel.LNCEL_TDD_FRAME_CONF, 1, 0.4, 0.2) +
                   decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) / 35 +
                   decode(lncel.LNCEL_UL_CH_BW, '', 0, lncel.LNCEL_UL_CH_BW)) / 2 ����PRB������,
               decode(sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000),
                      0,
                      0,
                      sum(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_PUSCH) /
                      sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000)) as ����PRBռ��ƽ����,
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
                                  lncel.LNCEL_DL_CH_BW)) / 2)) ����PRBƽ��������,
               sum(decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                   decode(lncel.LNCEL_TDD_FRAME_CONF, 1, 0.4, 0.6) +
                   decode(lncel.LNCEL_CH_BW, '', 0, lncel.LNCEL_CH_BW) *
                   decode(lncel.LNCEL_TSSC_296, 5, 0.0428, 0.1428) +
                   decode(lncel.LNCEL_DL_CH_BW, '', 0, lncel.LNCEL_DL_CH_BW)) / 2 AS ����PRB������,
               decode(sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000),
                      0,
                      0,
                      sum(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_PDSCH) /
                      sum(NOKLTE_PS_LCELLR_LNCEL_day.PERIOD_DURATION * 60 * 1000)) as ����PRBռ��ƽ����,
                      SUM(NOKLTE_PS_LCELLR_LNCEL_day.AGG1_USED_PDCCH+2*NOKLTE_PS_LCELLR_LNCEL_day.AGG2_USED_PDCCH+4*NOKLTE_PS_LCELLR_LNCEL_day.AGG4_USED_PDCCH+8*NOKLTE_PS_LCELLR_LNCEL_day.AGG8_USED_PDCCH) as CCEռ��,
        SUM(84*1000*60*NOKLTE_PS_LCELLR_LNCEL_day.period_duration)  as CCE����,
        SUM(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_DL_TOTAL/(NOKLTE_PS_LCELLR_LNCEL_day.period_duration*60000)) AS  ����PRB��Դʹ�ø���,
        SUM(NOKLTE_PS_LCELLR_LNCEL_day.PRB_USED_UL_TOTAL/(NOKLTE_PS_LCELLR_LNCEL_day.period_duration*60000)) AS  ����PRB��Դʹ�ø���
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
               SUM(CELL_LOAD_ACT_UE_AVG) ƽ�������û���,
               MAX(CELL_LOAD_ACT_UE_MAX) ��󼤻��û���,
               avg(RRC_CONN_UE_AVG) ƽ��RRC������_avg,
               sum(RRC_CONN_UE_AVG) ƽ��RRC������_sum,
               max(RRC_CONN_UE_MAX) ���RRC������_max,
               sum(RRC_CONN_UE_MAX) ���RRC������_sum
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
               sum(NOKLTE_PS_LUEST_LNCEL_Day.SIGN_EST_F_RRCCOMPL_MISSING) as Setup_comp_miss��Ӧ��,
               sum(NOKLTE_PS_LUEST_LNCEL_Day.SIGN_EST_F_RRCCOMPL_ERROR) as Setup_comp_errorС���ܾ�,
               sum(NOKLTE_PS_LUEST_LNCEL_Day.SIGN_CONN_ESTAB_FAIL_RRMRAC) as Reject_RRM_RAC��Դ����ʧ
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
                      sum(p.rrc_con_re_estab_att)) RRC�ؽ��ɹ��ʣ� 
                      sum(p.rrc_con_re_estab_att) RRC�ؽ�����,
               sum(p.rrc_con_re_estab_succ) RRC�ؽ��ɹ�����,
               sum(p.RRC_CON_RE_ESTAB_ATT_HO_FAIL) RRC�ؽ�������HOԭ��,
               sum(p.RRC_CON_RE_ESTAB_SUCC_HO_FAIL) RRC�ؽ��ɹ���HOԭ��,
               sum(p.RRC_CON_RE_ESTAB_ATT_OTHER) RRC�ؽ�������otherԭ��,
               sum(p.RRC_CON_RE_ESTAB_SUCC_OTHER) RRC�ؽ��ɹ���otherԭ��,
               avg(p.RRC_CON_STP_TIM_MEAN) AS RRC����ƽ��ʱ��, 
               max(p.RRC_CON_STP_TIM_MAX) AS RRC�������ʱ��
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
       avg(p.ERAB_SETUP_TIME_MEAN) AS E_RAB����ƽ��ʱ��, 
       max(p.ERAB_SETUP_TIME_MAX) AS E_RAB�������ʱ��
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
        ROUND(DECODE(AVG(lepsb.DENOM_SUM_SIMUL_ERAB),0,NULL, AVG(lepsb.SUM_SIMUL_ERAB_QCI_1 + lepsb.SUM_SIMUL_ERAB_QCI_2 + lepsb.SUM_SIMUL_ERAB_QCI_3 + lepsb.SUM_SIMUL_ERAB_QCI_4 +   lepsb.SUM_SIMUL_ERAB_QCI_5 + lepsb.SUM_SIMUL_ERAB_QCI_6 +  lepsb.SUM_SIMUL_ERAB_QCI_7 + lepsb.SUM_SIMUL_ERAB_QCI_8 +   lepsb.SUM_SIMUL_ERAB_QCI_9) / AVG(lepsb.DENOM_SUM_SIMUL_ERAB)),8) AS  ƽ��E_RAB��,
        ROUND(DECODE(AVG(lepsb.DENOM_SUM_SIMUL_ERAB * lcelld.CELL_LOAD_ACT_UE_AVG),0,NULL, AVG(lepsb.SUM_SIMUL_ERAB_QCI_1 + lepsb.SUM_SIMUL_ERAB_QCI_2 + lepsb.SUM_SIMUL_ERAB_QCI_3 + lepsb.SUM_SIMUL_ERAB_QCI_4 + lepsb.SUM_SIMUL_ERAB_QCI_5 + lepsb.SUM_SIMUL_ERAB_QCI_6 + lepsb.SUM_SIMUL_ERAB_QCI_7 + lepsb.SUM_SIMUL_ERAB_QCI_8 +   lepsb.SUM_SIMUL_ERAB_QCI_9) / AVG(lepsb.DENOM_SUM_SIMUL_ERAB * lcelld.CELL_LOAD_ACT_UE_AVG)),8)  AS  ÿ�û�ƽ��E_RAB��,
        ROUND(decode(AVG(lcelld.DENOM_ACTIVE_UE_DATA_UL),0,null,AVG(lcelld.SUM_ACTIVE_UE_DATA_UL)/AVG(lcelld.DENOM_ACTIVE_UE_DATA_UL)),8) AS ���м���E_RAB��,
        ROUND(decode(AVG(lcelld.DENOM_ACTIVE_UE_DATA_DL),0,null,AVG(lcelld.SUM_ACTIVE_UE_DATA_DL)/AVG(lcelld.DENOM_ACTIVE_UE_DATA_DL)),8) AS ���м���E_RAB��
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
        decode(AVG(p.AVG_TRANS_PWR),0,0,10*log(10,AVG(p.AVG_TRANS_PWR))) AS С��ƽ�����书��, 
        decode(MAX(p.MAX_TRANS_PWR),0,0,10*log(10,MAX(p.MAX_TRANS_PWR))) AS С������书��     
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
                  
                  
                  
                  
                  
                  
       (select         count(distinct c.lnbtsid) as ��վ��,
               count(distinct c.lnbtsid * c.lncel_lcr_id) as С����,
               noklte_PS_lcelav_lncel_day.PERIOD_START_TIME as pm_date,
               c.city||c.netmodel as ����
      
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
   and tab1.���� = tab8.����
   and tab1.pm_date = tab8.pm_date(+)
 group by 
    to_char(tab1.pm_date, 'yyyymmdd'),       
          tab1.LNCEL_ENB_ID,
          tab1.LNBTS_ENB_NAME,
          tab1.LNCEL_LCR_ID,
          (CASE
                   WHEN ( tab1.���� = 'BaojiFDD' ) THEN '����FDD'
                   WHEN ( tab1.���� = 'BaojiTDD' ) THEN '����TDD'
                   WHEN ( tab1.���� = 'XianFDD' ) THEN '����FDD'
                   WHEN ( tab1.���� = 'XianTDD' ) THEN '����TDD'    
                   WHEN ( tab1.���� = 'XianyangFDD' ) THEN '����FDD'
                   WHEN ( tab1.���� = 'YananTDD' ) THEN '�Ӱ�FDD' 
                   WHEN ( tab1.���� = 'YulinTDD' ) THEN '����FDD'                   
                   ELSE NULL
               END),
          ��վ��,С����
having round(decode(sum(tab3.LTEҵ���ͷŴ���), 0, 0, sum(tab3.LTEҵ����ߴ���) / sum(tab3.LTEҵ���ͷŴ���)) * 100, 2) >= 0.5
 and sum(tab3.LTEҵ����ߴ���) > = 100
  