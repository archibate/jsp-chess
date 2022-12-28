#!/bin/bash
set -e

PORT=8080
IPADDR=`python -c 'import socket; print(socket.gethostbyname(socket.gethostname()))'`
docker run --name jspchess_mysql --rm -p 3306:3306 -e MYSQL_ROOT_PASSWORD=ihatesql -dit mysql
docker run --name jspchess_tomcat --rm -p 8080:$PORT -v "`pwd`":/usr/local/tomcat/webapps/ROOT -e MYSQL_ADDR=$IPADDR -dit tomcat
docker ps
echo "Now run init.sh then visit http://$IPADDR:$PORT"
