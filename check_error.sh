#!/bin/bash
#Перезапишем скрипт script.sh, чтобы была ошибка в скрипте 
echo "exit 1" > script.sh

docker build -t genotek-app:latest .

# Присваиваем тег
docker tag genotek-app:latest cr.yandex/$yid/genotek-app:latest

# Пушим в яндекс registry
docker push cr.yandex/$yid/genotek-app:latest

# Запускаем образ
docker run -d -p 5000:5000 cr.yandex/$yid/genotek-app:latest

# Проверяем работоспособность
sleep 5  # Даем контейнеру время запуститься
curl http://localhost:5000/time
