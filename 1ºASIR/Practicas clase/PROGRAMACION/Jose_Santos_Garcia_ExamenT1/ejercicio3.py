pal = input("Introduzca una palabra: ")
num = int(input("Introduzca una clave: "))
for clave in reversed(pal):
    if num % 2 == 0:
        print(clave.upper() + str(num), end="")
    else:
        print(clave.lower() + str(num), end="")
