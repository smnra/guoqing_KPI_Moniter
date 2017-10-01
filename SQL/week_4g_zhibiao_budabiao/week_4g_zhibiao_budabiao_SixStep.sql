select substr(&start_datetime,0,8)|| '-' || substr(&end_datetime,0,8) 时间, '诺基亚' 厂家, substr((CASE
         WHEN (LNCEL_ENB_ID >= 782337 and LNCEL_ENB_ID <= 783592) THEN
          '宝鸡FDD' --663个站点
		 WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN '宝鸡FDD'
         WHEN (LNCEL_ENB_ID >= 772600 and LNCEL_ENB_ID <= 774144) THEN
          '西安FDD' --544个站点
         WHEN (LNCEL_ENB_ID >= 778240 and LNCEL_ENB_ID <= 780287) THEN
          '咸阳FDD' --860个站点   
         ELSE
           'A'        
       END),0,2) 地市,
       lncel.lncel_enb_id,
       lncel.lncel_lcr_id from c_lte_lncel lncel
where lncel_lcr_id >10