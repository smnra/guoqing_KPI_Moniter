UPDATE b_4g_jiankongzhibiao_three
SET city = CASE
         WHEN (LNCEL_ENB_ID >= 782337 AND LNCEL_ENB_ID <= 783592) THEN
          '宝鸡' 
         WHEN (LNCEL_ENB_ID >= 775936 and LNCEL_ENB_ID <= 776286) THEN '宝鸡FDD'
         WHEN (LNCEL_ENB_ID >= 772600 AND LNCEL_ENB_ID <= 774144) THEN
          '西安'
         WHEN (LNCEL_ENB_ID >= 778240 AND LNCEL_ENB_ID <= 780287) THEN
          '咸阳'
         ELSE
           'A'        
       END;
