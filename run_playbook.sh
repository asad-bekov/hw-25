#!/bin/bash

set -e

echo "▶ Запуск контейнеров..."
docker run -d --name centos_host pycontribs/centos:7 sleep infinity || { echo "Ошибка запуска centos"; exit 1; }
docker run -d --name debian_host pycontribs/debian sleep infinity || { echo "Ошибка запуска debian"; exit 1; }
docker run -d --name fedora_host pycontribs/fedora sleep infinity || { echo "Ошибка запуска fedora"; exit 1; }

echo "▶ Ожидание готовности контейнеров..."
sleep 5  # Даем контейнерам время на инициализацию

echo "▶ Запуск ansible-playbook..."
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass || { echo "Ошибка выполнения playbook"; }

echo "▶ Остановка контейнеров..."
docker stop centos_host debian_host fedora_host
docker rm centos_host debian_host fedora_host