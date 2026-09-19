import csv  # csv: módulo para leer y escribir ficheros de tabla (como Excel pero en texto plano)

# =============================================================
# GUÍA RÁPIDA DE COMANDOS CSV
# -------------------------------------------------------------
# open(ruta, "r")          → abrir para leer
# open(ruta, "w")          → abrir para escribir (sobreescribe)
# open(ruta, "a")          → abrir para añadir al final
# newline=""               → SIEMPRE en CSV para evitar líneas vacías
# encoding="utf-8"         → para tildes y ñ
#
# csv.reader(f)            → leer fila a fila como listas
# csv.writer(f)            → escribir fila a fila
# csv.DictReader(f)        → leer fila a fila como diccionarios {columna: valor}
# csv.DictWriter(f, fields)→ escribir fila a fila como diccionarios
#
# writer.writerow([...])   → escribe una sola fila
# writer.writerows([[...]]) → escribe varias filas a la vez
# reader.__next__()        → salta la cabecera (primera fila)
# fieldnames               → lista con los nombres de las columnas
# =============================================================


# --- CARGAR: abre el CSV y devuelve lista de diccionarios ---
def cargar(ruta="empleados.csv"):
    try:
        with open(ruta, "r", encoding="utf-8", newline="") as f:
            reader = csv.DictReader(f)   # cada fila es un dict {columna: valor}
            return list(reader)          # convertir a lista para poder usarla fuera del with
    except FileNotFoundError:
        return []                        # si no existe aún, lista vacía


# --- GUARDAR: sobreescribe el CSV entero con la lista actualizada ---
def guardar(empleados, ruta="empleados.csv"):
    with open(ruta, "w", encoding="utf-8", newline="") as f:
        campos = ["nombre", "departamento", "salario"]  # nombres de las columnas
        writer = csv.DictWriter(f, fieldnames=campos)   # writer que escribe diccionarios
        writer.writeheader()                             # escribe la primera fila con los nombres
        writer.writerows(empleados)                      # escribe todas las filas de golpe


# --- AÑADIR: crear diccionario y meterlo en la lista ---
def añadir_empleado(empleados, nombre, departamento, salario):
    nuevo = {
        "nombre": nombre,
        "departamento": departamento,
        "salario": salario
    }
    empleados.append(nuevo)
    guardar(empleados)                   # guardar siempre tras modificar


# --- MOSTRAR: recorrer la lista e imprimir cada empleado ---
def mostrar(empleados):
    for e in empleados:
        print(f"{e['nombre']} | {e['departamento']} | {e['salario']}€")


# --- FILTRAR: lista por comprensión con condición ---
def por_departamento(empleados, departamento):
    encontrados = [e for e in empleados if e['departamento'].lower() == departamento.lower()]
    for e in encontrados:
        print(f"{e['nombre']} | {e['salario']}€")


# --- SUBIDA DE SALARIO: recorrer y modificar un campo ---
def subir_salario(empleados, nombre, cantidad):
    for e in empleados:
        if e['nombre'].lower() == nombre.lower():
            e['salario'] = str(int(e['salario']) + cantidad)  # CSV guarda todo como texto, convertir a int para operar
    guardar(empleados)                   # guardar tras modificar


# --- PROGRAMA PRINCIPAL ---
if __name__ == "__main__":
    empleados = cargar()                 # 1. cargar siempre al inicio

    # insertar datos de prueba solo si está vacío
    if len(empleados) == 0:
        añadir_empleado(empleados, "Ana", "Ventas", 2000)
        añadir_empleado(empleados, "Luis", "IT", 2500)
        añadir_empleado(empleados, "Marta", "Ventas", 1800)

    print("Todos los empleados:")
    mostrar(empleados)

    subir_salario(empleados, "Ana", 300)
    print("\nTras subir salario de Ana:")
    mostrar(empleados)

    print("\nEmpleados de Ventas:")
    por_departamento(empleados, "Ventas")