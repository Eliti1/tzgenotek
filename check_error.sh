#!/bin/bash
#Перезапишем скрипт script.sh, чтобы была ошибка в скрипте 
echo "exit 1" > script.sh

curl http://localhost:5000/time
