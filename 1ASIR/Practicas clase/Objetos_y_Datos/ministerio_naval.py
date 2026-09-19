import sqlite3

conn = sqlite3.connect("ministerio_naval.db")
cur = conn.cursor()

cur.executescript("""
CREATE TABLE IF NOT EXISTS naves (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    tipo TEXT,
    año_construccion INTEGER,
    epoca TEXT
);

CREATE TABLE IF NOT EXISTS agentes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    año_nacimiento INTEGER,
    especialidad TEXT,
    activo INTEGER DEFAULT 1
);

CREATE TABLE IF NOT EXISTS misiones (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_agente INTEGER,
    id_nave INTEGER,
    fecha_partida TEXT,
    fecha_regreso TEXT,
    exito INTEGER DEFAULT 0,
    incidencias TEXT,
    FOREIGN KEY (id_agente) REFERENCES agentes(id),
    FOREIGN KEY (id_nave) REFERENCES naves(id)
);
""")

conn.commit()


def registrar_nave(nombre, tipo, año, epoca):
    cur.execute(
        "INSERT INTO naves (nombre, tipo, año_construccion, epoca) VALUES (?, ?, ?, ?)",
        (nombre, tipo, año, epoca)
    )
    conn.commit()

def enviar_agente(id_agente, id_nave, fecha_partida):
    cur.execute(
        "SELECT id FROM misiones WHERE id_agente = ? AND fecha_regreso IS NULL",
        (id_agente,)
    )
    if cur.fetchone():
        cur.execute("SELECT nombre FROM agentes WHERE id = ?", (id_agente,))
        nombre = cur.fetchone()[0]
        print(f"✗ Error: El agente {nombre} ya está en misión. ¿Paradoja temporal detectada?")
        return
    cur.execute(
        "INSERT INTO misiones (id_agente, id_nave, fecha_partida) VALUES (?, ?, ?)",
        (id_agente, id_nave, fecha_partida)
    )
    conn.commit()

def cerrar_mision(id_mision, exito, incidencias):
    cur.execute(
        "UPDATE misiones SET fecha_regreso = date('now'), exito = ?, incidencias = ? WHERE id = ?",
        (exito, incidencias, id_mision)
    )
    conn.commit()

def naves_sin_capitan():
    cur.execute("""
        SELECT nombre FROM naves
        WHERE id NOT IN (
            SELECT id_nave FROM misiones WHERE fecha_regreso IS NULL
        )
    """)
    return cur.fetchall()

def historial_agente(id_agente):
    cur.execute("""
        SELECT m.fecha_partida, n.nombre, m.exito, m.incidencias
        FROM misiones m
        JOIN naves n ON m.id_nave = n.id
        WHERE m.id_agente = ?
        ORDER BY m.fecha_partida
    """, (id_agente,))
    return cur.fetchall()

def misiones_fallidas():
    cur.execute("""
        SELECT n.nombre, a.nombre, m.incidencias
        FROM misiones m
        JOIN naves n ON m.id_nave = n.id
        JOIN agentes a ON m.id_agente = a.id
        WHERE m.exito = 0 AND m.fecha_regreso IS NOT NULL
    """)
    return cur.fetchall()

cur.execute("SELECT COUNT(*) FROM naves")
if cur.fetchone()[0] == 0:
    registrar_nave("Santa María", "Carabela", 1460, "Descubrimiento")
    registrar_nave("San Martín", "Galeón", 1580, "Armada Invencible")
    registrar_nave("Victoria", "Nao", 1519, "Circunnavegación")
    registrar_nave("Numancia", "Fragata", 1863, "Edad Contemporánea")
    registrar_nave("Pelayo", "Acorazado", 1887, "Edad Contemporánea")

    cur.executemany(
        "INSERT INTO agentes (nombre, año_nacimiento, especialidad) VALUES (?, ?, ?)",
        [
            ("Rodrigo de Triana", 1469, "Navegación"),
            ("Isabel de Castilla", 1451, "Diplomacia"),
            ("Juan Sebastián Elcano", 1476, "Cartografía"),
            ("Blas de Lezo", 1689, "Combate naval"),
        ]
    )
    conn.commit()

    enviar_agente(1, 1, "1492-08-03")
    cerrar_mision(1, 1, None)

    enviar_agente(2, 2, "1588-05-20")
    cerrar_mision(2, 0, "Tormenta en el Canal de la Mancha")

    enviar_agente(3, 3, "1519-09-20")
    cerrar_mision(3, 1, None)

    enviar_agente(4, 4, "1741-03-15")
    cerrar_mision(4, 1, "Herido en combate")

    enviar_agente(1, 5, "1750-06-01")
    cerrar_mision(5, 0, "Nave averiada, regreso forzoso")

    enviar_agente(2, 3, "1760-01-10")
    cerrar_mision(6, 0, "Motín de la tripulación")

    enviar_agente(3, 4, "2024-11-01")

print("Naves sin capitán asignado:", len(naves_sin_capitan()))
for (nave,) in naves_sin_capitan():
    print(f"   - {nave}")

cur.execute("SELECT id, nombre FROM agentes")
for id_agente, nombre in cur.fetchall():
    historial = historial_agente(id_agente)
    print(f"\nHistorial de {nombre}: {len(historial)} misión(es)")
    for fecha, nave, exito, incidencias in historial:
        estado = "✓" if exito else "✗"
        inc = incidencias if incidencias else "Sin incidencias"
        print(f"   {estado} {fecha} | {nave} | {inc}")

fallidas = misiones_fallidas()
print(f"\nMisiones fallidas registradas: {len(fallidas)}")
for nave, agente, incidencia in fallidas:
    print(f"   - {nave} | {agente} | Incidencia: {incidencia}")

