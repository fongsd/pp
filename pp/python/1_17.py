# Zadatak 1.17Napisati funkcijumax_list(lista)koja vraća najveći element u listi listi.Napisati program koji testira ovu funkciju

a  = [1,2,3,1,-1,12]

def max(a):
    m = a[0]
    
    for i in range(1, len(a)):
        if m < a[i]:
            m = a[i]
            print(m)
    return m


print(max(a))