--fix name
local c int;
c = 0;
for(select substring(1 of line between ';') as curName,
           substring(2 of line between ';') as newName 
		from  'c:\temp\tags\tagname.txt')do
	for(select name as nn from ip_danalogdef where name = trim(curName))do
		write nn||';'||newName;
		--update ip_danalogdef set name = newName where name = nn;
		c = c +1;
	end
end
write 'Total: '||c;