SELECT
    a.DDATE,
    a.TTIME,
    a.ENB_ID,
    lnbts.LNBTS_ENB_NAME AS eNodeB����,
   -- a.lnbts_objid,
    a.version,
    a.����,
    a.��վ��,
    a.С����,
    a.LTEС�������ʷ���,
    a.LTEС�������ʷ�ĸ,
    a.LTEС��������, 
    a.LTEС��ƽ���˷�ʱ��s,
    a.LTEС�����˷�ʱ��s,
    a.PRACH�ɹ���,
    a.��������ͻ�������,
    a.cell�����ǰ��������,
    a.cell�����ǰ�����Ǿ�,
    a.���߽�ͨ��,
    a.RRC���ӽ����ɹ���,
    a.RRC���ӽ����������,
    a.RRC���ӽ����ɹ�����,
    a.RRC����ƽ��ʱ��,
    a.RRC�������ʱ��,
    a.Setup_comp_miss��Ӧ��,
    a.Setup_comp_errorС���ܾ�,
    a.Reject_RRM_RAC��Դ����ʧ,
    a.SIGN_CONN_ESTAB_FAIL_MAXRRC,
    a.RRC�ؽ��ɹ���,
    a.RRC�ؽ�����,
    a.RRC�ؽ��ɹ�����,
    a.RRC�ؽ�������HOԭ��,
    a.RRC�ؽ��ɹ���HOԭ��,
    a.RRC�ؽ�������otherԭ��,
    a.RRC�ؽ��ɹ���otherԭ��,
    a.ERAB�����ɹ���,
    a.ERAB�����������,
    a.ERAB�����ɹ�����,
    a.E_RAB����ƽ��ʱ��,
    a.E_RAB�������ʱ��,
    a.������Դӵ������,
    a.ERABʧ��_�����,
    a.ERAB����ʧ��_UE����Ӧ,    
    a.ERAB����ʧ��_��ȫģʽ, 
    a.E_RAB����ʧ��_������,
    a.E_RAB����ʧ��_���߲�,
    a.LTEҵ�������,
    a.LTEҵ���ͷŴ���,
    a.LTEҵ����ߴ���,
    a.MME�ͷŵ�ERAB�������,
    a.eNB�ͷŵ�ERAB�������,
    a.eNB�ͷŵ�ERAB��other,
    a.eNB�ͷŵ�ERAB�������,
    a.E_RAB�쳣�ͷ�_����ӵ��,  
    a.�տ�����ҵ���ֽ���MB,---MByte ��λ
    a.�տ�����ҵ��ƽ������,---Mbps��λ
    a.�տ�����ҵ���ֽ���MB,---MByte ��λ
    a.�տ�����ҵ��ƽ������,---Mbps��λ
    --a.����PRBƽ��������,
    --a.����PRBƽ��������, 
    a.����PRB��������,
    a.����PRBռ������,
    a.����PRBƽ��������,
    a.����PRBռ��ƽ����,
    a.����PRB��������,
    a.����PRBռ������,
    a.����PRBƽ��������,
    a.����PRBռ��ƽ����,
    a.����������Դ������,
    a.����������Դ������, 
    a.ƽ��RRC������_avg,
    a.ƽ��RRC������_sum,
    a.���RRC������_sum,
    a.���RRC������_max,
    a.ƽ�������û���,
    a.��󼤻��û���,
    a.ƽ��E_RAB��,
    a.ÿ�û�ƽ��E_RAB��,
    a.���м���E_RAB��,
    a.���м���E_RAB��,
    a.����PRB��Դʹ�ø���,
    a.����PRB��Դʹ�ø���, 
    a.CCEռ��,
    a.CCE����,
    a.С��ƽ�����书��,
    a.С������书�� 

