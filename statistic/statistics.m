%����ͳ��


geo=geo_distri(datestr(now-1,29),datestr(now,29));
%ǰһ�ն�������ͳ��
price=price_distri(datestr(now-1,29),datestr(now,29));
%ǰһ�ն����۸�ͳ��
datediff=date_distri('2016-09-01',datestr(now+1,29));
%�������ж�������ʱ���뱣����ʼʱ��ͳ��

custom=custom_new(datestr(now-1,29),datestr(now,29));
custom_num=length(custom(:,1));
%ǰһ�������û�����

custom_percent=new_money_percent(datestr(now-1,29));
%ǰһ�����û�����ռ��

conn=database('','','','','jdbc:mysql:///');
query=['select count(distinct(mobile)) from deal where deal_state!=0'];
getcitydata=exec(conn,query);
getcitydata=fetch(getcitydata);
cityData=getcitydata.data;
total_custom=cell2mat(cityData);%���û���
close(conn)


