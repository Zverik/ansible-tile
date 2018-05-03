#!/bin/bash
[ $# -lt 2 ] && echo "Usage: $0 <inventory> <planet.pbf> [<bounds.json>]" && exit 1
ansible-playbook upload_pbf.yml -i "$1" -e "pbf=$2" ${3+-e "bounds=$3"}
