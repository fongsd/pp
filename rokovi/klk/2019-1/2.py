#! /usr/bin/python3

prelazi = {}

prelazi[(0, 'a')] = 1
prelazi[(0, 'b')] = 2
prelazi[(0, 'c')] = 0
prelazi[(1, 'b')] = 0

rec = input()
stanje = 0
zavrsna_stanja = set()
zavrsna_stanja.add(2)

for slovo in rec:
    if (stanje, slovo) not in prelazi:
        print("Rec nije prihvacena")
        exit()
    stanje = prelazi[(stanje, slovo)]

if stanje in zavrsna_stanja:
    print("Rec je prihvacena")
else:
    print("Rec nije prihvacena")
