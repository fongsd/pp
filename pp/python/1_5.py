# Zadatak 1.5 Napisati program koji sa standardnog ulaza ucitava ceo broj, koji je otporan na
# pogresan ulaz. Nakon toga, ilustrovati imutabilnost stringova.

try:
    n = int(input())

except:
    print("pogresan ulaz")


x = "Hello world"
y = "Hello world"

print(x, id(x), x[1])
x[1] = 'a'
print(y, id(y))
print(x == y)