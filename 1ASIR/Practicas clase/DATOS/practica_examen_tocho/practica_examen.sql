USE logistica_global;

FLUSH LOGS;

-- ANALIZAMOS
SHOW TABLES;

-- TABLA INCIDENCIAS
SELECT * FROM incidencias;

START TRANSACTION;

-- SANEAMOS COLUMNA F_INCIDENCIA
SET SQL_SAFE_UPDATES = 0;

SAVEPOINT incidencias_fecha;

DELETE FROM incidencias WHERE envio_id IS NULL;

UPDATE incidencias 
SET f_incidencia = TRIM(f_incidencia);

UPDATE incidencias
SET f_incidencia = CASE
    WHEN f_incidencia REGEXP '^[0-9]{2}[./-][0-9]{2}[./-][0-9]{4}$' 
        THEN DATE_FORMAT(STR_TO_DATE(REPLACE(REPLACE(f_incidencia, '.', '-'), '/', '-'), '%d-%m-%Y'), '%Y-%m-%d')    
    WHEN f_incidencia REGEXP '^[0-9]{4}[./-][0-9]{2}[./-][0-9]{2}$' 
        THEN DATE_FORMAT(STR_TO_DATE(REPLACE(REPLACE(f_incidencia, '.', '-'), '/', '-'), '%Y-%m-%d'), '%Y-%m-%d')
    WHEN f_incidencia REGEXP '^[0-9]{2}[./-][0-9]{2}[./-]26$' 
        THEN DATE_FORMAT(STR_TO_DATE(REPLACE(REPLACE(f_incidencia, '.', '-'), '/', '-'), '%d-%m-%y'), '%Y-%m-%d')
    WHEN f_incidencia REGEXP '^26[./-][0-9]{2}[./-][0-9]{2}$' 
        THEN DATE_FORMAT(STR_TO_DATE(REPLACE(REPLACE(f_incidencia, '.', '-'), '/', '-'), '%y-%m-%d'), '%Y-%m-%d')
    WHEN f_incidencia REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN f_incidencia
    ELSE NULL
END;

-- ROLLBACK TO incidencias_fechas;

SET SQL_SAFE_UPDATES = 1;

-- COMPROBAMOS 
SELECT f_incidencia FROM incidencias;

-- SANEAMOS COLUMNA COSTE ASOCIADO SUCIO
SAVEPOINT incidencias_coste;

SET SQL_SAFE_UPDATES = 0;

UPDATE incidencias
SET coste_asociado_sucio = REGEXP_REPLACE(TRIM(coste_asociado_sucio),'[^0-9]', '');

SET SQL_SAFE_UPDATES = 1;

-- ROLLBACK TO incidencias_coste;

-- COMPROBAMOS
SELECT coste_asociado_sucio FROM incidencias;

COMMIT;

-- HACEMOS COPIA DE SEGURIDAD INCREMENTAL
FLUSH LOGS;

SHOW MASTER STATUS;

-- EXAMEN MODELO 
SHOW TABLES;

-- EJERCICIO 1
SELECT * FROM mantenimientos_flota;

ALTER TABLE mantenimientos_flota
	ADD COLUMN coste_eur DECIMAL(10,2);
    
START TRANSACTION;

SAVEPOINT mantenimiento_flota_coste_eur;

SET SQL_SAFE_UPDATES = 0;

UPDATE mantenimientos_flota
SET coste_eur = CAST(REGEXP_REPLACE(coste_reparacion, '[^0-9]','') AS DECIMAL(10,2)) * 1.21;

SET SQL_SAFE_UPDATE = 1;

-- ROLLBACK TO mantenimiento_flota_coste_eur;

COMMIT;

-- EJERCICIO 2
SELECT * FROM almacenes;

-- PRIMERO SANEAMOS ALMACENES 
START TRANSACTION; 

SAVEPOINT sanear_cod_almacenes;

SET SQL_SAFE_UPDATES = 0;

UPDATE almacenes 
SET cod_almacen = REPLACE(TRIM(cod_almacen), '_', '');

UPDATE almacenes 
SET cod_almacen = CONCAT(SUBSTRING_INDEX(cod_almacen, '-', 1), '-', '0', SUBSTRING_INDEX(cod_almacen, '-', -1)) WHERE cod_almacen REGEXP '^ALM-[0-9]{2}$';

UPDATE almacenes 
SET cod_almacen = CONCAT(SUBSTRING_INDEX(cod_almacen, '-', 1), '-', '00', SUBSTRING_INDEX(cod_almacen, '-', -1)) WHERE cod_almacen REGEXP '^ALM-[0-9]{1}$';

SET SQL_SAFE_UPDATES = 1;

ROLLBACK TO sanear_cod_almacenes;

SELECT COUNT(cod_almacen) FROM almacenes GROUP BY id HAVING COUNT(cod_almacen) > 1;

FLUSH LOGS;

SHOW MASTER STATUS;