echo "started"
REM The service was
sc config "RabbitMQ" obj= ".\LocalSystem" password= ""
REM Set new user and pass
REM the user must be granted logon as service user before this
REM sc config "RabbitMQ" obj= "Domain\function_key_name" password= "A-PASSWORD"

net stop RabbitMQ

net start RabbitMQ

echo "We are done"
pause