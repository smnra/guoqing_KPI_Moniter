with 
busyhour AS (
        SELECT 
     m1.wcel_id,
     m1.seg_id,
     mm.pm_date AS pm_date_hour
    FROM
     (select 
       wcel_id,
       seg_id,
       to_char(to_date(pm_date,'yyyymmddhh24'), 'yyyymmdd') as pm_date,

       max(最大业务量) AS 最大业务量
     from    
       (SELECT 
       traffic.bts_gid AS wcel_id,
       traffic.seg_id AS seg_id,
       to_char(traffic.period_start_time, 'yyyymmddhh24') as pm_date,
       round(sum(traffic.ave_busy_tch/traffic.res_av_denom14),2) AS 最大业务量
       --TCH话务量
     FROM 
       BSC_PS_RESAVAIL_TTP1_RAW traffic
     WHERE 
          traffic.period_start_time >= to_date(&start_date, 'yyyy-mm-dd')
       AND traffic.period_start_time < to_date(&end_date, 'yyyy-mm-dd')


     GROUP BY 
       traffic.bts_gid,
       traffic.seg_id,
       to_char(traffic.period_start_time, 'yyyymmddhh24')
       )
     group by 
       wcel_id,
       seg_id,
       to_char(to_date(pm_date,'yyyymmddhh24'), 'yyyymmdd')
     ) m1
     
    inner JOIN 
       
     (SELECT 
       traffic.bts_gid AS wcel_id,
       traffic.seg_id AS seg_id,
       to_char(traffic.period_start_time, 'yyyymmddhh24') pm_date,
       round(sum(traffic.ave_busy_tch/traffic.res_av_denom14),2) AS 最大业务量
       --TCH话务量
       
     FROM 
       BSC_PS_RESAVAIL_TTP1_RAW traffic
     WHERE 
          traffic.period_start_time >= to_date(&start_date, 'yyyy-mm-dd')
       AND traffic.period_start_time < to_date(&end_date, 'yyyy-mm-dd')


     GROUP BY 
       traffic.bts_gid,
       traffic.seg_id,
       to_char(traffic.period_start_time, 'yyyymmddhh24')
     )   mm ON m1.wcel_id = mm.wcel_id and m1.seg_id = mm.seg_id  AND m1.最大业务量 = mm.最大业务量 AND mm.最大业务量<>0
    
    
    ORDER BY 
     m1.wcel_id
),

