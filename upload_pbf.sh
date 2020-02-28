#!/bin/bash
[ $# -lt 2 ] && echo "Usage: $0 <planet.pbf> [<bounds.json>]" && exit 1
ansible-playbook upload_pbf.yml -i hosts -e "pbf=$2" ${3+-e "bounds=$3"}
