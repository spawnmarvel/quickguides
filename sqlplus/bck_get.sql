 for(select name as nn, io_data_status st, io_tagname as opc, occnum as onum, trim(replace('IP_INPUT_VALUE' with '' in "IO_VALUE_RECORD&&FLD")) as tag 
	from ioGetDef where name = 'Get_record') do
	
	write nn||';'||onum||';'||st||';'||opc||';'||tag;
end
