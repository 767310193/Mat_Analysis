% m=datestr(now,29);
% m_1=datestr(now+1,29);
function p=price_distri(m,m_1)
conn=database('','','','com.mysql.jdbc.Driver','jdbc:mysql:///');
query=['select pay_fee from deal where buyer_add_time>="',m,'" and buyer_add_time<="',m_1,'" and deal_state!=0 '];
getcitydata=exec(conn,query);
getcitydata=fetch(getcitydata);
cityData=getcitydata.data;
money_today=cityData;
close(conn)

conn=database('','','','com.mysql.jdbc.Driver','jdbc:mysql:///');

query=['select distinct pay_fee from deal where buyer_add_time>="',m,'" and buyer_add_time<="',m_1,'" and deal_state!=0 order by pay_fee '];
getcitydata=exec(conn,query);
getcitydata=fetch(getcitydata);
cityData=getcitydata.data;
money=cell2mat(cityData)/100;
close(conn)

for i=1:length(money)
    money_count(i,1)=length(find(cell2mat(money_today)/100==money(i)));
end

distri=[money,money_count];
distri(:,3)=distri(:,2).*distri(:,1);
p=distri;