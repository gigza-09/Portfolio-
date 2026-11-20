#!/usr/bin/env bash
# Downloads every image the site uses from Framer's CDN into ./assets
# Run once from the project folder:  bash download-assets.sh
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p assets
total=$(grep -c . assets-manifest.txt)
i=0
while read -r url; do
  [ -z "$url" ] && continue
  i=$((i + 1))
  name="${url##*/}"
  if [ -f "assets/$name" ]; then echo "[$i/$total] skip $name"; continue; fi
  echo "[$i/$total] $name"
  curl -fsSL "$url" -o "assets/$name"
done < assets-manifest.txt
echo "Done. $total images in ./assets"
