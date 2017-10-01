with 
busyhour AS (
    SELECT 
        m1.lncel_id,
        mm.pm_date AS pm_date_hour
    FROM
        (select 
            lncel_id,
            to_char(to_date(pm_date,'yyyymmddhh24'), 'yyyymmdd') as pm_date,

            max(最大业务量) AS 最大业务量
        from    
                (SELECT 
            lcellt.lncel_id AS lncel_id,
            to_char(lcellt.period_start_time, 'yyyymmddhh24') pm_date,
            SUM(PDCP_SDU_VOL_UL + PDCP_SDU_VOL_DL)  AS 最大业务量
            
        FROM 
            NOKLTE_PS_LCELLT_LNCEL_HOUR lcellt
        WHERE 
                lcellt.period_start_time >= to_date(&start_date, 'yyyy-mm-dd')
            AND lcellt.period_start_time < to_date(&end_date, 'yyyy-mm-dd')


        GROUP BY 
            lcellt.lncel_id,
            to_char(lcellt.period_start_time, 'yyyymmddhh24')
            )
        group by 
            lncel_id,
            to_char(to_date(pm_date,'yyyymmddhh24'), 'yyyymmdd')
        ) m1
        
    left JOIN 
            
        (SELECT 
            lcellt.lncel_id AS lncel_id,
            to_char(lcellt.period_start_time, 'yyyymmddhh24') pm_date,
            SUM(PDCP_SDU_VOL_UL + PDCP_SDU_VOL_DL)  AS 最大业务量
            
        FROM 
            NOKLTE_PS_LCELLT_LNCEL_HOUR lcellt
        WHERE 
                lcellt.period_start_time >= to_date(&start_date, 'yyyy-mm-dd')
            AND lcellt.period_start_time < to_date(&end_date, 'yyyy-mm-dd')


        GROUP BY 
            lcellt.lncel_id,
            to_char(lcellt.period_start_time, 'yyyymmddhh24')
        )   mm ON m1.lncel_id = mm.lncel_id  AND m1.最大业务量 = mm.最大业务量 AND mm.最大业务量<>0
    
    ORDER BY 
    m1.lncel_id
),

