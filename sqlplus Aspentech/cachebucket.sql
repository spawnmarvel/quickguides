local teller;
local search_for record, found_field field;
teller = 0;

for (select name as a1, num_of_points ca from diskhistorydef order by name) do
	search_for = a1;
	found_field = nxtrefer(NULL, search_for);
 
	while found_field is not null do
		found_field = nxtrefer(found_field, search_for);
		teller = teller + 1;
	end
	--write search_for||';'||teller||'; Cache; '||ca;

	if (teller > ca) then
		write 'fix for '||search_for||';'||teller||'; Cache; '||ca;
	else
		--we are good
	end

	Teller = 0;

End
