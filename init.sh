echo drop database letterdb | ./sql.sh 2> /dev/null
exec ./sql.sh < letter.sql
