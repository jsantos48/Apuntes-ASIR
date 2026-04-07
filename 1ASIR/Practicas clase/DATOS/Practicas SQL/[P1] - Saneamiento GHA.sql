USE gha_analytics;

-- Ejercicio 1:
-- Vemos los datos
SELECT id, 
	nombre_completo, 
    nif 
FROM pacientes;

START TRANSACTION;

SET SQL_SAFE_UPDATES = 0;

-- Para eliminar espacios adicionales entre el nombre y en los extremos
UPDATE pacientes
SET nombre_completo = TRIM(REPLACE(nombre_completo,'  ',' ')); 

SET SQL_SAFE_UPDATES = 1;

-- Vemos los duplicados
SELECT 
    p1.id AS p1_id, 
    p2.id AS p2_id,
    p1.nif, 
    p1.nombre_completo
FROM pacientes p1
INNER JOIN pacientes p2 ON p1.nif = p2.nif AND p1.nombre_completo = p2.nombre_completo
WHERE p1.id > p2.id;

SAVEPOINT ej1_eliminacion_idbajo;
-- Borramos los duplicados manteniendo el ID más bajo
SET SQL_SAFE_UPDATES = 0;

DELETE p1 
FROM pacientes p1
	JOIN pacientes p2 ON p1.nif = p2.nif AND p1.nombre_completo = p2.nombre_completo
WHERE p1.id > p2.id;

SET SQL_SAFE_UPDATES = 1;

SAVEPOINT ej1_eliminacion_checkeo;
SET SQL_SAFE_UPDATES = 0;

-- Quitamos posibles espacios en el nif
UPDATE pacientes
SET nif = TRIM(REPLACE(nif,' ',''));

-- Eliminamos aquellos nif que no cumplan el requisito de 8 números y 1 letra
DELETE FROM pacientes 
	WHERE nif NOT REGEXP '^[0-9]{8}[A-Z]$';

SET SQL_SAFE_UPDATES = 1;

-- Aseguramos que siga dicho formato
ALTER TABLE pacientes
	ADD CONSTRAINT chk_pacientes_nif CHECK(nif REGEXP '^[0-9]{8}[A-Z]$');
    
-- Modificamos la columna "nif" en la tabla "pacientes"
ALTER TABLE pacientes 
	MODIFY COLUMN nif VARCHAR(9) NOT NULL UNIQUE;
    
-- Comprobamos que todo está en orden
SELECT 
    p1.id AS p1_id, 
    p2.id AS p2_id,
    p1.nif, 
    p1.nombre_completo
FROM pacientes p1
INNER JOIN pacientes p2 ON p1.nif = p2.nif AND p1.nombre_completo = p2.nombre_completo
WHERE p1.id > p2.id;

COMMIT;

-- Ejercicio 2:
-- Comprobamos los datos
SELECT *
FROM
	medicos;

START TRANSACTION;
-- Corregimos el formato del número de colegiado
SET SQL_SAFE_UPDATES = 0;

SAVEPOINT ej2_reemplazo_guion;
UPDATE medicos
SET num_colegiado = TRIM(REPLACE(num_colegiado,'/','-'));

SAVEPOINT ej2_estandarizacion;

UPDATE medicos 
SET num_colegiado = CONCAT(SUBSTRING(num_colegiado,1,3),'-',SUBSTRING(num_colegiado, 4, 2), '-', SUBSTRING(num_colegiado, 6, 4))
WHERE num_colegiado REGEXP '^COL[0-9]{6}$';

UPDATE medicos
SET num_colegiado = CONCAT('COL-',num_colegiado)
	WHERE num_colegiado REGEXP '^[0-9]{2}-[0-9]{4}$';

-- PREGUNTAR QUE SE HACE CON EL INV, SI ELIMINAR O MODIFICAR (MÁS PROBABLE).

ROLLBACK TO ej2_estandarizacion;
SET SQL_SAFE_UPDATES = 1;
ALTER TABLE medicos
	ADD CONSTRAINT chk_medicos_num_colegiado CHECK(num_colegiado REGEXP '^COL-[0-9]{2}-[0-9]{4}$');
    