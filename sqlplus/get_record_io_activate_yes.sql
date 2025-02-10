for(select name nn, io_record_processing pp,  "IO_ACTIVATE?" act from iogetdef)do
	write nn||';'||pp||';'||act;
	--update iogetdef set "IO_ACTIVATE?" = 'YES' where name = nn;
     	--wait 30; -- sec

end