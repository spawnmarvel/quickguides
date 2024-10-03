
-- Source tag avg y day (MW) x 24  (h) = MWh
-- Run the script after midnight and run it once a day

local val real;
local ts_midnight	timestamp;
local ts_next_day	timestamp;
local ts_start_time timestamp;

begin
-- ####
write 'start q yday; '||getdbtime;

ts_midnight = (substring(getdbtime+600*60 from 1 for 10)||'00:00'); -- example 03-OCT-24 00:00:00.0
ts_start_time = (substring(getdbtime-600*60*27 from 1 for 10)||'00:00'); -- example 02-OCT-24 00:00:00.0
ts_next_day  = (substring(ts_midnight+600*60*27 from 1 for 10)||'00:00'); -- example 04-OCT-24 00:00:00.0
write 'Midnight is; '||ts_midnight;
write 'Start time is; '||ts_start_time;
write 'Next day is; '||ts_next_day;


declare local temporary table module.tags_yday(tag_name char(40), soft_tag_name char(45));

-- # test
-- Test tag, TEST-TAG.cv.yday
insert into module.tags_yday VALUES('TEST-TAG-1', 'TEST-TAG-1.cv.yday'); 
insert into module.tags_yday VALUES('TEST-TAG-2', 'TEST-TAG-2.cv.yday'); 
-- # test



FOR (select tag_name, soft_tag_name from module.tags_yday) do

	if exists (select name from ip_danalogdef where name = trim(tag_name)) then
		write '-- batch --';

		-- avg for 24 h start time to endtime
		-- select name,  avg, TS_START, TS_END from aggregates where name = tag_name and ts between ts_start_time and ts_midnight and period = 24:00;
		-- above for debug

		-- avg get value for 24 h start time to endtime
            val = 0;
		val = (select avg from aggregates where name = tag_name and ts between ts_start_time and ts_midnight and period = 24:00);
		write tag_name||';'||val||'; Must be multiplied with 24';
		
		-- avg for 24 h start time to endtime x 24
		val = val * 24;
		if exists (select name from ip_danalogdef where name = trim(soft_tag_name)) then

			write 'Soft tag; '||soft_tag_name||';'||val||'; MWh'||'. Ready for update:';

			-- ##
			update ip_danalogdef
			set ip_input_value = val,  qstatus(IP_INPUT_value) = 'GOOD', qtimestamp(ip_input_VALUE) = GETDBTIME
			where name = soft_tag_name;
			-- ##
		else
			write 'Soft tag does not exist;'||soft_tag_name||'. Calculation is not done.';

		
		end

      else
			write 'Tag does not exist'||tag_name||'. Calculation is not done.';
	end

end -- 4 loop end
			
exception
--statement...
write 'exception'||error_code;
write 'exception'||error_text;
write 'exception'||error_line;


 
end
write 'end q; '||getdbtime;