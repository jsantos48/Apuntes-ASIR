# 11. Modificar el programa del punto anterior para que si el primer número que metemos es mayor que el segundo funcione correctamente. Es decir, si metemos en primer lugar el
# 50 y en segundo el 10 nos debería de generar un número aleatorio entre el 10 y el 50 (y no entre el 50 y el 10 que no tiene mucha lógica...)
import random

num1 = int(input("Introduzca el primer número: "))
num2 = int(input("Introduzca el segundo número: "))

mayor = max(num1, num2)
menor = min(num1, num2)
num = random.randint(menor, mayor)

print(num)