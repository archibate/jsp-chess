x:
	-echo drop database letterdb | ./sql.sh
	./sql.sh < letter.sql
