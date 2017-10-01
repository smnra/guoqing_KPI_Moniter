SELECT
    tab1.DDATE,
    tab1.TTIME,
    tab1.����,
    tab9.��վ��,
    tab9.С����,
    tab1.LTEС�������ʷ���,
    tab1.LTEС�������ʷ�ĸ,
    tab1.LTEС��������, 
    tab1.LTEС��ƽ���˷�ʱ��s,
    tab1.LTEС�����˷�ʱ��s,
    tab6.PRACH�ɹ���,
    tab6.��������ͻ�������,
    tab6.cell�����ǰ��������,
    tab6.cell�����ǰ�����Ǿ�,
    tab2.���߽�ͨ��,
    tab2.RRC���ӽ����ɹ���,
    tab2.RRC���ӽ����������,
    tab2.RRC���ӽ����ɹ�����,
    tab7.RRC����ƽ��ʱ��,
    tab7.RRC�������ʱ��,
    tab2.Setup_comp_miss��Ӧ��,
    tab2.Setup_comp_errorС���ܾ�,
    tab2.Reject_RRM_RAC��Դ����ʧ,
    tab2.SIGN_CONN_ESTAB_FAIL_MAXRRC,
    tab7.RRC�ؽ��ɹ���,
    tab7.RRC�ؽ�����,
    tab7.RRC�ؽ��ɹ�����,
    tab7.RRC�ؽ�������HOԭ��,
    tab7.RRC�ؽ��ɹ���HOԭ��,
    tab7.RRC�ؽ�������otherԭ��,
    tab7.RRC�ؽ��ɹ���otherԭ��,
    tab2.ERAB�����ɹ���,
    tab2.ERAB�����������,
    tab2.ERAB�����ɹ�����,
    tab8.E_RAB����ƽ��ʱ��,
    tab8.E_RAB�������ʱ��,
    tab2.������Դӵ������,
    tab2.ERABʧ��_�����,
    tab2.ERAB����ʧ��_UE����Ӧ,    
    tab2.ERAB����ʧ��_��ȫģʽ, 
    tab2.E_RAB����ʧ��_������,
    tab2.E_RAB����ʧ��_���߲�,
    tab2.LTEҵ�������,
    tab2.LTEҵ���ͷŴ���,
    tab2.LTEҵ����ߴ���,
    tab2.MME�ͷŵ�ERAB�������,
    tab2.eNB�ͷŵ�ERAB�������,
    tab2.eNB�ͷŵ�ERAB��other,
    tab2.eNB�ͷŵ�ERAB�������,
    tab2.E_RAB�쳣�ͷ�_����ӵ��,  
    tab4.�տ�����ҵ���ֽ���MB,---MByte ��λ
    tab4.�տ�����ҵ��ƽ������,---Mbps��λ
    tab4.�տ�����ҵ���ֽ���MB,---MByte ��λ
    tab4.�տ�����ҵ��ƽ������,---Mbps��λ
    --tab5.����PRBƽ��������,
    --tab5.����PRBƽ��������, 
    tab5.����PRBƽ��������,
    tab5.����PRBƽ��������,
    tab6.ƽ��RRC������_avg,
    tab6.ƽ��RRC������_sum,
    tab6.���RRC������_sum,
    tab6.���RRC������_max,
    tab5.����PRB��������,
    tab5.����PRBռ������,    
    tab5.����PRBռ��ƽ����,
    tab5.����PRB��������,
    tab5.����PRBռ������,    
    tab5.����PRBռ��ƽ����,
    tab5.����������Դ������,
    tab5.����������Դ������, 
    tab6.ƽ�������û���,
    tab6.��󼤻��û���,
    tab10.ƽ��E_RAB��,
    tab10.ÿ�û�ƽ��E_RAB��,
    tab10.���м���E_RAB��,
    tab10.���м���E_RAB��,
    tab5.����PRB��Դʹ�ø���,
    tab5.����PRB��Դʹ�ø���, 
    tab5.CCEռ��,
    tab5.CCE����,
    tab11.С��ƽ�����书��,
    tab11.С������书�� 

