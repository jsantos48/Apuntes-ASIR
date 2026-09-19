import json
from datetime import date

# 1. Cargar los datos existentes
def cargar_diario(ruta="diario.json"):
    try:
        with open(ruta, "r", encoding="utf-8") as f:
            return json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):
        return []


# 2. Guardar los datos en el fichero
def guardar_diario(entradas, ruta="diario.json"):
    with open(ruta, "w", encoding="utf-8") as f:
        json.dump(entradas, f, indent=4, ensure_ascii=False)


# 3. Lógica principal
def mi_diario():
    diario = cargar_diario()

    print("--- 📝 MI DIARIO PERSONAL ---")
    print("1. Nueva entrada | 2. Ver últimas | 3. Buscar | 4. Salir")

    opcion = input("¿Qué quieres hacer?: ")

    if opcion == "1":
        titulo = input("Título: ")
        texto = input("Contenido: ")
        # Creamos el diccionario de la entrada
        nueva_entrada = {
            "fecha": str(date.today()),
            "titulo": titulo,
            "texto": texto
        }
        diario.append(nueva_entrada)
        guardar_diario(diario)
        print("✅ Entrada guardada.")

    elif opcion == "2":
        n = int(input("¿Cuántas entradas quieres ver?: "))
        # Usamos slicing [-n:] para sacar las últimas y luego reverse para ver la más reciente primero
        for e in reversed(diario[-n:]):
            print(f"\n[{e['fecha']}] - {e['titulo']}\n{e['texto']}")

    elif opcion == "3":
        palabra = input("Palabra a buscar: ").lower()
        encontrados = [e for e in diario if palabra in e['texto'].lower() or palabra in e['titulo'].lower()]
        print(f"Resultados ({len(encontrados)}):")
        for e in encontrados:
            print(f"- {e['fecha']}: {e['titulo']}")

    elif opcion == "4":
        print("¡Hasta mañana!")

    else:
        print("Opción no válida.")


# Ejecutar el programa
if __name__ == "__main__":
    mi_diario()