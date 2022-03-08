--********************************************************************
--				DESCRIPTION
--				-----------
--                      A note about the logic
--                      B note
--********************************************************************
-- Version	Date      	 Author	Description
-- -------  ------	-------	----------------------------------------
-- V1.0	21.10.2019	 jekl	      Created script, see description
-- V1.1	


--*** vars, To declare a, b, and c all as real variables using one statement, use the following syntax (not local a, b real;:
local tmp_val real;
local sum_val real;
local tmp_t timestamp;


--***func
function mult(v1 int, v2 int)
	return v1*v2;
end

--*** tmp tables
declare local temporary table module.inmem(i_value real, i_time timestamp);

delete from module.inmem;
-- add as many tmps as needed

--*** Disable logging statements (insert into inmem is now gone)
set log_rows = 0;

--***start
begin
write 'start q; '||getdbtime;

--*** get data insert tmp
for(select ip_input_time t, ip_input_value v from ip_danalogdef where name = 'TAG-NAME-01')do

	--minimize all writes, just use it for debug, Combine select statements with for loops to initialize local variables with fields from records
	tmp_t = t;
	tmp_val = v;
	insert into module.inmem values(tmp_val, tmp_t);
end

--*** use tmp for all work
for(select i_value, i_time from module.inmem)do

	sum_val = mult(i_value, 2);
	--
	write i_value||';'||sum_val||';'||i_time;
	
	--statment exception
	Begin
	-- do something
	Exception
		Write ''failed;
	end
	
end


--*** exceptions
exception
--statement...
write 'exception'||error_code;
write 'exception'||error_text;
write 'exception'||error_line;


 
end
write 'end q; '||getdbtime;