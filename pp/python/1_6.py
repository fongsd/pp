# zadatak 1.6 Ako je prvi dan u mesecu ponedeljak napisati funkciju radni_dan(dan) koja
# kao argument dobija dan u mesecu i vraća tačno ako je dan radni dan. Napisati program koji
# testira ovu funkciju, korisnik sa standardnog ulaza u petlji unosi deset dana i dobija o poruku o
# tome da li su uneti dani radni ili ne.

def ucitaj_dan(x):
    if x % 7 == 0 or x % 7 == 6:
        return False
    else:
        return True

for i in range(10):
    if ucitaj_dan(int(input())):
        print("radan")
    else:
        print("neradan")