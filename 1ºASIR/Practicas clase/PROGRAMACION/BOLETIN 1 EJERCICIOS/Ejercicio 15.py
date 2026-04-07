# 15. Escribir un programa que pida un número al usuario y calcule si es primo o no lo es

num = int(input("Introduzca un número: "))
primo = True

for i in range(2, num):
    if num%i == 0:
        primo = False
if primo:
    print(f"El {num} es primo")
else:
    print(f"El {num} no es primo")