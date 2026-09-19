import json

# --- CARGAR: siempre al principio, con try/except por si no existe el fichero ---
def cargar(ruta="contactos.json"):
    try:
        with open(ruta, "r", encoding="utf-8") as f:
            return json.load(f)        # convierte el JSON en lista Python
    except (FileNotFoundError, json.JSONDecodeError):
        return []                      # si no existe, empezamos con lista vacía

# --- GUARDAR: siempre tras modificar la lista ---
def guardar(contactos, ruta="contactos.json"):
    with open(ruta, "w", encoding="utf-8") as f:
        json.dump(contactos, f, indent=4, ensure_ascii=False)  # lista Python → JSON

# --- AÑADIR: crear diccionario y meterlo en la lista ---
def añadir_contacto(contactos, nombre, telefono, ciudad):
    nuevo = {
        "nombre": nombre,
        "telefono": telefono,
        "ciudad": ciudad
    }
    contactos.append(nuevo)
    guardar(contactos)                 # guardar siempre tras modificar

# --- MOSTRAR: recorrer la lista e imprimir cada contacto ---
def mostrar_contactos(contactos):
    for c in contactos:
        print(f"{c['nombre']} | {c['telefono']} | {c['ciudad']}")

# --- BUSCAR: lista por comprensión filtrando por ciudad ---
def buscar_por_ciudad(contactos, ciudad):
    encontrados = [c for c in contactos if c['ciudad'].lower() == ciudad.lower()]
    for c in encontrados:
        print(f"{c['nombre']} | {c['telefono']}")

# --- PROGRAMA PRINCIPAL ---
if __name__ == "__main__":
    contactos = cargar()               # 1. cargar siempre al inicio

    añadir_contacto(contactos, "Ana", "600111222", "Madrid")
    añadir_contacto(contactos, "Luis", "600333444", "Barcelona")
    añadir_contacto(contactos, "Marta", "600555666", "Madrid")

    print("Todos los contactos:")
    mostrar_contactos(contactos)

    print("\nContactos en Madrid:")
    buscar_por_ciudad(contactos, "Madrid")