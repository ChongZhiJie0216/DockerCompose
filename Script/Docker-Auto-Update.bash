#!/bin/bash
#Discord_WebHook
server_name=
user_name=
discord_webhook=
avatar_url=
server_icon_url=
#Docker_Enviroment
dir_path=
dir=()
#Funtion
curl -H "Content-Type: application/json" -d'{
  "username": "'$user_name'",
  "avatar_url": "'$avatar_url'",
  "content": "",
  "embeds": [
    {
      "title": "Docker Compose Start Update",
      "color": 16711680,
      "description": "",
      "timestamp": "",
      "author": {
        "name": "'$server_name'",
        "icon_url": "'$server_icon_url'"
      },
      "image": {},
      "thumbnail": {},
      "footer": {
        "text": "'"$(date +"%m-%d-%Y %T")"'"
      },
      "fields": []
    }
  ],
  "components": []}' "$discord_webhook"
for x in ${dir[@]}; do
  curl -H "Content-Type: application/json" -d '{
  "username": "'$user_name'",
  "avatar_url": "'$avatar_url'",
  "content": "",
  "embeds": [
    {
      "title": "Docker Compose Updating",
      "color": 16690208,
      "description": "Now Updating: '"$x"'",
      "timestamp": "",
      "author": {
        "name": "'$server_name'",
        "icon_url": "'$server_icon_url'"
      },
      "image": {},
      "thumbnail": {},
      "footer": {
        "text": "'"$(date +"%m-%d-%Y %T")"'"
      },
      "fields": []
    }
  ],
  "components": []}' "$discord_webhook"
  up_docker_dir=$dir_path/${x}
  cd "$up_docker_dir"
  docker compose pull
  docker compose up -d
done
echo "y" | docker image prune 
curl -H "Content-Type: application/json" -d'{
  "username": "'$user_name'",
  "avatar_url": "'$avatar_url'",
  "content": "",
  "embeds": [
    {
      "title": "Docker Compose Update Done",
      "color": 1179392,
      "description": "",
      "timestamp": "",
      "author": {
        "name": "'$server_name'",
        "icon_url": "'$server_icon_url'"
      },
      "image": {},
      "thumbnail": {},
      "footer": {
        "text": "'"$(date +"%m-%d-%Y %T")"'"
      },
      "fields": []
    }
  ],
  "components": []}' "$discord_webhook"