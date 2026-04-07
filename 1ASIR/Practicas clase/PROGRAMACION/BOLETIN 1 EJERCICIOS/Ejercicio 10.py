# 10. Escribir un programa que nos pida dos números y genere un número aleatorio comprendido entre ambos. Por el momento no te preocupes de que el primer número
# siempre debería de ser menor que el segundo, simplemente no los metas en un orden incorrecto.
import random

num1 = int(input("Introduzca el primer número: "))
num2 = int(input("Introduzca el segundo número: "))

num = random.randint(num1, num2)

print(num)
