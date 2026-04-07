#4. Escribir un programa donde se muestren todos los números divisibles por 7 menores a 10000
for num in range(10000):
    if num%7 == 0 and num <=10000:
        print(num)