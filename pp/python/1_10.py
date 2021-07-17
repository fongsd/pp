# Zadatak 1.10 Ilustrovati prenos argumenata funkciji: definisati dve funkcije koje rade sa
# listom, jednu koja menja, a drugu koja pravi kopiju prosleđenog joj argumenta.


l = [1, 2, 3]

def promeni(l):
    try:
        l[0] = 'a'
        pass
    except:
        print("failed")
        pass

def kopija(l):
    x = l.copy()
    return x


print(l)
promeni(l)
print(l)
x = kopija(l)
print(id(x))
print( id(l))