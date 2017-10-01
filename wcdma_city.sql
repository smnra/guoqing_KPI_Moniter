with 
busyhour AS (
    SELECT 
        m1.wcel_id,
        mm.pm_date AS pm_date_hour
    FROM
        (select 
            wcel_id,
            to_char(to_date(pm_date,'yyyymmddhh24'), 'yyyymmdd') as pm_date,

            max(最大业务量) AS 最大业务量
        from    
                (SELECT 
            traffic.wcel_id AS wcel_id,
            to_char(traffic.period_start_time, 'yyyymmddhh24') pm_date,
            SUM((traffic.DUR_FOR_AMR_4_75_UL_IN_SRNC+ traffic.DUR_FOR_AMR_5_15_UL_IN_SRNC +
                traffic.DUR_FOR_AMR_5_9_UL_IN_SRNC+ traffic.DUR_FOR_AMR_6_7_UL_IN_SRNC+
                traffic.DUR_FOR_AMR_7_4_UL_IN_SRNC+ traffic.DUR_FOR_AMR_7_95_UL_IN_SRNC+
                traffic.DUR_FOR_AMR_10_2_UL_IN_SRNC+ traffic.DUR_FOR_AMR_12_2_UL_IN_SRNC)/(
                traffic.PERIOD_DURATION*100*60)) AS 最大业务量
                --语音含切话务量
        FROM 
            NOKRWW_PS_TRAFFIC_MNC1_RAW traffic
        WHERE 
                traffic.period_start_time >= to_date(&start_date, 'yyyy-mm-dd')
            AND traffic.period_start_time < to_date(&end_date, 'yyyy-mm-dd')


        GROUP BY 
            traffic.wcel_id,
            to_char(traffic.period_start_time, 'yyyymmddhh24')
            )
        group by 
            wcel_id,
            to_char(to_date(pm_date,'yyyymmddhh24'), 'yyyymmdd')
        ) m1
        
    left JOIN 
            
        (SELECT 
            traffic.wcel_id AS wcel_id,
            to_char(traffic.period_start_time, 'yyyymmddhh24') pm_date,
            SUM((traffic.DUR_FOR_AMR_4_75_UL_IN_SRNC+ traffic.DUR_FOR_AMR_5_15_UL_IN_SRNC +
                traffic.DUR_FOR_AMR_5_9_UL_IN_SRNC+ traffic.DUR_FOR_AMR_6_7_UL_IN_SRNC+
                traffic.DUR_FOR_AMR_7_4_UL_IN_SRNC+ traffic.DUR_FOR_AMR_7_95_UL_IN_SRNC+
                traffic.DUR_FOR_AMR_10_2_UL_IN_SRNC+ traffic.DUR_FOR_AMR_12_2_UL_IN_SRNC)/(
                traffic.PERIOD_DURATION*100*60)) AS 最大业务量
            
        FROM 
            NOKRWW_PS_TRAFFIC_MNC1_RAW traffic
        WHERE 
                traffic.period_start_time >= to_date(&start_date, 'yyyy-mm-dd')
            AND traffic.period_start_time < to_date(&end_date, 'yyyy-mm-dd')


        GROUP BY 
            traffic.wcel_id,
            to_char(traffic.period_start_time, 'yyyymmddhh24')
        )   mm ON m1.wcel_id = mm.wcel_id  AND m1.最大业务量 = mm.最大业务量 AND mm.最大业务量<>0
    
    
    ORDER BY 
        m1.wcel_id
)




select
    c.city,
    --c.wcel_rnc_id,
    --c.ci,
    traffic.period_start_time,
    round(SUM(traffic.语音含切话务量),2) AS "全天话务量（ERL）",
    round(SUM(celltp.数据下行MB + celltp.数据上行MB)/1000,2) AS "全天上下行流量_GB",
    
    
    round(decode(sum(servlev.RRC建立成功率_Y),0,null,sum(servlev.RRC建立成功率_X)/sum(servlev.RRC建立成功率_Y)) * decode(sum(servlev.RAB建立成功率_Y),0,null,sum(servlev.RAB建立成功率_X)/sum(servlev.RAB建立成功率_Y))*100,2)  as 无线接通率,

  
    --round(decode(sum(servlev.RRC建立成功率_Y),0,null,
    --sum(servlev.RRC建立成功率_X)/sum(servlev.RRC建立成功率_Y))*100,2) AS "RRC建立成功率",
    --round(decode(sum(servlev.RAB建立成功率_Y),0,null,
    --sum(servlev.RAB建立成功率_X)/sum(servlev.RAB建立成功率_Y))*100,2) AS "RAB建立成功率",
    
    

    /* servlev.语音业务掉话率 AS "电路域业务掉话率(%)", */
    round(decode(sum(servlev.语音业务掉话率_Y),0,null,
    sum(servlev.语音业务掉话率_X)/sum(servlev.语音业务掉话率_Y))*100,2) AS "CS掉话率",



    /* servlev.分组业务掉线率 AS "分组域业务掉话率(%)", */
    round(decode(sum(servlev.分组业务掉线率_Y),0,null,
    sum(servlev.分组业务掉线率_X)/sum(servlev.分组业务掉线率_Y))*100,2) AS "PS掉话率",


    /* softho.小区拥塞率 AS "小区拥塞率(%)", */
    round(decode(sum(servlev.小区拥塞率_Y),0,null,
    sum(servlev.小区拥塞率_X)/sum(servlev.小区拥塞率_Y))*100,2) AS "拥塞率"


     

