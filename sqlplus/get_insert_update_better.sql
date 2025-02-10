local get_rec_name char(54);
get_rec_name = 'AspenChem_Get';
local position int;


-- set record to off, iogetdef or iolongtaggetdef?

--update iogetdef set io_record_processing = 'off' where name = get_rec_name;

for(select
	substring(1 of line between ';') as opc,
	substring(2 of line between ';') as tag

from 'C:\Temp\tags.txt') do

	write opc||';'||tag;
	-- add to get record, start
	position = get_rec_name->"io_#tags";
	write tag||' -> get-record '||get_rec_name||';'||position;

	-- add new OPC-T103;T103.PV 
 	--update iogetdef set "io_#tags" = position + 1 where name = get_rec_name;
	--update iogetdef set io_tagname = opc, "io_value_Record&&fld" = tag||' IP_INPUT_VALUE', io_data_processing = 'on' where name = get_rec_name and occnum = position + 1;
		
	-- write the new size
     
	
end
write 'Get total '||get_rec_name||';'||position;
-- set record to on, iogetdef or iolongtaggetdef?
--update iogetdef set io_record_processing = 'on' where name = get_rec_name;

