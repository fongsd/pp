# Zadatak 1.11 Definisati funkciju printf, koja na standardni izlaz stampa svoje argumente (ne
# praviti nikakve pretpostavke o broju argumenata). Modifikovati definisanu funkciju tako da kao
# argumente prima proiyvoljan imenovanih argumenata.
# Definisati funkciju koja racuna aritmeticku sredinu svojih argumenata (pretpostaviti da je nad
# argumentima definisane operacije deljenja i sabiranja, kao i da će broj samih argumenata biti veći
# od jedan.

def printfp(*x):
    print(x)

def printf(*args):
    for i in args:
        print(i)


l = [1,2,3]
a = "asdas"
printfp(l, a, 1)

def ar(*x):
    suma = 0
    for i in x:
        suma += i

    return suma/len(x)

print(ar(1, 2 ,3))