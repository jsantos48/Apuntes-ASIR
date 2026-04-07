max_not = 10
min_not = 0
cont = 0
suma = 0
num = int(input("Dime tu nota: "))
while num >= 0:
    if num > 10:
        print("Nota no válida")
        break
    else:
        suma += num
        cont += 1
        num = float(input("Dime tu nota: "))
if cont == 0:
    print("Nota invalida")
else:
    print("Media: " ,suma / cont)
