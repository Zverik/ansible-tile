PYTHON = 'python3.5'
NIK4 = '/opt/src/Nik4/nik4.py'

STYLES = [
    ['veloroad', 'Veloroad Ru', '/opt/styles/veloroad/veloroad-r.xml', True],
    ['veloroaden', 'Veloroad', '/opt/styles/veloroad/veloroad-en.xml', True],
    ['osm', 'OSM-Carto', '/opt/styles/osm-carto/osm-r.xml', False],
]
TILES = {
    'veloroad': ['http://tile.osmz.ru/veloroad/{z}/{x}/{y}.png',
                 'Map &copy; OpenStreetMap | Tiles &copy Ilya Zverev'],
    'veloroaden': ['http://tile.osmz.ru/veloroad/{z}/{x}/{y}.png',
                   'Map &copy; OpenStreetMap | Tiles &copy Ilya Zverev'],
    'osm': ['https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            'Map &copy; OpenStreetMap'],
}
