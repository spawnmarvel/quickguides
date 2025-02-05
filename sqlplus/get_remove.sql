--deloccs
-- må sortere fra høy yil lav occnum
local c int;
c = 0;
local res int;
--MACRO AREC = 
local arec char(60);
--the occnum of tag
local occToDel integer;
--which record and what repeat area
Arec = 'my_get_rec_01 1 io_tagname';
--pick a tag
for(select line as tagname from 'C:\temp\tag\tags_to_be_del.txt')do
	--get that tags reference
	for(select occnum as onum, "IO_VALUE_RECORD&&FLD" as tag, io_data_status st
          from my_get_rec_01 
		where trim(replace('IP_INPUT_VALUE' with '' in "IO_VALUE_RECORD&&FLD")) = trim(tagname))do
		write onum||' ; '||trim(replace('IP_INPUT_VALUE' with '' in tag))||';'||st;
		--delete the occurrenc
		--wait 10;
		--get the result from deloccs, should be 1 for each delete
		--res = DELOCCS(arec, onum, 1);
		c = c + 1;
		write res;
	end
end
--write '';
write 'Total to be deleted; '||c;


SELECT "IO_#TAGS" as Amount_of_occurences, "NAME"
FROM my_get_rec_01;
