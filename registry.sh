#!/bin/bash


yc config set service-account-key /home/$USER/tzgenotek/authorized_key.json
yc config list

# Установка JQ
sudo apt-get install -y jq

registry_id=$(yc container registry list --format json | jq -r '.[0].id')
echo "Registry ID: $registry_id"

# Создаем реестр (если ещё не создан)
yc container registry create --name genotek-app

# Авторизация в Docker
yc container registry configure-docker
docker login cr.yandex -u iam -p $(yc iam create-token)

# Билдим образ
docker build -t genotek-app:latest .

# Присваиваем тег
docker tag genotek-app:latest cr.yandex/$registry_id/genotek-app:latest

# Пушим в реестр
docker push cr.yandex/$registry_id/genotek-app:latest

# Запускаем образ
docker run -d -p 5000:5000 cr.yandex/$registry_id/genotek-app:latest

# Проверяем
sleep 5
curl http://localhost:5000/time

#Добавим права на выполнение скрипта для проверки ошибки
chmod +x check_error.sh
