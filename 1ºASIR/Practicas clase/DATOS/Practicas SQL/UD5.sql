USE erp_logistica;

SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM pedidos;
SELECT * FROM productos;

-- Ejercicio 1:
-- 1) Ver qué está mal
SELECT COUNT(nombre_completo) FROM clientes WHERE nombre_completo LIKE ' %';

SELECT nombre_completo FROM clientes WHERE nombre_completo LIKE ' %';

-- 2) Intentar arreglar
SET SQL_SAFE_UPDATES = 0;
UPDATE clientes SET nombre_completo = 
	TRIM(nombre_completo);
SET SQL_SAFE_UPDATES = 1;

-- 3) Comprobar que está bien.
SELECT nombre_completo FROM clientes WHERE nombre_completo LIKE ' %';

SELECT nombre_completo FROM clientes;

-- Ejercicio 2:
-- 1) Ver qué está mal.
SELECT email FROM clientes;
    
-- 2) Intentar arreglarlo.
SET SQL_SAFE_UPDATES = 0;
UPDATE clientes SET email = 
	REPLACE(email, '.con', '.com');
SET SQL_SAFE_UPDATES = 1;

-- 3) Comprobar que está bien. 
SELECT email FROM clientes;
    
-- Ejercicio 3:
-- 1) Ver qué está mal
SELECT telefono FROM clientes;

-- 2) Arreglamos
SET SQL_SAFE_UPDATES = 0;
UPDATE clientes SET telefono = 
	REPLACE(REPLACE(telefono,' ',''),'-','');

UPDATE clientes SET telefono = 
	SUBSTRING(telefono,5,9) WHERE telefono LIKE '0034%';

UPDATE clientes SET telefono = 
	REPLACE(telefono,'+34','') WHERE telefono LIKE '+34%';
SET SQL_SAFE_UPDATES = 1;

-- 3) Comprobamos que funciona 
SELECT telefono FROM clientes;

-- Ejercicio 4:
-- 1) Ver qué está mal
SELECT * FROM pedidos;

-- 2) Arreglamos
SET SQL_SAFE_UPDATES = 0;
UPDATE pedidos SET estado = 
	UPPER(estado);
SET SQL_SAFE_UPDATES = 1;

-- 3) Comprobamos
SELECT estado FROM pedidos;

-- Ejercicio 5:
-- 1) Comprobamos 
SELECT precio_sucio FROM productos;

-- 2) Arreglamos
SET SQL_SAFE_UPDATES = 0;
UPDATE productos SET precio_sucio = TRIM(precio_sucio);
UPDATE productos SET precio_sucio = 
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(precio_sucio,'$',''),'€',''),'EUR',''),'Gratis','0'),',','.');
SET SQL_SAFE_UPDATES = 1;

-- Otra forma de hacerlo, haciendo cambios temporales para protegernos de inconvenientes.
-- 2 FORMAS DE CAMBIOS TEMPORALES: Staging y transacciones

-- STAGING: columna o tabla temporal. En este caso, vamos a crear una columna temporal en l aque ir guradando las modificaciones de precio_sucio
-- 1.1 Ver tipos de datos (Send to SQL editor -> Create statement)
/* CREATE TABLE `productos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `precio_sucio` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `precio_oferta` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categoria_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
); */ 

-- 1.2 
EXPLAIN productos;

-- 1) Añadimos una columna
ALTER TABLE productos
	ADD COLUMN precio_en_proceso VARCHAR(59);
EXPLAIN productos; -- comprobamos que se ha añadido
SELECT * FROM productos; -- vemos que está vacíalter

-- 2) Rellenamos la columna vacía
SET SQL_SAFE_UPDATES = 0;
UPDATE productos SET precio_en_proceso = REPLACE(precio_sucio, '$','');
SELECT * FROM productos; -- vemos que esta vacia
-- 15 afectadas, 15 matcheadas y 15 modificadas

UPDATE productos SET precio_en_proceso = REPLACE(precio_en_proceso,'€','');
-- 6 afectadas, 15 matcheadas y 6 modificadas.
SELECT * FROM productos;

UPDATE productos SET precio_en_proceso = REPLACE(precio_en_proceso,'EUR','');
UPDATE productos SET precio_en_proceso = REPLACE(precio_en_proceso,' ','');
UPDATE productos SET precio_en_proceso = REPLACE(precio_en_proceso,',','.');
UPDATE productos SET precio_en_proceso = REPLACE(precio_en_proceso,'Gratis','0.00');
SELECT* FROM productos;

UPDATE productos SET precio_sucio = precio_en_proceso;
SELECT * FROM productos;

ALTER TABLE productos
	DROP COLUMN precio_en_proceso;
    
SELECT * FROM productos;

SET SQL_SAFE_UPDATES = 1;

