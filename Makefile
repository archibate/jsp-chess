reset:
	-echo drop database letterdb | ./sql.sh
	./sql.sh < letter.sql

shell:
	./sql.sh letterdb
