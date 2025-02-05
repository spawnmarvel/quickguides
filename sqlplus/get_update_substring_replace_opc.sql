local gnam char(24);
local gogo int;
local ny char(56);

gogo = 7;
gnam = 'Get_Name_01';

set log_Rows = 0;
if(gogo = 7) then update iolongtaggetdef set io_record_processing = 'off' where name = gnam; end

for(select occnum p, io_Tagname opc, trim(replace('IP_INPUT_VALUE' with '' in "io_value_Record&&fld")) tag, io_data_status stat
	from iolongtaggetdef where name = gnam and io_tagname like '65%' and io_data_status <> 'good') do

	ny = replace('PV/SIG' with 'X.Value' in opc);
	write tag||chR(9)||opc||chr(9)||stat||chr(9)||ny;

	if(gogo = 7) then
		set log_rows = 0;
		update iolongtaggetdef set io_Tagname = ny where name = gnam and occnum = p;
	end
end
set log_rows = 0;
if(gogo = 7) then update iolongtaggetdef set io_record_processing = 'on' where name = gnam; end