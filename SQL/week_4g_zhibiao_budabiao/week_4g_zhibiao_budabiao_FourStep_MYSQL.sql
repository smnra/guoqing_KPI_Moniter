INSERT INTO b_4g_jiankongzhibiao_budabiao_four
SELECT a.city ,a.lncel_enb_id,a.lncel_lcr_id,ROUND((b.M8006C15 - a.fz)/(b.fm)*100,2) zb
FROM b_4g_jiankongzhibiao_budabiao_four_fz a,
b_4g_jiankongzhibiao_budabiao_four_fm b 
WHERE  a.lncel_enb_id = b.lncel_enb_id
      AND a.lncel_lcr_id = b.lncel_lcr_id