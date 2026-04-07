datos_poblacion = {}

print("Entrada de datos (Escribe -1 en el país para terminar):")
print("PD: El número de población estará en millones")

while True:
    nombre_pais = input("Nombre del país: ")

    if nombre_pais == "-1":
        break

    poblacion = float(input(f"Población de {nombre_pais}: "))
    datos_poblacion[nombre_pais] = poblacion

paises_ordenados = sorted(datos_poblacion.items(), key=lambda pais: pais[1], reverse=True)

print("\nLISTADO ORDENADO DE POBLACIÓN:")
for pais, hab in paises_ordenados:
    print(f"{pais}: {hab} millones")