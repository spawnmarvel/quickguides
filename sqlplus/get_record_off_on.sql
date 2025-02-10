--long
for(select name n, io_record_processing pro, io_last_update ls, io_last_status st from iolongtaggetdef)do

	write n||';'||pro||';'||ls||';'||st;
	--update iolongtaggetdef set io_record_processing = 'ON' where name = n;
	--update iolongtaggetdef set io_record_processing = 'OFF' where name = n;
	--wait 30;
end
