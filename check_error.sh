#!/bin/bash
#Перезапишем скрипт script.sh, чтобы была ошибка в скрипте 
echo "exit 1" > script.sh

# Получаем ID из JSON файла
yid=$(jq -r '.id' ./authorized_key.json)
echo "id: $yid"

# Создаем реестр
yc container registry create --name genotek-app-error

# Выводим список репозиториев
yc container repository list --registry-id $yid

# Конфигурируем Docker
yc container registry configure-docker

# Билдим образ
#cd genotek
docker build -t genotek-app:error .

# Присваиваем тег
docker tag genotek-app:error cr.yandex/$yid/genotek-app:error

# Пушим в яндекс registry
docker push cr.yandex/$yid/genotek-app:error

# Запускаем образ
docker run -d -p 5001:5000 cr.yandex/$yid/genotek-app:latest

# Проверяем работоспособность
sleep 5  # Даем контейнеру время запуститься
curl http://localhost:5001/time
