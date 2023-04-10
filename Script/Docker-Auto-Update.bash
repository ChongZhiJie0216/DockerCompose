#!/bin/bash
#Discord_WebHook
server_name=Unraid_Server
user_name=Jiecloud_Unraid
discord_webhook=
#Docker_Enviroment
dir_path=/mnt/user/appdata
dir=(Alist AllTube-Download-yt-dlp Discord-AutoDelete DiscordGSM DiscordRSS FastAPI-DLS FileBrowser FileBrowser-NovelAI 
    Freenom Glances-Monitor Hexo Homarr IMMICH MariaDB Nextcloud NginxProxyManager OnlyOffice-DocumentServer OpenSpeedTest 
    Portainer-CE Redis RSSHUB RustDesk Sudhanplayz-Discord-Musicbot-v5 UptimeKuma )
#Funtion
curl -H "Content-Type: application/json" -d '{"username": "'$user_name'", "content": "''🖥️'"$server_name"' ''🕒:'"$(date +"%m-%d-%Y %T")"' 🔴Docker Compose Update Start⚠️  "}' "$discord_webhook"
for x in ${dir[@]}; do
  curl -H "Content-Type: application/json" -d '{"username": "'$user_name'", "content": "''🖥️'"$server_name"' ''🕒:'"$(date +"%m-%d-%Y %T")"' 🟠Now Updating : '"$x"' "}' "$discord_webhook"
  up_docker_dir=$dir_path/${x}
  cd "$up_docker_dir"
  docker compose pull
  docker compose up -d
done
echo "y" | docker image prune 
curl -H "Content-Type: application/json" -d '{"username": "'$user_name'", "content": "''🖥️'"$server_name"' ''🕒:'"$(date +"%m-%d-%Y %T")"' 🟢All Docker Compose Update Done✅  "}' "$discord_webhook"
