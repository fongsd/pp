#!/usr/bin/python3

import sys
import os
import re

try:
    f = open("televizori.xml", "r")
    content = f.read()
    f.close()
except IOError:
    sys.exit("Failed reading televizori.xml")

TELEVIZORI_REGEX = r'\s*<televizor\s+id\s*=\s*"(?P<id>[1-9]\d*)">' + r'.*?</televizor>'
televizori_pattern = re.compile(TELEVIZORI_REGEX, re.S)

televizori = {}

for m in televizori_pattern.finditer(content):
    if m is not None:
        #treba izdvojiti sa re.search() marku,dig, ...
        id = m.group("id")
        
        MARKA_REGEX = r'<rmarka>\s*(?P<marka>[A-Za-z0-9 ]+)\s*</rmarka>'
        marka = re.search(MARKA_REGEX, m.group()).group("marka")
        
        OZNAKA_MODELA_REGEX = r'<model>\s*(?P<model>.+)\s*</model>'
        model = re.search(OZNAKA_MODELA_REGEX, m.group()).group("model")

        GODINA_MODELA_REGEX = r'<godina>\s*(?P<godina>\d{4})\s*</godina>'
        godina = int(re.search(GODINA_MODELA_REGEX, m.group()).group("godina"))

        DIAG_REGEX = r'<diag>\s*(?P<diag>[1-9]\d+(\.[0-9])?)\s*</diag>'
        diag = re.search(DIAG_REGEX, m.group()).group("diag")
 
        PANEL_REGEX = r'<panel>\s*(?P<panel>(TN|IPS|VA|LED)-(HD|FHD|UHD))\s*</panel>'
        panel = re.search(PANEL_REGEX, m.group()).group("panel")

        CENA_REGEX = r'<cena>\s*(?P<cena>0|[1-9]\d*)\s*</cena>'
        cena = int(re.search(CENA_REGEX, m.group()).group("cena"))

        KOLICINA_REGEX = r'<kolicina>\s*(?P<kolicina>0|[1-9]\d*)\s*</kolicina>'
        kolicina = int(re.search(KOLICINA_REGEX, m.group()).group("kolicina"))

        televizori[id] = (marka, model, godina, diag, panel, cena, kolicina)

def ispis_tv(v):
    if v[6] > 0:
        print(str(v[2]) + " " + v[0] + " " + v[1] + " " + str(v[3]) + "in " + v[4] + " " + str(v[5]) + "din: " + str(v[6]) + " komada na stanju")
    else:
        print(str(v[2]) + " " + v[0] + " " + v[1] + " " + str(v[3]) + "in " + v[4] + " " + str(v[5]) + "din: " + "Nema na stanju")

if len(sys.argv) < 2:
    for televizor in televizori.values():
        ispis_tv(televizor)
elif len(sys.argv) > 2 and sys.argv[1] == '-r':
    for id, televizor in televizori.items():
        if televizor[0] == sys.argv[2]:
            ispis_tv(televizor)
elif len(sys.argv) > 3 and sys.argv[1] == '-c':
    for id, televizor in televizori.items():
        min_cena = int(sys.argv[2])
        max_cena = int(sys.argv[3])
        cena = televizor[5]
        if cena >= min_cena and cena <= max_cena:
            ispis_tv(televizor)
elif len(sys.argv) > 3 and sys.argv[1] == '-d':
    for id, televizor in televizori.items():
        min_diag = float(sys.argv[2])
        max_diag = float(sys.argv[3])
        diag = float(televizor[3])
        if diag >= min_diag and diag <= max_diag:
            ispis_tv(televizor)
elif len(sys.argv) > 2 and sys.argv[1] == '-g':
    for id, televizor in televizori.items():
        if televizor[2] == int(sys.argv[2]):
            ispis_tv(televizor)
else:
    sys.exit("Argumenti")
