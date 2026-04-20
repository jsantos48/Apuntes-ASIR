USE gha_analytics;

-- ESCENARIO 1
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
show index from pacientes;
    
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
SET num_colegiado = CONCAT(SUBSTRING(num_colegiado, 1, 3),'-',SUBSTRING(num_colegiado, 4, 2), '-', SUBSTRING(num_colegiado, 6, 4))
WHERE num_colegiado REGEXP '^COL[0-9]{6}$';

UPDATE medicos
SET num_colegiado = CONCAT('COL-',num_colegiado)
	WHERE num_colegiado REGEXP '^[0-9]{2}-[0-9]{4}$';

-- Inventamos una variante para el inventado
UPDATE medicos
SET num_colegiado = CONCAT('COL-', '99-', SUBSTRING(num_colegiado, 5, 4))
	WHERE num_colegiado LIKE 'INV-%';

-- Añadimos 0s para que cuumpla el requisito
UPDATE medicos 
SET num_colegiado = CONCAT(SUBSTRING(num_colegiado, 1, 7), '0', SUBSTRING(num_colegiado, 8, 4))
	WHERE num_colegiado REGEXP '^COL-99-[0-9]{3}$';

UPDATE medicos 
SET num_colegiado = CONCAT(SUBSTRING(num_colegiado, 1, 7), '00', SUBSTRING(num_colegiado, 8, 4))
	WHERE num_colegiado REGEXP '^COL-99-[0-9]{2}$';

UPDATE medicos 
SET num_colegiado = CONCAT(SUBSTRING(num_colegiado, 1, 7), '000', SUBSTRING(num_colegiado, 8, 4))
	WHERE num_colegiado REGEXP '^COL-99-[0-9]{1}$';


ROLLBACK TO ej2_estandarizacion;

SET SQL_SAFE_UPDATES = 1;

ALTER TABLE medicos
	ADD CONSTRAINT chk_medicos_num_colegiado CHECK(num_colegiado REGEXP '^COL-[0-9]{2}-[0-9]{4}$');

COMMIT;
    
-- Ejercicio 3
-- Vemos las especialidades de los médicos y las disponibles
SELECT * 
FROM medicos;

SELECT * 
FROM especialidades;

-- Sustituimos la especialidad inexistente de los médicos 
START TRANSACTION;

SET SQL_SAFE_UPDATES = 0;

SAVEPOINT mod_id_especialidad;

UPDATE medicos
SET especialidad_id = (SELECT id FROM especialidades WHERE nombre LIKE 'Medicina General')
	WHERE especialidad_id NOT IN (SELECT id FROM especialidades);

ROLLBACK TO mod_id_especialidad;

SAVEPOINT clave_foranea_medvisita;

-- Vemos los errores de la tabla visitas, ya que haciendo el alter table directamente da error.
-- El JOIN elimina los huérfanos del resultado; para encontrarlos debes quitar los JOIN y usar OR
SELECT * FROM visitas;

DELETE FROM visitas 
	WHERE paciente_id NOT IN (SELECT id FROM pacientes);
    
DELETE FROM visitas
	WHERE medico_id NOT IN (SELECT id FROM medicos);

ALTER TABLE visitas 
	ADD CONSTRAINT fk_visitas_medicos FOREIGN KEY (medico_id) REFERENCES medicos(id)
	ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE visitas 
	ADD CONSTRAINT fk_visitas_pacientes FOREIGN KEY (paciente_id) REFERENCES pacientes(id)
	ON DELETE CASCADE ON UPDATE CASCADE;
    
ALTER TABLE medicos
	ADD CONSTRAINT fk_medicos_especialidad FOREIGN KEY (especialidad_id) REFERENCES especialidades(id)
	ON DELETE CASCADE ON UPDATE CASCADE;

ROLLBACK TO clave_foranea_medvisita;

SET SQL_SAFE_UPDATES = 1;

-- Comprobamos
SELECT * FROM visitas;

COMMIT;

-- Ejercicio 4
-- Creamos la tabla "seguros_pacientes"
START TRANSACTION;

SAVEPOINT tabla_seguros;

SET SQL_SAFE_UPDATES = 0;

