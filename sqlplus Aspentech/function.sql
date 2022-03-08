--function
FUNCTION get_avg_tag_value(tag_name CHAR(40), start_time TIMESTAMP, end_time TIMESTAMP)
	RETURN (SELECT AVG(IP_TREND_VALUE) FROM IP_AnalogDef WHERE name = tag_name AND IP_TREND_TIME >= start_time AND IP_TREND_TIME < end_time AND IP_TREND_QSTATUS = 'Good');
END


--procedure
PROCEDURE update_tag_value(tag_name CHAR(40), val REAL, start_time TIMESTAMP)
	UPDATE IP_AnalogDef SET IP_INPUT_VALUE = val, Qstatus(IP_INPUT_VALUE) = 'Good', QTimeStamp(IP_INPUT_VALUE) = start_time  WHERE name = tag_name;
	WRITE 'Tag: ' || tag_name || ' updated with value: ' || val;
END
--
local tag char(40);
local t_value real;
local t_time timestamp;

tag = (select name from ip_analogdef where name = 'TEST-MA');
t_time = getdbtime;




-use it---
update_tag_value(tag,30,t_time);
WRITE(get_avg_tag_value(tag, '01-DEC-19 23:00', '17-DEC-19 12:35'));

function upDateAna(n char(50), q char(20), v real, t timestamp)

	update ip_analogdef
	set ip_input_value = v,  qstatus(IP_INPUT_value) = q, qtimestamp(ip_input_VALUE) = t
	where name = n;

end

upDateAna('jekl', 'GOOD', 12.2, getdbtime);
select name, ip_input_time, ip_input_value from ip_analogdef where name = 'jekl';
