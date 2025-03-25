#!/bin/bash

echo "Настраиваем реестр..."
# Получаем ID из JSON файла
yid=$(jq -r '.id' /home/$USER/authorized_key.json)
echo "id: $yid"

# Создаем реестр
yc container registry create --name genotek-app || true

# Выводим список репозиториев
yc container repository list --registry-id $yid

# Конфигурируем Docker
yc container registry configure-docker

# Билдим образ
#cd genotek
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
