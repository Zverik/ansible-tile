#!/bin/bash
set -e -u -x

WWW=/var/www/sotm
HERE="$(cd "$(dirname "$0")"; pwd)"
DATA="$HERE/sotm_schedules"
VENV="$HERE/sc_venv"

mkdir -p "$DATA"
wget -q -r -O "$DATA/sotmus2019.json" "https://sessionize.com/api/v2/sedalw8w/view/all"
wget -q -r -O "$DATA/sotm2019.xml" "https://pretalx.com/sotm2019/schedule/export/schedule.xml"
wget -q -r -O "$DATA/sotm2019-at.xml" "https://pretalx.com/sotm2019-at/schedule/export/schedule.xml"
wget -q -r -O "$DATA/sotm2019-add.json" "https://wiki.openstreetmap.org/w/api.php?format=json&action=parse&prop=wikitext&page=State_of_the_Map_2019/Additional_Sessions"
wget -q -r -O "$DATA/hot2019.xml" "https://summit2019.hotosm.org/schedule.xml"
sed -i -e 's#<track></track>#<track>Academic</track>#' "$DATA/sotm2019-at.xml"

cd "$HERE/schedule-convert"
if [ -x "$VENV/bin/python3" ]; then
  PYTHON="$VENV/bin/python3"
else
  PYTHON=python3
fi

$PYTHON -m schedule_convert $DATA/sotmus2019.ini $DATA/sotmus2019.json -o $WWW/us19.xml
$PYTHON -m schedule_convert $DATA/sotmus2019.ini $DATA/sotmus2019.json -f ical -o $WWW/us19.ics
$PYTHON -m schedule_convert $DATA/hot2019.xml -o $WWW/hot19.xml
$PYTHON -m schedule_convert $DATA/hot2019.xml -f ical -o $WWW/hot19.ics
$PYTHON -m schedule_convert $DATA/sotm2019.xml $DATA/sotm2019-at.xml -o $WWW/19.xml
$PYTHON -m schedule_convert $DATA/sotm2019.xml $DATA/sotm2019-at.xml -f ical -o $WWW/19.ics
# $PYTHON -m schedule_convert $DATA/sotm2019.xml $DATA/sotm2019-at.xml $DATA/sotm2019-add.json -o $WWW/19.xml
