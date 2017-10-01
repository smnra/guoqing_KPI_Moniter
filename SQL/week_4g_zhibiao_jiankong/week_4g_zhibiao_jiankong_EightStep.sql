SELECT a.*,`设备完好率`,`CQI≤4占比`,`CQI≥10占比`,`RRC链接用户数（0-20）占比`,`RRC链接用户数（21-200）占比`,
`RRC链接用户数大于200占比`,`X2切换占比`,`平均噪声干扰区间≥-100dbm`,`平均噪声干扰区间<-100dbm&≥-105dbm`,`CSFB请求次数`,`4G至3G重定向率` FROM 
b_4g_jiankongzhibiao_result_one a,
b_4g_jiankongzhibiao_result_two b,
b_4g_jiankongzhibiao_result_three c,
b_4g_jiankongzhibiao_result_four d,
b_4g_jiankongzhibiao_result_five e,
b_4g_jiankongzhibiao_result_six f,
b_4g_jiankongzhibiao_result_seven g
WHERE a.city = b.city AND
 a.city = c.city AND
 a.city = d.city AND
 a.city = e.city AND
 a.city = f.city AND
 a.city = g.city 