function percentage=new_money_percent(day_num)
conn=database('','','','com.mysql.jdbc.Driver','jdbc:mysql:///');
m=datestr(now,29);
m=str2double([m(1:4),m(6:7),m(9:10)]);
k=1;
for i=20160719:m
    if (i>20160731&&i<20160801)||(i>20160831&&i<20160901)
        continue
    end
    time=num2str(i);
    time=[time(1:4),'-',time(5:6),'-',time(7:8)];
    date(k)={time};
    if i==20160731||i==20160831
        time_plus1=num2str(i+70);
    else
        time_plus1=num2str(i+1);
    end
    time_plus1=[time_plus1(1:4),'-',time_plus1(5:6),'-',time_plus1(7:8)];   
    query1=['SELECT sum(pay_fee)/100 FROM deal WHERE deal_state!=0 AND buyer_add_time>="',time,'" AND buyer_add_time<="',time_plus1,'" '];
    getcitydata1=exec(conn,query1);
    getcitydata1=fetch(getcitydata1);
    cityData1=getcitydata1.data;
    cityData1=cell2mat(cityData1);
    if isnan(cityData1)
        cityData1=0;
    end
    buyer_num(k)=cityData1;
    k=k+1;
end
close(conn);
time_start='2016-07-19';
%day_num=datestr(now,29);
day_num_1=datestr(datenum(day_num)+datenum(1),29);
custom_newbuyer=custom_new(day_num,day_num_1);
if strcmp(custom_newbuyer,'No Data')==1
    custom_newbuyer(1)={0};
    custom_newbuyer(2)={0};
end
money_new=sum(cell2mat(custom_newbuyer(:,2)));

day_diff=datenum(day_num)-datenum(time_start);
money_total=buyer_num(day_diff+1);
if money_total==0
    money_total=1;
end

percentage=money_new/money_total;

