# 13. Escribir un programa que nos permita generar una quiniela. Para ello nos debe generar quince números aleatorios entre el 1 y el 3. Recuerda que los resultados válidos son 1 X
# o 2, así que si te sale un 3 lo que tienes que imprimir en pantalla es una X
import random

num = random.randint(1, 3)
if num == 3:
    print("X")
elif num == 1:
    print(1)
else:
    print (2)