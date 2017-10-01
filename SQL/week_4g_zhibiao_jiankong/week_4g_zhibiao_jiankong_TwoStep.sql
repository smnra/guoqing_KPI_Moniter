select tab1.地市,
       round(设备完好率,2) "设备完好率",round(zb*100,2) "CQI≤4占比",
       round(zb_10*100,2) "CQI≥10占比"  from (select substr((CASE
                              WHEN (LNCEL_ENB_ID >= 782337 and
                                   LNCEL_ENB_ID <= 783592) THEN
                               '宝鸡FDD' --663个站点
							  WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN
          '宝鸡FDD' 
                              WHEN (LNCEL_ENB_ID >= 772600 and
                                   LNCEL_ENB_ID <= 774144) THEN
                               '西安FDD' --544个站点
                              WHEN (LNCEL_ENB_ID >= 778240 and
                                   LNCEL_ENB_ID <= 780287) THEN
                               '咸阳FDD' --860个站点
                              ELSE
                               'A'
                            END),
                            0,
                            2) 地市,
                     decode(sum(DENOM_CELL_AVAIL),
                            0,
                            0,
                            100 * sum(SAMPLES_CELL_AVAIL) /
                            sum(DENOM_CELL_AVAIL)) 设备完好率
                from c_lte_lncel                lncel,
                     c_lte_lnbts                lnbts,
                     noklte_PS_lcelav_lncel_day
               where noklte_PS_lcelav_lncel_day.LNCEL_ID = lncel.obj_gid
                 and noklte_PS_lcelav_lncel_day.LNBTS_ID = lnbts.obj_gid
                 and lncel.conf_id = 1
                 and lnbts.CONF_ID = 1
                 and noklte_PS_lcelav_lncel_day.PERIOD_START_TIME >=
                     to_date(&start_datetime, 'yyyymmddhh24')
                 and noklte_PS_lcelav_lncel_day.PERIOD_START_TIME <
                     to_date(&end_datetime, 'yyyymmddhh24')
               group by substr((CASE
                                 WHEN (LNCEL_ENB_ID >= 782337 and
                                      LNCEL_ENB_ID <= 783592) THEN
                                  '宝鸡FDD' --663个站点
								 WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN
          '宝鸡FDD' 
                                 WHEN (LNCEL_ENB_ID >= 772600 and
                                      LNCEL_ENB_ID <= 774144) THEN
                                  '西安FDD' --544个站点
                                 WHEN (LNCEL_ENB_ID >= 778240 and
                                      LNCEL_ENB_ID <= 780287) THEN
                                  '咸阳FDD' --860个站点
                                 ELSE
                                  'A'
                               END),
                               0,
                               2)) tab1,
       (
       select substr((CASE
                        WHEN (LNCEL_ENB_ID >= 782337 and LNCEL_ENB_ID <= 783592) THEN
                         '宝鸡FDD' --663个站点
						WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN
          '宝鸡FDD' 
                        WHEN (LNCEL_ENB_ID >= 772600 and LNCEL_ENB_ID <= 774144) THEN
                         '西安FDD' --544个站点
                        WHEN (LNCEL_ENB_ID >= 778240 and LNCEL_ENB_ID <= 780287) THEN
                         '咸阳FDD' --860个站点
                        ELSE
                         'A'
                      END),
                      0,
                      2) 地市,
  count(distinct lncel.lncel_enb_id*lncel.lncel_lcr_id) 小区数,
  sum(NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_00 +
                   NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_01 +
                   NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_02 +
                   NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_03 +
                   NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_04) /
               sum(NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_00 +
                   NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_01 +
                   NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_02 +
                   NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_03 +
                   NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_04 +
                   NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_05 +
                   NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_06 +
                   NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_07 +
                   NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_08 +
                   NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_09 +
                   NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_10 +
                   NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_11 +
                   NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_12 +
                   NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_13 +
                   NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_14 +
                   NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_15) zb,
                   sum(NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_10+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_11+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_12+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_13+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_14+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_15)/sum(NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_00+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_01+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_02+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_03+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_04+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_05+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_06+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_07+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_08+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_09+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_10+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_11+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_12+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_13+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_14+NOKLTE_PS_LPQDL_MNC1_RAW.UE_REP_CQI_LEVEL_15) zb_10               
  from c_lte_lncel lncel, c_lte_lnbts lnbts, NOKLTE_PS_LPQDL_MNC1_RAW
 where NOKLTE_PS_LPQDL_MNC1_RAW.LNCEL_ID = lncel.obj_gid
   and NOKLTE_PS_LPQDL_MNC1_RAW.LNBTS_ID = lnbts.obj_gid
   and lncel.conf_id = 1
   and lnbts.CONF_ID = 1
   and NOKLTE_PS_LPQDL_MNC1_RAW.PERIOD_START_TIME >=
       to_date(&start_datetime, 'yyyymmddhh24')
   and NOKLTE_PS_LPQDL_MNC1_RAW.PERIOD_START_TIME <
       to_date(&end_datetime, 'yyyymmddhh24')
 group by substr((CASE
                   WHEN (LNCEL_ENB_ID >= 782337 and LNCEL_ENB_ID <= 783592) THEN
                    '宝鸡FDD' --663个站点
				   WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN
          '宝鸡FDD' 
                   WHEN (LNCEL_ENB_ID >= 772600 and LNCEL_ENB_ID <= 774144) THEN
                    '西安FDD' --544个站点
                   WHEN (LNCEL_ENB_ID >= 778240 and LNCEL_ENB_ID <= 780287) THEN
                    '咸阳FDD' --860个站点
                   ELSE
                    'A'
                 END),
                 0,
                 2)
) tab2 
where tab1.地市 = tab2.地市(+)
and tab1.地市 <>'A'