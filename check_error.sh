#!/bin/bash
#Перезапишем скрипт script.sh, чтобы была ошибка в скрипте 
echo "exit 1" > script.sh

# Получаем ID из JSON файла
registry_id=$(yc container registry list --format json | jq -r '.[0].id')
echo "Registry ID: $registry_id"

# Создаем реестр
yc container registry create --name genotek-app-error

# Конфигурируем Docker
yc container registry configure-docker

# Билдим образ
#cd genotek
docker build -t genotek-app:error .

# Присваиваем тег
docker tag genotek-app:error cr.yandex/$registry_id/genotek-app:error

# Пушим в яндекс registry
docker push cr.yandex/$registry_id/genotek-app:error

# Запускаем образ
docker run -d -p 5001:5000 cr.yandex/$registry_id/genotek-app:latest

# Проверяем работоспособность
sleep 5  # Даем контейнеру время запуститься
curl http://localhost:5001/time
