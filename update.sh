#!/data/data/com.termux/files/usr/bin/bash

cd ~/repos/kev.bike
location=$(termux-location 2>/dev/null | jq '.')

latitude=$(echo "$location" | jq '.latitude')
longitude=$(echo "$location" | jq '.longitude')

# Check if latitude and longitude are numbers
if ! [[ "$latitude" =~ ^-?[0-9.]+$ ]] || ! [[ "$longitude" =~ ^-?[0-9.]+$ ]]; then
  echo "Error: Invalid GPS coordinates. Skipping update."
  sleep 5
  exit 1
fi

FILE="map/index.html"

sed -i "s/];/  { lat: $latitude, lng: $longitude },\n];/" "$FILE"

# Commit and push the changes to Git
git add "$FILE"
git commit -m "Added new coordinates to routeCoordinates: lat=$latitude, lng=$longitude"
git push origin main

echo "Coordinates added, changes committed, and pushed successfully."
