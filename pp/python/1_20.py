# Zadatak 1.20Sa standardnog ulaza se unose reči do rečiquit. Napisati program koji ispisujeunete reči eliminišući duplikate.

a = set()

while (True):
    s = input()

    if s == "quit":
        break
    
    else:
        a.add(s)

print(a)