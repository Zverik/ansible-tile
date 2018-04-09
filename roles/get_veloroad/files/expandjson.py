#!/usr/bin/python
import sys, os, cgi, json
import psycopg2
import cgitb


def query_geometry(osm_type, osm_id, coord, by_coord=False):
    if (not by_coord or not coord) and osm_id and (osm_type == 'way' or osm_type == 'relation'):
        # query db for an enclosing object for way/rel
        cur.execute('SELECT ST_AsGeoJSON(ST_Transform(way, 4326)) FROM planet_osm_polygon WHERE osm_id = %s', (osm_id if osm_type == 'way' else '-{}'.format(osm_id),))
        result = cur.fetchone()
        return json.loads(result[0]) if result else None
    elif len(coord) >= 2:
        # query by smallest building enclosing coord
        cur.execute('SELECT ST_AsGeoJSON(ST_Transform(way, 4326)), ST_Area(way) as area FROM planet_osm_polygon WHERE ST_Transform(ST_SetSRID(ST_Point(%s, %s), 4326), 900913) && way ORDER BY area', (coord[0], coord[1]))
        result = cur.fetchone()
        return json.loads(result[0]) if result else None


cgitb.enable()

conn = psycopg2.connect('dbname=gis user=osm')
cur = conn.cursor()

form = cgi.FieldStorage()
if 'jsont' in form and len(form.getfirst('jsont')):
    data = json.loads(form.getfirst('jsont'))
elif 'json' in form and form['json'].file:
    data = json.load(form['json'].file)
else:
    sys.exit(1)

by_coord = form.getfirst('bycoord') == '1'

if 'type' in data and data['type'] == 'FeatureCollection':
    for f in data['features']:
        osm_type = None
        osm_id = None
        coord = None
        if 'osm_type' in f['properties'] and 'osm_id' in f['properties']:
            osm_type = f['properties']['osm_type']
            osm_id = f['properties']['osm_id']
        if f['geometry']['type'] == 'Point':
            coord = f['geometry']['coordinates']
        geom = query_geometry(osm_type, osm_id, coord, by_coord)
        if geom:
            f['geometry'] = geom

cur.close()
conn.close()

print 'Content-Type: application/json\n'
print json.dumps(data)
