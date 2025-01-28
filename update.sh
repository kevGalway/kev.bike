#!/data/data/com.termux/files/usr/bin/bash

cd ~/repos/kev.bike
location=$(termux-location | jq '.')
latitude=$(echo "$location" | jq '.latitude')
longitude=$(echo "$location" | jq '.longitude')

FILE="map/index.html"

sed -i "s/];/  { lat: $latitude, lng: $longitude },\n];/" map/index.html

# Commit and push the changes to Git
git add "$FILE"
git commit -m "Added new coordinates to routeCoordinates: lat=$latitude, lng=$longitude"
git push origin main

echo "Coordinates added, changes committed, and pushed successfully."



