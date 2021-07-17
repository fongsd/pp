import sys
import re

try:
	f = open("televizori.xml", "r")
	data = f.read()
except IOError:
	sys.exit("open")
f.close()

televizori_re = re.compile(r'\s*<televizor\s+id\s*=\s*"(?P<id>[1-9]\d*)">'
			 + r'.*?</televizor>', re.S)

televizor_re = re.compile(r'(?=.*?<rmarka>(?P<marka>[A-Za-z0-9 ]+)</rmarka>)'
			+ r'(?=.*?<model>(?P<model>.+)</model>)'
			+ r'(?=.*?<godina>(?P<godina>\d{4})</godina>)'
			+ r'(?=.*?<diag>(?P<diag>[1-9]\d+(\.\d)?)</diag>)'
			+ r'(?=.*?<panel>(?P<panel>(TN|IPS|VA|LED)-(HD|FHD|UHD))</panel>)'
			+ r'(?=.*?<cena>(?P<cena>0|[1-9]\d*)</cena>)'
			+ r'(?=.*?<kolicina>(?P<kolicina>0|[1-9]\d*)</kolicina>)', re.S)

televizori = {}

for m in televizori_re.finditer(data):
	if m is not None:
		s = televizor_re.match(m.group())
		if s is not None:
			marka = s.group("marka")
			model = s.group("model")
			godina = int(s.group("godina"))
			diag = float(s.group("diag"))
			panel = s.group("panel")
			cena = int(s.group("cena"))
			kolicina = int(s.group("kolicina"))
			televizori[m.group("id")] = (marka, model, godina, diag, panel, cena, kolicina)

def ispis_tv(tv):
	print(str(v[2]) + " " + v[0] + " " + v[1] + " " + str(v[3]) + "in " + v[4] + " " + str(v[5]) + "din: " + str(v[6]) + " komada na stanju")

if len(sys.argv) < 2:
	for k, v in televizori.items():
		ispis_tv(v)
elif len(sys.argv) > 2 and sys.argv[1] == '-r':
	for k, v in televizori.items():
		if v[0] == sys.argv[2]:
			ispis_tv(v)
elif len(sys.argv) > 3 and sys.argv[1] == '-c':
	for k, v in televizori.items():
		if v[5] >= int(sys.argv[2]) and v[5] <= int(sys.argv[3]):
			ispis_tv(v)
elif len(sys.argv) > 3 and sys.argv[1] == '-d':
	for k, v in televizori.items():
		if v[3] >= int(sys.argv[2]) and v[3] <= int(sys.argv[3]):
			ispis_tv(v)
elif len(sys.argv) > 2 and sys.argv[1] == '-g':
	for k, v in televizori.items():
		if v[2] == int(sys.argv[2]):
			ispis_tv(v)
else:
	sys.exit("Argumenti")
