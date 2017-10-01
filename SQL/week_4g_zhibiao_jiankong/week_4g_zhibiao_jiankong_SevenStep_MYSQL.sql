TRUNCATE TABLE b_4g_jiankongzhibiao_result_seven;
INSERT INTO b_4g_jiankongzhibiao_result_seven 
SELECT a.city ,ROUND((b.M8006C15 - a.fz)/(b.fm)*100,2) zb
FROM b_4g_jiankongzhibiao_seven_fz a,
b_4g_jiankongzhibiao_seven_fm b 
WHERE a.city = b.city




 

 