FROM
    (SELECT 
        to_char(tab1.pm_date,'yyyymmdd') AS DDATE,
        to_char(tab1.pm_date,'hh24') AS TTIME,
        tab1.���� AS ����,
        sum(tab1.LTEС�������ʷ���) AS LTEС�������ʷ���,
        sum(tab1.LTEС�������ʷ�ĸ) AS LTEС�������ʷ�ĸ,
        round(decode(sum(tab1.LTEС�������ʷ�ĸ),0,0,sum(tab1.LTEС�������ʷ���)/sum(tab1.LTEС�������ʷ�ĸ)*100),2) AS LTEС��������, 
        round(avg(tab1.LTEС���˷�ʱ��),2) AS LTEС��ƽ���˷�ʱ��s,
        round(sum(tab1.LTEС���˷�ʱ��),2) AS LTEС�����˷�ʱ��s
          
    FROM 
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            c.lncel_lcr_id AS lncel_lcr_id,
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
            ELSE NULL END) ����,
            ROUND(DECODE(SUM(DENOM_CELL_AVAIL),0,0,100 * SUM(SAMPLES_CELL_AVAIL) / SUM(DENOM_CELL_AVAIL)),2) AS LTEС��������,
            SUM(SAMPLES_CELL_AVAIL) LTEС�������ʷ���,
            SUM(DENOM_CELL_AVAIL) LTEС�������ʷ�ĸ,
            SUM(DENOM_CELL_AVAIL - SAMPLES_CELL_AVAIL) * 10 AS LTEС���˷�ʱ��
            
        FROM 
            NOKLTE_PS_LCELAV_LNCEL_HOUR lcelav
            INNER JOIN C_LTE_CUSTOM c ON c.lncel_objid = lcelav.lncel_id

        WHERE 

                lcelav.period_start_time >= to_date(&start_datetime,'yyyymmdd')
            AND lcelav.period_start_time <  to_date(&end_datetime,'yyyymmdd')
        
        GROUP BY
            lcelav.period_start_time��
            c.lnbtsid,
            c.lncel_lcr_id,
            c.city,
            c.netmodel
            
        ) tab1

    GROUP BY
        to_char(tab1.pm_date,'yyyymmdd'),
        to_char(tab1.pm_date,'hh24'),
        tab1.����
        
    ) tab1,


    (SELECT 
        to_char(tab2.pm_date,'yyyymmdd') AS DDATE,
        to_char(tab2.pm_date,'hh24') AS TTIME,
        tab2.���� AS ����,
        round((decode(sum(tab2.RRC���ӽ����������),0,0,sum(tab2.RRC���ӽ����ɹ�����)/sum(tab2.RRC���ӽ����������)))*(decode(SUM(tab2.ERAB�����������),0,0,sum(tab2.ERAB�����ɹ�����)/SUM(tab2.ERAB�����������)))*100,2) AS ���߽�ͨ��,
        round(decode(sum(tab2.RRC���ӽ����������),0,0,sum(tab2.RRC���ӽ����ɹ�����)/sum(tab2.RRC���ӽ����������))*100,2) AS RRC���ӽ����ɹ���,
        sum(tab2.RRC���ӽ����������) AS RRC���ӽ����������,
        sum(tab2.RRC���ӽ����ɹ�����) AS RRC���ӽ����ɹ�����,
        sum(tab2.Setup_comp_miss��Ӧ��) AS Setup_comp_miss��Ӧ��,
        sum(tab2.Setup_comp_errorС���ܾ�) AS Setup_comp_errorС���ܾ�,
        sum(tab2.Reject_RRM_RAC��Դ����ʧ) AS Reject_RRM_RAC��Դ����ʧ,
        sum(tab2.SIGN_CONN_ESTAB_FAIL_MAXRRC) as SIGN_CONN_ESTAB_FAIL_MAXRRC,
        round(decode(SUM(tab2.ERAB�����������),0,0,sum(tab2.ERAB�����ɹ�����)/SUM(tab2.ERAB�����������))*100,2) AS ERAB�����ɹ���,
        sum(tab2.ERAB�����������) AS ERAB�����������,
        sum(tab2.ERAB�����ɹ�����) AS ERAB�����ɹ�����,
        sum(tab2.������Դӵ������) AS ������Դӵ������,
        sum(tab2.������Դӵ������) AS ERABʧ��_�����,
        sum(tab2.ERAB����ʧ��_UE����Ӧ) AS ERAB����ʧ��_UE����Ӧ,    
        sum(tab2.ERAB����ʧ��_����) AS ERAB����ʧ��_��ȫģʽ, 
        ROUND(avg(tab2.E_RAB����ʧ��_������),0) AS E_RAB����ʧ��_������,
        ROUND(avg(tab2.E_RAB����ʧ��_���߲�),0) AS E_RAB����ʧ��_���߲�,
        round(decode(sum(tab2.LTEҵ���ͷŴ���),0,0,sum(tab2.LTEҵ����ߴ���)/sum(tab2.LTEҵ���ͷŴ���))*100,2) AS LTEҵ�������,
        sum(tab2.LTEҵ���ͷŴ���) AS LTEҵ���ͷŴ���,
        sum(tab2.LTEҵ����ߴ���) AS LTEҵ����ߴ���,
        sum(tab2.EPC_EPS_BEARER_REL_REQ_RNL) AS MME�ͷŵ�ERAB�������,
        sum(tab2.ENB_EPS_BEARER_REL_REQ_RNL) AS eNB�ͷŵ�ERAB�������,
        sum(tab2.ENB_EPS_BEARER_REL_REQ_OTH) AS eNB�ͷŵ�ERAB��other,
        sum(tab2.ENB_EPS_BEARER_REL_REQ_TNL) AS eNB�ͷŵ�ERAB�������,
        sum(tab2.EPC_EPS_BEAR_REL_REQ_R_QCI1) AS  E_RAB�쳣�ͷ�_����ӵ��

    FROM 
        (SELECT
            c.lnbtsid AS lncel_enb_id,
            c.lncel_lcr_id AS lncel_lcr_id,
            luest.period_start_time AS pm_date,
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
            decode((CASE WHEN c.version='FL16' THEN 'FL16' WHEN c.version='FLF16' THEN 'FL16' WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(lepsb.ERAB_INI_SETUP_FAIL_RNL_RIP + lepsb.ERAB_ADD_SETUP_FAIL_RNL_RIP),'') AS E_RAB����ʧ��_���߲�, --LN7.0�޴�ָ��
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
        tab2.����
    ) tab2,
        
        
        
        
    (SELECT 
        to_char(tab4.pm_date,'yyyymmdd') AS DDATE,
        to_char(tab4.pm_date,'hh24') AS TTIME,
        tab4.���� AS ����,
        round(sum(tab4.�տ�����ҵ���ֽ���MB)/1024,2) AS �տ�����ҵ���ֽ���MB,---MByte ��λ
        round(decode(sum(tab4.ACTIVE_TTI_UL),0,0,(sum(tab4.�տ�����ҵ���ֽ���MB)*1000*8)/sum(tab4.ACTIVE_TTI_UL)/1024),2) AS �տ�����ҵ��ƽ������,---Mbps��λ
        round(sum(tab4.�տ�����ҵ���ֽ���MB)/1024,2) AS �տ�����ҵ���ֽ���MB,---MByte ��λ
        round(decode(sum(tab4.ACTIVE_TTI_DL),0,0,(sum(tab4.�տ�����ҵ���ֽ���MB)*1000*8)/sum(tab4.ACTIVE_TTI_DL)/1024),2) AS �տ�����ҵ��ƽ������---Mbps��λ
      
    FROM 
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            c.lncel_lcr_id AS lncel_lcr_id,
            lcellt.period_start_time AS pm_date,
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
            decode(sum(lcellt.ACTIVE_TTI_UL),0,0,sum(lcellt.PDCP_SDU_VOL_UL) * 8 * 1000 /
                sum(lcellt.ACTIVE_TTI_UL*1024)) AS �տ�����ҵ��ƽ������,
            SUM(PDCP_SDU_VOL_UL) / 1024 AS �տ�����ҵ���ֽ���MB,
            sum(lcellt.ACTIVE_TTI_UL)  AS ACTIVE_TTI_UL,
            decode(sum(lcellt.ACTIVE_TTI_DL), 0, 0,sum(lcellt.PDCP_SDU_VOL_DL) * 8 * 1000 /
                sum(lcellt.ACTIVE_TTI_DL*1024)) AS �տ�����ҵ��ƽ������,
            SUM(PDCP_SDU_VOL_DL) / 1024 AS �տ�����ҵ���ֽ���MB,
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
        tab4.����
        
    ) tab4,    
        
        
        
    (SELECT 
        to_char(tab5.pm_date,'yyyymmdd') AS DDATE,
        to_char(tab5.pm_date,'hh24') AS TTIME,
        tab5.���� AS ����,
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
        round(sum(tab5.����PRB��Դʹ�ø���),0) AS ����PRB��Դʹ�ø���,
        round(sum(tab5.����PRB��Դʹ�ø���),0) AS ����PRB��Դʹ�ø���, 
        round(avg(tab5.CCEռ��),2) AS CCEռ��,
        round(avg(tab5.CCE����),2) AS CCE����
        
    FROM 
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            c.lncel_lcr_id AS lncel_lcr_id,
            lcellr.period_start_time AS pm_date,
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
        tab5.����

    ) tab5,
        
        
        
        
    (SELECT 
        to_char(tab6.pm_date,'yyyymmdd') AS DDATE,
        to_char(tab6.pm_date,'hh24') AS TTIME,
        tab6.���� AS ����,
        round(avg(tab6.ƽ��RRC������_avg),2) ƽ��RRC������_avg,
        round(sum(tab6.ƽ��RRC������_sum),2) ƽ��RRC������_sum,
        sum(tab6.���RRC������_sum) ���RRC������_sum,
        max(tab6.���RRC������_max) ���RRC������_max,
        sum(tab6.��������ͻ�������) as ��������ͻ�������,
        sum(tab6.cell�����ǰ��������) as cell�����ǰ��������,
        sum(tab6.cell�����ǰ�����Ǿ�) as cell�����ǰ�����Ǿ�,
        round(decode(sum(tab6.cell�����ǰ��������+tab6.cell�����ǰ�����Ǿ�),0,0,sum(tab6.��������ͻ�������)/sum(tab6.cell�����ǰ��������+tab6.cell�����ǰ�����Ǿ�))*100,2) AS PRACH�ɹ���,
        round(sum(tab6.ƽ�������û���),0) AS ƽ�������û���,
        round(sum(tab6.��󼤻��û���),0) AS ��󼤻��û���
        
    FROM 
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            c.lncel_lcr_id AS lncel_lcr_id,
            lcelld.period_start_time AS pm_date,
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
        tab6.����
        
    ) tab6,   
     
        

        
    (SELECT 
        to_char(tab7.pm_date,'yyyymmdd') AS DDATE,
        to_char(tab7.pm_date,'hh24') AS TTIME,
        tab7.���� AS ����,
        ROUND(avg(tab7.RRC����ƽ��ʱ��),0) AS RRC����ƽ��ʱ��,
        ROUND(max(tab7.RRC�������ʱ��),0) AS RRC�������ʱ��,
        round(decode(sum(tab7.RRC�ؽ�����),0,0,sum(tab7.RRC�ؽ��ɹ�����)/sum(tab7.RRC�ؽ�����)*100),2) AS RRC�ؽ��ɹ���,
        sum(tab7.RRC�ؽ�����) AS RRC�ؽ�����,
        sum(tab7.RRC�ؽ��ɹ�����) AS RRC�ؽ��ɹ�����,
        sum(tab7.RRC�ؽ�������HOԭ��) AS RRC�ؽ�������HOԭ��,
        sum(tab7.RRC�ؽ��ɹ���HOԭ��) AS RRC�ؽ��ɹ���HOԭ��,
        sum(tab7.RRC�ؽ�������otherԭ��) AS RRC�ؽ�������otherԭ��,
        sum(tab7.RRC�ؽ��ɹ���otherԭ��) AS RRC�ؽ��ɹ���otherԭ��

    FROM 
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            c.lncel_lcr_id AS lncel_lcr_id,
            lrrc.period_start_time AS pm_date,
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
        tab7.����    
        
    ) tab7,    
        
        
        

        
    (SELECT 
        to_char(tab8.pm_date,'yyyymmdd') AS DDATE,
        to_char(tab8.pm_date,'hh24') AS TTIME,
        tab8.���� AS ����,
        ROUND(avg(tab8.E_RAB����ƽ��ʱ��),0) AS E_RAB����ƽ��ʱ��,
        ROUND(max(tab8.E_RAB�������ʱ��),0) AS E_RAB�������ʱ��
        
    FROM 
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            c.lncel_lcr_id AS lncel_lcr_id,
            lrdb.period_start_time AS pm_date,
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
            round(avg(lrdb.ERAB_SETUP_TIME_MEAN),4) AS E_RAB����ƽ��ʱ��, 
            max(lrdb.ERAB_SETUP_TIME_MAX) AS E_RAB�������ʱ��
            
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
        tab8.����

    ) tab8,   
        
        
        
        
    (SELECT     
        to_char(lcelav.period_start_time,'yyyymmdd') AS DDATE,
        to_char(lcelav.period_start_time,'hh24') AS TTIME,
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
        ELSE NULL END) AS ����,
        count(distinct c.lnbtsid) ��վ��,
        count(distinct c.lnbtsid*c.lncel_lcr_id) AS С����
        
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
        tab10.���� AS ����,
        round(avg(tab10.ƽ��E_RAB��), 2) AS ƽ��E_RAB��,
        round(avg(tab10.ÿ�û�ƽ��E_RAB��), 2) AS ÿ�û�ƽ��E_RAB��,
        round(avg(tab10.���м���E_RAB��), 2) AS ���м���E_RAB��,
        round(avg(tab10.���м���E_RAB��), 2) AS ���м���E_RAB��
        
    FROM 
        (SELECT 
            c.lnbtsid AS lncel_enb_id,
            c.lncel_lcr_id AS lncel_lcr_id,
            lepsb.period_start_time AS pm_date, 
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
            ROUND(DECODE(AVG(lepsb.DENOM_SUM_SIMUL_ERAB),0,NULL, AVG(lepsb.SUM_SIMUL_ERAB_QCI_1 + lepsb.SUM_SIMUL_ERAB_QCI_2 + lepsb.SUM_SIMUL_ERAB_QCI_3 + lepsb.SUM_SIMUL_ERAB_QCI_4 +   lepsb.SUM_SIMUL_ERAB_QCI_5 + lepsb.SUM_SIMUL_ERAB_QCI_6 +  lepsb.SUM_SIMUL_ERAB_QCI_7 + lepsb.SUM_SIMUL_ERAB_QCI_8 +   lepsb.SUM_SIMUL_ERAB_QCI_9) / AVG(lepsb.DENOM_SUM_SIMUL_ERAB)),8) AS  ƽ��E_RAB��,
            ROUND(DECODE(AVG(lepsb.DENOM_SUM_SIMUL_ERAB * lcelld.CELL_LOAD_ACT_UE_AVG),0,NULL, AVG(lepsb.SUM_SIMUL_ERAB_QCI_1 + lepsb.SUM_SIMUL_ERAB_QCI_2 + lepsb.SUM_SIMUL_ERAB_QCI_3 + lepsb.SUM_SIMUL_ERAB_QCI_4 + lepsb.SUM_SIMUL_ERAB_QCI_5 + lepsb.SUM_SIMUL_ERAB_QCI_6 + lepsb.SUM_SIMUL_ERAB_QCI_7 + lepsb.SUM_SIMUL_ERAB_QCI_8 +   lepsb.SUM_SIMUL_ERAB_QCI_9) / AVG(lepsb.DENOM_SUM_SIMUL_ERAB * lcelld.CELL_LOAD_ACT_UE_AVG)),8)  AS  ÿ�û�ƽ��E_RAB��,
            ROUND(decode(AVG(lcelld.DENOM_ACTIVE_UE_DATA_UL),0,null,AVG(lcelld.SUM_ACTIVE_UE_DATA_UL)/AVG(lcelld.DENOM_ACTIVE_UE_DATA_UL)),8) AS ���м���E_RAB��,
            ROUND(decode(AVG(lcelld.DENOM_ACTIVE_UE_DATA_DL),0,null,AVG(lcelld.SUM_ACTIVE_UE_DATA_DL)/AVG(lcelld.DENOM_ACTIVE_UE_DATA_DL)),8) AS ���м���E_RAB��
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
        tab10.����

    ) tab10,

        
        
        
    (SELECT 
        to_char(tab11.pm_date,'yyyymmdd') AS DDATE,
        to_char(tab11.pm_date,'hh24') AS TTIME,
        tab11.���� AS ����,
        round(avg(tab11.С��ƽ�����书��),2) AS С��ƽ�����书��,
        round(max(tab11.С������书��),0) AS С������书��
        
    FROM 
        (SELECT
            c.lnbtsid AS lncel_enb_id,
            c.lncel_lcr_id AS lncel_lcr_id,
            lpqdl.period_start_time AS pm_date,  
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
            --������ָ��LN7.0��FL16 ָ�깫ʽ��һ�£�LNBTS �޴�ָ�ꡣ
            decode(AVG(lpqdl.AVG_TRANS_PWR),0,0,10*log(10,AVG(lpqdl.AVG_TRANS_PWR))) AS С��ƽ�����书��, 
            decode(MAX(lpqdl.MAX_TRANS_PWR),0,0,10*log(10,MAX(lpqdl.MAX_TRANS_PWR))) AS С������书��    
            
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
        tab11.����

    ) tab11    
    
    
    
    
    
WHERE
        tab1.DDATE = tab2.DDATE AND tab1.���� = tab2.���� AND tab1.TTIME = tab2.TTIME
    AND tab1.DDATE = tab4.DDATE AND tab1.���� = tab4.���� AND tab1.TTIME = tab4.TTIME
    AND tab1.DDATE = tab5.DDATE AND tab1.���� = tab5.���� AND tab1.TTIME = tab5.TTIME
    AND tab1.DDATE = tab6.DDATE AND tab1.���� = tab6.���� AND tab1.TTIME = tab6.TTIME
    AND tab1.DDATE = tab7.DDATE AND tab1.���� = tab7.���� AND tab1.TTIME = tab7.TTIME
    AND tab1.DDATE = tab8.DDATE AND tab1.���� = tab8.���� AND tab1.TTIME = tab8.TTIME
    AND tab1.DDATE = tab9.DDATE AND tab1.���� = tab9.���� AND tab1.TTIME = tab9.TTIME
    AND tab1.DDATE = tab10.DDATE AND tab1.���� = tab10.���� AND tab1.TTIME = tab10.TTIME
    AND tab1.DDATE = tab11.DDATE AND tab1.���� = tab11.���� AND tab1.TTIME = tab11.TTIME
    
    
    
    
    
