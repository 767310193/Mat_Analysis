function p=custom_new(m,m_1)
conn=database('','','','com.mysql.jdbc.Driver','jdbc:mysql:///');
query=['SELECT mobile,SUM(pay_fee)/100 FROM deal WHERE deal_state!=0 AND buyer_add_time>="',m,'" AND buyer_add_time<="',m_1,'" AND weather_type=4 AND mobile NOT IN(SELECT DISTINCT mobile FROM deal WHERE buyer_add_time<"',m,'" AND weather_type=4 and deal_state!=0 ) GROUP BY mobile ORDER BY buyer_add_time'];
getcitydata=exec(conn,query);
getcitydata=fetch(getcitydata);
cityData=getcitydata.data;
new_custom=cityData;
p=new_custom;