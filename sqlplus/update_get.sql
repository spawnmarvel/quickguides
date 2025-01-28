-- UPDATE OPC
local nTag char(40);
for (select 
SUBSTRING(1 OF LINE BETWEEN ';') AS NEWOPC,
SUBSTRING(2 OF LINE BETWEEN ';') AS IP21TAG
from 'c:\temp\tags\new_opc.txt') do

	for (select name as nn, io_tagname as ionn, occnum as onum, "IO_VALUE_RECORD&&FLD" as tag, io_data_status as st
		from iolongtaggetdef where trim(replace('IP_INPUT_VALUE' with '' in "IO_VALUE_RECORD&&FLD" )) = IP21TAG ) do

		--from iolongtaggetdef where trim(replace('IP_INPUT_VALUE' with '' in "IO_VALUE_RECORD&&FLD" )) like IP21TAG and name = 'get recname') do
	
		write nn||' ; '||onum||' ;'||trim(replace('IP_INPUT_VALUE' with '' in tag))||' ;'||ionn||' ;'||st||'; '||NEWOPC;

        -- set the get record to off to off 
		-- for OPC Change  
		--update iolongtaggetdef set io_tagname = NEWOPC where name = nn and occnum = onum;
	end
End