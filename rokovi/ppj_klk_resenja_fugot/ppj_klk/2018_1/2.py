import sys

# (0|1)*(00|11)

stanje = 'A'
zavrsno_stanje = ['D', 'E']

prelaz = {('A', '0') : 'B', ('A', '1') : 'C',
	  ('B', '0') : 'D', ('B', '1') : 'C',
	  ('C', '0') : 'B', ('C', '1') : 'E',
	  ('D', '0') : 'D', ('D', '1') : 'C',
	  ('E', '0') : 'B', ('E', '1') : 'E'}

while True:
	try:
		c = input()
		if c != '0' and c != '1':
			sys.exit("Azbuka")
		stanje = prelaz[(stanje, c)]
	except EOFError:
		break

if stanje in zavrsno_stanje:
	print("Rec pripada jeziku")
else:
	print("Rec ne pripada jeziku")
