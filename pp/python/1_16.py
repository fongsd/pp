# Zadatak 1.16Korisnik sa standardnog ulaza unosi ceo brojn, a potom ciklično pomerenrastuće sortiran niz (pr.56781234) koji imanelemenata. Napisati program koji na standarni izlazispisuje sortiran niz bez ponavljanja elementa
try:
    n = int(input())
except:
    print("failed")
    exit(-1)

niz = []

for i in range(n):
    niz.append(int(input()))


import heapq

heapq.heapify(niz)



print(set(niz))