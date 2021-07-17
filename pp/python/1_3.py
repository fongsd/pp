# Zadatak 1.3 Napisati program koji sa standardnog ulaza ucitava 
# jedan string i jedan ceo broj,
# a zatim ispisuje (dinamicki određene) tipove ucitanih promenljivih. 
# Nakon toga, na standardni
# izlaz ispisati poruku Ispisivanje vise stringova koriscenjem 
# separatora =, <-> i novog reda, ???
# redom.

a = input()

try:
    b, s = a.split()
    bp = int(b)
    print(type(bp))
    print(type(s))
    print("ispisivanje vise stringova ")
except:
    pass