vipcell as (
    select '西安' as  地市, 'BSC3' as BSCID, '22521' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '22522' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '22523' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '22531' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '22532' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '22533' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '22541' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '22542' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '22543' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '22591' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '22592' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '22593' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '22641' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '22642' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '22643' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '22831' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '22832' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '22833' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '21581' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '21582' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '21583' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '21691' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '21692' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '21693' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '21801' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '21802' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '21803' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '27221' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '27222' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '27223' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '27481' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '27482' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '27483' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '27491' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '27492' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '27493' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '27591' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '27592' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '27593' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '28031' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '28032' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '28033' as CELLID, '西安北客站' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '28211' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '28212' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '28213' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '26991' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '26992' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '26993' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '20041' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '20042' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '20043' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '20071' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '20072' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '20073' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '20091' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '20092' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '20093' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '20151' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '20152' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, 'BSC3' as BSCID, '20153' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '22131' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '22132' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '22133' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '22161' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '22162' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '22163' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '22171' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '22172' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '22173' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '22261' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '22262' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '22263' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15016' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15017' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15018' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15026' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15036' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15037' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15046' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15047' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15048' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15056' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15057' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15058' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15066' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15067' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15068' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15076' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15077' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15078' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15086' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15087' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15088' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15096' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15097' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15098' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15106' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15107' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15108' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15116' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15117' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15118' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15126' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15127' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15128' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15136' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15137' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15138' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15146' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15147' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15148' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15156' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15157' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15158' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15166' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15167' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15168' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15176' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15177' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15178' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15186' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15187' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15188' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15196' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15197' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15198' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15206' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15207' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15208' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15216' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15217' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15218' as CELLID, '咸阳机场' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '15595' as CELLID, '西安火车站' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '18031' as CELLID, '西安火车站' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '27571' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '27572' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, 'BSC2' as BSCID, '27573' as CELLID, '高铁' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '21681' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '21682' as CELLID, '高速' as 场景 from dual union
    select '西安' as  地市, 'BSC1' as BSCID, '21683' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '20562' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '20791' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '20792' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '20793' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21211' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21212' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21213' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21221' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21222' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21223' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21251' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21252' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21253' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21451' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21452' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21453' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21501' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21502' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21511' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21512' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21513' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21631' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21632' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21633' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21841' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21842' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21843' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22041' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22042' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22043' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22491' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22492' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22493' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22501' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22502' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22503' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22591' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22592' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22593' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22801' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22802' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22803' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '23201' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '23202' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '23203' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24006' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24007' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24008' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24031' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24032' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24033' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24036' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24037' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24038' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24046' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24047' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24048' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24051' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24052' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24053' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24066' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24067' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24068' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24071' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24072' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24073' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24081' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24082' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24083' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24156' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24157' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24158' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24272' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24273' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24476' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24477' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24478' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24501' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24502' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24503' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24956' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24957' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24958' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '28021' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '28022' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '28221' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '28222' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '28223' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '28311' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '28312' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '28313' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '28341' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '28342' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '28343' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '29721' as CELLID, '高铁' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '20101' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '20102' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '20103' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '20241' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '20242' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '20243' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '20432' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '20572' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '20573' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '20951' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '20952' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '20953' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21242' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21243' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21482' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21483' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21532' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21533' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21691' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21692' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '21693' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22152' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22153' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22242' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22582' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22583' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22772' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22773' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22792' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '22793' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24011' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24012' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24013' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24016' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24017' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24027' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24028' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24041' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24042' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24043' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24046' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24047' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24048' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24051' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24052' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24053' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24061' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24062' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24063' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24066' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24067' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24068' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24071' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24072' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24073' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24106' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24107' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24108' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24171' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24172' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24173' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24176' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24177' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24178' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24246' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24247' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24248' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24286' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24287' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24288' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24392' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24961' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24962' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '24963' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '28212' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '28213' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '28382' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '28383' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '28661' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '28662' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '28663' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '29622' as CELLID, '高速' as 场景 from dual union
    select '宝鸡' as  地市, 'BJFBSC2' as BSCID, '29623' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '30721' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '30722' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '30723' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '36751' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '33611' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '33612' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '33613' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '37151' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '37152' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '38111' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '38112' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '38113' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '30391' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '30392' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '30393' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '37871' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '37872' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '37873' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '33721' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '33722' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '33723' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '37821' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '37822' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '37823' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '36781' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '36782' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '36783' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '37311' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '37312' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '37313' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '37831' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '37832' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '37833' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '38171' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '38172' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '38173' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '33021' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '33022' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '33023' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC2' as BSCID, '37843' as CELLID, '高速' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '30112' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '30113' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '30236' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '30237' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '30245' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '30246' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '30286' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '30287' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '30771' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '30772' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '31481' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '31483' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '31515' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '31517' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '31551' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '31553' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '31911' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '31912' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '32595' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '32597' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '33032' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '33033' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '34421' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '34423' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '34542' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '34543' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '34942' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '34943' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '34962' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '34963' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '35611' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '35613' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '35632' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '35662' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '35663' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '35951' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '36001' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '36092' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '36093' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '36102' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '36103' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '36211' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '36213' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '36832' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC1' as BSCID, '36833' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '38421' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '38423' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '33074' as CELLID, '高铁' as 场景 from dual union
    select '咸阳' as  地市, 'XYFBSC3' as BSCID, '33079' as CELLID, '高铁' as 场景 from dual 

)