vipcell as (
    select '西安' as  地市, '77324011' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77324021' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77324031' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77324012' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77324022' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77324032' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77324111' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77324121' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77324131' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77324211' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77324221' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77324231' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77324212' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77324222' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77324232' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77338411' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77338421' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77338431' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77338412' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77338422' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77338432' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77367711' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77367721' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77367731' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77368111' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77368121' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77368131' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77368112' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77368122' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77368132' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77368811' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77368821' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77368831' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77369011' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77369021' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77369031' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77370011' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77370021' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77370031' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77370012' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77370022' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77370032' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, '77252811' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77252821' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77252831' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77252911' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77252921' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77252931' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77257111' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77257121' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77257131' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77260711' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77260721' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77260731' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77271611' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77271621' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77271631' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77271711' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77271721' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77271731' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77283011' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77283021' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77283031' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77283611' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77283621' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77283631' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77283711' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77283721' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77283731' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77284311' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77284321' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77284331' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77285011' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77285021' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77285031' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77285611' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77285621' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77285631' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77286111' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77287911' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77287921' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77287931' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77288211' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77288221' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77288231' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77290811' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77290821' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77290831' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77292111' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77292121' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77292131' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77294411' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77294421' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77294431' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77295911' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77295921' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77295931' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77300011' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77300021' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77300031' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77302011' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77302021' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77305011' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77305021' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77305031' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77305111' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77305121' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77305131' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77305311' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77305321' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77305331' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77305411' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77305421' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77305431' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77306111' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77306121' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77306131' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77306611' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77306621' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77306631' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77306811' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77306821' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77306831' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77307311' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77307321' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77307331' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77307711' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77307721' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77307731' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77308411' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77308421' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77308431' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77308911' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77308921' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77308931' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77309011' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77309021' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77309031' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77309311' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77309321' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77309331' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77310011' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77310021' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77310031' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77311811' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77311821' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77311831' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77312011' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77312021' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77312031' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77314011' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77314021' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77314031' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77315511' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77315521' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77315531' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77315711' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77315721' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77315731' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77315811' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77315821' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77315831' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77320611' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77320621' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77320631' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77321211' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77321221' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77321231' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77321611' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77321621' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77321631' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77322111' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77322121' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77322131' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77333511' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77333521' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77333531' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77333611' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77333621' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77333631' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77335311' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77335321' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77335331' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77336011' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77336021' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77336031' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77340311' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77340321' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77340331' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77340611' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77340621' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77340631' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77343011' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77343021' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77343031' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77344511' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77344521' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77344531' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77345111' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77345121' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77345131' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77347611' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77347621' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77347631' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77347711' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77347721' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77347731' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77347811' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77347821' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77347831' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77347911' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77347921' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77347931' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77348111' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77348121' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77348131' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77348411' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77348421' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77348431' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77348811' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77348821' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77348831' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77349711' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77349721' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77349731' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77356211' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77356221' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77356231' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77359911' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77359921' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77359931' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77365611' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77365621' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77365631' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77372011' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77372021' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77372031' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77372041' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77378411' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77378421' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77378431' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77387311' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77387321' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77387331' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77391311' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77391321' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77391331' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77391411' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77391421' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77391431' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77394011' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77394021' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77394031' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77407611' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77407621' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77407631' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77409211' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77409221' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77409231' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77411211' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77411221' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77411231' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77413211' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77413221' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77413231' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77255411' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77255421' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77255431' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77266011' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77266021' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77266031' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77267611' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77267621' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77267631' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77270311' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77270321' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77270331' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77288711' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77288721' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77288731' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77288811' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77288821' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77288831' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77289411' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77289421' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77289431' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77292611' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77292621' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77292631' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77292911' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77292921' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77292931' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77293111' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77293121' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77293131' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77323411' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77323421' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77323431' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77326511' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77326521' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77326531' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77335611' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77335621' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77335631' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77335911' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77335921' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77335931' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77355411' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77355421' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77355431' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77364811' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77364821' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77364831' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77367711' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77367721' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77367731' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77367811' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77367921' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77369911' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77369921' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77369931' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77369912' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77369922' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77369932' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77380811' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77380821' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77380831' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77380911' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77380921' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77380931' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77381011' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77381021' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77381031' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77381111' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77381121' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77381131' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77382911' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77382921' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77382931' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77386011' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77386012' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77386021' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77386022' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77386031' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77386032' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77387511' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77387521' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77387531' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77393411' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77393421' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77398311' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77398321' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77398331' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77401411' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77401421' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77401431' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77401611' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77401621' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77401631' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77413111' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77413121' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77413131' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, '77251411' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77251421' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77251431' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77327311' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77327321' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77327331' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77327411' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77327421' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77327431' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77327911' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77327921' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77328011' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77328021' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77373311' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77373411' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77373421' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77373431' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77373511' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77373521' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77373531' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77373611' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77373621' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77373631' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77373811' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77373821' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77373831' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77373911' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77373921' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77373931' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374011' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374021' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374031' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374111' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374121' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374131' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374211' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374221' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374231' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374311' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374321' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374331' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374411' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374421' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374431' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374511' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374521' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374531' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374611' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374621' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374631' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374711' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374721' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374731' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374811' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374821' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374831' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374911' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374921' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77374931' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77375011' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77375021' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77375031' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77375111' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77375121' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77375131' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77375211' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77375221' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77375231' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77375311' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77375321' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77375331' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77375341' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77383511' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77383521' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77383531' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77383512' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77383522' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77383532' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384411' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384421' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384431' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384441' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384451' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384511' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384521' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384531' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384512' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384522' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384532' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384611' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384621' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384631' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384711' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384721' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384731' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384811' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384821' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77384831' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77385011' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77385021' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77385031' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, '77255411' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77255421' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77255431' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77267511' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77267611' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77267621' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77267631' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77324811' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77324821' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77324831' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77324841' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77324851' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77324911' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77324921' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77324931' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77324941' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77324951' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77324961' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325011' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325021' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325031' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325041' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325051' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325061' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325111' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325121' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325131' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325141' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325151' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325161' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325211' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325221' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325231' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325241' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325251' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325261' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325311' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325321' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325331' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325341' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325411' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325421' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325431' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325441' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325451' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325461' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325811' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325821' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77325831' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77365111' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77365121' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77365131' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77367811' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77367831' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77367841' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77367911' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77367921' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77369311' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77369321' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77369331' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77369811' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77369821' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77369831' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77369911' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77369921' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77369931' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77369912' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77369922' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77369932' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77375511' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77375521' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77375531' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77386611' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77386621' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77386631' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77388511' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77388521' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77388531' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77389011' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77389021' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77389311' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77389321' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77389331' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77390411' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77390421' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77390431' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77393411' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77393421' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77413111' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77413121' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77413131' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77414111' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77414121' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, '77414131' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77870711' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77870721' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77870731' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77923311' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77923321' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77923331' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77922811' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77922821' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77922831' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77922711' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77922721' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77922731' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77923111' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77923121' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77923131' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77922911' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77922921' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77922931' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77923211' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77923221' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77923231' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77923011' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77923021' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77923031' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77922611' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77922621' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77922631' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77922511' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77922521' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77922531' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77873511' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77873521' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77873531' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77859911' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77859921' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77859931' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77857011' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77857021' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77857031' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77826211' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77826221' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77826231' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77826212' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77826222' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77826232' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77974611' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77974621' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77974631' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77859811' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77859821' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77859831' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77860111' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77860121' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77860131' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77832911' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77832921' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77832931' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77904711' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77904721' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77904731' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77904511' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77904521' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77904531' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77834311' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77834321' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77834331' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77834341' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77834351' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77834361' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77847111' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77847121' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77847131' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77859511' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77859521' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77859531' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77936311' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77936321' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77936331' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77849611' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77849621' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77849631' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77836311' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77836321' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77836331' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77836411' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77836421' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77836431' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77983711' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77983721' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77983731' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77825511' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77825521' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77825531' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77825541' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77825551' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77825561' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77859611' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77859621' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77859631' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77825111' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77825121' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77825131' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77840311' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77840321' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77840331' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77860011' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77860021' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77860031' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77972411' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77972421' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77972431' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77850511' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77850521' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77850531' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77825911' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77825921' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77825931' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77860211' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77860221' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77860231' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77859011' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77859021' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77859031' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925911' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925921' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925931' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925411' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925421' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925431' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77970411' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77970421' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77970431' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77926011' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77926021' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77926031' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77926311' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77926321' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77926331' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77924911' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77924921' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77924931' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77929811' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77929821' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77929831' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77926211' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77926221' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77926231' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925211' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925221' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925231' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925111' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925121' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925131' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77970111' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77970121' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77970131' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77972311' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77972321' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77972331' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77926411' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77926421' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77926431' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925311' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925321' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925331' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77926111' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77926121' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77926131' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925011' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925021' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925031' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77928811' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77928821' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77928831' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77966211' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77966221' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77966231' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925511' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925521' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925531' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925711' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925721' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925731' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925811' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925821' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925831' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925611' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925621' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77925631' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, '77862611' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77862631' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77904211' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77904221' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77904231' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77959411' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77959431' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77864011' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77864021' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77864031' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77863011' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77863021' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77863031' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77904621' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77904631' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77959121' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77959131' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77959311' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77959321' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77950211' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77950231' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77864621' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77864631' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77864521' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77864531' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77958911' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77958921' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77958931' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77864311' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77864331' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77904111' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77904121' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77863221' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77863231' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77888611' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77888621' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77888631' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77897011' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77897021' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77897031' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77957311' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77957321' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77957331' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77959211' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77959221' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77957421' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77957431' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77971411' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77971421' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77971431' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77862721' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77862731' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77863111' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77863121' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77863131' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77950711' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77950721' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77950731' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77959021' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77959031' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77864721' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77864731' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77957711' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77957721' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77957731' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77995611' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77995621' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, '77995631' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78339311' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78339321' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78339331' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78352611' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78352621' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78339411' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78339421' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77640611' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77640621' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77640631' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78336211' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78336221' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78336231' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78239111' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78239121' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78239131' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78339611' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78339621' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78339631' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78339711' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78339721' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78339731' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78339811' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78339821' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78339831' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78339911' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78339921' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78339931' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340011' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340021' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340111' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340121' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340131' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340211' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340221' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340231' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78278211' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78278221' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78278231' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340311' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340321' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340331' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340411' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340421' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340431' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340511' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340521' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340531' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340611' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340621' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340631' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78314711' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78314721' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340811' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340821' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340831' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340911' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340921' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78340931' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341011' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341021' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341031' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341111' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341121' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341131' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341211' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341221' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341231' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341311' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341321' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341331' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77630711' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77630721' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77630731' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341411' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341421' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341431' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341511' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341521' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341531' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341611' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341621' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341631' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341711' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341721' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341731' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78308111' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78308121' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78308131' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341911' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341921' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78341931' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342011' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342021' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342031' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342111' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342121' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342131' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342211' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342221' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342231' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78268911' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78268921' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78268931' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342411' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342421' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342431' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342511' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342521' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342531' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342611' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342621' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342631' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342711' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342721' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342731' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342811' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342821' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342831' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342911' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342921' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78342931' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343011' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343021' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343031' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343111' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343121' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343211' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343221' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343231' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343311' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343321' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343331' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343411' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343421' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343431' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343511' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343521' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343531' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343611' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343621' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343631' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343711' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343721' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343811' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343821' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343831' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343911' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343921' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78343931' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344011' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344021' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344031' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344111' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344121' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344131' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344211' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344221' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344231' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344311' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344321' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344331' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344411' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344421' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344431' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344511' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344521' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344531' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344611' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344621' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344631' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344711' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344721' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78344731' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77612911' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77612921' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77612931' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77612941' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613011' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613021' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613031' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613111' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613121' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613131' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613141' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613211' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613221' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613231' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613241' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613251' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613261' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613311' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613321' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613331' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613341' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613351' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613361' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613411' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613421' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613431' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613441' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613511' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613521' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613531' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613541' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613551' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613561' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613611' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613621' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613631' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613641' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613651' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613661' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613711' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613721' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613731' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613741' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613751' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613761' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613811' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613821' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613831' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613841' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613851' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613861' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613911' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613921' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613931' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77613941' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614011' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614021' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614031' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614041' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614051' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614061' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614111' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614121' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614131' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614141' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614151' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614161' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614211' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614221' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614231' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614241' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614251' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614261' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614311' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614321' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614331' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614341' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614411' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614421' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614431' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614441' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614511' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614521' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614531' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614541' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614611' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614621' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614631' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614641' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614651' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77614661' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77615711' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77615721' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '77615731' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, '78258411' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78258421' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78258811' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78258821' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78258831' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78263611' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78263621' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78263631' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78265411' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78265421' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78265431' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78265911' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78265921' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78265931' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78268511' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78268521' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78268531' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78268611' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78268621' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78268631' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78271011' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78271021' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78271031' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78277811' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78277821' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78277831' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78284711' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78284721' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78284731' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78287211' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78287221' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78287231' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78296611' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78296621' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78296631' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78300411' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78300421' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78300431' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78304911' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78304921' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78304931' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78305611' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78305621' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78305631' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78312611' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78312621' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78312631' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78313111' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78313121' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78313131' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78315111' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78315121' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78315311' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78315321' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78315331' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78315611' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78315621' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78315631' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78315811' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78315821' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78315831' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78315911' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78315921' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78315931' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78319611' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78319621' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78319631' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78321411' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78321421' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78321431' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324211' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324221' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324231' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324311' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324321' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324331' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324411' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324421' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324431' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324511' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324521' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324531' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324611' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324621' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324631' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324711' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324721' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324731' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324811' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324821' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324831' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324911' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324921' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78324931' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78325011' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78325021' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78325031' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78325111' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78325121' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78325131' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78327611' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78327621' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78327631' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78328511' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78328521' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78328531' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78338511' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78338521' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78338531' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78338711' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78338721' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78338731' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78338811' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78338821' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78338831' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78343811' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78343821' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78343831' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78343911' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78343921' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78343931' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78344011' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78344021' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78344031' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78344111' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78344121' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78344131' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78351111' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78351121' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78351131' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78351911' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78351921' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78351931' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78356411' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78356421' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '78356431' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77619711' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77619721' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77619731' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77632011' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77632021' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77632031' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77632041' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77632111' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77632121' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77632131' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77632141' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77633611' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77633621' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77633631' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77633911' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77633921' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77633931' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77638311' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77638321' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77638331' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77639011' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77639021' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77639031' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77641511' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77641521' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77641531' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77647211' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77647221' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77647231' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77647511' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77647521' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77647531' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77647711' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77647721' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77647731' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77653611' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77653621' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77653631' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77657511' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77657521' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77657531' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77660811' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77660821' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77660831' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77661111' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77661121' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77661131' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77667311' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77667321' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77667331' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77627811' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77627821' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77627831' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77662411' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77662421' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, '77662431' as CELLID, '高速' as 场景 from dual

)


    
    


