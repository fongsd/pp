#! /usr/bin/python3

import sys
import re

if len(sys.argv) < 2 or len(sys.argv) > 4:
    print("./1.py filepath [-a | -v NAZIV | -w NAZIV | -r NAZIV | -o NAZIV]")
    exit()
    
if re.match('.*\.xml', sys.argv[1], re.I) == None:
    print("Pogresna ekstenzija ulaznog fajla.")
    exit()
    
try:
    f = open(sys.argv[1], "r")
    fajl = f.read()
    f.close()
except IOError:
    exit("Greska pri otvaranju fajla")

patern = r"<paket id=\"(\d+)\">(.*?)</paket>"
#patern += r"(.(?!</paket>))*.</paket>"

# bolje je .*? 

mapa = {}

for x in re.finditer(patern, fajl, re.DOTALL):
    id = int(x.group(1))
    
    pattern_naziv = r"<naziv>\s*([A-Za-z]+)\s*</naziv>"
    naziv_obj = re.search(pattern_naziv, x.group(0))
    
    pattern_verzija = r"<verzija>\s*((0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*))\s*</verzija>"  
    verzija_obj = re.search(pattern_verzija, x.group(0))
    
    pattern_opis = r"<opis>\s*(.*?)\s*</opis>"
    opis_obj = re.search(pattern_opis, x.group(0))
        
    pattern_repo = r"<repo>\s*(github|gitlab|bitbucket)\s*</repo>"
    repo_obj = re.search(pattern_repo, x.group(0))
    
    pattern_webstrana = r"<veb>\s*((www)?(\w+\.)+(org|com))\s*</veb>"
    webstrana_obj = re.search(pattern_webstrana, x.group(0))
    
    if naziv_obj is not None and verzija_obj is not None and opis_obj is not None and repo_obj is not None and webstrana_obj is not None:
        mapa[id] = (naziv_obj.group(1), verzija_obj.group(1), opis_obj.group(1), repo_obj.group(1), webstrana_obj.group(1))
        
if sys.argv[2] == '-a':
   
   paketi = [mapa[x] for x in mapa]
   paketi.sort(key = lambda x: x[0]) # x[0] je naziv
    
   for p in paketi:
       print('[' + p[0] + ']', 'v' + p[1], p[3], '\n', p[4], '\n', p[2], '\n')

elif len(sys.argv) > 2 and sys.argv[2] == '-v':
    for id in mapa.keys():
        if mapa[id][0] == sys.argv[3]:
            print('Verzija: ' + mapa[id][1])
elif len(sys.argv) > 2 and sys.argv[2] == '-w':
    for id in mapa.keys():
        if mapa[id][0] == sys.argv[3]:
            print('Veb: ' + mapa[id][4])
elif len(sys.argv) > 2 and sys.argv[2] == '-r':
    for id in mapa.keys():
        if mapa[id][0] == sys.argv[3]:
            print('Repo: ' + mapa[id][3])
elif len(sys.argv) > 2 and sys.argv[2] == '-o':
    for id in mapa.keys():
        if mapa[id][0] == sys.argv[3]:
            print('Veb: ' + mapa[id][2])
            break
else:
    print("Neispravni argumenti")
