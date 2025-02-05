-- UPDATE OPC
local nTag char(40);
for (select 
SUBSTRING(1 OF LINE BETWEEN ';') AS NEWOPC,
SUBSTRING(2 OF LINE BETWEEN ';') AS IP21TAG
from 'c:\temp\addtags\new_opc.txt') do

	for (select name as nn, io_tagname as ionn, occnum as onum, "IO_VALUE_RECORD&&FLD" as tag, io_data_status as st, io_data_processing as pr
		from iolongtaggetdef where trim(replace('IP_INPUT_VALUE' with '' in "IO_VALUE_RECORD&&FLD" )) = IP21TAG ) do

		--from iolongtaggetdef where trim(replace('IP_INPUT_VALUE' with '' in "IO_VALUE_RECORD&&FLD" )) like IP21TAG and name = 'get recname') do
	
		write nn||' ; '||onum||' ;'||trim(replace('IP_INPUT_VALUE' with '' in tag))||' ;'||ionn||' ;'||st||'; '||pr||';'||NEWOPC;

        -- 1 set the main get record to off to off 
        -- 2 set the tag processing to off
       -- update iolongtaggetdef set io_data_processing = 'off' where name = nn and occnum = onum;

        -- 3 set new opc  
	-- update iolongtaggetdef set io_tagname = NEWOPC where name = nn and occnum = onum;
	
	-- 1 set the main get record to onn, off
	-- 4 set the tag record to on
	--update iolongtaggetdef set io_data_processing = 'on' where name = nn and occnum = onum;

	
	end
end

-- fix this