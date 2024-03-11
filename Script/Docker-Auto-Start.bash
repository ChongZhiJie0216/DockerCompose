#!/bin/bash
# Sleep for 30 seconds
sleep 30s
# Define Discord webhook variables
server_name="Ubuntu"
user_name="DockerBOT"
discord_webhook="WEBHOOK_URL"
avatar_url="https://www.docker.com/wp-content/uploads/2022/03/Moby-logo.png"
server_icon_url="https://revdal.me/img/unraid.png"
# Define Docker environment variables
dir_path="/root/Docker-Compose/"

# Create an array of folder names
if [ ! -f "./foldername.txt" ]; then
  find "./" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' > "./foldername.txt"
else
  readarray -t dir < "./foldername.txt"
fi
# Function to send Discord webhook message
send_discord_message() {
  local embed_title="$1"
  local embed_description="$2"
  local embed_color="$3"
  curl -H "Content-Type: application/json" -d '{
    "username": "'"$user_name"'",
    "avatar_url": "'"$avatar_url"'",
    "content": "",
    "embeds": [
      {
        "title": "'"$embed_title"'",
        "color": '"$embed_color"',
        "description": "'"$embed_description"'",
        "timestamp": "",
        "author": {
          "name": "'"$server_name"'",
          "icon_url": "'"$server_icon_url"'"
        },
        "image": {},
        "thumbnail": {},
        "footer": {
          "text": "'"$(date +"%m-%d-%Y %T")"'"
        },
        "fields": []
      }
    ],
    "components": []
  }' "$discord_webhook"
}
# Loop through the directory names
for x in "${dir[@]}"; do
  up_docker_dir="$dir_path/${x}"
  cd "$up_docker_dir"
  # Send Discord message before starting Docker Compose
  send_discord_message "Docker Compose Starting" "Now Starting: '$x'" 16690208
  # Start Docker Compose and sleep for 5 seconds
  docker compose up -d
  sleep 5s
done
# Send Discord message after all Docker Compose processes have started
send_discord_message "All Docker Compose Started" "" 1179392
