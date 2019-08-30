#!/bin/bash
set -e -u -x

WWW=/var/www/sotm
HERE="$(cd "$(dirname "$0")"; pwd)"
DATA="$HERE/sotm_schedules"
VENV="$HERE/sc_venv"
BASEURL="http://sotm.osmz.ru"

mkdir -p "$DATA"
wget -q -r -O "$DATA/sotmus2019.json" "https://sessionize.com/api/v2/sedalw8w/view/all"
wget -q -r -O "$DATA/sotm2019.xml" "https://pretalx.com/sotm2019/schedule/export/schedule.xml"
wget -q -r -O "$DATA/sotm2019-at.xml" "https://pretalx.com/sotm2019-at/schedule/export/schedule.xml"
wget -q -r -O "$DATA/sotm2019-add.csv" 'https://docs.google.com/spreadsheets/d/1EO3aC3vF9dvb1wopT_cUHaDXqdGIrid_Kj59PZyzR_g/export?format=csv&id=0'
wget -q -r -O "$DATA/hot2019.xml" "https://summit2019.hotosm.org/schedule.xml"
sed -i -e 's#<track></track>#<track>Academic</track>#' "$DATA/sotm2019-at.xml"

SC="$VENV/bin/schedule_convert"
$SC $DATA/sotmus2019.ini $DATA/sotmus2019.json -l "$WWW" "$BASEURL/us19"
$SC $DATA/hot2019.xml -l "$WWW" "$BASEURL/hot19"
$SC $DATA/sotm2019.xml $DATA/sotm2019-at.xml $DATA/sotm2019-add.csv -l "$WWW" "$BASEURL/19"
