# 5. Escribir un programa que pida un número al usuario y diga si es par o impar
num = int(input("Introduzca un número: "))
if num%2 == 0:
    print(f"{num} es par")
else:
    print(f"{num} es impar")