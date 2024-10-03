local ts_midnight	timestamp;
local ts_next_day	timestamp;
local ts_start_time timestamp;
write getdbtime;

write 'test';
ts_midnight = (substring(getdbtime+600*60 from 1 for 10)||'00:00'); -- example 03-OCT-24 00:00:00.0
ts_start_time = (substring(getdbtime-600*60*27 from 1 for 10)||'00:00'); -- example 02-OCT-24 00:00:00.0
ts_next_day  = (substring(ts_midnight+600*60*27 from 1 for 10)||'00:00'); -- example 04-OCT-24 00:00:00.0
write 'mid '||ts_midnight;
write 'start  '||ts_start_time;
write 'next '||ts_next_day;
