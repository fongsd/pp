import sys
import re

if len(sys.argv) < 3:
	sys.exit("Argumenti")

if re.match(r"^.+\.csv$", sys.argv[1]) is None:
	sys.exit("Ekstenzija")

try:
	f = open(sys.argv[1], "r")
except IOError:
	sys.exit("open")

igrac_re = re.compile(r"\s*(?P<ime>([A-Z][a-z]+)((\s+[A-Z][a-z]+){0,2}|\s+([A-Z][a-z]+|[a-z]+)\s+([A-Z][a-z]+))),"
		    + r"\s*(?P<drzava>[A-Z][a-z]+),"
		    + r"\s*(?P<golovi>[1-9]\d*),"
		    + r"\s*(?P<utakmice>[1-9]\d*),"
		    + r"\s*(?P<pocetak>\d\d\d\d)-(?P<kraj>\d\d\d\d)?,"
		    + r"\s*(?P<klubovi>[A-Z][A-Za-z0-9 ]+(,\s*[A-Za-z0-9 ]+)*)")

igraci = {}

brojac = 0
for linija in f:
	m = igrac_re.match(linija)
	if m is not None:
		ime = m.group("ime")
		golovi = int(m.group("golovi"))
		utakmice = int(m.group("utakmice"))
		pocetak = int(m.group("pocetak"))
		if m.group("kraj") is None:
			kraj = 2018
		else:
			kraj = int(m.group("kraj"))
		klubovi = str.split(m.group("klubovi"), ",")
		klubovi = list(map(str.strip, klubovi))
		igraci[brojac] = (ime, golovi, utakmice, pocetak, kraj, klubovi)
		brojac += 1
f.close()

if sys.argv[2] == '-g':
	sortirano = reversed(sorted(igraci.items(), key = lambda x : x[1][1] / x[1][2]))
	for i in sortirano:
		print("%s %.2f" % (i[1][0], i[1][1] / i[1][2]))
elif sys.argv[2] == '-t' and len(sys.argv) > 3:
	for k, v in igraci.items():
		if sys.argv[3] in v[5]:
			print("%s %d %d" % (v[0], v[3], v[4] - v[3]))
else:
	sys.exit("Opcije")
