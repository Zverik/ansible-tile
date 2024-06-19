#!/bin/bash
set -e -u -x

WWW=/var/www/sotm
HERE="$(cd "$(dirname "$0")"; pwd)"
DATA="$HERE/sotm_schedules"
VENV="$HERE/sc_venv"
BASEURL="https://sotm.osmz.ru"

mkdir -p "$DATA"
# wget -q -r -O "$DATA/f2022.xml" "https://talks.osgeo.org/foss4g-2022/schedule/export/schedule.xml"
# wget -q -r -O "$DATA/f2022-at.xml" "https://talks.osgeo.org/foss4g-2022-academic-track/schedule/export/schedule.xml"
# wget -q -r -O "$DATA/sotm2020-add.csv" 'https://docs.google.com/spreadsheets/d/1EO3aC3vF9dvb1wopT_cUHaDXqdGIrid_Kj59PZyzR_g/export?format=csv&id=0'
# sed -i -e 's/Academic Track | Track 2 - Sunday, July 5/Track 2/' "$DATA/sotm2020-at.xml"
wget -q -r -O "$DATA/tartu2024.xml" "https://talks.osgeo.org/foss4g-europe-2024/schedule/export/schedule.xml"
wget -q -r -O "$DATA/tartu2024w.xml" "https://talks.osgeo.org/foss4g-europe-2024-workshops/schedule/export/schedule.xml"
wget -q -r -O "$DATA/tartu2024a.csv" 'https://docs.google.com/spreadsheets/d/1Jp88ifOSrYb2T93YTQt9YV0bk7MEZWO6eMtOvKKwdQ4/gviz/tq?tqx=out:csv'

SC="$VENV/bin/schedule_convert"
$SC $DATA/tartu2024.ini $DATA/tartu2024.xml $DATA/tartu2024w.xml $DATA/tartu2024a.csv -l "$WWW" "$BASEURL/tartu2024"
