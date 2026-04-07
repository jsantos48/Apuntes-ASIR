# Hasta ahora, hemos estado trabajando con objetos.

# Concretamos objetos en base a un caso general
## Por ejemplo: vehículos (general), todos ellos tienen características similares, pero un avión no se mueve como un barco o carro o camión, etc. (concretación).

# Duck Typing: si una clase se posee las mismas cualidades que otra, Python las considera iguales, o que son de la misma rama.

nombre = "José Santos" # Esto es un objeto.
edad = 18 # Otro objeto.
contador = 100
list = []
texto = "Epale, mano. Buenos días, colabora brother, te vendo estas empanadas a unos 25 Bolívares..."



print(type(nombre)) # <class 'str'>
print(type(edad)) # <class 'int'>
print(type(contador)) # <class 'int'> iden. al ant.

print(edad.bit_length()) # 5 bits, si es int, si cambia su tipo, pierde ciertas propiedades.
print(contador.bit_length()) # 7 bits, si es int. iden. al ant.

print(nombre.title()) # Nos pone la primera letra en mayúscula
print(texto.title()) # Nos pone la primera letra en mayús de cada palabra.

print(nombre.split(" ")) # Separa el contenido, mediante el separador especificado.
print(texto.split(" ")) # Iden. al ant.


# print(nombre.split(" ").) # Al añadir un punto después de la función anterior, podemos implementar métodos. Descomentar para revisar.

# Propiedades: características que posee el objeto.
# Métodos: cosas que puede hacer el objeto.

# Ahora haremos nuestras propias clases. on nuestras propias características, en otro archivo llamado libro.