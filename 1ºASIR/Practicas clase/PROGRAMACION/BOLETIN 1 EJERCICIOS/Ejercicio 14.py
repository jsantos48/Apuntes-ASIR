# 14. Escribe un programa que genere números aleatorios entre el 1 y el 1000 sin parar y que sólo se detenga cuando salga el 666

import random

while True:
    num = random.randint(1, 1000)
    print(num)
    if num == 666:
        break
