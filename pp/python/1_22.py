import random

print("ime i prezime:")
input()
x = random.randint(0, 100)

while (True):
    print("pogodi broj")
    y = int(input())
    if y == x:
        print("uspesno!!!")
        break
    elif y <= x:
        print("vise")
    elif y > x:
        print("manje")
    print("opet")