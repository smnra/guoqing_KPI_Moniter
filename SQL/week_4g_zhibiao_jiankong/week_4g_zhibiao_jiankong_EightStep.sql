SELECT a.*,`�豸�����`,`CQI��4ռ��`,`CQI��10ռ��`,`RRC�����û�����0-20��ռ��`,`RRC�����û�����21-200��ռ��`,
`RRC�����û�������200ռ��`,`X2�л�ռ��`,`ƽ���������������-100dbm`,`ƽ��������������<-100dbm&��-105dbm`,`CSFB�������`,`4G��3G�ض�����` FROM 
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