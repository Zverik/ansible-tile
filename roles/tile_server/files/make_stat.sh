#!/bin/sh
df -h /
echo
du --max-depth 1 -h /var/lib/mod_tile | grep 'lonely\|dhr\|smoot\|sur\|osm\|old'
du --max-depth 1 -h /var/lib/mod_tile/veloroad/ | sort -k 2
echo
top -n 1 -b |head -n 15
