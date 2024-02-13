SET OUTPUT 'c:\temp\fil.txt';--skriver over
SET APPEND 'c:\temp\fil.txt'; legger til
Select name, ip_input_time, ip_input_value from ip_danalogdef where name ="TEST-TAG";


local logfile char(300);
logfile = 'C:\temp\DOF\RealTime_'|| TRIM(REPLACE(':' WITH '_' IN GETDBTIME)) || '.log';
SET OUTPUT logfile;
