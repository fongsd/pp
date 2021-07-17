#! usr/bin/python

import sys

import re

if len(sys.argv) < 2 or len(sys.argv) > 5:
	print("koriscenje:bla bla")
	exit()

if re.match(".*\.xml", sys.argv[1], re.I) == None:
	print ("datoteka mora biti xml")	

f = open(sys.argv[1],"r")

fajl = f.read()

pattern = r"<televizor id=\"(\d+)\">"
pattern += r"(.(?!</televizor>))*.</televizor>"

idjevi = []
godina = {}
diag = {}
panel = {}
rmarka = {}
model = {}
cena = {}
kolicina = {}

for x in re.finditer(pattern, fajl, re.DOTALL):
	id = x.group(1)
	idjevi.append(id)
	pattern_godina = r"<godina>\s*(\d\d\d\d)\s*</godina>"
	godina[id] = re.search(pattern_godina, x.group()).group(1)
	pattern_diag = r"<diag>\s*(\d\d+(\.[0-9])?)\s*</diag>"
	diag[id] = re.search(pattern_diag, x.group()).group(1)
	pattern_rmarka = r"<rmarka>\s*((\w|\d|\s)+)\s*</rmarka>"
	rmarka[id] = re.search(pattern_rmarka, x.group()).group(1)
	pattern_model = r"<model>\s*(.+)\s*</model>"
	model[id] = re.search(pattern_model, x.group()).group(1)
	pattern_cena = r"<cena>\s*(\d+)\s*</cena>"
	cena[id] = re.search(pattern_cena, x.group()).group(1)
	pattern_kolicina = r"<kolicina>\s*(\d+)\s*</kolicina>"
	kolicina[id] = re.search(pattern_kolicina, x.group()).group(1)	
	pattern_panel = r"<panel>\s*((IPS|TN|VA|LED)-(UHD|HD|FHD))\s*</panel>"
	panel[id] = re.search(pattern_panel, x.group()).group(1)

if len(sys.argv) == 2:
	for id in idjevi:
		print(godina[id] + " " + rmarka[id] + " " + model[id] + " " + diag[id] + "in " + panel[id] + " " + cena[id] + "din: " + kolicina[id] + " komada na stanju")
		f.close()
		exit()

if sys.argv[2] == "-r":
	for	id in idjevi:
		if rmarka[id] == sys.argv[3]:
			print(godina[id] + " " + rmarka[id] + " " + model[id] + " " + diag[id] + "in " + panel[id] + " " + cena[id] + "din: " + kolicina[id] + " komada na stanju")
	
if sys.argv[2] == "-c":
	for	id in idjevi:
		if int(cena[id]) >= int(sys.argv[3]) and int(cena[id]) <= int(sys.argv[4]):
			print(godina[id] + " " + rmarka[id] + " " + model[id] + " " + diag[id] + "in " + panel[id] + " " + cena[id] + "din: " + kolicina[id] + " komada na stanju")

if sys.argv[2] == "-d":
	for	id in idjevi:
		if int(diag[id]) >= int(sys.argv[3]) and int(diag[id]) <= int(sys.argv[4]):
			print(godina[id] + " " + rmarka[id] + " " + model[id] + " " + diag[id] + "in " + panel[id] + " " + cena[id] + "din: " + kolicina[id] + " komada na stanju")

if sys.argv[2] == "-g":
	for	id in idjevi:
		if int(godina[id]) == int(sys.argv[3]):
			print(godina[id] + " " + rmarka[id] + " " + model[id] + " " + diag[id] + "in " + panel[id] + " " + cena[id] + "din: " + kolicina[id] + " komada na stanju")

f.close()
