#!/bin/sh
# Home docked layout — update output names with: xrandr --query
# Example from old machine (3x DP-2-* on docking station):
# xrandr --output DP-2-1 --mode 2560x1440 --pos 5120x0 --rotate normal \
#        --output DP-2-2 --mode 2560x1440 --pos 2560x0 --rotate normal \
#        --output DP-2-3 --mode 2560x1440 --pos 0x0    --rotate normal \
#        --output eDP-1  --off

echo "Update this script with your actual monitor outputs (run: xrandr --query)"