SELECT * FROM pacientes; 
-- Creamos la tabla e insertamos los datos de pacientes
CREATE TABLE seguros_pacientes (
    paciente_id INT AUTO_INCREMENT,  
    num_poliza VARCHAR(50),
    estado_poliza VARCHAR(20) DEFAULT 'ACTIVA', 
    CONSTRAINT pk_paciente_seguro PRIMARY KEY(paciente_id),
    CONSTRAINT fk_seguros_pacientes FOREIGN KEY(paciente_id) 
        REFERENCES pacientes(id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO seguros_pacientes (paciente_id, num_poliza)
SELECT id, num_poliza
FROM pacientes
WHERE num_poliza IS NOT NULL;

-- Comprobamos la nueva tabla
SELECT * FROM seguros_pacientes;

-- Borramos la columna de pacientes
ALTER TABLE pacientes 
DROP COLUMN num_poliza;

-- Comprobamos si se ha borrado
SELECT * FROM pacientes;

SET SQL_SAFE_UPDATES = 1;

ROLLBACK TO tabla_seguros;

COMMIT;

-- Ejercicio 5
START TRANSACTION;

SELECT * FROM visitas;

EXPLAIN visitas;

SAVEPOINT copago_visitas;

SET SQL_SAFE_UPDATES = 0;

ALTER TABLE visitas
	ADD COLUMN copago_estimado DECIMAL(10,2);

UPDATE visitas
SET importe_sucio = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(importe_sucio, ',', '.'),'EUR', ''), '€', ''), 'Gratis', '0.00'));

UPDATE visitas
SET copago_estimado = CAST(importe_sucio AS DECIMAL(10,2)) * 0.20;

ALTER TABLE visitas
	MODIFY copago_estimado DECIMAL (10,2) NOT NULL;
    
ALTER TABLE seguros_pacientes
	MODIFY num_poliza VARCHAR(50) NOT NULL;

ROLLBACK TO copago_visitas;

SET SQL_SAFE_UPDATES = 1;

COMMIT;

-- Ejercicio 6
START TRANSACTION;

SELECT * FROM raw_import_visitas;

select * from pacientes;
explain pacientes;

SAVEPOINT procesado;

-- Esta opción es válida, sin embargo, no es la mejor
/* INSERT INTO pacientes (nif, nombre_completo, f_nacimiento)
SELECT 
    SUBSTRING_INDEX(raw_data, '|', 1),
    SUBSTRING_INDEX(SUBSTRING_INDEX(raw_data, '|', 2), '|', -1),
    SUBSTRING_INDEX(SUBSTRING_INDEX(raw_data, '|', 3), '|', -1)
FROM raw_import_visitas
WHERE NOT EXISTS (
	SELECT 1
    FROM pacientes
    WHERE pacientes.nif = SUBSTRING_INDEX(raw_data, '|', 1));
*/ 

-- Esta opción es mejor, ya que me devuelve las columnas duplicadas aunque no las añada
INSERT IGNORE INTO pacientes (nif, nombre_completo, f_nacimiento)
SELECT 
    SUBSTRING_INDEX(raw_data, '|', 1),
    SUBSTRING_INDEX(SUBSTRING_INDEX(raw_data, '|', 2), '|', -1),
    SUBSTRING_INDEX(SUBSTRING_INDEX(raw_data, '|', 3), '|', -1)
FROM raw_import_visitas;

SHOW INDEX FROM pacientes;

INSERT INTO visitas (paciente_id, medico_id, fecha_visita, importe_sucio)
SELECT 
    p.id, 
    1,
    NOW(), 
    SUBSTRING_INDEX(raw_data, '|', -1)
FROM raw_import_visitas r
JOIN pacientes p ON p.nif = SUBSTRING_INDEX(SUBSTRING_INDEX(r.raw_data, '|', 2), '|', -1);

ROLLBACK TO procesado;

COMMIT;


-- ESCENARIO 2
-- TABLA PACIENTES
SELECT * FROM pacientes;

START TRANSACTION;

SAVEPOINT pacientes_mod;

SET SQL_SAFE_UPDATES = 0;

SELECT COUNT(*) FROM pacientes WHERE f_nacimiento NOT LIKE '__/__/____';

SET SQL_SAFE_UPDATES = 1;

ROLLBACK TO visitas_mod;

COMMIT;