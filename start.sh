#!/bin/bash

docker run --rm -p 3306:3306 -e MYSQL_ROOT_PASSWORD=ihatesql -dit mysql
docker run --rm -p 8080:8080 -v "`pwd`":/usr/local/tomcat/webapps/ROOT -e MYSQL_ADDR=`python -c 'import socket; print(socket.gethostbyname(socket.gethostname()))'` -dit tomcat
docker ps
