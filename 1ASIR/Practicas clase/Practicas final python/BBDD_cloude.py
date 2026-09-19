import sqlite3

conn = sqlite3.connect("juegos.db")
cur = conn.cursor()

cur.executescript("""
CREATE TABLE IF NOT EXISTS juegos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    genero TEXT,
    precio REAL
);
""")
conn.commit()

def insertar_juego(titulo, genero, precio):
    cur.execute(
        "INSERT INTO juegos (titulo, genero, precio) VALUES (?, ?, ?)",
        (titulo, genero, precio)
    )
    conn.commit()

def ver_todos():
    cur.execute("SELECT * FROM juegos")
    return cur.fetchall()

def actualizar_precio(id, precio_nuevo):
    cur.execute("UPDATE juegos SET precio = ? WHERE id = ?", (precio_nuevo, id))
    conn.commit()

def borrar_juego(id):
    cur.execute("DELETE FROM juegos WHERE id = ?", (id,))
    conn.commit()

def juegos_baratos():
    cur.execute("SELECT * FROM juegos WHERE precio < 30")
    return cur.fetchall()

# Insertar datos solo si la tabla está vacía
cur.execute("SELECT COUNT(*) FROM juegos")
if cur.fetchone()[0] == 0:
    insertar_juego("Zelda", "Aventura", 59.99)
    insertar_juego("FIFA 25", "Deportes", 24.99)
    insertar_juego("Minecraft", "Sandbox", 19.99)

print("Todos los juegos:")
for id, titulo, genero, precio in ver_todos():
    print(f"  {id}. {titulo} | {genero} | {precio}€")

actualizar_precio(1, 49.99)
print("\nTras actualizar Zelda:")
for id, titulo, genero, precio in ver_todos():
    print(f"  {id}. {titulo} | {genero} | {precio}€")

borrar_juego(2)
print("\nTras borrar FIFA:")
for id, titulo, genero, precio in ver_todos():
    print(f"  {id}. {titulo} | {genero} | {precio}€")

print("\nJuegos menos de 30€:")
for id, titulo, genero, precio in juegos_baratos():
    print(f"  {titulo} | {precio}€")