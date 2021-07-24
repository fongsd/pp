
matrix = [["-", "-", "-"], ["-", "-", "-"], ["-", "-", "-"]]

def ispisi_matricu():
    for i in matrix:
        for j in i:
            print(j, end=" ")
        print("")

def p():
    for i in matrix:
        for j in i:
            if j == "-":
                return False

    return True

def proveri_matric():
    if matrix[0][0] == matrix[1][1] and matrix[0][0] == matrix[2][2] and p():
        if matrix[0][0] == "X":
            print("pobenik je iks")
        else:
            print("pobenik je oks")
        return False

    if matrix[0][0] == matrix[0][1] and matrix[0][0] == matrix[0][2] and p():
        if matrix[0][0] == "X":
            print("pobenik je iks")
        else:
            print("pobenik je oks")
        return False
    
    if matrix[0][0] == matrix[1][0] and matrix[0][0] == matrix[2][0] and p():
        if matrix[0][0] == "X":
                print("pobenik je iks")
        else:
            print("pobenik je oks")
        return False

    if matrix[2][0] == matrix[2][1] and matrix[2][0] == matrix[2][2] and p():
        if matrix[2][0] == "X":
            print("pobenik je iks")
        else:
            print("pobenik je oks")
        return False
    

    if matrix[2][2] == matrix[1][2] and matrix[2][2] == matrix[0][2] and p():
        if matrix[2][2] == "X":
            print("pobenik je iks")
        else:
            print("pobenik je oks")
        return False
    
    else:
        return True
    
print("igrac x")
x = "X"
o = "O"
print("unesi vrstu")
i = input()
print("unesi kolonu")
j = input()

matrix[int(i)][int(j)] = "X"
ispisi_matricu()


print("igrac oks")
x = "X"
o = "O"
print("unesi vrstu")
i = input()
print("unesi kolonu")
j = input()

matrix[int(i)][int(j)] = "O"
ispisi_matricu()

proveri_matric()

while(True):
    proveri_matric()
    print("igrac x")
    x = "X"
    o = "O"
    print("unesi vrstu")
    i = input()
    print("unesi kolonu")
    j = input()

    matrix[int(i)][int(j)] = "X"
    ispisi_matricu()


    print("igrac oks")
    x = "X"
    o = "O"
    print("unesi vrstu")
    i = input()
    print("unesi kolonu")
    j = input()

    matrix[int(i)][int(j)] = "O"
    ispisi_matricu()
    proveri_matric()