--trim luft fra txt fil
local tname char(100);
local c int;
c = 0;
for(select
	substring(1 of line between ';') as tagname,
	substring(2 of line between ';') as tagdesc,
	substring(3 of line between ';') as tagunit,
	substring(4 of line between ';') as tagmin,
	substring(5 of line between ';') as tagmax



	from 'C:\temp\tags\addtags\ins.txt') do
	c = c +1;
	
	tname = trim(tagname);
		write tname||';'||tagdesc||';'||tagunit||';'||tagmin||';'||tagmax;
		if not exists (select select_description from "ENG-UNITS" where select_description like trim(tagunit)) then
					write 'Not exists; '||tagunit;
				end
		

		--****
		--insert into ip_analogdef(name) values(tname);
		----****
		update ip_analogdef set 
		ip_plant_area = 'plant',
		ip_eng_units = tagunit,
		ip_description = tagdesc,
		ip_value_format = 'F10.3',
		ip_graph_minimum = tagmin,
		ip_graph_maximum = tagmax,
		ip_repository = 'TSK_repos',
		ip_#_of_trend_values = 2,
		ip_archiving = 'on',
		ip_bf_repository = 'TSK_AGGR_06',
		ip_#_of_bf_values = 2,
		ip_bf_archiving = 'on',
		ip_alarm_repository = 'TSK_ALARM_04',
		ip_#_of_alarm_values = 2,
		ip_alarm_archiving = 'on',
            ip_dc_significance = 0.0000001, 
            ip_dc_max_time_int = '+000:05:00.0'
		where name = tname;
--	
--	
end
write c;
