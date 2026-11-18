#!/bin/bash
# Pick a random wallpaper from the user's backgrounds and apply it to slick-greeter
BGDIR="/home/pjs/pics/backgrounds"
CONF="/etc/lightdm/slick-greeter.conf"

bg=$(find "$BGDIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n1)

[ -z "$bg" ] && exit 0

cat > "$CONF" <<EOF
[Greeter]
background=$bg
EOF
