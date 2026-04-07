num = int(input("Introduzca un número: "))

for i in range(2,num):
    primo = True
    if num%i == 0:
        print(f"El número {num} no es primo")
        primo = False
        break
else:
    print(f"El número {num} es primo")
