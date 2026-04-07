def procesar_notas(lista):
    notas_validas = []

    for validas in lista:
        try:
            nota = float(validas)
            if nota > 10:
                raise Exception(f"La nota {nota} es mayor a 10")

            notas_validas.append(nota)
        except ValueError:
            print(f"ERROR: '{validas}' no es válido")
            continue

        except Exception as e:
            print(f"ERROR: {e}")
            continue

    return notas_validas

notas_sucias = ["8", "10", "falta", "5", "9.5", "20"]
resultado = procesar_notas(notas_sucias)

print(f"Estas eran las notas antes: {notas_sucias}")
print(f"Estas son las notas válidas: {resultado}")