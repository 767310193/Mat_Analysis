conn=database('' ,'','','com.mysql.jdbc.Driver','jdbc:mysql:///');%mysql address
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
    query=['SELECT COUNT(1) FROM deal WHERE deal_state!=0 AND buyer_add_time>="',time,'" AND buyer_add_time<="',time_plus1,'" '];
    getcitydata=exec(conn,query);
    getcitydata=fetch(getcitydata);
    cityData=getcitydata.data;
    cityData=cell2mat(cityData);
    buyer_num(2,k)=cityData;
    buyer_num(1,k)=i;
    
    query1=['SELECT sum(pay_fee)/100 FROM deal WHERE deal_state!=0 AND buyer_add_time>="',time,'" AND buyer_add_time<="',time_plus1,'" '];
    getcitydata1=exec(conn,query1);
    getcitydata1=fetch(getcitydata1);
    cityData1=getcitydata1.data;
    cityData1=cell2mat(cityData1);
    if isnan(cityData1)
        cityData1=0;
    end
    buyer_num(3,k)=cityData1;
    
    query2=['SELECT count(1) FROM deal WHERE deal_state=3 AND etime="',time,'" '];
    getcitydata2=exec(conn,query2);
    getcitydata2=fetch(getcitydata2);
    cityData2=getcitydata2.data;
    cityData2=cell2mat(cityData2);
    if isnan(cityData2)
        cityData2=0;
    end
    buyer_num(4,k)=cityData2;
    
    query3=['SELECT sum(payout_fee)/100 FROM deal WHERE deal_state!=0 AND etime="',time,'" '];
    getcitydata3=exec(conn,query3);
    getcitydata3=fetch(getcitydata3);
    cityData3=getcitydata3.data;
    cityData3=cell2mat(cityData3);
    if isnan(cityData3)
        cityData3=0;
    end
    buyer_num(5,k)=cityData3;
    
%     query4=['SELECT (sum(pay_fee)-sum(payout_fee))/100 FROM deal WHERE deal_state!=0 AND etime="',time,'" '];
%     getcitydata4=exec(conn,query4);
%     getcitydata4=fetch(getcitydata4);
%     cityData4=getcitydata4.data;
%     cityData4=cell2mat(cityData4);
%     if isnan(cityData4)
%         cityData4=0;
%     end
%     buyer_num(6,k)=cityData4;
%     buyer_num(7,k)=buyer_num(6,k)/buyer_num(3,k);
    
    k=k+1;
end
% for i=1:length(buyer_num(1,:))
%     date0=num2str(buyer_num(1,i));
%     date=[date0(1:4),'-',date0(5:6),'-',date0(7:8)];
% end
close(conn);
buyer_num(6,:)=buyer_num(3,:)-buyer_num(5,:);
buyer_num(7,:)=buyer_num(6,:)./buyer_num(3,:);


startDate = datenum(cell2mat(date(1)));
endDate = datenum(cell2mat(date((length(date)))));
xData = linspace(startDate,endDate,length(buyer_num(1,:)));

subplot(2,2,1);
%plot(xData,buyer_num(3,:),xData,buyer_num(5,:))
plot(xData,buyer_num(2,:))
%bar(xData,buyer_num(2,:),1)
set(gca,'XTick',startDate:(endDate-startDate)/8:endDate)
datetick('x','yyyy/mm/dd','keepticks')
xlabel('时间');ylabel('购买单数（人次）');
grid on
set(gca,'XMinorGrid','on')
set(gca,'YMinorGrid','on')

subplot(2,2,2);
plot(xData,buyer_num(3,:))
%bar(xData,buyer_num(3,:),1)
xlabel('时间');ylabel('收入金额（元）');
set(gca,'XTick',startDate:(endDate-startDate)/8:endDate)
datetick('x','yyyy/mm/dd','keepticks')
grid on
set(gca,'XMinorGrid','on')
set(gca,'YMinorGrid','on')

subplot(2,2,3);
%plot(xData,buyer_num(2,:),xData,buyer_num(3,:))
plot(xData,buyer_num(4,:))
%hold on
%bar(xData,buyer_num(4,:),1)
%hold off
set(gca,'XTick',startDate:(endDate-startDate)/8:endDate)
datetick('x','yyyy/mm/dd','keepticks')
xlabel('时间');ylabel('赔付单数（人次）');
grid on
set(gca,'XMinorGrid','on')
set(gca,'YMinorGrid','on')

subplot(2,2,4);
plot(xData,buyer_num(5,:))

%bar(xData,buyer_num(5,:),1)

xlabel('时间');ylabel('赔付金额（元）');
set(gca,'XTick',startDate:(endDate-startDate)/8:endDate)
datetick('x','yyyy/mm/dd','keepticks')
grid on
set(gca,'XMinorGrid','on')
set(gca,'YMinorGrid','on')

buyer_numt=buyer_num'



%sum()