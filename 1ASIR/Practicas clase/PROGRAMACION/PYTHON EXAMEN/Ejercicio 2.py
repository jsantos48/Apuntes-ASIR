def convertir_a_entero(lista):
    lista_limpia = []

    for elemento in lista:
        try:
            numero = int(elemento)
            lista_limpia.append(numero)
        except ValueError:
            continue

    return lista_limpia

entrada = ["10", "hola", "20", "3.5", "42"]
resultado = convertir_a_entero(entrada)

print(f"Entrada original: {entrada}")
print(f"Resultado filtrado: {resultado}")