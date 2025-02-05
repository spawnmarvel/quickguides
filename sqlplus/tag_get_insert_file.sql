local search_for record, found_field field;
local gnam char(54);
local getana char(54);
local getdig char(54);
local pos int;
local rep char(54);
local bf char(54);
local al char(54);
local pa char(54);
local sjekk char(54);
local posana int;
local posdig int;
local i_opc char(99);
local i_pos int;
local i_nam char(54);

pa = 'SYS 18';
pos  = 29;
getdig = 'Get_Name_Dig_01';
getana = 'Get_Name_Ana_05';
rep = 'TSK_REP_01';
bf  = 'TSK_AGGR_01';
al  = 'TSK_ALARM_02';

declare local temporary table module.x(xtag char(54),xgnam char(54),xpos int, xopc char(65), oldopc char(54));

for(select
trim(substring(1  of line between chr(9))) opc,
trim(substring(2  of line between chr(9))) tag,
trim(substring(3  of line between chr(9))) besk,
trim(substring(4  of line between chr(9))) unit,
trim(substring(5  of line between chr(9))) tmin,
trim(substring(6  of line between chr(9))) tmax,
trim(substring(7  of line between chr(9))) hh,
trim(substring(8  of line between chr(9))) h,
trim(substring(9  of line between chr(9))) tagtype

from 'C:temp\tags.txt') do

	if(tagtype = 'digital') then gnam = getdig; end	
	if(tagtype = 'analog') then gnam = getana; end

	sjekk = (Select name from all_Records where name = tag);
	if(sjekk like '') then
	
		if(tagtype = 'digital') then
			write tag||chr(9)||tagtype||chr(9)||besk||chr(9)||unit;
			set log_rows = 0;
			insert into ip_discretedef(name,ip_description,ip_plant_Area,ip_eng_units,ip_dc_significance,ip_dc_max_time_int,ip_graph_maximum,
			ip_value_format,ip_graph_minimum,ip_repository,ip_#_of_trend_values,ip_archiving,ip_bf_repository,ip_#_of_bf_values,ip_bf_archiving,
			ip_alarm_repository,ip_#_of_alarm_values,ip_alarm_archiving)
			values(tag,besk,pa,'digital',1,'+000:05:00.0',2,'I4',-1,rep,2,'on',bf,2,'on',al,2,'on');
		else
			write tag||chr(9)||tagtype||chr(9)||besk||chr(9)||unit;
			set log_Rows = 0;
			insert into ip_analogdef(name,ip_description,ip_plant_Area,ip_eng_units,ip_dc_significance,ip_dc_max_time_int,
			ip_graph_maximum,ip_graph_minimum,ip_value_format,ip_high_high_limit,ip_high_limit,
			ip_repository,ip_#_of_trend_values,ip_archiving,ip_bf_repository,ip_#_of_bf_values,ip_bf_archiving,
			ip_alarm_repository,ip_#_of_alarm_values,ip_alarm_archiving)
			values(tag,besk,pa,unit,0.000001,'+000:05:00.0',tmax,tmin,'F10.3',hh,h,rep,2,'on',bf,2,'on',al,2,'on');
		end
	else
		sjekk = (tag->ip_input_Quality);

		if(sjekk = 'initial') then
			-- # Legg inn i getrecords
			pos = gnam->"io_#tags";
			write tag||' -> get-record '||gnam||chr(9)||pos;
			set log_rows = 0;
			update iolongtaggetdef set io_record_processing = 'off' where name = gnam;
			update iolongtaggetdef set "io_#tags" = pos + 1 where name = gnam;
			update iolongtaggetdef set io_tagname = opc, "io_value_Record&&fld" = tag||' ip_input_value', io_data_processing = 'on' where name = gnam and occnum = pos+1;
			update iolongtaggetdef set io_record_processing = 'on' where name = gnam;
			set output = default;
            
		else
			write tag||chr(9)||tag->ip_input_time||chr(9)||tag->ip_input_quality||chr(9)||tag->ip_input_value||chr(9)||chr(9)||opc;
		end
	end
end