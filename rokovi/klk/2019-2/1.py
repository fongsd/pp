#! /usr/bin/python3

import re
import sys

if re.match(r'.*\.xml', sys.argv[1], re.I) is None:
    print("usage: ./1.py vozila.xml")
    exit()
    
try:
    fajl = open(sys.argv[1])
    f = fajl.read()
    fajl.close()
except IOError:
    print("Greska pri otvaranju ili citanju")
    exit()

pattern_vozilo = r"<vozilo id=\"(?P<id>\d+)\">(?P<tekst>.*?)</vozilo>"
ri = re.compile(pattern_vozilo, re.DOTALL)

mapa = {}

for x in ri.finditer(f):
    id = int(x.group("id"))
    tekst = x.group("tekst")

    try:
        fabrika = re.search(r"<fabrika>(?P<a>[A-Za-z ]+)</fabrika>", tekst).group("a")
        model = re.search(r"<model>(?P<a>[A-Za-z0-9 ;,!?.:']+)</model>", tekst).group("a")
        godina = re.search(r"<godina>(?P<a>\d{4})</godina>", tekst).group("a")
        zapremina = re.search(r"<zapremina>(?P<a>([7-9]\d\d|\d{4,})(\.\d)?)</zapremina>", tekst).group("a")
        gorivo = re.search(r"<gorivo>(?P<a>(Benzin|Dizel|TNG)-(EURO3|EURO4|EURO5|EURO6))</gorivo>", tekst).group("a")
        cena = re.search(r"<cena>(?P<a>\d+)</cena>", tekst).group("a")
        snaga_motora = re.search(r"<snaga_motora>(?P<a>\d+)</snaga_motora>", tekst).group("a")
    except AttributeError:
        continue
    mapa[id] = (fabrika, model, godina, float(zapremina), gorivo, int(cena), int(snaga_motora))

def ispisi_vozilo(fabrika, model, godina, zapremina, gorivo, cena, snaga_motora):
    print(godina, fabrika, model, str(zapremina) + 'cm3', str(snaga_motora) + 'kW', gorivo, str(cena) + 'Evra')

if len(sys.argv) == 4 and sys.argv[2] == '-f':
    for k, v in mapa.items():
        if v[0] == sys.argv[3]:
            ispisi_vozilo(v[0], v[1], v[2], v[3], v[4], v[5], v[6])
elif len(sys.argv) == 5 and sys.argv[2] == '-c':
    minx = int(sys.argv[3])
    maxx = int(sys.argv[4]) 
    for k, v in mapa.items():
        if minx <= v[5]  and v[5] <= maxx :
            ispisi_vozilo(v[0], v[1], v[2], v[3], v[4], v[5], v[6])
elif len(sys.argv) == 5 and sys.argv[2] == '-z':
    minx = int(sys.argv[3])
    maxx = int(sys.argv[4]) 
    for k, v in mapa.items():
        if minx <= v[3]  and v[3] <= maxx :
            ispisi_vozilo(v[0], v[1], v[2], v[3], v[4], v[5], v[6])
elif len(sys.argv) == 5 and sys.argv[2] == '-g':
    gorivox = sys.argv[3]
    normax = sys.argv[4] 
    for k, v in mapa.items():
        x = v[4].split('-') 
        gorivo = x[0]
        norma = x[1]
        if gorivox == gorivo  and normax == norma:
            ispisi_vozilo(v[0], v[1], v[2], v[3], v[4], v[5], v[6])
else:
    for k,v in mapa.items():
        ispisi_vozilo(v[0], v[1], v[2], v[3], v[4], v[5], v[6])
