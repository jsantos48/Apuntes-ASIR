#String secuencia. Inmutable y ordenada
cadena = "patata"

print(cadena[-2])
print(type(cadena))
print(len(cadena))

#Lista
lista = [1,2,4,4,4,6]
print(lista)
lista[3] = 0
print(lista)
lista.sort()
print(lista)
lista.append(4)
print(lista)
print(lista.index(4))
print(lista.count(5))
print(len(lista))
matriz = [["a","b","c"],
          ["d","e","f"],
          ["g","h","i"]]
print(matriz[2][1])

#Tupla
tuplaRGB = (12,10,105)
print(tuplaRGB)