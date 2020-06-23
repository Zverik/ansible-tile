#!/bin/bash
set -e -u -x

WWW=/var/www/sotm
HERE="$(cd "$(dirname "$0")"; pwd)"
DATA="$HERE/sotm_schedules"
VENV="$HERE/sc_venv"
BASEURL="http://sotm.osmz.ru"

mkdir -p "$DATA"
wget -q -r -O "$DATA/sotm2020.xml" "https://pretalx.com/sotm2020/schedule/export/schedule.xml"
wget -q -r -O "$DATA/sotm2020-at.xml" "https://pretalx.com/state-of-the-map-2020-academic-track/schedule/export/schedule.xml"
# wget -q -r -O "$DATA/sotm2020-add.csv" 'https://docs.google.com/spreadsheets/d/1EO3aC3vF9dvb1wopT_cUHaDXqdGIrid_Kj59PZyzR_g/export?format=csv&id=0'
sed -i -e 's/Academic Track | Track 2 - Sunday, July 5/Track 2/' "$DATA/sotm2020-at.xml"

SC="$VENV/bin/schedule_convert"
$SC $DATA/sotm2020.ini $DATA/sotm2020.xml $DATA/sotm2020-at.xml -l "$WWW" "$BASEURL/2020"
