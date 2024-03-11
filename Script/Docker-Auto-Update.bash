#!/bin/bash
# Define Discord webhook variables
server_name="Ubuntu"
user_name="DockerBOT"
discord_webhook="WEBHOOK_URL"
avatar_url="https://www.docker.com/wp-content/uploads/2022/03/Moby-logo.png"
server_icon_url="https://revdal.me/img/unraid.png"
# Define Docker environment variables
dir_path="/root/Docker-Compose/"
# Function to send a Discord message
send_discord_message() {
    local title="$1"
    local description="$2"
    local color="$3"

    curl -H "Content-Type: application/json" -d '{
        "username": "'"$user_name"'",
        "avatar_url": "'"$avatar_url"'",
        "content": "",
        "embeds": [
            {
                "title": "'"$title"'",
                "color": '"$color"',
                "description": "'"$description"'",
                "author": {
                    "name": "'"$server_name"'",
                    "icon_url": "'"$server_icon_url"'"
                },
                "footer": {
                    "text": "'"$(date +"%m-%d-%Y %T")"'"
                }
            }
        ],
        "components": []
    }' "$discord_webhook"
}
# Check if foldername.txt exists, and create it if not
if [ ! -f "./foldername.txt" ]; then
    find "./" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' > "./foldername.txt"
else
    readarray -t dir < <(tac "./foldername.txt")
fi
# Send initial Discord message
send_discord_message "Docker Compose Start Update" "" 16711680
# Loop through directories and update Docker Compose
for x in "${dir[@]}"; do
    send_discord_message "Docker Compose Updating" "Now Updating: '$x'" 16690208
    up_docker_dir="$dir_path/${x}"
    cd "$up_docker_dir"
    docker compose pull
    docker compose up -d
    sleep 5s
done
# Prune Docker images
echo "y" | docker image prune
# Send final Discord message
send_discord_message "Docker Compose Update Done" "" 1179392