# Zadatak 1.15Napisati program koji imitira rad bafera. Maksimalni broj elemenata u baferuje5. Korisnik sa standardnog ulaza unosi podatke do unosa rečiquit. Program ih smešta u bafer,posto se bafer napuni unosi se ispisuju na standarni izlaz i bafer se prazn

bufer = [] 

i = 0 

while (True):
    try:
        bufer.append(int(input()))
        i += 1
        
        if i == 5:
            i  = 0
            print(bufer)
            bufer = []
            print("bufer se ispraznio")
            continue

    except:
        print("FAILED")
        break