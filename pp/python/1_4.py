# Zadatak 1.4 Napisati program koji sa standardnog ulaza ucitava ceo broj n, a zatim na
# standardni izlaz ispisuje poruku o ostatku koji taj broj daje kada se podeli sa pet. Nakon toga,
# koristeci for i while petlju ispisati prvih n prirodnih brojeva.

n = int(input())
print(n % 5)
i = 0
while i < n:
    print(i, end = ' ')
    i+=1
print()
for i in range(n):
    print(i, end = ' ')
    i+=1
    