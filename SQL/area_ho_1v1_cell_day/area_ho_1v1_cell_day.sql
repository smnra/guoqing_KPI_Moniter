Select To_Char(pmraw.PERIOD_START_TIME, 'yyyymmdd') As SDATE,
       pmraw.LNCEL_ID As S_LNCEL_GID,
       To_Number(s.enodebid) As S_ENB,
       To_Number(s.lncel_id) As S_CEL,
       To_Number(s.ecgi) As S_ECI,
       To_Number(t.enodebid) As T_ENB,
       To_Number(t.lncel_id) As T_CEL,
       To_Number(pmraw.ECI_ID) As T_ECI,
       (CASE
         WHEN (s.enodebid >= 782337 and s.enodebid <= 783592) THEN
          '宝鸡FDD' --663个站点
         WHEN (s.enodebid >= 775936 and s.enodebid <= 776286) THEN '宝鸡FDD' 
         WHEN (s.enodebid >= 772600 and s.enodebid <= 774144) THEN
          '西安FDD' --544个站点
         WHEN (s.enodebid >= 778240 and s.enodebid <= 780287) THEN
          '咸阳FDD' --860个站点
         WHEN (s.enodebid >= 783593 and s.enodebid <= 783615) THEN
          '宝鸡TDD' --23个站点
         WHEN (s.enodebid >= 788460 and s.enodebid <= 788479) THEN
          '汉中TDD' --20个站点
         WHEN (s.enodebid >= 789499 and s.enodebid <= 789503) THEN
          '商洛TDD' --5个站点
         WHEN (s.enodebid >= 787448 and s.enodebid <= 787455) THEN
          '铜川TDD' --8个站点
         WHEN (s.enodebid >= 778100 and s.enodebid <= 778239) THEN
          '西安TDD' --40个站点
         WHEN (s.enodebid >= 786416 and s.enodebid <= 786431) THEN
          '延安TDD' --16个站点
         WHEN (s.enodebid >= 782323 and s.enodebid <= 782335) THEN
          '榆林TDD' --13个站点
       
         ELSE
          NULL
       END) 区域,
       
       Round(decode(Sum(NVL(pmraw.INTRA_HO_ATT_NB, 0) +
                        NVL(pmraw.INTER_HO_ATT_NB, 0)),
                    0,
                    null,
                    Sum(NVL(pmraw.INTRA_HO_SUCC_NB, 0) +
                        NVL(pmraw.INTER_HO_SUCC_NB, 0)) /
                    Sum(NVL(pmraw.INTRA_HO_ATT_NB, 0) +
                        NVL(pmraw.INTER_HO_ATT_NB, 0)) * 100),
             2) As ho_succ_ratio,
       Sum(NVL(pmraw.INTRA_HO_ATT_NB, 0) + NVL(pmraw.INTER_HO_ATT_NB, 0)) As HO_ATT,
       Sum(NVL(pmraw.INTRA_HO_SUCC_NB, 0) + NVL(pmraw.INTER_HO_SUCC_NB, 0)) As HO_SUCC,
       Sum(NVL(pmraw.INTRA_HO_ATT_NB, 0) + NVL(pmraw.INTER_HO_ATT_NB, 0) -
           NVL(pmraw.INTRA_HO_SUCC_NB, 0) - NVL(pmraw.INTER_HO_SUCC_NB, 0)) As HO_ATT_FAILS,
       Sum(NVL(pmraw.INTRA_HO_FAIL_NB, 0) + NVL(pmraw.INTER_HO_FAIL_NB, 0)) As HO_FAIL,
       Sum(NVL(pmraw.INTRA_HO_DROPS_NB, 0) +
           NVL(pmraw.INTER_HO_DROPS_NB, 0)) As HO_DROPS,
       Sum(NVL(pmraw.MRO_LATE_HO_NB, 0)) As LATE_HO,
       Sum(NVL(pmraw.MRO_EARLY_TYPE1_HO_NB, 0)) As EARLY_TYPE1_HO,
       Sum(NVL(pmraw.MRO_EARLY_TYPE2_HO_NB, 0)) As EARLY_TYPE2_HO,
       Sum(NVL(pmraw.MRO_PING_PONG_HO_NB, 0)) As PING_PONG
  From NOKLTERAW.NOKLTE_P_LNCELHO_DMNC1_PMC pmraw
  Left Join (Select lnbts.CO_OBJECT_INSTANCE              As enodebid,
                    lnbts.CO_NAME                         As sitename,
                    lncel.CO_OBJECT_INSTANCE              As lncel_id,
                    CMDLTE.C_LTE_LNCEL.LNCEL_EUTRA_CEL_ID As ecgi
               From UMA.UTP_COMMON_OBJECTS lncel
               Left Join UMA.UTP_COMMON_OBJECTS lnbts
                 On lncel.CO_PARENT_GID = lnbts.CO_GID
               Left Join CMDLTE.C_LTE_LNCEL
                 On lncel.CO_GID = CMDLTE.C_LTE_LNCEL.OBJ_GID
              Where lncel.CO_OC_ID = 3130
                And lnbts.CO_OC_ID = 3129
                And CMDLTE.C_LTE_LNCEL.CONF_ID = 1) t
    On pmraw.ECI_ID = t.ecgi
  Left Join (Select lnbts.CO_OBJECT_INSTANCE              As enodebid,
                    lnbts.CO_NAME                         As sitename,
                    lncel.CO_OBJECT_INSTANCE              As lncel_id,
                    CMDLTE.C_LTE_LNCEL.LNCEL_EUTRA_CEL_ID As ecgi,
                    lncel.CO_GID
               From UMA.UTP_COMMON_OBJECTS lncel
               Left Join UMA.UTP_COMMON_OBJECTS lnbts
                 On lncel.CO_PARENT_GID = lnbts.CO_GID
               Left Join CMDLTE.C_LTE_LNCEL
                 On lncel.CO_GID = CMDLTE.C_LTE_LNCEL.OBJ_GID
              Where lncel.CO_OC_ID = 3130
                And lnbts.CO_OC_ID = 3129
                And CMDLTE.C_LTE_LNCEL.CONF_ID = 1) s
    On pmraw.LNCEL_ID = s.CO_GID
 Where pmraw.PERIOD_START_TIME >= To_Date(&start_datetime, 'yyyymmdd')
   And pmraw.PERIOD_START_TIME < To_Date(&end_datetime, 'yyyymmdd')
 Group By (CASE
            WHEN (s.enodebid >= 782337 and s.enodebid <= 783592) THEN
             '宝鸡FDD' --663个站点
            WHEN (s.enodebid >= 775936 and s.enodebid <= 776286) THEN '宝鸡FDD' 
            WHEN (s.enodebid >= 772600 and s.enodebid <= 774144) THEN
             '西安FDD' --544个站点
            WHEN (s.enodebid >= 778240 and s.enodebid <= 780287) THEN
             '咸阳FDD' --860个站点
            WHEN (s.enodebid >= 783593 and s.enodebid <= 783615) THEN
             '宝鸡TDD' --23个站点
            WHEN (s.enodebid >= 788460 and s.enodebid <= 788479) THEN
             '汉中TDD' --20个站点
            WHEN (s.enodebid >= 789499 and s.enodebid <= 789503) THEN
             '商洛TDD' --5个站点
            WHEN (s.enodebid >= 787448 and s.enodebid <= 787455) THEN
             '铜川TDD' --8个站点
            WHEN (s.enodebid >= 778100 and s.enodebid <= 778239) THEN
             '西安TDD' --40个站点
            WHEN (s.enodebid >= 786416 and s.enodebid <= 786431) THEN
             '延安TDD' --16个站点
            WHEN (s.enodebid >= 782323 and s.enodebid <= 782335) THEN
             '榆林TDD' --13个站点
            ELSE
             NULL
          END),
          To_Char(pmraw.PERIOD_START_TIME, 'yyyymmdd'),
          pmraw.LNCEL_ID,
          s.enodebid,
          s.lncel_id,
          s.ecgi,
          t.enodebid,
          t.lncel_id,
          pmraw.ECI_ID
      Having(Sum(NVL(pmraw.INTRA_HO_PREP_FAIL_NB, 0) + NVL(pmraw.INTER_HO_PREP_FAIL_OTH_NB, 0) + NVL(pmraw.INTER_HO_PREP_FAIL_TIME_NB, 0) +
 NVL(pmraw.INTER_HO_PREP_FAIL_AC_NB, 0)) > 0) Or (Sum(NVL(pmraw.INTRA_HO_ATT_NB, 0) + NVL(pmraw.INTER_HO_ATT_NB, 0)) > 0)
 Order By SDATE, S_ENB, S_CEL