-- TRANSACCIONES:
START TRANSACTION; -- Todos los cambios de modificaciones (DML) son temporales (hastsa el commit) o reversibles (hasta el rollback)

SET SQL_SAFE_UPDATES = 0;

UPDATE productos SET precio_sucio = REPLACE(precio_sucio,'$','');
UPDATE productos SET precio_sucio = REPLACE(precio_sucio,'€','');
SELECT * FROM productos;
SAVEPOINT guardando_partida; -- sigo en la transaccion, por lo que todo es temporal. Si se va la luz, lo pierdo.
-- ROLLBACK; -- retrocede hasta el transaction
-- COMMIT; -- convierte en definitivos todos los cambios temporales DML que se hayan hecho desde el "start transaction"
SELECT * FROM productos;
-- SE VA LA LUZ
UPDATE productos SET precio_sucio = REPLACE(precio_sucio,'EUR','');
UPDATE productos SET precio_sucio = REPLACE(precio_sucio,' ','');
UPDATE productos SET precio_sucio = REPLACE(precio_sucio,',','.');
SELECT * FROM productos;
-- Me he equivocado, quiero Ctrl-Z, pero, no desde el principio. Vamos a "cargar la prtida guardada".
-- ROLLBACK TO guardando_partida;
SELECT * FROM productos;
UPDATE productos SET precio_sucio = REPLACE(precio_sucio,'Gratis','0.00');
COMMIT;
-- ROLLBACK

-- Ejercicio 9
EXPLAIN productos;
SELECT * FROM productos;
START TRANSACTION;
-- innecesario el set sql_safe_updates = 0
ALTER TABLE productos
	CHANGE COLUMN precio_sucio precio DECIMAL(10,2);
ROLLBACK; -- no ha funcionado
EXPLAIN productos;

-- ¿Distingues DDL de DML?
-- DDL define y estructura la base de datos, mientras que DML manipula los datos contenidos dentro de esa estructura

-- Modify cambia el tipo de DATO, rename cambia el nombre y change hace las dos cosas. 

-- Ejercicio 10: ERROR
SHOW TABLES;
SELECT * FROM pedidos;
SELECT STR_TO_DATE('3-5-2027','%d-%m-%Y');
SELECT STR_TO_DATE('3-5-2027','%d-%m-%Y');
SELECT STR_TO_DATE('3-5-27','%d-%m-%y'); -- 27 es 2027
SELECT STR_TO_DATE('3-5-70','%d-%m-%y'); -- 1970
SELECT STR_TO_DATE('3-5-69','%d-%m-%y'); -- 2069

SET SQL_SAFE_UPDATES = 0;
UPDATE pedidos 
	SET fecha_texto = STR_TO_DATE(fecha_texto,'%d/%m/%Y')
    /* WHERE fecha_texto LIKE '__/__/____'
		OR fecha_texto LIKE '_/_/____'
        OR fecha_texto LIKE '_/__/____'
        OR fecha_texto LIKE '__/_/____'; */
	WHERE fecha_texto LIKE '%/%/____'; -- este filtro es fundamental
UPDATE pedidos
	SET fecha_texto = STR_TO_DATE(fecha_texto,'%d-%m-%Y')
    WHERE fecha_texto LIKE '%-%-____'; -- este filtro es fundamental
UPDATE pedidos
	SET fecha_texto = STR_TO_DATE(fecha_texto,'%Y.%m.%d')
    WHERE fecha_texto LIKE '____.%.%'; -- este filtro es fundamental
SET SQL_SAFE_UPDATES = 1;
-- comprobamos cutremente
SELECT * FROM pedidos;
-- comprobamos bien
SELECT COUNT(*) FROM pedidos 
	WHERE fecha_texto LIKE '____-__-__';
    
-- ¿Cuantas hay mal?
SELECT 
	(SELECT COUNT(*) FROM pedidos) -
    (SELECT COUNT(*) FROM pedidos WHERE fecha_texto LIKE '____-__-__');
SELECT * FROM pedidos;

-- cambiar el tipo de dato:
ALTER TABLE pedidos
	CHANGE COLUMN fecha_texto fecha DATE;
EXPLAIN pedidos;

-- 11) PRODUCTOS HUERFANOS
SELECT * FROM productos;
SELECT * FROM categorias;

UPDATE productos
	SET categoria_id = 4 WHERE id = 4;
    
-- ¿Como se hace de forma general?
-- 1) ¿Que productos están huérfanos?
-- OPCION 1: LEFT JOIN
SELECT * FROM productos;
SELECT * FROM categorias;

SELECT * FROM productos 
	LEFT JOIN categorias ON productos.categoria_id = categorias.id
WHERE categorias.id IS NULL;

