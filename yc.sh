#!/bin/bash

# Установка YC CLI
echo "Устанавливаем YC CLI..."
curl -s https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash -s -- -a
source ~/.bashrc

yc config set service-account-key /home/$USER/authorized_key.json
yc config list
