local c int;
c = 0;
for (select line as tag from 'c:\temp\tags\rm_discrete.txt')do
	for(select name n from ip_discretedef where name = tag)do
		write n;
		update ip_discretedef set ip_archiving = 'OFF' where name = n;
		wait 20;
		delete from ip_discretedef where name = n;
		c = c +1;
	end	
end
write c;