from
    (SELECT
        traffic.WCEL_ID,
        to_char(traffic.PERIOD_START_TIME,'yyyy-mm-dd')  AS PERIOD_START_TIME,

        round(SUM((traffic.DUR_FOR_AMR_4_75_UL_IN_SRNC+ traffic.DUR_FOR_AMR_5_15_UL_IN_SRNC +
        traffic.DUR_FOR_AMR_5_9_UL_IN_SRNC+ traffic.DUR_FOR_AMR_6_7_UL_IN_SRNC+
        traffic.DUR_FOR_AMR_7_4_UL_IN_SRNC+ traffic.DUR_FOR_AMR_7_95_UL_IN_SRNC+
        traffic.DUR_FOR_AMR_10_2_UL_IN_SRNC+ traffic.DUR_FOR_AMR_12_2_UL_IN_SRNC)/(
        traffic.PERIOD_DURATION*100*60)),2) As 语音含切话务量



    From
        NOKRWW_PS_TRAFFIC_MNC1_RAW traffic
        --inner join busyhour on traffic.wcel_id = busyhour.wcel_id
        --    and to_char(traffic.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour
        
    WHERE
        traffic.period_start_time >= To_Date(&start_date, 'yyyy-mm-dd')
        AND traffic.period_start_time <  To_Date(&end_date, 'yyyy-mm-dd')

    GROUP BY
        traffic.WCEL_ID,
        to_char(traffic.PERIOD_START_TIME,'yyyy-mm-dd')
) traffic

   
    
inner join   
    (SELECT
        celltp.WCEL_ID,
        to_char(celltp.PERIOD_START_TIME,'yyyy-mm-dd') AS PERIOD_START_TIME,

        Round(Sum(celltp.NRT_DCH_DL_DATA_VOL + celltp.HS_DSCH_DATA_VOL) / 1000000, 8) AS 数据下行MB,
        Round(Sum(celltp.NRT_DCH_UL_DATA_VOL + celltp.NRT_DCH_HSDPA_UL_DATA_VOL + celltp.NRT_EDCH_UL_DATA_VOL) / 1000000, 8) AS 数据上行MB
    From
        NOKRWW_PS_CELLTP_MNC1_RAW celltp
        --inner join busyhour on celltp.wcel_id = busyhour.wcel_id
        --    and to_char(celltp.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour
    WHERE
        celltp.period_start_time >= To_Date(&start_date, 'yyyy-mm-dd')
        AND celltp.period_start_time <  To_Date(&end_date, 'yyyy-mm-dd')

    GROUP BY
        celltp.WCEL_ID,
        to_char(celltp.PERIOD_START_TIME,'yyyy-mm-dd')

) celltp on traffic.WCEL_ID = celltp.WCEL_ID and traffic.PERIOD_START_TIME = celltp.PERIOD_START_TIME 
 
  
    
    
inner join   
    (SELECT
        servlev.WCEL_ID,
        to_char(servlev.PERIOD_START_TIME,'yyyy-mm-dd')  AS PERIOD_START_TIME,

        Sum(servlev.RRC_CONN_ACC_COMP + servlev.RRC_CON_SETUP_COMP_DIRECTED +
        rrc.CELL_FACH_STATE_CELL_PCH_INA + rrc.CELL_DCH_STATE_TO_CELL_PCH) As RRC建立成功率_X,

        Sum(servlev.RRC_CONN_STP_ATT + servlev.RRC_CONN_SETUP_COMP_AFT_DIR -
        servlev.RRC_CONN_STP_REJ_EMERG_CALL - servlev.RRC_CONN_ACC_REL_CELL_RESEL -
        servlev.RRC_CONN_SETUP_ATT_REPEAT + rrc.CELL_FACH_STATE_CELL_PCH_INA +
        rrc.CELL_DCH_STATE_TO_CELL_PCH) As RRC建立成功率_Y,

        Sum(servlev.RAB_ACC_COMP_CS_VOICE + servlev.RAB_ACC_COMP_CS_CONV +
        servlev.RAB_ACC_COMP_CS_STREA + servlev.RAB_ACC_COMP_PS_CONV +
        servlev.RAB_ACC_COMP_PS_STREA + servlev.RAB_ACC_COMP_PS_INTER +
        servlev.RAB_ACC_COMP_PS_BACKG) As RAB建立成功率_X,
        
        Sum(servlev.RAB_STP_ATT_CS_VOICE + servlev.RAB_STP_ATT_CS_CONV +
        servlev.RAB_STP_ATT_CS_STREA + servlev.RAB_STP_ATT_PS_CONV +
        servlev.RAB_STP_ATT_PS_STREA + servlev.RAB_STP_ATT_PS_INTER +
        servlev.RAB_STP_ATT_PS_BACKG) As RAB建立成功率_Y,

        Sum(servlev.rab_act_fail_ps_inter_bts + servlev.rab_act_fail_ps_inter_iu
        + servlev.rab_act_fail_ps_inter_iur + servlev.rab_act_fail_ps_inter_radio
        + servlev.rab_act_fail_ps_inter_rnc + servlev.rab_act_fail_ps_inter_ue
        + servlev.rab_act_fail_ps_inter_trans + servlev.rab_act_fail_ps_backg_bts
        + servlev.rab_act_fail_ps_backg_iu + servlev.rab_act_fail_ps_backg_iur
        + servlev.rab_act_fail_ps_backg_radio + servlev.rab_act_fail_ps_backg_rnc
        + servlev.rab_act_fail_ps_backg_ue + servlev.rab_act_fail_ps_backg_trans
        + servlev.rab_act_fail_ps_strea_bts + servlev.rab_act_fail_ps_strea_iu
        + servlev.rab_act_fail_ps_strea_iur + servlev.rab_act_fail_ps_strea_radio
        + servlev.rab_act_fail_ps_strea_rnc + servlev.rab_act_fail_ps_strea_ue
        + servlev.rab_act_fail_ps_strea_trans -  servlev.RAB_ACT_FAIL_PS_BACKG_PCH
        -  servlev.RAB_ACT_FAIL_PS_INT_PCH) As 分组业务掉线率_X,

        Sum(servlev.rab_act_comp_ps_strea + servlev.rab_act_comp_ps_backg
        + servlev.rab_act_comp_ps_inter + servlev.rab_act_rel_ps_strea_p_emp
        + servlev.rab_act_rel_ps_strea_srnc + servlev.rab_act_rel_ps_backg_srnc
        + servlev.rab_act_rel_ps_inter_srnc + servlev.rab_act_rel_ps_strea_hho
        + servlev.rab_act_rel_ps_backg_hho + servlev.rab_act_rel_ps_inter_hho
        + servlev.rab_act_rel_ps_strea_isho + servlev.rab_act_rel_ps_bgr_isho
        + servlev.rab_act_rel_ps_inter_isho + servlev.rab_act_fail_ps_strea_iu
        + servlev.rab_act_fail_ps_strea_radio + servlev.rab_act_fail_ps_strea_bts
        + servlev.rab_act_fail_ps_strea_iur + servlev.rab_act_fail_ps_strea_rnc
        + servlev.rab_act_fail_ps_strea_ue + servlev.rab_act_fail_ps_strea_trans
        + servlev.rab_act_fail_ps_inter_iu + servlev.rab_act_fail_ps_inter_radio
        + servlev.rab_act_fail_ps_inter_bts + servlev.rab_act_fail_ps_inter_iur
        + servlev.rab_act_fail_ps_inter_rnc + servlev.rab_act_fail_ps_inter_ue
        + servlev.rab_act_fail_ps_inter_trans + servlev.rab_act_fail_ps_backg_iu
        + servlev.rab_act_fail_ps_backg_radio + servlev.rab_act_fail_ps_backg_bts
        + servlev.rab_act_fail_ps_backg_iur + servlev.rab_act_fail_ps_backg_rnc
        + servlev.rab_act_fail_ps_backg_ue + servlev.rab_act_fail_ps_backg_trans
        +rrc.CELL_FACH_STATE_CELL_PCH_INA + rrc.CELL_DCH_STATE_TO_CELL_PCH) As 分组业务掉线率_Y,

        Sum(servlev.RAB_ACT_FAIL_CS_VOICE_IU + servlev.RAB_ACT_FAIL_CS_VOICE_RADIO +
        servlev.RAB_ACT_FAIL_CS_VOICE_BTS + servlev.RAB_ACT_FAIL_CS_VOICE_IUR +
        servlev.RAB_ACT_FAIL_CS_VOICE_RNC + servlev.RAB_ACT_FAIL_CS_VOICE_UE) As 语音业务掉话率_X,

        Sum(servlev.RAB_ACT_COMP_CS_VOICE + servlev.RAB_ACT_REL_CS_VOICE_SRNC +
        servlev.RAB_ACT_REL_CS_VOICE_P_EMP + servlev.RAB_ACT_FAIL_CS_VOICE_IU +
        servlev.RAB_ACT_FAIL_CS_VOICE_RADIO + servlev.RAB_ACT_FAIL_CS_VOICE_BTS +
        servlev.RAB_ACT_FAIL_CS_VOICE_IUR + servlev.RAB_ACT_FAIL_CS_VOICE_RNC +
        servlev.RAB_ACT_FAIL_CS_VOICE_UE) As 语音业务掉话率_Y,

        Sum(servlev.RAB_STP_FAIL_CS_VOICE_FROZBS
        + servlev.RAB_STP_FAIL_CS_CONV_FROZBS + servlev.RAB_STP_FAIL_CS_STREA_FROZBS +
        servlev.RAB_STP_FAIL_PS_CONV_FROZBS + servlev.RAB_STP_FAIL_PS_STREA_FROZBS +
        servlev.RAB_STP_FAIL_PS_INTER_FROZBS + servlev.RAB_STP_FAIL_PS_BACKG_FROZBS +
        servlev.RAB_STP_FAIL_CS_VOICE_RNC + servlev.RAB_STP_FAIL_CS_CONV_RNC +
        servlev.RAB_STP_FAIL_CS_STREA_RNC + servlev.RAB_STP_FAIL_PS_CONV_RNC +
        servlev.RAB_STP_FAIL_PS_STREA_RNC + servlev.RAB_STP_FAIL_PS_INTER_RNC +
        servlev.RAB_STP_FAIL_PS_BACKG_RNC + servlev.RAB_STP_FAIL_CS_VOICE_AC +
        servlev.RAB_STP_FAIL_CS_CONV_AC + servlev.RAB_STP_FAIL_CS_STREA_AC +
        servlev.RAB_STP_FAIL_PS_CONV_AC + servlev.RAB_STP_FAIL_PS_STREA_AC +
        servlev.RAB_STP_FAIL_PS_INTER_AC + servlev.RAB_STP_FAIL_PS_BACKG_AC +
        servlev.RAB_STP_FAIL_CS_V_IUB_AAL2 + servlev.RAB_STP_FAIL_CS_CO_IUB_AAL2 +
        servlev.RAB_STP_FAIL_CS_ST_IUB_AAL2 + servlev.RAB_STP_FAIL_PS_ST_IUB_AAL2) AS 小区拥塞率_X,

        Sum(servlev.RAB_STP_ATT_CS_VOICE + servlev.RAB_STP_ATT_CS_CONV +
        servlev.RAB_STP_ATT_CS_STREA + servlev.RAB_STP_ATT_PS_CONV +
        servlev.RAB_STP_ATT_PS_STREA + servlev.RAB_STP_ATT_PS_INTER + servlev.RAB_STP_ATT_PS_BACKG) AS 小区拥塞率_Y


    From
        NOKRWW_PS_SERVLEV_MNC1_RAW servlev
        
        inner join busyhour on servlev.wcel_id = busyhour.wcel_id
            and to_char(servlev.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour

        Left Join
            NOKRWW_PS_RRC_MNC1_RAW rrc
            ON servlev.period_start_time = rrc.period_start_time
            AND servlev.WCEL_ID = rrc.WCEL_ID
            and rrc.wcel_id = busyhour.wcel_id
            and to_char(rrc.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour

    WHERE
        servlev.period_start_time >= To_Date(&start_date, 'yyyy-mm-dd')
        AND servlev.period_start_time <  To_Date(&end_date, 'yyyy-mm-dd')

    GROUP BY
        servlev.WCEL_ID,
        to_char(servlev.PERIOD_START_TIME,'yyyy-mm-dd')

) servlev on traffic.WCEL_ID = servlev.WCEL_ID and traffic.PERIOD_START_TIME = servlev.PERIOD_START_TIME 


inner join c_w_custom c on c.wcel_objid = traffic.wcel_id

group by
    c.city,
    --c.wcel_rnc_id,
    --c.ci,
    traffic.period_start_time
       
    

    