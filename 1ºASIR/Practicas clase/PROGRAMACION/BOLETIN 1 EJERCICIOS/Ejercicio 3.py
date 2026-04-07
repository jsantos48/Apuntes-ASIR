#3. Escribir un programa donde se muestren los 5 primeros números múltiplos de uno dado
# por el usuario
numero = int(input("Introduce un número: "))

print("Los 5 primeros múltiplos de " + str(numero) + " son:")

for i in range(1, 6):
    print(numero * i)
