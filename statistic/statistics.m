%常用统计


geo=geo_distri(datestr(now-1,29),datestr(now,29));
%前一日订单地理统计
price=price_distri(datestr(now-1,29),datestr(now,29));
%前一日订单价格统计
datediff=date_distri('2016-09-01',datestr(now+1,29));
%至今所有订单购买时间与保障起始时间统计

custom=custom_new(datestr(now-1,29),datestr(now,29));
custom_num=length(custom(:,1));
%前一日新增用户详情

custom_percent=new_money_percent(datestr(now-1,29));
%前一日新用户购买占比

conn=database('','','','','jdbc:mysql:///');
query=['select count(distinct(mobile)) from deal where deal_state!=0'];
getcitydata=exec(conn,query);
getcitydata=fetch(getcitydata);
cityData=getcitydata.data;
total_custom=cell2mat(cityData);%总用户数
close(conn)


