#!/bin/bash
set -e

docker stop jspchess_mysql
docker stop jspchess_tomcat
docker ps
