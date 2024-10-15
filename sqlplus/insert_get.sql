--short

--add ip input value
local tagname char(60);
local c int;
local repsize int;
repsize = my_get_rec_03.IO_#TAGS;
c = 0;
for(select 
	trim(substring(1 of line between ';')) opc,
	trim(substring(2 of line between ';')) tag

	from 'C:\temp\tags\addtags\opc.txt')
do
tagname = tag ||' IP_INPUT_VALUE';
write 'Opc; '||opc||'; Tag: '||tagname;
--slå av io_processing på record
--SET EXPAND_REPEAT = 1; --occurrence
--INSERT INTO my_get_rec_03(IO_TAGNAME, "IO_VALUE_RECORD&&FLD", IO_DATA_TYPE, IO_DATA_PROCESSING)
--values (opc, tagname, 'Default', 'ON');
c = c +1;

End
write 'Slå på io processing på get record....';
write 'Satt inn :'||c||' rader';
write repsize;
