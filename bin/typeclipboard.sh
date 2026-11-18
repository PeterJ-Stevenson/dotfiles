#!/bin/bash
sleep 0.5
prevkeymap=$(setxkbmap -query | grep layout | awk '{print $2}')
setxkbmap us
xdotool type "$(xsel)"
setxkbmap "$prevkeymap"
