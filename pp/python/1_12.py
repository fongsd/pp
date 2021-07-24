# Zadatak 1.12
# Napisati program koji sa standardnog ulaza učitava listu celih brojeva, a zatimna standardni izlaz ispisuje njenu dužinu, sumu njenih elemenata, njen maksimalni element kao ibroj pojavljivanja broja jedan u unetoj listi.


l = []

while (True):
    try:
         l.append(int(input()))
    except:
        print(l)
        break

print(len(l))
print(sum(l))
print(max(l))

print(l.count(1))