-- OPCION 2:
SELECT * FROM productos
	WHERE categoria_id NOT IN 
		(SELECT id FROM categorias);
	
-- UPDATE
SET SQL_SAFE_UPDATES = 0;
UPDATE productos
	SET categoria_id = 4
	WHERE categoria_id 
		NOT IN (SELECT id FROM categorias);
SET SQL_SAFE_UPDATES = 1;
    
-- 12) CLIENTES HUÉRFANOS
-- ES IGUAL QUE EL ANTERIOR

-- 13) Deduplicación de clientes:
/* Elimina duplicados manteniendo el ID más bajo.
Importante: Reasigna primero los pedidos de los clientes que vas 
a borrar para no perder el histórico. */

-- listado de clientes duplicados
SELECT id, email FROM clientes GROUP BY email HAVING COUNT(id) > 1;
SELECT min(id), email FROM clientes GROUP BY email HAVING COUNT(id) > 1;
SELECT  id FROM clientes 
	WHERE email IN (SELECT email FROM clientes 
		GROUP BY email HAVING COUNT(id) > 1);
SELECT * FROM pedidos;
-- solucion trampa
UPDATE pedidos
	SET cliente_id = 3 WHERE cliente_id IN (4,5); 

-- solucion MALA porque solo funciona si hay un único cliente repetido. 
-- Si solo hay uno repetido, entonces funciona
UPDATE pedidos 
	SET cliente_id = (SELECT 
							min(id)
						FROM
							clientes
						WHERE
							email IN (SELECT 
									email
								FROM
									clientes
								GROUP BY email
								HAVING COUNT(id) > 1))  
    WHERE cliente_id IN (SELECT 
							id
						FROM
							clientes
						WHERE
							email IN (SELECT 
									email
								FROM
									clientes
								GROUP BY email
								HAVING COUNT(id) > 1));

-- SOLUCION BUENA BUENISIMA
SELECT p.id AS pedido_id,
	p.cliente_id,
	c1.id AS c1_id,
    c1.email,
    c2.id AS c2_id,
    c2.email
FROM pedidos p 
	JOIN clientes c1 ON p.cliente_id = c1.id
    JOIN clientes c2 ON c1.email = c2.email;
-- Reasignación de pedidos
UPDATE pedidos p 
	JOIN clientes c1 ON p.cliente_id = c1.id
    JOIN clientes c2 ON c1.email = c2.email
SET p.cliente_id = c2.id WHERE c1.id > c2.id;

    
-- COMPROBAMOS: 
SELECT
	p.id AS pedido_id,
    p.cliente_id,
    c1.id AS c1_id,
    c1.email,
    c2.id AS c2_id,
    c2.email
FROM pedidos p 
	JOIN clientes c1 ON p.cliente_id = c1.id
    JOIN clientes c2 ON c1.email = c2.email;
    
-- TODO OJ
SELECT * FROM clientes;

-- Eliminación de duplicados
DELETE c1 FROM clientes c1 INNER JOIN clientes c2
	ON c1.email = c2.email WHERE c1.id > c2.id;
    
-- ROLLBACK;
COMMIT;

-- 2 Blindaje: Añade las restricciones de FOREIGN KEY a productos y pedidos

ALTER TABLE pedidos
	ADD CONSTRAINT fk_pedidos_clientes FOREIGN KEY(cliente_id) REFERENCES clientes(id)
    ON UPDATE CASCADE ON DELETE RESTRICT;
SELECT * FROM pedidos WHERE cliente_id NOT IN (SELECT id FROM clientes);
-- este constraint ha fallado porque hay pedidos que los han hecho clientes que no existen.
-- CONCLUSIÓN: No se puede aplicar un constraint sin antes haber limpiado los datos. Limpia los datos (2.3.2) y funcionará

ALTER TABLE productos
	ADD CONSTRAINT fk_productos_categorias FOREIGN KEY(categoria_id) REFERENCES categorias(id)
    ON UPDATE CASCADE ON DELETE RESTRICT;
-- COMPROBAMOS: Saca el diagrama database->reverse

-- 2.5.2. Consolidación de Precios: Crea precio_final y públalo usando COALESCE entre precio_oferta y precio
SELECT * FROM productos;
ALTER TABLE productos
	ADD COLUMN precio_final DECIMAL(10,2) AFTER precio_oferta;
SET SQL_SAFE_UPDATES = 0;
SELECT * FROM productos;
UPDATE productos
 -- SET precio_final = 1ª opción: precio_oferta. Si es nulo, entonces 2ª opción: precio. Si es nulo, entonces 3ª opción: 99999999.99
 -- SET precio_final = CASE WHEN ... THEN
SET precio_final = COALESCE(precio_oferta, precio, 99999999.99);
SET SQL_SAFE_UPDATES = 1;

