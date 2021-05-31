default: reset copy

reset:
	-echo drop database letterdb | ./sql.sh
	./sql.sh < letter.sql

copy:
	-sudo cp * /var/lib/tomcat10/webapps/chess/

query:
	./sql.sh

shell:
	./sql.sh letterdb