select
    decode(ava.BSC_ID,'BSC1','西安',
                      'BSC2','西安',
                      'BSC3','西安',
                      'XYFBSC1','咸阳', 'XYFBSC2', '咸阳','XYFBSC3', '咸阳', 
                      'BJFBSC1','宝鸡', 'BJFBSC2', '宝鸡','Other') AS CITY,
    --vipcell.场景 AS AREA,
    --vipcell.BSCID AS BSCID,
    --vipcell.CELLID AS CELLID,
    --ava.BSC_ID AS BSC_ID,
    --ava.CELL_ID AS CELL_ID,
    to_char(ava.Sdate, 'yyyymmdd') as period_start_time,
 
    round(SUM(ava.TCH话务量),2) AS "全天话务量（ERL）",
    

    round(decode(sum(tra.掉话率_含切换_Y),0,null,
    sum(tra.掉话率_含切换_X)/sum(tra.掉话率_含切换_Y))*100,2) AS 掉话率_含切换,
    
    sum(tra.掉话率_含切换_X) AS 掉话率_含切换_X,
    sum(tra.掉话率_含切换_Y) AS 掉话率_含切换_Y,
    

    round(decode(sum(tra.TCH拥塞率_Y),0,null,
    sum(tra.TCH拥塞率_X)/sum(tra.TCH拥塞率_Y))*100,2) AS TCH拥塞率,

    sum(tra.TCH拥塞率_X) AS TCH拥塞率_X,    
    sum(tra.TCH拥塞率_Y) AS TCH拥塞率_Y,
    

    
    round((1 - decode(sum(tra.TCH拥塞率_Y),0,null,
    sum(tra.TCH拥塞率_X)/sum(tra.TCH拥塞率_Y)) -
    decode(sum(tra.SDCCH拥塞率_Y),0,null,
    sum(tra.SDCCH拥塞率_X)/sum(tra.SDCCH拥塞率_Y)))*100,2) AS 无线接通率,
    
    sum(tra.SDCCH拥塞率_X) AS SDCCH拥塞率_X, 
    sum(tra.SDCCH拥塞率_Y) AS SDCCH拥塞率_Y
    

    
