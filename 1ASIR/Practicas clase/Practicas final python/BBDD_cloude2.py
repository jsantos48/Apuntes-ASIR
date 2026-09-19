import sqlite3

# --- CONEXIÓN: siempre las dos líneas juntas ---
conn = sqlite3.connect("peliculas.db")  # crea o abre el fichero
cur = conn.cursor()                      # cursor para ejecutar SQL

# --- CREAR TABLA: IF NOT EXISTS para no repetirla ---
cur.executescript("""
    CREATE TABLE IF NOT EXISTS peliculas (
        id       INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo   TEXT NOT NULL,
        director TEXT,
        año      INTEGER
    );
""")
conn.commit()                            # guardar la creación

# --- INSERTAR: ? por cada valor, tupla como segundo parámetro ---
def insertar(titulo, director, año):
    cur.execute(
        "INSERT INTO peliculas (titulo, director, año) VALUES (?, ?, ?)",
        (titulo, director, año)
    )
    conn.commit()                        # guardar tras insertar

# --- MOSTRAR: SELECT sin commit, fetchall devuelve lista de tuplas ---
def mostrar_todas():
    cur.execute("SELECT * FROM peliculas")
    for id, titulo, director, año in cur.fetchall():
        print(f"{id}. {titulo} | {director} | {año}")

# --- ACTUALIZAR: UPDATE + WHERE para apuntar a una fila ---
def actualizar_director(id, director_nuevo):
    cur.execute(
        "UPDATE peliculas SET director = ? WHERE id = ?",
        (director_nuevo, id)
    )
    conn.commit()                        # guardar tras modificar

# --- FILTRAR: WHERE con condición ---
def anteriores_2000():
    cur.execute("SELECT * FROM peliculas WHERE año < 2000")
    for id, titulo, director, año in cur.fetchall():
        print(f"{titulo} | {director} | {año}")

# --- DATOS DE PRUEBA: solo si la tabla está vacía ---
cur.execute("SELECT COUNT(*) FROM peliculas")
if cur.fetchone()[0] == 0:             # COUNT(*) cuenta las filas
    insertar("El Padrino", "Coppola", 1972)
    insertar("Inception", "Nolan", 2010)
    insertar("Pulp Fiction", "Tarantino", 1994)

# --- PROGRAMA PRINCIPAL ---
print("Todas las películas:")
mostrar_todas()

actualizar_director(2, "Christopher Nolan")
print("\nTras actualizar Inception:")
mostrar_todas()

print("\nAnteriores al 2000:")
anteriores_2000()