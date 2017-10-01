truncate table b_4g_jiankongzhibiao_result_one;
truncate table b_4g_jiankongzhibiao_result_two;
insert into b_4g_jiankongzhibiao_result_one 
select a.city,cnt1 "下行无线资源利用率<=20%的小区数", 
(cnt1*100)/cnt "下行无线资源利用率<=20%的小区占比" ,
cnt2 "下行无线资源利用率>=50%的小区数",
(cnt2*100)/cnt "下行无线资源利用率>=50%的小区占比" 
 from (select city ,count(*) cnt1 from  b_4g_jiankongzhibiao_one
where radiorate <=20
GROUP BY city) a
join (select city ,count(*) cnt from b_4g_jiankongzhibiao_one
GROUP BY city) b
on a.city = b.city
join  (select city ,count(*) cnt2 from b_4g_jiankongzhibiao_one
where radiorate >=50
GROUP BY city) c
on a.city = c.city;