select
    c.city,
    --c.lnbtsid,
    --c.lncel_lcr_id,
    vipcell.场景,
    lcellt.PERIOD_START_TIME,
    round(sum(lcellt.空口业务字节数)/1024/1024/1024,4) as 空口业务字节数_GB,
    round(sum(lcellt.空口上行业务字节数)/1024/1024/1024,4)  as 空口上行业务字节数_GB,
    round(sum(lcellt.空口下行业务字节数)/1024/1024/1024,4)  as 空口下行业务字节数_GB,

    sum(lcelld.最大RRC连接用户数) as 最大RRC连接用户数,
    
    --无线接通率
    round(decode(sum(luest.RRC连接建立请求次数),0,null,sum(luest.RRC连接建立成功次数)/sum(luest.RRC连接建立请求次数))* decode(sum(luest.ERAB建立请求个数),0,null,sum(luest.ERAB建立成功个数)/sum(luest.ERAB建立请求个数))*100,2) as 无线接通率,
    
    sum(luest.RRC连接建立请求次数) as RRC连接建立请求次数,
    sum(luest.RRC连接建立成功次数) as RRC连接建立成功次数,

    sum(luest.ERAB建立请求个数) as ERAB建立请求个数,
    sum(luest.ERAB建立成功个数) as ERAB建立成功个数,
    
    --掉话率
    round(decode(sum(luest.LTE业务释放次数),0,null,sum(luest.LTE业务掉线次数)/sum(luest.LTE业务释放次数))*100,2) as 掉话率,
    sum(luest.LTE业务释放次数) as LTE业务释放次数,
    sum(luest.LTE业务掉线次数) as LTE业务掉线次数,

    --下行PRB平均利用率
    --sum(lcellr.下行PRB可用数) as 下行PRB可用数,
    --sum(lcellr.下行PRB占用平均数) as 下行PRB占用平均数,
    
    round(AVG(lcellr.下行PRB平均利用率)*100,2) AS 下行PRB平均利用率,
    
    --RRC拥塞率
    round(decode(sum(luest.RRC连接建立请求次数),0,null,sum(luest.RRC建立拥塞次数)/sum(luest.RRC连接建立请求次数))*100,2) as RRC拥塞率,
    sum(luest.RRC连接建立请求次数) as RRC连接建立请求次数,
    sum(luest.RRC建立拥塞次数) as RRC建立拥塞次数,
    
    
    --同频切换成功率
    round(decode(sum(lienbho.同频切换请求次数),0,null,sum(lienbho.同频切换成功次数)/sum(lienbho.同频切换请求次数))*100,2) as 同频切换成功率,
    sum(lienbho.同频切换请求次数) as 同频切换请求次数,
    sum(lienbho.同频切换成功次数) as 同频切换成功次数,

	
    --异频切换出成功率
    round(decode(sum(lienbho.异频切换请求次数),0,null,sum(lienbho.异频切换出成功次数)/sum(lienbho.异频切换请求次数))*100,2) as 异频切换成功率,
    sum(lienbho.异频切换请求次数) as 异频切换请求次数,
    sum(lienbho.异频切换出成功次数) as 异频切换出成功次数



 

