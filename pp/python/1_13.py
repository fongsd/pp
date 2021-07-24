# adatak 1.13Napisati program kojim se ilustruje upotreba struktura podataka: steka, skupa,mape i torke.

stek = []

stek.append(1)
stek.pop()
print(len(stek))

mapa = {'milan' : 2}

mapa[1] = 'a' 

print(mapa.keys(), mapa.values())

skup = set()

skup.add(2)
skup.add(1)
skup.add(1)
skup.add(1)
print(skup)