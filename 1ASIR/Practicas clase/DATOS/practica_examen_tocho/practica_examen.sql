USE logistica_global;

SHOW TABLES;

EXPLAIN incidencias;

SELECT * FROM incidencias;

START TRANSACTION;

SAVEPOINT incidencias_fecha;

SET SQL_SAFE_UPDATES = 0;

UPDATE incidencias
SET f_incidencia = CASE
    WHEN f_incidencia LIKE '____.__.__' THEN REPLACE(f_incidencia,'.','/')
    WHEN f_incidencia LIKE '____-__-__' THEN REPLACE(f_incidencia,'-','/')
    WHEN f_incidencia LIKE '__.__.____' THEN REPLACE(f_incidencia,'.','/')
    WHEN f_incidencia LIKE '__-__-____' THEN REPLACE(f_incidencia,'-','/')
    WHEN f_incidencia LIKE '__.__.__' THEN REPLACE(f_incidencia,'.','/')
    WHEN f_incidencia LIKE '__-__-__' THEN REPLACE(f_incidencia,'-','/')
    WHEN f_incidencia LIKE '____/%/%' AND LENGTH(f_incidencia) = 10 THEN DATE_FORMAT(STR_TO_DATE(f_incidencia, '%Y/%m/%d'), '%d/%m/%Y')
    WHEN f_incidencia LIKE '__/%/%' AND SUBSTRING(f_incidencia, 3, 1) = '/' AND LENGTH(f_incidencia) = 8 THEN DATE_FORMAT(STR_TO_DATE(f_incidencia, '%y/%m/%d'), '%d/%m/%Y')
	WHEN f_incidencia LIKE '__/__/__' AND LENGTH(f_incidencia) = 8 THEN DATE_FORMAT(STR_TO_DATE(f_incidencia, '%d/%m/%y'), '%d/%m/%Y')
	WHEN f_incidencia LIKE '__/__/____' AND LENGTH(f_incidencia) = 10 THEN DATE_FORMAT(STR_TO_DATE(f_incidencia, '%d/%m/%Y'), '%d/%m/%Y')
    ELSE f_incidencia
END;

UPDATE incidencias SET f_incidencia = CASE 
    WHEN f_incidencia LIKE '__/__/____' THEN STR_TO_DATE(f_incidencia, '%d/%m/%Y')
    WHEN f_incidencia LIKE '__-__-____' THEN STR_TO_DATE(f_incidencia, '%d-%m-%Y')
    WHEN f_incidencia LIKE '____-__-__' THEN STR_TO_DATE(f_incidencia, '%Y-%m-%d')
    WHEN f_incidencia LIKE '____/__/__' THEN STR_TO_DATE(f_incidencia, '%Y/%m/%d')
    WHEN f_incidencia LIKE '__/__/__'   THEN STR_TO_DATE(f_incidencia, '%d/%m/%y')
    WHEN f_incidencia LIKE '__-__-__'   THEN STR_TO_DATE(f_incidencia, '%d-%m-%y')
    WHEN f_incidencia LIKE '__-__-__' AND SUBSTRING(f_incidencia, 3, 1) = '-' THEN STR_TO_DATE(f_incidencia, '%y-%m-%d')
    WHEN f_incidencia LIKE '__/__/__' AND SUBSTRING(f_incidencia, 3, 1) = '/' THEN STR_TO_DATE(f_incidencia, '%y/%m/%d')
    ELSE NULL
    END;

SET SQL_SAFE_UPDATES = 1;
ROLLBACK TO incidencias_fecha;

