USE gestion_universidad;

-- ========================================================================
-- FASE 1: DATOS VÁLIDOS (Línea base)
-- ========================================================================

-- 1. Insertamos facultades (id_decano es NULL inicialmente según el enunciado)
INSERT INTO facultades (codigo, nombre, id_decano) VALUES 
('F001', 'Facultad de Informática', NULL),
('F002', 'Facultad de Ciencias', NULL);

-- 2. Insertamos profesores (Probando DEFAULT salario = 2000.00)
INSERT INTO profesores (nif, nombre_completo, id_facultad) VALUES 
('12345678A', 'Alan Turing', 1),
('87654321B', 'Marie Curie', 2);

-- 3. Actualizamos decano (Ahora que existen profesores)
UPDATE facultades SET id_decano = 1 WHERE id_facultad = 1;

-- 4. Insertamos grados
INSERT INTO grados (nombre, id_facultad) VALUES 
('Ingeniería del Software', 1),
('Grado en Física', 2);

-- 5. Insertamos asignaturas (Probando DEFAULT creditos = 6)
INSERT INTO asignaturas (codigo_asig, nombre) VALUES 
('BASES01', 'Bases de Datos'),
('FISIC01', 'Física Cuántica');

-- 6. Insertamos en 'imparten' (Probando DEFAULT ENUM 'TEORIA')
INSERT INTO imparten (id_profesor, id_asignatura) VALUES (1, 1);
INSERT INTO imparten (id_profesor, id_asignatura, tipo_group) VALUES (2, 2, 'PRACTICA');


-- ========================================================================
-- FASE 2: VIOLACIÓN DE RESTRICCIONES (Deben dar ERROR)
-- ========================================================================

-- --- 2.1. Tabla: facultades ---
-- ERROR: Código duplicado (UNIQUE)
INSERT INTO facultades (codigo, nombre) VALUES ('F001', 'Otra Facultad');

-- ERROR: Código != 4 caracteres (Si usaste CHECK o es tipo CHAR(4))
INSERT INTO facultades (codigo, nombre) VALUES ('F0005', 'Error Longitud');


-- --- 2.2. Tabla: profesores ---
-- ERROR: Salario <= 0 (CHECK)
INSERT INTO profesores (nif, nombre_completo, salario, id_facultad) VALUES ('11111111X', 'Invalido', -50, 1);

-- ERROR: NIF duplicado (UNIQUE)
INSERT INTO profesores (nif, nombre_completo, id_facultad) VALUES ('12345678A', 'Duplicado', 1);


-- --- 2.3. Tabla: asignaturas ---
-- ERROR: Créditos < 3 (CHECK)
 INSERT INTO asignaturas (codigo_asig, nombre, creditos) VALUES ('ERR01', 'Corta', 2);


-- --- 2.4. Tabla: imparten ---
-- ERROR: ENUM no permitido
INSERT INTO imparten (id_profesor, id_asignatura, tipo_group) VALUES (1, 2, 'LABORATORIO');


-- ========================================================================
-- FASE 3: PRUEBAS DE BORRADO (CASCADE)
-- ========================================================================

-- Al borrar la asignatura 1, se debe borrar su relación en 'imparten' por el ON DELETE CASCADE
DELETE FROM asignaturas WHERE id_asignatura = 1;

-- Comprobación automática
SELECT 
    IF(COUNT(*) = 0, 
       '✅ ÉXITO: Borrado en cascada verificado en tabla IMPARTEN.', 
       '❌ ERROR: Fallo en la cascada. El registro sigue en IMPARTEN.'
    ) AS 'Resultado_Test_Cascada'
FROM imparten 
WHERE id_asignatura = 1;

-- Intento de borrar facultad (Debería fallar o restringirse si hay profesores/grados asociados)
DELETE FROM facultades WHERE id_facultad = 2;
