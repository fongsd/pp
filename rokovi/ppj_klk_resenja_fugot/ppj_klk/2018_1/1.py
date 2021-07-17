import sys
import re

if len(sys.argv) < 2:
	sys.exit("Fale argumenti!")

try:
	f = open("paketi.xml", "r")
	data = f.read()
except IOError:
	sys.exit("open")
f.close()

paketi_re = re.compile(r'<paket\s+id\s*=\s*"(?P<id>[1-9]\d*)+">'
		    + r'.*?</paket>', re.S)

paket_re = re.compile(r'(?=.*?<naziv>\s*(?P<naziv>[A-Za-z]+)\s*</naziv>)'
		    + r'(?=.*?<verzija>\s*(?P<verzija>(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*))\s*</verzija>)'
		    + r'(?=.*?<opis>\s*(?P<opis>.*?)\s*</opis>)'
		    + r'(?=.*?<repo>\s*(?P<repo>github|gitlab|bitbucket)\s*</repo>)'
		    + r'(?=.*?<veb>\s*(?P<veb>(\w+\.)+(org|com))\s*</veb>)', re.S)

paketi = {}

for m in paketi_re.finditer(data):
	paket = m.group()
	p = paket_re.match(paket)
	if p is not None:
		paketi[m.group("id")] = (p.group("naziv"), p.group("verzija"), p.group("opis"), p.group("repo"), p.group("veb"))

if sys.argv[1] == '-a':
	sortirani = sorted(paketi.items(), key = lambda x : x[1][0])
	for i in sortirani:
		print(i)
elif sys.argv[1] == '-v' and len(sys.argv) > 2:
	for k, v in paketi.items():
		if v[0] == sys.argv[2]:
			print(v[1])
elif sys.argv[1] == '-w' and len(sys.argv) > 2:
	for k, v in paketi.items():
		if v[0] == sys.argv[2]:
			print(v[4])
elif sys.argv[1] == '-r' and len(sys.argv) > 2:
	for k, v in paketi.items():
		if v[0] == sys.argv[2]:
			print(v[3])
elif sys.argv[1] == '-o' and len(sys.argv) > 2:
	for k, v in paketi.items():
		if v[0] == sys.argv[2]:
			print(v[2])
else:
	sys.exit("Problem sa komandom! (nepoznata/fale argumenti)")
