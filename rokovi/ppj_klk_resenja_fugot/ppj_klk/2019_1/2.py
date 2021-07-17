import sys

# (ab|c)*b

stanje = 'A'
zavrsno_stanje = 'C'

prelaz = {('A', 'a') : 'B', ('A', 'b') : 'C', ('A', 'c') : 'DE',
	  ('B', 'b') : 'DE',
	  ('DE', 'a') : 'B', ('DE', 'b') : 'C', ('DE', 'c') : 'DE'}

while True:
	try:
		c = input()
		if c != 'a' and c != 'b' and c != 'c':
			sys.exit("Azbuka")
		stanje = prelaz.get((stanje, c))
		if stanje is None:
			print("Rec nije u jeziku")
			sys.exit()
	except EOFError:
		break

if stanje == zavrsno_stanje:
	print("Rec je u jeziku")
else:
	print("Rec nije u jeziku")
