select 省份,DDATE, 网络,
  '/' as SGW忙时峰值附着用户数,
  '/' as MME忙时附着用户数,
  sum(基站数),
  sum(小区数),
  sum(空口上行业务字节数Kb),
  sum(空口下行业务字节数Kb),
  sum(忙时上行业务字节数Kb),
  sum(忙时下行业务字节数Kb) from 
(
SELECT 
  '陕西' as 省份,
  substr(tab4.地市,0,2) 地市,
  substr(tab4.地市,3,3) 网络,
  to_char(tab4.pm_date, 'yyyymmdd') DDATE,
  '/' as SGW忙时峰值附着用户数,
  '/' as MME忙时附着用户数,
       基站数,
       小区数,       
       round(sum(tab4.空口上行业务字节数) , 2) as 空口上行业务字节数Kb, ---MByte 单位
       round(sum(tab4.空口下行业务字节数) , 2) as 空口下行业务字节数Kb, ---MKByte 单位
       round(sum(tab5.忙时上行业务字节数) , 2) as 忙时上行业务字节数Kb, ---MByte 单位
       round(sum(tab5.忙时下行业务字节数) , 2) as 忙时下行业务字节数Kb ---MKByte 单位
       
  from  (select (CASE
         WHEN (LNCEL_ENB_ID >= 782337 and LNCEL_ENB_ID <= 783592) THEN
          '宝鸡FDD' --663个站点
		 WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN
          '宝鸡FDD' 
         WHEN (LNCEL_ENB_ID >= 772600 and LNCEL_ENB_ID <= 774144) THEN
          '西安FDD' --544个站点
         WHEN (LNCEL_ENB_ID >= 778240 and LNCEL_ENB_ID <= 780287) THEN
          '咸阳FDD' --860个站点
         WHEN (LNCEL_ENB_ID >= 783593 and LNCEL_ENB_ID <= 783615) THEN
          '宝鸡TDD' --23个站点
         WHEN (LNCEL_ENB_ID >= 788460 and LNCEL_ENB_ID <= 788479) THEN
          '汉中TDD' --20个站点
         WHEN (LNCEL_ENB_ID >= 789499 and LNCEL_ENB_ID <= 789503) THEN
          '商洛TDD' --5个站点
         WHEN (LNCEL_ENB_ID >= 787448 and LNCEL_ENB_ID <= 787455) THEN
          '铜川TDD' --8个站点
         WHEN (LNCEL_ENB_ID >= 778100 and LNCEL_ENB_ID <= 778239) THEN
          '西安TDD' --40个站点
         WHEN (LNCEL_ENB_ID >= 786416 and LNCEL_ENB_ID <= 786431) THEN
          '延安TDD' --16个站点
         WHEN (LNCEL_ENB_ID >= 782323 and LNCEL_ENB_ID <= 782335) THEN
          '榆林TDD' --13个站点
         ELSE
          NULL
       END) 地市, 
               noklte_PS_lcellt_lncel_day.PERIOD_START_TIME pm_date,
                max(nvl(PDCP_SDU_VOL_UL,0)) / 1024 as 空口上行业务字节数,
                max(nvl(PDCP_SDU_VOL_DL,0)) / 1024 as 空口下行业务字节数
          from c_lte_lncel lncel, noklte_PS_lcellt_lncel_day
         where noklte_PS_lcellt_lncel_day.LNCEL_ID = lncel.obj_gid
           and lncel.conf_id = 1
           and noklte_PS_lcellt_lncel_day.PERIOD_START_TIME >=
               to_date(&start_datetime, 'yyyymmddhh24')
           and noklte_PS_lcellt_lncel_day.PERIOD_START_TIME <
               to_date(&end_datetime, 'yyyymmddhh24')
         group by (
         CASE
         WHEN (LNCEL_ENB_ID >= 782337 and LNCEL_ENB_ID <= 783592) THEN
          '宝鸡FDD' --663个站点
		 WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN
          '宝鸡FDD' 
         WHEN (LNCEL_ENB_ID >= 772600 and LNCEL_ENB_ID <= 774144) THEN
          '西安FDD' --544个站点
         WHEN (LNCEL_ENB_ID >= 778240 and LNCEL_ENB_ID <= 780287) THEN
          '咸阳FDD' --860个站点
         WHEN (LNCEL_ENB_ID >= 783593 and LNCEL_ENB_ID <= 783615) THEN
          '宝鸡TDD' --23个站点
         WHEN (LNCEL_ENB_ID >= 788460 and LNCEL_ENB_ID <= 788479) THEN
          '汉中TDD' --20个站点
         WHEN (LNCEL_ENB_ID >= 789499 and LNCEL_ENB_ID <= 789503) THEN
          '商洛TDD' --5个站点
         WHEN (LNCEL_ENB_ID >= 787448 and LNCEL_ENB_ID <= 787455) THEN
          '铜川TDD' --8个站点
         WHEN (LNCEL_ENB_ID >= 778100 and LNCEL_ENB_ID <= 778239) THEN
          '西安TDD' --40个站点
         WHEN (LNCEL_ENB_ID >= 786416 and LNCEL_ENB_ID <= 786431) THEN
          '延安TDD' --16个站点
         WHEN (LNCEL_ENB_ID >= 782323 and LNCEL_ENB_ID <= 782335) THEN
          '榆林TDD' --13个站点
         ELSE
          NULL
       END), noklte_PS_lcellt_lncel_day.PERIOD_START_TIME) tab4, 
         
       (
       select 地市,pm_date,max(忙时上行业务字节数1) 忙时上行业务字节数,
       max(忙时下行业务字节数1) 忙时下行业务字节数 from(
       select (CASE
         WHEN (LNCEL_ENB_ID >= 782337 and LNCEL_ENB_ID <= 783592) THEN
          '宝鸡FDD' --663个站点
		 WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN
          '宝鸡FDD' 
         WHEN (LNCEL_ENB_ID >= 772600 and LNCEL_ENB_ID <= 774144) THEN
          '西安FDD' --544个站点
         WHEN (LNCEL_ENB_ID >= 778240 and LNCEL_ENB_ID <= 780287) THEN
          '咸阳FDD' --860个站点
         WHEN (LNCEL_ENB_ID >= 783593 and LNCEL_ENB_ID <= 783615) THEN
          '宝鸡TDD' --23个站点
         WHEN (LNCEL_ENB_ID >= 788460 and LNCEL_ENB_ID <= 788479) THEN
          '汉中TDD' --20个站点
         WHEN (LNCEL_ENB_ID >= 789499 and LNCEL_ENB_ID <= 789503) THEN
          '商洛TDD' --5个站点
         WHEN (LNCEL_ENB_ID >= 787448 and LNCEL_ENB_ID <= 787455) THEN
          '铜川TDD' --8个站点
         WHEN (LNCEL_ENB_ID >= 778100 and LNCEL_ENB_ID <= 778239) THEN
          '西安TDD' --40个站点
         WHEN (LNCEL_ENB_ID >= 786416 and LNCEL_ENB_ID <= 786431) THEN
          '延安TDD' --16个站点
         WHEN (LNCEL_ENB_ID >= 782323 and LNCEL_ENB_ID <= 782335) THEN
          '榆林TDD' --13个站点
         ELSE
          NULL
       END) 地市, to_date(
               to_char(noklte_PS_lcellt_lncel_hour.PERIOD_START_TIME,'yyyymmdd'),
               'yyyymmdd') pm_date,
                to_char(noklte_PS_lcellt_lncel_hour.PERIOD_START_TIME,'hh24') TTIME,
                sum(PDCP_SDU_VOL_UL)  / 1024 as 忙时上行业务字节数1,
                sum(PDCP_SDU_VOL_DL) / 1024 as 忙时下行业务字节数1
          from c_lte_lncel lncel, noklte_PS_lcellt_lncel_hour
         where noklte_PS_lcellt_lncel_hour.LNCEL_ID = lncel.obj_gid
           and lncel.conf_id = 1
           and noklte_PS_lcellt_lncel_hour.PERIOD_START_TIME >=
               to_date(&start_datetime, 'yyyymmddhh24')
           and noklte_PS_lcellt_lncel_hour.PERIOD_START_TIME <
               to_date(&end_datetime, 'yyyymmddhh24')            
         group by (CASE
         WHEN (LNCEL_ENB_ID >= 782337 and LNCEL_ENB_ID <= 783592) THEN
          '宝鸡FDD' --663个站点
		 WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN
          '宝鸡FDD' 
         WHEN (LNCEL_ENB_ID >= 772600 and LNCEL_ENB_ID <= 774144) THEN
          '西安FDD' --544个站点
         WHEN (LNCEL_ENB_ID >= 778240 and LNCEL_ENB_ID <= 780287) THEN
          '咸阳FDD' --860个站点
         WHEN (LNCEL_ENB_ID >= 783593 and LNCEL_ENB_ID <= 783615) THEN
          '宝鸡TDD' --23个站点
         WHEN (LNCEL_ENB_ID >= 788460 and LNCEL_ENB_ID <= 788479) THEN
          '汉中TDD' --20个站点
         WHEN (LNCEL_ENB_ID >= 789499 and LNCEL_ENB_ID <= 789503) THEN
          '商洛TDD' --5个站点
         WHEN (LNCEL_ENB_ID >= 787448 and LNCEL_ENB_ID <= 787455) THEN
          '铜川TDD' --8个站点
         WHEN (LNCEL_ENB_ID >= 778100 and LNCEL_ENB_ID <= 778239) THEN
          '西安TDD' --40个站点
         WHEN (LNCEL_ENB_ID >= 786416 and LNCEL_ENB_ID <= 786431) THEN
          '延安TDD' --16个站点
         WHEN (LNCEL_ENB_ID >= 782323 and LNCEL_ENB_ID <= 782335) THEN
          '榆林TDD' --13个站点
         ELSE
          NULL
       END),  to_char(noklte_PS_lcellt_lncel_hour.PERIOD_START_TIME,'yyyymmdd')
                  ,to_char(noklte_PS_lcellt_lncel_hour.PERIOD_START_TIME,'hh24')
                  )group by 地市,pm_date
                   ) tab5,      
       (
       select  count(distinct lncel.lncel_enb_id) 基站数,
        count(distinct lncel.lncel_enb_id*lncel.lncel_lcr_id) 小区数,               
               noklte_PS_lcelav_lncel_day.PERIOD_START_TIME pm_date,
               (CASE
         WHEN (lncel.LNCEL_ENB_ID >= 782337 and lncel.LNCEL_ENB_ID <= 783592) THEN
          '宝鸡FDD' --663个站点
		 WHEN (lncel.LNCEL_ENB_ID >= 775936 and lncel.LNCEL_ENB_ID <= 776286) THEN
          '宝鸡FDD' 
         WHEN (lncel.LNCEL_ENB_ID >= 772600 and lncel.LNCEL_ENB_ID <= 774144) THEN
          '西安FDD' --544个站点
         WHEN (lncel.LNCEL_ENB_ID >= 778240 and lncel.LNCEL_ENB_ID <= 780287) THEN
          '咸阳FDD' --860个站点
         WHEN (lncel.LNCEL_ENB_ID >= 783593 and lncel.LNCEL_ENB_ID <= 783615) THEN
          '宝鸡TDD' --23个站点
         WHEN (lncel.LNCEL_ENB_ID >= 788460 and lncel.LNCEL_ENB_ID <= 788479) THEN
          '汉中TDD' --20个站点
         WHEN (lncel.LNCEL_ENB_ID >= 789499 and lncel.LNCEL_ENB_ID <= 789503) THEN
          '商洛TDD' --5个站点
         WHEN (lncel.LNCEL_ENB_ID >= 787448 and lncel.LNCEL_ENB_ID <= 787455) THEN
          '铜川TDD' --8个站点
         WHEN (lncel.LNCEL_ENB_ID >= 778100 and lncel.LNCEL_ENB_ID <= 778239) THEN
          '西安TDD' --40个站点
         WHEN (lncel.LNCEL_ENB_ID >= 786416 and lncel.LNCEL_ENB_ID <= 786431) THEN
          '延安TDD' --16个站点
         WHEN (lncel.LNCEL_ENB_ID >= 782323 and lncel.LNCEL_ENB_ID <= 782335) THEN
          '榆林TDD' --13个站点
         ELSE
          NULL
       END) 地市        
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
         group by  (CASE
         WHEN (lncel.LNCEL_ENB_ID >= 782337 and lncel.LNCEL_ENB_ID <= 783592) THEN
          '宝鸡FDD' --663个站点
		 WHEN (lncel.LNCEL_ENB_ID >= 775936 and lncel.LNCEL_ENB_ID <= 776286) THEN
          '宝鸡FDD' 
         WHEN (lncel.LNCEL_ENB_ID >= 772600 and lncel.LNCEL_ENB_ID <= 774144) THEN
          '西安FDD' --544个站点
         WHEN (lncel.LNCEL_ENB_ID >= 778240 and lncel.LNCEL_ENB_ID <= 780287) THEN
          '咸阳FDD' --860个站点
         WHEN (lncel.LNCEL_ENB_ID >= 783593 and lncel.LNCEL_ENB_ID <= 783615) THEN
          '宝鸡TDD' --23个站点
         WHEN (lncel.LNCEL_ENB_ID >= 788460 and lncel.LNCEL_ENB_ID <= 788479) THEN
          '汉中TDD' --20个站点
         WHEN (lncel.LNCEL_ENB_ID >= 789499 and lncel.LNCEL_ENB_ID <= 789503) THEN
          '商洛TDD' --5个站点
         WHEN (lncel.LNCEL_ENB_ID >= 787448 and lncel.LNCEL_ENB_ID <= 787455) THEN
          '铜川TDD' --8个站点
         WHEN (lncel.LNCEL_ENB_ID >= 778100 and lncel.LNCEL_ENB_ID <= 778239) THEN
          '西安TDD' --40个站点
         WHEN (lncel.LNCEL_ENB_ID >= 786416 and lncel.LNCEL_ENB_ID <= 786431) THEN
          '延安TDD' --16个站点
         WHEN (lncel.LNCEL_ENB_ID >= 782323 and lncel.LNCEL_ENB_ID <= 782335) THEN
          '榆林TDD' --13个站点
         ELSE
          NULL
       END), noklte_PS_lcelav_lncel_day.PERIOD_START_TIME                  
       )   tab8                   
           
 where  tab4.地市 = tab5.地市   
   and  tab4.pm_date = tab5.pm_date(+) 
   and tab4.地市 = tab8.地市
   and tab4.pm_date = tab8.pm_date(+)  
group by '陕西',substr(tab4.地市,0,2) ,
  substr(tab4.地市,3,3),to_char(tab4.pm_date, 'yyyymmdd'),        
           基站数,小区数) ASDF           
group by 省份,DDATE,网络          
 order by DDATE 