/*
    round(decode(sum(tra.无线接通率_2)*sum(tra.无线接通率_4)*sum(tra.无线接通率_6)*sum(tra.无线接通率_8),0,null,
    sum(tra.无线接通率_1)/sum(tra.无线接通率_2)*sum(tra.无线接通率_3)/sum(tra.无线接通率_4)*sum(tra.无线接通率_5)/sum(tra.无线接通率_6)*sum(tra.无线接通率_7)/sum(tra.无线接通率_8))*100,2) AS 无线接通率,
    
    sum(tra.无线接通率_1) AS 无线接通率_1,
    sum(tra.无线接通率_2) AS 无线接通率_2,
    sum(tra.无线接通率_3) AS 无线接通率_3,
    sum(tra.无线接通率_4) AS 无线接通率_4,
    sum(tra.无线接通率_5) AS 无线接通率_5,
    sum(tra.无线接通率_6) AS 无线接通率_6,
    sum(tra.无线接通率_7) AS 无线接通率_7,
    sum(tra.无线接通率_8) AS 无线接通率_8
*/    
  
  
from
    (SELECT 
        ava.period_start_time AS Sdate,
        ava.bsc_gid AS bsc_gid,
        ava.bts_gid AS bts_gid,
        ava.seg_id  AS seg_id,
         
        decode(ava.bsc_gid,
            1465095,'BSC3',
            1371519,'BSC1',
            1425731,'BSC2',
            1611712,'BJFBSC1',
            1647836,'BJFBSC2',
            1493723,'XYFBSC1',
            1539563,'XYFBSC2',
            1539713,'XYFBSC3', 0) AS BSC_ID,
            
        bts.bts_cell_id AS CELL_ID,
        round(sum(ava.ave_busy_tch/ava.res_av_denom14),2) AS "TCH话务量"
        
    FROM    
        BSC_PS_RESAVAIL_TTP1_RAW ava
         --inner join busyhour on ava.bts_gid = busyhour.wcel_id  and ava.seg_id = busyhour.seg_id
         --                   and to_char(ava.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour       
        left join c_bsc_bts bts on ava.bts_gid=bts.obj_gid
         
    WHERE
        ava.period_start_time >= To_Date(&start_date, 'yyyy-mm-dd')
        AND ava.period_start_time <  To_Date(&end_date, 'yyyy-mm-dd')
        

    GROUP BY
        ava.period_start_time,
        ava.bsc_gid,
        ava.bts_gid,
        ava.seg_id,
        ava.bsc_gid,
        bts.bts_cell_id 

    ) ava

LEFT JOIN
    (SELECT 
        ava.period_start_time AS Sdate,
        ava.bsc_gid AS bsc_gid,
        ava.bts_gid AS bts_gid,
        ava.seg_id  AS seg_id,
        
        round(decode(sum(tra.MS_TCH_SUCC_SEIZ_ASSIGN_CMPLT+ho.BSC_I_TCH_TCH+ho.BSC_I_SDCCH_TCH+ho.MSC_I_TCH_TCH+ho.MSC_I_SDCCH_TCH+ho.CELL_TCH_TCH+ho.CELL_SDCCH_TCH),0,0,100*sum(ava.CLEAR_REQUEST_BY_BSC_ON_TCH)/sum(tra.MS_TCH_SUCC_SEIZ_ASSIGN_CMPLT+ho.BSC_I_TCH_TCH+ho.BSC_I_SDCCH_TCH+ho.MSC_I_TCH_TCH+ho.MSC_I_SDCCH_TCH+ho.CELL_TCH_TCH+ho.CELL_SDCCH_TCH)),2) AS "掉话率_含切换",
        
        sum(ava.CLEAR_REQUEST_BY_BSC_ON_TCH) AS "掉话率_含切换_X",
        sum(tra.MS_TCH_SUCC_SEIZ_ASSIGN_CMPLT+ho.BSC_I_TCH_TCH+ho.BSC_I_SDCCH_TCH+ho.MSC_I_TCH_TCH+ho.MSC_I_SDCCH_TCH+ho.CELL_TCH_TCH+ho.CELL_SDCCH_TCH) AS "掉话率_含切换_Y",        
        
        round(decode(sum(tra.TCH_CALL_REQ+ho.MSC_I_TCH_TCH_AT+ho.MSC_I_SDCCH_TCH_AT+ho.BSC_I_TCH_TCH_AT+ho.BSC_I_SDCCH_TCH_AT+ho.CELL_TCH_TCH_AT+ho.CELL_SDCCH_TCH_AT+tra.TCH_FAST_REQ),0,0,100*(sum(tra.QUE_ALL_ASS_REQ_FAIL+tra.QUE_NALL_ASS_REQ_FAIL-tra.A_IF_CRC_MISMATCH_CALL_SETUP+tra.REMOVAL_FROM_QUE_DUE_TO_DR-ho.MSC_O_SDCCH_TCH-ho.BSC_O_SDCCH_TCH-ho.CELL_SDCCH_TCH)+sum(ho.BSC_I_FAIL_LACK+ho.MSC_I_FAIL_LACK))/sum(tra.TCH_CALL_REQ+ho.MSC_I_TCH_TCH_AT+ho.MSC_I_SDCCH_TCH_AT+ho.BSC_I_TCH_TCH_AT+ho.BSC_I_SDCCH_TCH_AT+ho.CELL_TCH_TCH_AT+ho.CELL_SDCCH_TCH_AT+tra.TCH_FAST_REQ)),2) AS "TCH拥塞率", 
        
        (sum(tra.QUE_ALL_ASS_REQ_FAIL+tra.QUE_NALL_ASS_REQ_FAIL-tra.A_IF_CRC_MISMATCH_CALL_SETUP+tra.REMOVAL_FROM_QUE_DUE_TO_DR-ho.MSC_O_SDCCH_TCH-ho.BSC_O_SDCCH_TCH-ho.CELL_SDCCH_TCH)+sum(ho.BSC_I_FAIL_LACK+ho.MSC_I_FAIL_LACK)) AS "TCH拥塞率_X",
        
        sum(tra.TCH_CALL_REQ+ho.MSC_I_TCH_TCH_AT+ho.MSC_I_SDCCH_TCH_AT+ho.BSC_I_TCH_TCH_AT+ho.BSC_I_SDCCH_TCH_AT+ho.CELL_TCH_TCH_AT+ho.CELL_SDCCH_TCH_AT+tra.TCH_FAST_REQ) AS "TCH拥塞率_Y",
                
       
        round(decode(sum(serv.SDCCH_REQ+ho.MSC_I_SDCCH_AT+ho.BSC_I_SDCCH_AT+ho.CELL_SDCCH_AT),0,0,100*sum(tra.SDCCH_BUSY_ATT)/sum(serv.SDCCH_REQ+ho.MSC_I_SDCCH_AT+ho.BSC_I_SDCCH_AT+ho.CELL_SDCCH_AT)),2) "SDCCH拥塞率",
        
        sum(tra.SDCCH_BUSY_ATT) AS "SDCCH拥塞率_X",
        sum(serv.SDCCH_REQ+ho.MSC_I_SDCCH_AT+ho.BSC_I_SDCCH_AT+ho.CELL_SDCCH_AT) AS "SDCCH拥塞率_Y"
        
        
        
        
        
        
        
/*             
        round(decode(sum(serv.SDCCH_REQ+ho.MSC_I_SDCCH_AT+ho.BSC_I_SDCCH_AT+ho.CELL_SDCCH_AT)*SUM(serv.SERVED_SDCCH_REQ+ho.MSC_I_SDCCH+ho.BSC_I_SDCCH+ho.CELL_SDCCH) * sum(tra.TCH_CALL_REQ-tra.A_IF_CRC_MISMATCH_CALL_SETUP +(ho.MSC_I_TCH_TCH_AT+ho.MSC_I_SDCCH_TCH_AT+ho.BSC_I_TCH_TCH_AT +ho.BSC_I_SDCCH_TCH_AT+ho.CELL_TCH_TCH_AT+ho.CELL_SDCCH_TCH_AT+tra.TCH_FAST_REQ)-(ho.MSC_O_SDCCH_TCH_AT+ho.BSC_O_SDCCH_TCH_AT+ho.CELL_SDCCH_TCH_AT))*sum(tra.TCH_NORM_SEIZ+ho.BSC_I_TCH_TCH+ho.BSC_I_SDCCH_TCH +ho.MSC_I_TCH_TCH+ho.MSC_I_SDCCH_TCH+ho.CELL_TCH_TCH+ho.CELL_SDCCH_TCH),0,100,
        100* sum(serv.SERVED_SDCCH_REQ+ho.MSC_I_SDCCH+ho.BSC_I_SDCCH+ho.CELL_SDCCH)/sum(serv.SDCCH_REQ+ho.MSC_I_SDCCH_AT+ho.BSC_I_SDCCH_AT+ho.CELL_SDCCH_AT)*SUM(serv.SERVED_SDCCH_REQ-tra.SDCCH_ACT_FAIL+ho.MSC_I_SDCCH+ho.BSC_I_SDCCH+ho.CELL_SDCCH)/SUM(serv.SERVED_SDCCH_REQ+ho.MSC_I_SDCCH+ho.BSC_I_SDCCH+ho.CELL_SDCCH)*sum(tra.TCH_NORM_SEIZ+ho.BSC_I_TCH_TCH+ho.BSC_I_SDCCH_TCH+ho.MSC_I_TCH_TCH+ho.MSC_I_SDCCH_TCH+ho.CELL_TCH_TCH+ho.CELL_SDCCH_TCH)/sum(tra.TCH_CALL_REQ-tra.A_IF_CRC_MISMATCH_CALL_SETUP +(ho.MSC_I_TCH_TCH_AT+ho.MSC_I_SDCCH_TCH_AT+ho.BSC_I_TCH_TCH_AT +ho.BSC_I_SDCCH_TCH_AT+ho.CELL_TCH_TCH_AT+ho.CELL_SDCCH_TCH_AT+tra.TCH_FAST_REQ) -(ho.MSC_O_SDCCH_TCH_AT+ho.BSC_O_SDCCH_TCH_AT+ho.CELL_SDCCH_TCH_AT)) *sum(tra.MS_TCH_SUCC_SEIZ_ASSIGN_CMPLT+ho.BSC_I_TCH_TCH+ho.BSC_I_SDCCH_TCH +ho.MSC_I_TCH_TCH+ho.MSC_I_SDCCH_TCH+ho.CELL_TCH_TCH+ho.CELL_SDCCH_TCH)/ sum(tra.TCH_NORM_SEIZ+ho.BSC_I_TCH_TCH+ho.BSC_I_SDCCH_TCH +ho.MSC_I_TCH_TCH+ho.MSC_I_SDCCH_TCH+ho.CELL_TCH_TCH+ho.CELL_SDCCH_TCH)),2) AS "无线接通率",
        
        sum(serv.SERVED_SDCCH_REQ+ho.MSC_I_SDCCH+ho.BSC_I_SDCCH+ho.CELL_SDCCH) as "无线接通率_1",
        sum(serv.SDCCH_REQ+ho.MSC_I_SDCCH_AT+ho.BSC_I_SDCCH_AT+ho.CELL_SDCCH_AT) as "无线接通率_2",
        
        SUM(serv.SERVED_SDCCH_REQ-tra.SDCCH_ACT_FAIL+ho.MSC_I_SDCCH+ho.BSC_I_SDCCH+ho.CELL_SDCCH) as "无线接通率_3",
        SUM(serv.SERVED_SDCCH_REQ+ho.MSC_I_SDCCH+ho.BSC_I_SDCCH+ho.CELL_SDCCH) as "无线接通率_4",
        
        sum(tra.TCH_NORM_SEIZ+ho.BSC_I_TCH_TCH+ho.BSC_I_SDCCH_TCH+ho.MSC_I_TCH_TCH+ho.MSC_I_SDCCH_TCH+ho.CELL_TCH_TCH+ho.CELL_SDCCH_TCH) as "无线接通率_5",        
        sum(tra.TCH_CALL_REQ-tra.A_IF_CRC_MISMATCH_CALL_SETUP +(ho.MSC_I_TCH_TCH_AT+ho.MSC_I_SDCCH_TCH_AT+ho.BSC_I_TCH_TCH_AT +ho.BSC_I_SDCCH_TCH_AT+ho.CELL_TCH_TCH_AT+ho.CELL_SDCCH_TCH_AT+tra.TCH_FAST_REQ) -(ho.MSC_O_SDCCH_TCH_AT+ho.BSC_O_SDCCH_TCH_AT+ho.CELL_SDCCH_TCH_AT)) as "无线接通率_6",
        
        sum(tra.MS_TCH_SUCC_SEIZ_ASSIGN_CMPLT+ho.BSC_I_TCH_TCH+ho.BSC_I_SDCCH_TCH +ho.MSC_I_TCH_TCH+ho.MSC_I_SDCCH_TCH+ho.CELL_TCH_TCH+ho.CELL_SDCCH_TCH) as "无线接通率_7",
        sum(tra.TCH_NORM_SEIZ+ho.BSC_I_TCH_TCH+ho.BSC_I_SDCCH_TCH +ho.MSC_I_TCH_TCH+ho.MSC_I_SDCCH_TCH+ho.CELL_TCH_TCH+ho.CELL_SDCCH_TCH) as "无线接通率_8"
        
        
 */  
       
   
        
    FROM    

         BSC_PS_RESAVAIL_TTP1_RAW ava
         
         inner join busyhour on ava.bts_gid = busyhour.wcel_id and ava.seg_id = busyhour.seg_id
                            and to_char(ava.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour
         
         LEFT JOIN BSC_PS_TRAFFIC_TTP1_RAW tra ON ava.period_start_time=tra.period_start_time 
                and ava.bts_gid=tra.bts_gid and ava.seg_id=tra.seg_id
                AND to_char(tra.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour
                and tra.bts_gid = busyhour.wcel_id and tra.seg_id = busyhour.seg_id
                   
         LEFT JOIN BSC_PS_HO_TTP1_RAW ho ON ava.period_start_time=ho.period_start_time 
                and ava.bts_gid=ho.bts_gid and ava.seg_id=ho.seg_id
                AND to_char(ho.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour
                and ho.bts_gid = busyhour.wcel_id and ho.seg_id = busyhour.seg_id
                
         LEFT JOIN BSC_PS_SERVICE_TTP1_RAW serv ON ava.period_start_time=serv.period_start_time 
                and ava.bts_gid=serv.bts_gid and ava.seg_id=serv.seg_id
                AND to_char(serv.period_start_time, 'yyyymmddhh24') = busyhour.pm_date_hour
                and serv.bts_gid = busyhour.wcel_id and serv.seg_id = busyhour.seg_id

   
         
    WHERE
        ava.period_start_time >= To_Date(&start_date, 'yyyy-mm-dd')
        AND ava.period_start_time <  To_Date(&end_date, 'yyyy-mm-dd')
        

    GROUP BY
        ava.period_start_time,
        ava.bsc_gid,
        ava.bts_gid,
        ava.seg_id

    ) tra on ava.bsc_gid = tra.bsc_gid and ava.bts_gid = tra.bts_gid and ava.seg_id = tra.seg_id


left join vipcell on vipcell.CELLID = ava.CELL_ID and vipcell.BSCID = ava.BSC_ID
  


group by
    decode(ava.BSC_ID,'BSC1','西安',
                      'BSC2','西安',
                      'BSC3','西安',
                      'XYFBSC1','咸阳', 'XYFBSC2', '咸阳','XYFBSC3', '咸阳', 
                      'BJFBSC1','宝鸡', 'BJFBSC2', '宝鸡','Other'),
    --vipcell.场景,
    --vipcell.BSCID,
    --vipcell.CELLID,
    --ava.BSC_ID,
    --ava.CELL_ID,
    to_char(ava.Sdate, 'yyyymmdd')
    
    

    