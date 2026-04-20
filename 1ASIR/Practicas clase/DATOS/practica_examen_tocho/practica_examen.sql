USE logistica_global;

SHOW TABLES;

-- TABLA INCIDENCIAS
EXPLAIN incidencias;

SELECT * FROM incidencias;

START TRANSACTION;

-- SANEAMIENTO DE LA FECHA

SAVEPOINT incidencias_fecha;

SET SQL_SAFE_UPDATES = 0;

UPDATE incidencias
SET f_incidencia = TRIM(f_incidencia);

UPDATE incidencias
SET f_incidencia = CASE
    WHEN f_incidencia LIKE '%.%' THEN REPLACE(f_incidencia,'.','-')
    WHEN f_incidencia LIKE '%/%' THEN REPLACE(f_incidencia,'/','-')
    WHEN f_incidencia LIKE '__-__-____' THEN DATE_FORMAT(STR_TO_DATE(f_incidencia,'%d-%m-%Y'),'%Y-%m-%d')
    WHEN f_incidencia LIKE '26-__-__' THEN DATE_FORMAT(STR_TO_DATE(f_incidencia, '%y-%m-%d'), '%Y-%m-%d')
    WHEN f_incidencia LIKE '__-__-26' THEN DATE_FORMAT(STR_TO_DATE(f_incidencia, '%d-%m-%y'), '%Y-%m-%d')
    ELSE NULL
END;

DELETE FROM incidencias WHERE envio_id IS NULL;

SET SQL_SAFE_UPDATES = 1;

-- ROLLBACK TO incidencias_fecha;

SAVEPOINT coste_asociado;

-- ROLLBACK TO coste_asociado;

-- COMPROBAMOS

SELECT * FROM incidencias;

COMMIT;

-- TABLA CLIENTES
SELECT * FROM clientes;

-- FECHA DEL ALTA DE LOS CLIENTES
SAVEPOINT fecha_alta_cliente;

SET SQL_SAFE_UPDATES = 0;

UPDATE clientes
SET fecha_alta_cliente = TRIM(fecha_alta_cliente);

UPDATE clientes
SET fecha_alta_cliente = CASE
    WHEN fecha_alta_cliente LIKE '%.%' THEN REPLACE(fecha_alta_cliente,'.','-')
    WHEN fecha_alta_cliente LIKE '%/%' THEN REPLACE(fecha_alta_cliente,'/','-')
    WHEN fecha_alta_cliente LIKE '__-__-____' THEN DATE_FORMAT(STR_TO_DATE(fecha_alta_cliente,'%d-%m-%Y'),'%Y-%m-%d')
    WHEN fecha_alta_cliente LIKE '20-__-__' THEN DATE_FORMAT(STR_TO_DATE(fecha_alta_cliente, '%y-%m-%d'), '%Y-%m-%d')
    WHEN fecha_alta_cliente LIKE '__-__-20' THEN DATE_FORMAT(STR_TO_DATE(fecha_alta_cliente, '%d-%m-%y'), '%Y-%m-%d')
    WHEN fecha_alta_cliente LIKE '21-__-__' THEN DATE_FORMAT(STR_TO_DATE(fecha_alta_cliente, '%y-%m-%d'), '%Y-%m-%d')
    WHEN fecha_alta_cliente LIKE '__-__-21' THEN DATE_FORMAT(STR_TO_DATE(fecha_alta_cliente, '%d-%m-%y'), '%Y-%m-%d')
    ELSE fecha_alta_cliente
END;
-- ROLLBACK TO fecha_alta_cliente;

SELECT * FROM almacenes;

SELECT SUBSTRING_INDEX(ubicacion_geografica,'|', 1) FROM almacenes;
