# Zadatak 1.9 Napisati program koji definiše praznu (bez tela) funkciju tri argumenta, kva-
# dratnu funkciju, kao i funkciju translacije, koja prosleđeni argument umanjuje za jedan. Ilustrovati
# kompoziciju kvadratne funkcije i translacije. Funkciju kvadriranja definisati kao anonimnu funk-
# ciju.
import os
import sys 

s = input()
x, y, z = s.split()

class Tacka():

    def __init__(self, x, y ,z):
        self.x = x
        self.y = y
        self.z = z

    def transliraj(self):
        self.x =  self.x - 1
        self.y =  self.y - 1
        self.z =  self.z - 1

    def stampaj(self):
        print(self.x, self.y, self.z)

    def kvadriraj(self):
        kvadrat = lambda x: x * x
        self.x = kvadrat(self.x)
        self.y = kvadrat(self.y)
        self.z = kvadrat(self.z)   

xp = int(x)
yp = int(y)
zp = int(z)
t = Tacka(xp, yp, zp)
t.kvadriraj()
t.stampaj()