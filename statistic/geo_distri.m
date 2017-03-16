%now=datestr(now,29);
%now_1=datestr(now+1,29);
function [p]=geo_distri(now,now_1)
m=now;
m_1=now_1;
conn=database('','','','com.mysql.jdbc.Driver','jdbc:mysql:///');
query=['select distinct city_id,count(city_id),sum(pay_fee)/100,sum(payout_fee)/100 from deal where buyer_add_time>="',m,'" AND weather_type = 4 and buyer_add_time<="',m_1,'" and deal_state!=0 group by city_id order by city_id '];
getcitydata=exec(conn,query);
getcitydata=fetch(getcitydata);
cityData=getcitydata.data;
geo=cityData;

if strcmp(cell2mat(geo(1,1)),'No Data')
    geo_distri={0};
    p=geo_distri;
elseif strcmp(cell2mat(geo(1,1)),'No Data')==0
    
    query2=['SELECT	en_name FROM	city_online WHERE	city_id IN (	SELECT DISTINCT	city_id	FROM	deal	WHERE	buyer_add_time >= "',m,'"	AND buyer_add_time <= "',m_1,'"	AND deal_state != 0	AND weather_type = 4 GROUP BY	city_id	)order by city_id '];
    getcitydata2=exec(conn,query2);
    getcitydata2=fetch(getcitydata2);
    cityData2=getcitydata2.data;
    cn_name=cityData2;
    geo_distri=[geo(:,1),cn_name,geo(:,2),geo(:,3),geo(:,4)];
    geo_distri=sortrows(geo_distri,-3);
    geo_distri=sortrows(geo_distri,-5);
    p=sortrows(geo_distri,-4);
end
