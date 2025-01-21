for(select line as tagname from 'c:\temp\tags\check.txt')do
	--write tagname;
	for(select name n, ip_input_time t, ip_input_value v, ip_input_quality q, ip_plant_area pl, ip_tag_type tp, IP_DESCRIPTION AS de from ip_danalogdef where name = trim(tagname))do
		write n||';'||t||';'||v||';'||q||';'||pl||';'||tp||';'||de;
	end
end
for(select line as tagname from 'c:\temp\tags\check.txt')do
	--write tagname;
	for(select name n, ip_input_time t, ip_input_value v, ip_input_quality q, ip_plant_area pl, ip_tag_type tp, IP_DESCRIPTION AS de from ip_discretedef where name = trim(tagname))do
		write n||';'||t||';'||v||';'||q||';'||pl||';'||tp||';'||de;
	end
end