FROM
    (SELECT 
        to_char(tab1.pm_date,'yyyymmdd') DDATE,
        to_char(tab1.pm_date,'hh24') AS TTIME,
           tab1.LNCEL_ENB_ID AS ENB_ID,
           --tab1.LNCEL_LCR_ID AS CELL_ID,
           tab1.lnbts_objid AS lnbts_objid,
           --tab1.LNCEL_ENB_ID * 100 + tab1.LNCEL_LCR_ID as ECI,
           tab1.version,
        tab1.����,
        tab9.��վ��,
        tab9.С����,
        sum(tab1.LTEС�������ʷ���) AS LTEС�������ʷ���,
        sum(tab1.LTEС�������ʷ�ĸ) AS LTEС�������ʷ�ĸ,
        round(decode(sum(tab1.LTEС�������ʷ�ĸ),0,0,sum(tab1.LTEС�������ʷ���)/sum(tab1.LTEС�������ʷ�ĸ)*100),2) AS LTEС��������, 
        round(avg(tab1.LTEС���˷�ʱ��),2) AS LTEС��ƽ���˷�ʱ��s,
        round(sum(tab1.LTEС���˷�ʱ��),2) AS LTEС�����˷�ʱ��s,
        round((decode(sum(tab2.RRC���ӽ����������),0,0,sum(tab2.RRC���ӽ����ɹ�����)/sum(tab2.RRC���ӽ����������)))*(decode(SUM(tab3.ERAB�����������),0,0,sum(tab3.ERAB�����ɹ�����)/SUM(tab3.ERAB�����������)))*100,2) AS ���߽�ͨ��,
        round(decode(sum(tab2.RRC���ӽ����������),0,0,sum(tab2.RRC���ӽ����ɹ�����)/sum(tab2.RRC���ӽ����������))*100,2) AS RRC���ӽ����ɹ���,
        sum(tab2.RRC���ӽ����������) AS RRC���ӽ����������,
        sum(tab2.RRC���ӽ����ɹ�����) AS RRC���ӽ����ɹ�����,
        ROUND(avg(tab7.RRC����ƽ��ʱ��),0) AS RRC����ƽ��ʱ��,
        ROUND(max(tab7.RRC�������ʱ��),0) AS RRC�������ʱ��,
        sum(tab2.Setup_comp_miss��Ӧ��) AS Setup_comp_miss��Ӧ��,
        sum(tab2.Setup_comp_errorС���ܾ�) AS Setup_comp_errorС���ܾ�,
        sum(tab2.Reject_RRM_RAC��Դ����ʧ) AS Reject_RRM_RAC��Դ����ʧ,
        sum(tab2.SIGN_CONN_ESTAB_FAIL_MAXRRC) AS SIGN_CONN_ESTAB_FAIL_MAXRRC, 
        round(decode(sum(tab7.RRC�ؽ�����),0,0,sum(tab7.RRC�ؽ��ɹ�����)/sum(tab7.RRC�ؽ�����)*100),2) AS RRC�ؽ��ɹ���,
        sum(tab7.RRC�ؽ�����) AS RRC�ؽ�����,
        sum(tab7.RRC�ؽ��ɹ�����) AS RRC�ؽ��ɹ�����,
        sum(tab7.RRC�ؽ�������HOԭ��) AS RRC�ؽ�������HOԭ��,
        sum(tab7.RRC�ؽ��ɹ���HOԭ��) AS RRC�ؽ��ɹ���HOԭ��,
        sum(tab7.RRC�ؽ�������otherԭ��) AS RRC�ؽ�������otherԭ��,
        sum(tab7.RRC�ؽ��ɹ���otherԭ��) AS RRC�ؽ��ɹ���otherԭ��,
        round(decode(SUM(tab3.ERAB�����������),0,0,sum(tab3.ERAB�����ɹ�����)/SUM(tab3.ERAB�����������))*100,2) AS ERAB�����ɹ���,
        sum(tab3.ERAB�����������) AS ERAB�����������,
        sum(tab3.ERAB�����ɹ�����) AS ERAB�����ɹ�����,
        ROUND(avg(tab8.E_RAB����ƽ��ʱ��),0) AS E_RAB����ƽ��ʱ��,
        ROUND(max(tab8.E_RAB�������ʱ��),0) AS E_RAB�������ʱ��,
        sum(tab2.������Դӵ������) AS ������Դӵ������,
        sum(tab2.������Դӵ������) AS ERABʧ��_�����,
        sum(tab2.ERAB����ʧ��_UE����Ӧ) AS ERAB����ʧ��_UE����Ӧ,    
        sum(tab2.ERAB����ʧ��_����) AS ERAB����ʧ��_��ȫģʽ, 
        ROUND(avg(tab2.E_RAB����ʧ��_������),0) AS E_RAB����ʧ��_������,
        ROUND(avg(tab2.E_RAB����ʧ��_���߲�),0) AS E_RAB����ʧ��_���߲�,
        round(decode(sum(tab3.LTEҵ���ͷŴ���),0,0,sum(tab3.LTEҵ����ߴ���)/sum(tab3.LTEҵ���ͷŴ���))*100,2) AS LTEҵ�������,
        sum(tab3.LTEҵ���ͷŴ���) AS LTEҵ���ͷŴ���,
        sum(tab3.LTEҵ����ߴ���) AS LTEҵ����ߴ���,
        sum(tab3.EPC_EPS_BEARER_REL_REQ_RNL) AS MME�ͷŵ�ERAB�������,
        sum(tab3.ENB_EPS_BEARER_REL_REQ_RNL) AS eNB�ͷŵ�ERAB�������,
        sum(tab3.ENB_EPS_BEARER_REL_REQ_OTH) AS eNB�ͷŵ�ERAB��other,
        sum(tab3.ENB_EPS_BEARER_REL_REQ_TNL) AS eNB�ͷŵ�ERAB�������,
        sum(tab3.EPC_EPS_BEAR_REL_REQ_R_QCI1) AS  E_RAB�쳣�ͷ�_����ӵ��,  
        round(sum(tab4.�տ�����ҵ���ֽ���MB)/1024,2) AS �տ�����ҵ���ֽ���MB,---MByte ��λ
        round(decode(sum(tab4.ACTIVE_TTI_UL),0,0,(sum(tab4.�տ�����ҵ���ֽ���MB)*1000*8)/sum(tab4.ACTIVE_TTI_UL)/1024),2) AS �տ�����ҵ��ƽ������,---Mbps��λ
        round(sum(tab4.�տ�����ҵ���ֽ���MB)/1024,2) AS �տ�����ҵ���ֽ���MB,---MByte ��λ
        round(decode(sum(tab4.ACTIVE_TTI_DL),0,0,(sum(tab4.�տ�����ҵ���ֽ���MB)*1000*8)/sum(tab4.ACTIVE_TTI_DL)/1024),2) AS �տ�����ҵ��ƽ������,---Mbps��λ
        -- round(avg(tab5.����PRBƽ��������)*100,2) AS ����PRBƽ��������,
        -- round(avg(tab5.����PRBƽ��������)*100,2) AS ����PRBƽ��������, 
        round(sum(tab5.����PRB������),2) AS ����PRB��������,
        round(sum(tab5.����PRBռ��ƽ����),2) AS ����PRBռ������,
        round(avg(tab5.����PRBƽ��������)*100,2) AS ����PRBƽ��������,
        round(avg(tab5.����PRBռ��ƽ����),2) AS ����PRBռ��ƽ����,
        round(sum(tab5.����PRB������),2) AS ����PRB��������,
        round(sum(tab5.����PRBռ��ƽ����),2) AS ����PRBռ������,
        round(avg(tab5.����PRBƽ��������)*100,2) AS ����PRBƽ��������,
        round(avg(tab5.����PRBռ��ƽ����),2) AS ����PRBռ��ƽ����,
        round(avg(tab5.����PRBƽ��������)/0.9/0.6/0.5*100,2) AS ����������Դ������,
        round(avg(tab5.����PRBƽ��������)/0.9/0.6/0.5*100,2) AS ����������Դ������, 
        round(avg(tab6.ƽ��RRC������_avg),2) ƽ��RRC������_avg,
        round(sum(tab6.ƽ��RRC������_sum),2) ƽ��RRC������_sum,
        sum(tab6.���RRC������_sum) ���RRC������_sum,
        max(tab6.���RRC������_max) ���RRC������_max,
        sum(tab6.��������ͻ�������) as ��������ͻ�������,
        sum(tab6.cell�����ǰ��������) as cell�����ǰ��������,
        sum(tab6.cell�����ǰ�����Ǿ�) as cell�����ǰ�����Ǿ�,
        round(decode(sum(tab6.cell�����ǰ��������+tab6.cell�����ǰ�����Ǿ�),0,0,sum(tab6.��������ͻ�������)/sum(tab6.cell�����ǰ��������+tab6.cell�����ǰ�����Ǿ�))*100,2) AS PRACH�ɹ���,

        round(sum(tab6.ƽ�������û���),0) AS ƽ�������û���,
        round(sum(tab6.��󼤻��û���),0) AS ��󼤻��û���,
        round(avg(tab10.ƽ��E_RAB��), 2) AS ƽ��E_RAB��,
        round(avg(tab10.ÿ�û�ƽ��E_RAB��), 2) AS ÿ�û�ƽ��E_RAB��,
        round(avg(tab10.���м���E_RAB��), 2) AS ���м���E_RAB��,
        round(avg(tab10.���м���E_RAB��), 2) AS ���м���E_RAB��,
        round(sum(tab5.����PRB��Դʹ�ø���),0) AS ����PRB��Դʹ�ø���,
        round(sum(tab5.����PRB��Դʹ�ø���),0) AS ����PRB��Դʹ�ø���, 
        round(avg(tab5.CCEռ��),2) AS CCEռ��,
        round(avg(tab5.CCE����),2) AS CCE����,
        round(avg(tab11.С��ƽ�����书��),2) AS С��ƽ�����书��,
        round(max(tab11.С������书��),0) AS С������书�� 
        
    FROM 
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            ----c.lncel_lcr_id AS lncel_lcr_id,
            c.lnbts_objid AS lnbts_objid,
            lcelav.period_start_time pm_date,
            c.version,
            (CASE 
                WHEN (c.city = 'Baoji' AND c.netmodel = 'FDD') THEN '����FDD'
                WHEN (c.city = 'Baoji' AND c.netmodel = 'TDD') THEN '����TDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'FDD') THEN '����FDD'
                WHEN (c.city = 'Xian' AND c.netmodel = 'TDD') THEN '����TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'FDD') THEN '����FDD'
                WHEN (c.city = 'Hanzhong' AND c.netmodel = 'TDD') THEN '����TDD'
                WHEN (c.city = 'Yulin' AND c.netmodel = 'TDD') THEN '����TDD'
                WHEN (c.city = 'Yanan' AND c.netmodel = 'TDD') THEN '�Ӱ�TDD'
                WHEN (c.city = 'Tongchuan' AND c.netmodel = 'TDD') THEN 'ͭ��TDD'
                WHEN (c.city = 'Shangluo' AND c.netmodel = 'TDD') THEN '����TDD'
                WHEN (c.city = 'Xianyang' AND c.netmodel = 'TDD') THEN '����TDD'            
            ELSE NULL END) ����,
            ROUND(DECODE(SUM(DENOM_CELL_AVAIL),0,0,100 * SUM(SAMPLES_CELL_AVAIL) / SUM(DENOM_CELL_AVAIL)),2) AS LTEС��������,
            SUM(SAMPLES_CELL_AVAIL) LTEС�������ʷ���,
            SUM(DENOM_CELL_AVAIL) LTEС�������ʷ�ĸ,
            SUM(DENOM_CELL_AVAIL - SAMPLES_CELL_AVAIL) * 10 AS LTEС���˷�ʱ��
            
        FROM 
            NOKLTE_PS_LCELAV_LNBTS_HOUR lcelav
            INNER JOIN C_LTE_CUSTOM c ON c.lnbts_objid = lcelav.lnbts_id

        WHERE 

                lcelav.period_start_time >= to_date(&start_datetime,'yyyymmdd')
            AND lcelav.period_start_time <  to_date(&end_datetime,'yyyymmdd')
        
        GROUP BY
            lcelav.period_start_time��
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
            * DECODE(sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS),0,0,sum(lepsb.EPS_BEARER_SETUP_COMPLETIONS)/sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS))*100,2) ���߽�ͨ��,
            round(DECODE(decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0,luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode( luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO)),sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_OTHERS + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0, luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode(luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO))), 0, 0, sum(luest.SIGN_CONN_ESTAB_COMP) / decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0,luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode( luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO)),sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_OTHERS + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0, luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode(luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO))))*100,2) AS RRC���ӽ����ɹ���,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0,luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode( luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO)),sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_OTHERS + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0, luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode(luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO))) AS RRC���ӽ����������,
            sum(luest.SIGN_CONN_ESTAB_COMP) AS RRC���ӽ����ɹ�����,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum( lepsb.ERAB_INI_SETUP_FAIL_RNL_RRNA + lepsb.ERAB_ADD_SETUP_FAIL_RNL_RRNA),sum(lepsb.EPS_BEARER_SETUP_FAIL_RESOUR)) AS ������Դӵ������,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS - lepsb.EPS_BEARER_SETUP_COMPLETIONS - lepsb.ERAB_INI_SETUP_FAIL_RNL_UEL - lepsb.ERAB_ADD_SETUP_FAIL_RNL_UEL - lepsb.ERAB_INI_SETUP_FAIL_TNL_TRU - lepsb.ERAB_ADD_SETUP_FAIL_TNL_TRU - lepsb.ERAB_INI_SETUP_FAIL_RNL_RRNA - lepsb.ERAB_ADD_SETUP_FAIL_RNL_RRNA - lepsb.ERAB_INI_SETUP_FAIL_RNL_RIP - lepsb.ERAB_ADD_SETUP_FAIL_RNL_RIP - lepsb.ERAB_ADD_SETUP_FAIL_UP - lepsb.ERAB_ADD_SETUP_FAIL_RNL_MOB),sum(lepsb.EPS_BEARER_SETUP_FAIL_TRPORT)) AS ������Դӵ������,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM(lepsb.ERAB_INI_SETUP_FAIL_RNL_UEL + lepsb.ERAB_ADD_SETUP_FAIL_RNL_UEL ),Sum(lepsb.EPS_BEARER_SETUP_FAIL_RNL)) ERAB����ʧ��_UE����Ӧ,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM(lepsb.ERAB_ADD_SETUP_FAIL_UP),Sum(lepsb.EPS_BEARER_SETUP_FAIL_OTH)) AS ERAB����ʧ��_����,
            sum(luest.SIGN_EST_F_RRCCOMPL_MISSING) AS Setup_comp_miss��Ӧ��,
            sum(luest.SIGN_EST_F_RRCCOMPL_ERROR) AS Setup_comp_errorС���ܾ�,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_FAIL_PUCCH),sum(luest.SIGN_CONN_ESTAB_FAIL_RRMRAC)) AS Reject_RRM_RAC��Դ����ʧ,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_FAIL_MAXRRC),'') AS SIGN_CONN_ESTAB_FAIL_MAXRRC, --LN7.0�޴�ָ��
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(lepsb.ERAB_ADD_SETUP_FAIL_UP),'') AS E_RAB����ʧ��_������, --LN7.0�޴�ָ��
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(lepsb.ERAB_INI_SETUP_FAIL_RNL_RIP + lepsb.ERAB_ADD_SETUP_FAIL_RNL_RIP),'') AS E_RAB����ʧ��_���߲� --LN7.0�޴�ָ��
        
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
            round(decode(sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS),0,0, sum(lepsb.EPS_BEARER_SETUP_COMPLETIONS) / sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS))*100,2) AS ERAB�����ɹ���,
            sum(lepsb.EPS_BEARER_SETUP_COMPLETIONS) AS ERAB�����ɹ�����,
            sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS) AS ERAB�����������,               
            round(DECODE(decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum( lepsb.EPC_EPS_BEARER_REL_REQ_RNL  + lepsb.ERAB_REL_ENB_RNL_UEL + lepsb.ERAB_REL_ENB_RNL_EUGR + lepsb.ERAB_REL_ENB_TNL_TRU + lepsb.ERAB_REL_HO_PART + lepsb.ERAB_REL_EPC_PATH_SWITCH + lepsb.ERAB_REL_ENB_RNL_INA + lepsb.ERAB_REL_ENB_RNL_RED + lepsb.ERAB_REL_ENB_RNL_RRNA + lepsb.EPC_EPS_BEARER_REL_REQ_NORM + lepsb.EPC_EPS_BEARER_REL_REQ_DETACH ) ,sum( lepsb.EPC_EPS_BEARER_REL_REQ_NORM + lepsb.EPC_EPS_BEARER_REL_REQ_DETACH + lepsb.EPC_EPS_BEARER_REL_REQ_RNL + lepsb.ERAB_REL_ENB_ACT_NON_GBR + lepsb.ENB_EPSBEAR_REL_REQ_RNL_REDIR + lepsb.ENB_EPS_BEARER_REL_REQ_NORM + lepsb.ENB_EPS_BEARER_REL_REQ_RNL + lepsb.ENB_EPS_BEARER_REL_REQ_TNL + lepsb.ENB_EPS_BEARER_REL_REQ_OTH + lepsb.EPC_EPS_BEAR_REL_REQ_R_QCI1 + lepsb.PRE_EMPT_GBR_BEARER + lepsb.PRE_EMPT_NON_GBR_BEARER )), 0, 0, decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM( lepsb.EPC_EPS_BEARER_REL_REQ_RNL + lepsb.ERAB_REL_ENB_RNL_UEL + lepsb.ERAB_REL_ENB_RNL_EUGR + lepsb.ERAB_REL_ENB_TNL_TRU + lepsb.ERAB_REL_HO_PART + lepsb.ERAB_REL_EPC_PATH_SWITCH ) ,SUM( lepsb.EPC_EPS_BEARER_REL_REQ_RNL + lepsb.EPC_EPS_BEAR_REL_REQ_R_QCI1 + lepsb.PRE_EMPT_GBR_BEARER + lepsb.PRE_EMPT_NON_GBR_BEARER + lepsb.ENB_EPS_BEARER_REL_REQ_RNL + lepsb.ENB_EPS_BEARER_REL_REQ_TNL + lepsb.ENB_EPS_BEARER_REL_REQ_OTH ))/ decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum( lepsb.EPC_EPS_BEARER_REL_REQ_RNL + lepsb.ERAB_REL_ENB_RNL_UEL + lepsb.ERAB_REL_ENB_RNL_EUGR + lepsb.ERAB_REL_ENB_TNL_TRU + lepsb.ERAB_REL_HO_PART + lepsb.ERAB_REL_EPC_PATH_SWITCH + lepsb.ERAB_REL_ENB_RNL_INA + lepsb.ERAB_REL_ENB_RNL_RED + lepsb.ERAB_REL_ENB_RNL_RRNA + lepsb.EPC_EPS_BEARER_REL_REQ_NORM + lepsb.EPC_EPS_BEARER_REL_REQ_DETACH ) ,sum( lepsb.EPC_EPS_BEARER_REL_REQ_NORM + lepsb.EPC_EPS_BEARER_REL_REQ_DETACH + lepsb.EPC_EPS_BEARER_REL_REQ_RNL + lepsb.ERAB_REL_ENB_ACT_NON_GBR + lepsb.ENB_EPSBEAR_REL_REQ_RNL_REDIR + lepsb.ENB_EPS_BEARER_REL_REQ_NORM + lepsb.ENB_EPS_BEARER_REL_REQ_RNL + lepsb.ENB_EPS_BEARER_REL_REQ_TNL + lepsb.ENB_EPS_BEARER_REL_REQ_OTH + lepsb.EPC_EPS_BEAR_REL_REQ_R_QCI1 + lepsb.PRE_EMPT_GBR_BEARER + lepsb.PRE_EMPT_NON_GBR_BEARER )) )*100,2) AS LTEҵ�������, 
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM( lepsb.EPC_EPS_BEARER_REL_REQ_RNL  + lepsb.ERAB_REL_ENB_RNL_UEL + lepsb.ERAB_REL_ENB_RNL_EUGR + lepsb.ERAB_REL_ENB_TNL_TRU + lepsb.ERAB_REL_HO_PART + lepsb.ERAB_REL_EPC_PATH_SWITCH ) ,SUM( lepsb.EPC_EPS_BEARER_REL_REQ_RNL + lepsb.EPC_EPS_BEAR_REL_REQ_R_QCI1 + lepsb.PRE_EMPT_GBR_BEARER + lepsb.PRE_EMPT_NON_GBR_BEARER + lepsb.ENB_EPS_BEARER_REL_REQ_RNL + lepsb.ENB_EPS_BEARER_REL_REQ_TNL + lepsb.ENB_EPS_BEARER_REL_REQ_OTH))  AS LTEҵ����ߴ���,
            sum(lepsb.EPC_EPS_BEARER_REL_REQ_RNL) EPC_EPS_BEARER_REL_REQ_RNL,
            sum(lepsb.EPC_EPS_BEARER_REL_REQ_OTH) EPC_EPS_BEARER_REL_REQ_OTH,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM(lepsb.ERAB_REL_HO_PART + lepsb.ERAB_REL_EPC_PATH_SWITCH),Sum(lepsb.ENB_EPS_BEARER_REL_REQ_OTH)) ENB_EPS_BEARER_REL_REQ_OTH,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM(lepsb.ERAB_REL_ENB_RNL_UEL),Sum(lepsb.ENB_EPS_BEARER_REL_REQ_RNL)) ENB_EPS_BEARER_REL_REQ_RNL,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM(lepsb.ERAB_REL_ENB_TNL_TRU),Sum(lepsb.ENB_EPS_BEARER_REL_REQ_TNL)) ENB_EPS_BEARER_REL_REQ_TNL,        
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM(lepsb.ERAB_REL_ENB_RNL_EUGR),Sum(lepsb.EPC_EPS_BEAR_REL_REQ_R_QCI1)) EPC_EPS_BEAR_REL_REQ_R_QCI1,
            AVG(lepsb.EPC_EPS_BEAR_REL_REQ_R_QCI1) avgEPC_EPS_BEAR_REL_REQ_R_QCI1,  
            sum(lepsb.PRE_EMPT_GBR_BEARER) PRE_EMPT_GBR_BEARER,
            sum(lepsb.PRE_EMPT_NON_GBR_BEARER) PRE_EMPT_NON_GBR_BEARER,
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum( lepsb.EPC_EPS_BEARER_REL_REQ_RNL  + lepsb.ERAB_REL_ENB_RNL_UEL + lepsb.ERAB_REL_ENB_RNL_EUGR + lepsb.ERAB_REL_ENB_TNL_TRU + lepsb.ERAB_REL_HO_PART + lepsb.ERAB_REL_EPC_PATH_SWITCH + lepsb.ERAB_REL_ENB_RNL_INA + lepsb.ERAB_REL_ENB_RNL_RED + lepsb.ERAB_REL_ENB_RNL_RRNA + lepsb.EPC_EPS_BEARER_REL_REQ_NORM + lepsb.EPC_EPS_BEARER_REL_REQ_DETACH ) ,sum( lepsb.EPC_EPS_BEARER_REL_REQ_NORM + lepsb.EPC_EPS_BEARER_REL_REQ_DETACH + lepsb.EPC_EPS_BEARER_REL_REQ_RNL + lepsb.ERAB_REL_ENB_ACT_NON_GBR + lepsb.ENB_EPSBEAR_REL_REQ_RNL_REDIR + lepsb.ENB_EPS_BEARER_REL_REQ_NORM + lepsb.ENB_EPS_BEARER_REL_REQ_RNL + lepsb.ENB_EPS_BEARER_REL_REQ_TNL + lepsb.ENB_EPS_BEARER_REL_REQ_OTH + lepsb.EPC_EPS_BEAR_REL_REQ_R_QCI1 + lepsb.PRE_EMPT_GBR_BEARER + lepsb.PRE_EMPT_NON_GBR_BEARER)) AS LTEҵ���ͷŴ���
        
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
                sum(lcellt.ACTIVE_TTI_UL*1024)) AS �տ�����ҵ��ƽ������,
            SUM(PDCP_SDU_VOL_UL) / 1024 AS �տ�����ҵ���ֽ���MB,
            sum(lcellt.ACTIVE_TTI_UL)  AS ACTIVE_TTI_UL,
            decode(sum(lcellt.ACTIVE_TTI_DL), 0, 0,sum(lcellt.PDCP_SDU_VOL_DL) * 8 * 1000 /
                sum(lcellt.ACTIVE_TTI_DL*1024)) AS �տ�����ҵ��ƽ������,
            SUM(PDCP_SDU_VOL_DL) / 1024 AS �տ�����ҵ���ֽ���MB,
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
                lncel.LNCEL_UL_CH_BW))/2)) AS ����PRBƽ��������,
            sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*decode(lncel.LNCEL_TDD_FRAME_CONF,1,0.4,0.2)+decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)/35+
                decode(lncel.LNCEL_UL_CH_BW,'',0,lncel.LNCEL_UL_CH_BW))/2 ����PRB������,  
            decode(sum(lcellr.PERIOD_DURATION*60*1000),0,0,sum(lcellr.PRB_USED_PUSCH)/
                sum(lcellr.PERIOD_DURATION*60*1000)) AS ����PRBռ��ƽ����,
            decode((sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)+decode(lncel.LNCEL_DL_CH_BW,'',0,lncel.LNCEL_DL_CH_BW))/2),0,0,decode(sum(lcellr.PERIOD_DURATION*60*1000),
                0,0, sum(lcellr.PRB_USED_PDSCH) /sum(lcellr.PERIOD_DURATION*60*1000))/(sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*
                decode(lncel.LNCEL_TDD_FRAME_CONF,1,0.4,0.6)+decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*decode(lncel.LNCEL_TSSC_296,5,0.0428,0.1428)+
                decode(lncel.LNCEL_DL_CH_BW,'',0,lncel.LNCEL_DL_CH_BW))/2)) AS ����PRBƽ��������,
            sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*decode(lncel.LNCEL_TDD_FRAME_CONF,1,0.4,0.6)+decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*decode(lncel.LNCEL_TSSC_296,5,0.0428,0.1428)+
                decode(lncel.LNCEL_DL_CH_BW,'',0,lncel.LNCEL_DL_CH_BW))/2  AS ����PRB������,
            decode(sum(lcellr.PERIOD_DURATION*60*1000),0,0, sum(lcellr.PRB_USED_PDSCH) /
                sum(lcellr.PERIOD_DURATION*60*1000)) AS ����PRBռ��ƽ����,
            SUM(lcellr.AGG1_USED_PDCCH+2*lcellr.AGG2_USED_PDCCH+4*lcellr.AGG4_USED_PDCCH+8*lcellr.AGG8_USED_PDCCH) AS CCEռ��,
            SUM(84*1000*60*lcellr.period_duration) AS CCE����,
            SUM(lcellr.PRB_USED_DL_TOTAL/(lcellr.period_duration*60000)) AS  ����PRB��Դʹ�ø���,
            SUM(lcellr.PRB_USED_UL_TOTAL/(lcellr.period_duration*60000)) AS  ����PRB��Դʹ�ø���
            
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
            round(SUM(lcelld.CELL_LOAD_ACT_UE_AVG),8) AS ƽ�������û���,
            MAX(lcelld.CELL_LOAD_ACT_UE_MAX) AS ��󼤻��û���,
            round(avg(lcelld.RRC_CONN_UE_AVG),8) AS ƽ��RRC������_avg,
            round(sum(lcelld.RRC_CONN_UE_AVG),8) AS ƽ��RRC������_sum,
            sum(lcelld.RACH_STP_COMPLETIONS) as ��������ͻ�������,
            sum(lcelld.RACH_STP_ATT_SMALL_MSG+lcelld.RACH_STP_ATT_LARGE_MSG) as cell�����ǰ��������,
            sum(lcelld.RACH_STP_ATT_DEDICATED) as cell�����ǰ�����Ǿ�,
            round(decode(sum(lcelld.RACH_STP_ATT_SMALL_MSG+lcelld.RACH_STP_ATT_LARGE_MSG+lcelld.RACH_STP_ATT_DEDICATED),0,0,sum(lcelld.RACH_STP_COMPLETIONS)/sum(lcelld.RACH_STP_ATT_SMALL_MSG+lcelld.RACH_STP_ATT_LARGE_MSG+lcelld.RACH_STP_ATT_DEDICATED))*100,2) AS PRACH�ɹ���,

            sum(lcelld.RRC_CONN_UE_MAX) AS ���RRC������_sum,
            max(lcelld.RRC_CONN_UE_MAX) AS ���RRC������_max    
            
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
                0,0,sum(lrrc.rrc_con_re_estab_succ)/sum(lrrc.rrc_con_re_estab_att))*100,2) AS RRC�ؽ��ɹ��ʣ�
            sum(lrrc.rrc_con_re_estab_att) AS RRC�ؽ�����,
            sum(lrrc.rrc_con_re_estab_succ) AS RRC�ؽ��ɹ�����,
            sum(lrrc.RRC_CON_RE_ESTAB_ATT_HO_FAIL) AS RRC�ؽ�������HOԭ��,
            sum(lrrc.RRC_CON_RE_ESTAB_SUCC_HO_FAIL) AS RRC�ؽ��ɹ���HOԭ��,
            sum(lrrc.RRC_CON_RE_ESTAB_ATT_OTHER) AS RRC�ؽ�������otherԭ��,
            sum(lrrc.RRC_CON_RE_ESTAB_SUCC_OTHER) AS RRC�ؽ��ɹ���otherԭ��,
            round(avg(lrrc.RRC_CON_STP_TIM_MEAN),2) AS RRC����ƽ��ʱ��, 
            max(lrrc.RRC_CON_STP_TIM_MAX) AS RRC�������ʱ��
            
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
            round(avg(lrdb.ERAB_SETUP_TIME_MEAN),4) AS E_RAB����ƽ��ʱ��, 
            max(lrdb.ERAB_SETUP_TIME_MAX) AS E_RAB�������ʱ��
            
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
            ROUND(DECODE(AVG(lepsb.DENOM_SUM_SIMUL_ERAB),0,NULL, AVG(lepsb.SUM_SIMUL_ERAB_QCI_1 + lepsb.SUM_SIMUL_ERAB_QCI_2 + lepsb.SUM_SIMUL_ERAB_QCI_3 + lepsb.SUM_SIMUL_ERAB_QCI_4 +   lepsb.SUM_SIMUL_ERAB_QCI_5 + lepsb.SUM_SIMUL_ERAB_QCI_6 +  lepsb.SUM_SIMUL_ERAB_QCI_7 + lepsb.SUM_SIMUL_ERAB_QCI_8 +   lepsb.SUM_SIMUL_ERAB_QCI_9) / AVG(lepsb.DENOM_SUM_SIMUL_ERAB)),8) AS  ƽ��E_RAB��,
            ROUND(DECODE(AVG(lepsb.DENOM_SUM_SIMUL_ERAB * lcelld.CELL_LOAD_ACT_UE_AVG),0,NULL, AVG(lepsb.SUM_SIMUL_ERAB_QCI_1 + lepsb.SUM_SIMUL_ERAB_QCI_2 + lepsb.SUM_SIMUL_ERAB_QCI_3 + lepsb.SUM_SIMUL_ERAB_QCI_4 + lepsb.SUM_SIMUL_ERAB_QCI_5 + lepsb.SUM_SIMUL_ERAB_QCI_6 + lepsb.SUM_SIMUL_ERAB_QCI_7 + lepsb.SUM_SIMUL_ERAB_QCI_8 +   lepsb.SUM_SIMUL_ERAB_QCI_9) / AVG(lepsb.DENOM_SUM_SIMUL_ERAB * lcelld.CELL_LOAD_ACT_UE_AVG)),8)  AS  ÿ�û�ƽ��E_RAB��,
            ROUND(decode(AVG(lcelld.DENOM_ACTIVE_UE_DATA_UL),0,null,AVG(lcelld.SUM_ACTIVE_UE_DATA_UL)/AVG(lcelld.DENOM_ACTIVE_UE_DATA_UL)),8) AS ���м���E_RAB��,
            ROUND(decode(AVG(lcelld.DENOM_ACTIVE_UE_DATA_DL),0,null,AVG(lcelld.SUM_ACTIVE_UE_DATA_DL)/AVG(lcelld.DENOM_ACTIVE_UE_DATA_DL)),8) AS ���м���E_RAB��
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
            --������ָ��LN7.0��FL16 ָ�깫ʽ��һ�� ��Ҫ�˶�
            decode(AVG(lpqdl.AVG_TRANS_PWR),0,0,10*log(10,AVG(lpqdl.AVG_TRANS_PWR))) AS С��ƽ�����书��, 
            decode(MAX(lpqdl.MAX_TRANS_PWR),0,0,10*log(10,MAX(lpqdl.MAX_TRANS_PWR))) AS С������书��    
            
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
            count(distinct c.lnbtsid) AS ��վ��,
            count(distinct c.lnbtsid*c.lncel_lcr_id) AS С����,               
            lcelav.period_start_time AS pm_date,
        (CASE 
            WHEN (c.city = 'Baoji' AND c.netmodel = 'FDD') THEN '����FDD'
            WHEN (c.city = 'Baoji' AND c.netmodel = 'TDD') THEN '����TDD'
            WHEN (c.city = 'Xian' AND c.netmodel = 'FDD') THEN '����FDD'
            WHEN (c.city = 'Xian' AND c.netmodel = 'TDD') THEN '����TDD'
            WHEN (c.city = 'Xianyang' AND c.netmodel = 'FDD') THEN '����FDD'
            WHEN (c.city = 'Hanzhong' AND c.netmodel = 'TDD') THEN '����TDD'
            WHEN (c.city = 'Yulin' AND c.netmodel = 'TDD') THEN '����TDD'
            WHEN (c.city = 'Yanan' AND c.netmodel = 'TDD') THEN '�Ӱ�TDD'
            WHEN (c.city = 'Tongchuan' AND c.netmodel = 'TDD') THEN 'ͭ��TDD'
            WHEN (c.city = 'Shangluo' AND c.netmodel = 'TDD') THEN '����TDD'
            WHEN (c.city = 'Xianyang' AND c.netmodel = 'TDD') THEN '����TDD'        
        ELSE NULL END) AS ����
            
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
        AND tab1.���� = tab9.����

    GROUP BY
        tab1.pm_date,
           tab1.LNCEL_ENB_ID,
           --tab1.LNCEL_LCR_ID,
           --tab1.lnbts_name,
           tab1.lnbts_objid,
           tab1.version,
        tab1.����,
        ��վ��,
        С����
    ) a
LEFT JOIN c_lte_lnbts lnbts ON lnbts.obj_gid = a.lnbts_objid  
