0:
	-echo drop database letterdb | ./sql.sh
	./sql.sh < letter.sql

x:
	./sql.sh letterdb