from
    (SELECT
        lcellt.lncel_id,
        to_char(lcellt.PERIOD_START_TIME,'yyyy-mm-dd') as PERIOD_START_TIME,
        SUM(lcellt.PDCP_SDU_VOL_UL + lcellt.PDCP_SDU_VOL_DL) AS 空口业务字节数,
        SUM(lcellt.PDCP_SDU_VOL_UL )  AS 空口上行业务字节数,
        SUM(lcellt.PDCP_SDU_VOL_DL )  AS 空口下行业务字节数
    FROM
            NOKLTE_PS_LCELLT_LNCEL_HOUR lcellt
        --inner join busyhour on lcellt.lncel_id = busyhour.lncel_id
        --and to_char(lcellt.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour
        
    WHERE
            lcellt.period_start_time >= To_Date(&start_date, 'yyyy-mm-dd')
        AND lcellt.period_start_time <  To_Date(&end_date, 'yyyy-mm-dd')

    GROUP BY
        lcellt.lncel_id,
        to_char(lcellt.PERIOD_START_TIME,'yyyy-mm-dd')
    ) lcellt


   
    
inner join   
    (SELECT
        lcelld.lncel_id,
        to_char(lcelld.PERIOD_START_TIME,'yyyy-mm-dd') as PERIOD_START_TIME,
        round(sum(lcelld.RRC_CONN_UE_MAX),2) as 最大RRC连接用户数

    FROM
        NOKLTE_PS_LCELLD_LNCEL_HOUR lcelld
        inner join busyhour on lcelld.lncel_id = busyhour.lncel_id
              and to_char(lcelld.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour
        
    WHERE
            lcelld.period_start_time >= To_Date(&start_date, 'yyyy-mm-dd')
        AND lcelld.period_start_time <  To_Date(&end_date, 'yyyy-mm-dd')

    GROUP BY
        lcelld.lncel_id,
        to_char(lcelld.PERIOD_START_TIME,'yyyy-mm-dd')
        
    ) lcelld on lcelld.lncel_id = lcellt.lncel_id and lcelld.PERIOD_START_TIME = lcellt.PERIOD_START_TIME 
    
  
    
    
inner join   
    (SELECT
        luest.lncel_id,
        to_char(luest.PERIOD_START_TIME,'yyyy-mm-dd') as PERIOD_START_TIME,

        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0,luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode( luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO)),sum(luest.SIGN_CONN_ESTAB_ATT_MO_S + luest.SIGN_CONN_ESTAB_ATT_MT + luest.SIGN_CONN_ESTAB_ATT_MO_D + luest.SIGN_CONN_ESTAB_ATT_OTHERS + luest.SIGN_CONN_ESTAB_ATT_EMG + decode(luest.SIGN_CONN_ESTAB_ATT_DEL_TOL,'',0, luest.SIGN_CONN_ESTAB_ATT_DEL_TOL)+ decode(luest.SIGN_CONN_ESTAB_ATT_HIPRIO,'',0,luest.SIGN_CONN_ESTAB_ATT_HIPRIO))) AS RRC连接建立请求次数,
        
        sum(luest.SIGN_CONN_ESTAB_COMP) AS RRC连接建立成功次数,

        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_FAIL_PUCCH),sum(luest.SIGN_CONN_ESTAB_FAIL_RRMRAC)) AS RRC建立拥塞次数,

        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum( lepsb.ERAB_INI_SETUP_FAIL_RNL_RRNA + lepsb.ERAB_ADD_SETUP_FAIL_RNL_RRNA),sum(lepsb.EPS_BEARER_SETUP_FAIL_RESOUR)) AS 无线资源拥塞次数,
        
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS - lepsb.EPS_BEARER_SETUP_COMPLETIONS - lepsb.ERAB_INI_SETUP_FAIL_RNL_UEL - lepsb.ERAB_ADD_SETUP_FAIL_RNL_UEL - lepsb.ERAB_INI_SETUP_FAIL_TNL_TRU - lepsb.ERAB_ADD_SETUP_FAIL_TNL_TRU - lepsb.ERAB_INI_SETUP_FAIL_RNL_RRNA - lepsb.ERAB_ADD_SETUP_FAIL_RNL_RRNA - lepsb.ERAB_INI_SETUP_FAIL_RNL_RIP - lepsb.ERAB_ADD_SETUP_FAIL_RNL_RIP - lepsb.ERAB_ADD_SETUP_FAIL_UP - lepsb.ERAB_ADD_SETUP_FAIL_RNL_MOB),sum(lepsb.EPS_BEARER_SETUP_FAIL_TRPORT)) AS 传输资源拥塞次数,
        
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM(lepsb.ERAB_INI_SETUP_FAIL_RNL_UEL + lepsb.ERAB_ADD_SETUP_FAIL_RNL_UEL ),Sum(lepsb.EPS_BEARER_SETUP_FAIL_RNL)) ERAB建立失败_UE无响应,
        
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM(lepsb.ERAB_ADD_SETUP_FAIL_UP),Sum(lepsb.EPS_BEARER_SETUP_FAIL_OTH)) AS ERAB建立失败_配置,
        
        sum(luest.SIGN_EST_F_RRCCOMPL_MISSING) AS Setup_comp_miss无应答,
        
        sum(luest.SIGN_EST_F_RRCCOMPL_ERROR) AS Setup_comp_error小区拒绝,
        
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_FAIL_PUCCH),sum(luest.SIGN_CONN_ESTAB_FAIL_RRMRAC)) AS Reject_RRM_RAC资源分配失,
        
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(luest.SIGN_CONN_ESTAB_FAIL_MAXRRC),'') AS SIGN_CONN_ESTAB_FAIL_MAXRRC, --LN7.0无此指标
        
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(lepsb.ERAB_ADD_SETUP_FAIL_UP),'') AS E_RAB建立失败_核心网, 
        --LN7.0无此指标
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(lepsb.ERAB_INI_SETUP_FAIL_RNL_RIP + lepsb.ERAB_ADD_SETUP_FAIL_RNL_RIP),'') AS E_RAB建立失败_无线层, --LN7.0无此指标
        
        round(decode(sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS),0,0, sum(lepsb.EPS_BEARER_SETUP_COMPLETIONS) / sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS))*100,2) AS ERAB建立成功率,

        sum(lepsb.EPS_BEARER_SETUP_COMPLETIONS) AS ERAB建立成功个数,
        
        sum(lepsb.EPS_BEARER_SETUP_ATTEMPTS) AS ERAB建立请求个数,
        
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum(lepsb.ERAB_INI_SETUP_FAIL_RNL_RRNA + lepsb.ERAB_INI_SETUP_FAIL_TNL_TRU + lepsb.ERAB_ADD_SETUP_FAIL_RNL_RRNA + lepsb.ERAB_ADD_SETUP_FAIL_TNL_TRU),SUM( lepsb.EPS_BEARER_SETUP_FAIL_TRPORT + lepsb.EPS_BEARER_SETUP_FAIL_RESOUR )) AS ERAB建立拥塞次数，
        
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',SUM( lepsb.EPC_EPS_BEARER_REL_REQ_RNL  + lepsb.ERAB_REL_ENB_RNL_UEL + lepsb.ERAB_REL_ENB_RNL_EUGR + lepsb.ERAB_REL_ENB_TNL_TRU + lepsb.ERAB_REL_HO_PART + lepsb.ERAB_REL_EPC_PATH_SWITCH ) ,SUM( lepsb.EPC_EPS_BEARER_REL_REQ_RNL + lepsb.EPC_EPS_BEAR_REL_REQ_R_QCI1 + lepsb.PRE_EMPT_GBR_BEARER + lepsb.PRE_EMPT_NON_GBR_BEARER + lepsb.ENB_EPS_BEARER_REL_REQ_RNL + lepsb.ENB_EPS_BEARER_REL_REQ_TNL + lepsb.ENB_EPS_BEARER_REL_REQ_OTH))  AS LTE业务掉线次数,

        
        decode((CASE WHEN c.version='FL16' THEN 'FL16'WHEN c.version='FLF16' THEN 'FL16'WHEN c.version='FL16A' THEN 'FL16' WHEN c.version='TL16' THEN 'FL16' ELSE c.version END),'FL16',sum( lepsb.EPC_EPS_BEARER_REL_REQ_RNL  + lepsb.ERAB_REL_ENB_RNL_UEL + lepsb.ERAB_REL_ENB_RNL_EUGR + lepsb.ERAB_REL_ENB_TNL_TRU + lepsb.ERAB_REL_HO_PART + lepsb.ERAB_REL_EPC_PATH_SWITCH + lepsb.ERAB_REL_ENB_RNL_INA + lepsb.ERAB_REL_ENB_RNL_RED + lepsb.ERAB_REL_ENB_RNL_RRNA + lepsb.EPC_EPS_BEARER_REL_REQ_NORM + lepsb.EPC_EPS_BEARER_REL_REQ_DETACH ) ,sum( lepsb.EPC_EPS_BEARER_REL_REQ_NORM + lepsb.EPC_EPS_BEARER_REL_REQ_DETACH + lepsb.EPC_EPS_BEARER_REL_REQ_RNL + lepsb.ERAB_REL_ENB_ACT_NON_GBR + lepsb.ENB_EPSBEAR_REL_REQ_RNL_REDIR + lepsb.ENB_EPS_BEARER_REL_REQ_NORM + lepsb.ENB_EPS_BEARER_REL_REQ_RNL + lepsb.ENB_EPS_BEARER_REL_REQ_TNL + lepsb.ENB_EPS_BEARER_REL_REQ_OTH + lepsb.EPC_EPS_BEAR_REL_REQ_R_QCI1 + lepsb.PRE_EMPT_GBR_BEARER + lepsb.PRE_EMPT_NON_GBR_BEARER)) AS LTE业务释放次数

    FROM
        NOKLTE_PS_LUEST_LNCEL_HOUR luest
        
        inner join busyhour 
            on luest.lncel_id = busyhour.lncel_id
            and to_char(luest.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour
                
        INNER JOIN NOKLTE_PS_LEPSB_LNCEL_HOUR lepsb 
            ON lepsb.lncel_id = luest.lncel_id
            AND lepsb.period_start_time = luest.period_start_time
            and luest.lncel_id = busyhour.lncel_id
            and to_char(lepsb.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour


        RIGHT JOIN C_LTE_CUSTOM c 
            ON c.lncel_objid = luest.lncel_id
        
    WHERE
        luest.period_start_time >= To_Date(&start_date, 'yyyy-mm-dd')
        AND luest.period_start_time <  To_Date(&end_date, 'yyyy-mm-dd')

    GROUP BY
        luest.lncel_id,
        to_char(luest.PERIOD_START_TIME,'yyyy-mm-dd'),
        c.version
        
    ) luest on luest.lncel_id = lcellt.lncel_id and luest.PERIOD_START_TIME = lcellt.PERIOD_START_TIME 
       
    
    
    
    
inner join 
    (SELECT 
        to_char(lcellr.PERIOD_START_TIME,'yyyy-mm-dd') AS period_start_time,
        lcellr.lncel_id,
        decode((sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)+decode(lncel.LNCEL_UL_CH_BW,'',0,lncel.LNCEL_UL_CH_BW))/2),0,0, decode(sum(lcellr.PERIOD_DURATION*60*1000),0,0,sum(lcellr.PRB_USED_PUSCH)/sum(lcellr.PERIOD_DURATION*60*1000))/        (sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*decode(lncel.LNCEL_TDD_FRAME_CONF,1,0.4,0.2)+ decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)/35+decode(lncel.LNCEL_UL_CH_BW,'',0, lncel.LNCEL_UL_CH_BW))/2)) AS 上行PRB平均利用率,

        sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*decode(lncel.LNCEL_TDD_FRAME_CONF,1,0.4,0.2)+decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)/35+ decode(lncel.LNCEL_UL_CH_BW,'',0,lncel.LNCEL_UL_CH_BW))/2  AS 上行PRB可用数,  
        
        decode(sum(lcellr.PERIOD_DURATION*60*1000),0,0,sum(lcellr.PRB_USED_PUSCH)/sum(lcellr.PERIOD_DURATION*60*1000)) AS 上行PRB占用平均数,
        
        decode((sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)+decode(lncel.LNCEL_DL_CH_BW,'',0,lncel.LNCEL_DL_CH_BW))/2),0,0,decode(sum(lcellr.PERIOD_DURATION*60*1000),0,0, sum(lcellr.PRB_USED_PDSCH) /sum(lcellr.PERIOD_DURATION*60*1000))/(sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)* decode(lncel.LNCEL_TDD_FRAME_CONF,1,0.4,0.6)+decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*decode(lncel.LNCEL_TSSC_296,5,0.0428,0.1428)+ decode(lncel.LNCEL_DL_CH_BW,'',0,lncel.LNCEL_DL_CH_BW))/2)) AS 下行PRB平均利用率,
        
        sum(decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*decode(lncel.LNCEL_TDD_FRAME_CONF,1,0.4,0.6)+decode(lncel.LNCEL_CH_BW,'',0,lncel.LNCEL_CH_BW)*decode(lncel.LNCEL_TSSC_296,5,0.0428,0.1428)+ decode(lncel.LNCEL_DL_CH_BW,'',0,lncel.LNCEL_DL_CH_BW))/2  AS 下行PRB可用数,
        
        decode(sum(lcellr.PERIOD_DURATION*60*1000),0,0, sum(lcellr.PRB_USED_PDSCH) / sum(lcellr.PERIOD_DURATION*60*1000)) AS 下行PRB占用平均数

    FROM 
        NOKLTE_PS_LCELLR_LNCEL_HOUR lcellr
        
        inner join busyhour 
            on lcellr.lncel_id = busyhour.lncel_id
            and to_char(lcellr.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour   
        
        inner JOIN c_lte_lncel lncel 
            ON lcellr.lncel_id = lncel.obj_gid
            and busyhour.lncel_id = lncel.obj_gid

    WHERE 
            lcellr.period_start_time >=to_date(&start_date, 'yyyy-mm-dd')
        AND lcellr.period_start_time < to_date(&end_date, 'yyyy-mm-dd')
        
    GROUP BY 
        to_char(lcellr.PERIOD_START_TIME,'yyyy-mm-dd'),
        lcellr.lncel_id

    ) lcellr on lcellr.lncel_id = lcellt.lncel_id and lcellr.PERIOD_START_TIME = lcellt.PERIOD_START_TIME 

