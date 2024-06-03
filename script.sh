#!/bin/bash

DOCKER_CONFIG_FILE="/etc/docker/daemon.json"
BACKUP_FILE="/etc/docker/daemon.json.backup"

if [ ! -f "$DOCKER_CONFIG_FILE" ]; then
    echo '{}' | tee "$DOCKER_CONFIG_FILE"
fi

cp "$DOCKER_CONFIG_FILE" "$BACKUP_FILE"

TEMP_FILE=$(mktemp)

jq '. + {"registry-mirrors": [
    "https://dockerhub.timeweb.cloud", 
    "https://dockerhub1.beget.com", 
    "https://noohub.ru", 
    "https://jockerhub.com"
]}' "$DOCKER_CONFIG_FILE" > "$TEMP_FILE"

mv "$TEMP_FILE" "$DOCKER_CONFIG_FILE"

chmod 644 "$DOCKER_CONFIG_FILE"

systemctl restart docker

echo "Docker configuration updated and Docker restarted."