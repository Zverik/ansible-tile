#!/bin/bash
[ $# -lt 1 ] && echo "Usage: $0 <planet.pbf> [<bounds.json>]" && exit 1
#ansible-playbook upload_pbf.yml -i hosts -e "pbf=$1" ${2+-e "bounds=$2"}
ansible-playbook upload_pbf.yml -i hosts -e "pbf=$1" ${2+-e "bounds=$2"} --skip-tags osm2pgsql
