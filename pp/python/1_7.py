# Zadatak 1.7 Napisati program koji ilustruje osnovne sistemske funkcije i module programskog
# jezika Python tako škoristi funkcije faktorijel, logaritam (math), generise pseudoslucajne brojeve
# (modul random), ispisuje argumente komandne linije na izlaz (modul sys), poziva sistemski poziv
# listanja tekuceg direktorijuma (modul os), ispisuje broj sekundi od 1.1.1970. godine , finalno unosi
# string sa ulaza za koji proverava (korišćenjem regularnih izraza) da li predstavlja zapis celog broja.

import random, math, os, sys

n = int(input())
print(math.factorial(n))
print(math.log(n))
print(random.random())
print(sys.argv)
print(os.listdir())

import time

print(time.time())

import re
try:
    if re.search(r'[0-9]+', n) is not None:
        print("jeste")
    else:
        print("nije")
except:
    pass