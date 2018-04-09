#!/bin/bash
[ $# -lt 3 ] && echo "Usage: $0 <inventory> <planet.pbf> <state_idx>" && exit 1
ansible-playbook upload_pbf.yml -i "$1" -e "pbf_file=$2" -e "pbf_state=$3"
