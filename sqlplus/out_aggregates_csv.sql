SET OUTPUT 'c:\temp\files\extract-tagname.csv'; -- remove -- if you want to write to a file

for(select name n, ts t, avg av from aggregates where name = 'tagname'
	and ts between '30-JAN-18 00:00' AND '20-NOV-24 00:00'
      and period = 24:00)do

	write n||';'||t||';'||av;

end