inner join 
    (SELECT
        lianbho.lncel_id,
        to_char(lianbho.PERIOD_START_TIME,'yyyy-mm-dd') AS period_start_time,

        --round(DECODE(SUM(lianbho.ATT_INTRA_ENB_HO+lienbho.ATT_INTER_ENB_HO+lienbho.INTER_ENB_S1_HO_ATT-lho.HO_INTFREQ_ATT),0,0,SUM(lianbho.SUCC_INTRA_ENB_HO+lienbho.SUCC_INTER_ENB_HO+LIENBHO.INTER_ENB_S1_HO_SUCC-LHO.HO_INTFREQ_SUCC)/SUM(lianbho.ATT_INTRA_ENB_HO+lienbho.ATT_INTER_ENB_HO+lienbho.INTER_ENB_S1_HO_ATT-lho.HO_INTFREQ_ATT))*100,2) AS 同频切换成功率，
        
        SUM(lianbho.ATT_INTRA_ENB_HO+lienbho.ATT_INTER_ENB_HO+lienbho.INTER_ENB_S1_HO_ATT-lho.HO_INTFREQ_ATT) AS 同频切换请求次数,
        
        SUM(lianbho.SUCC_INTRA_ENB_HO+lienbho.SUCC_INTER_ENB_HO+LIENBHO.INTER_ENB_S1_HO_SUCC-LHO.HO_INTFREQ_SUCC) AS 同频切换成功次数,
        
        --round(decode(SUM(lho.HO_INTFREQ_ATT),0,0,SUM(lho.HO_INTFREQ_SUCC)/SUM(lho.HO_INTFREQ_ATT))*100,2) AS 异频切换成功率，
        
        SUM(lho.HO_INTFREQ_ATT) AS 异频切换请求次数,
        
        SUM(lho.HO_INTFREQ_SUCC) AS 异频切换出成功次数

    FROM
        NOKLTE_PS_LIENBHO_LNCEL_HOUR lienbho
        
        inner join busyhour 
            on lienbho.lncel_id = busyhour.lncel_id
            and to_char(lienbho.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour   
            
        INNER JOIN NOKLTE_PS_LIANBHO_LNCEL_HOUR lianbho 
            ON lienbho.lncel_id = lianbho.lncel_id
            AND lienbho.period_start_time = lianbho.period_start_time
            and busyhour.lncel_id = lianbho.lncel_id
            and busyhour.pm_date_hour = to_char(lianbho.period_start_time, 'yyyymmddhh24') 

        INNER JOIN NOKLTE_PS_LHO_LNCEL_HOUR lho 
            ON lienbho.lncel_id = lho.lncel_id
            AND lienbho.period_start_time = lho.period_start_time 
            and busyhour.lncel_id = lho.lncel_id
            and busyhour.pm_date_hour = to_char(lho.period_start_time, 'yyyymmddhh24')
            
    WHERE
            lienbho.period_start_time >= To_Date(&start_date, 'yyyy-mm-dd')
        AND lienbho.period_start_time <  To_Date(&end_date, 'yyyy-mm-dd')


    GROUP BY
        lianbho.lncel_id,
        to_char(lianbho.PERIOD_START_TIME,'yyyy-mm-dd')

    ) lienbho on lienbho.lncel_id = lcellt.lncel_id and lienbho.PERIOD_START_TIME = lcellt.PERIOD_START_TIME  

inner join c_lte_custom c on c.lncel_objid = lcellt.lncel_id
inner join vipcell on vipcell.CELLID = c.ci
group by
    c.city,
    --c.lnbtsid,
    --c.lncel_lcr_id,
    vipcell.场景,
   lcellt.PERIOD_START_TIME
       
    

    