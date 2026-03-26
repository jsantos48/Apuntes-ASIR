SELECT 
    *
FROM
    pedidos
        JOIN
    pagos ON pedidos.id_pedido = pagos.id_pedido
WHERE
    YEAR(fecha_pedido) = 2023
        AND fecha_pago IS NOT NULL
        AND metodo_pago = 'tarjeta';
    
SELECT 
    *
FROM
    clientes
        JOIN
    pedidos ON clientes.id_cliente = pedidos.id_cliente
        JOIN
    detalle_pedido ON pedidos.id_pedido = detalle_pedido.id_pedido
WHERE
    nombre LIKE 'Ana Torres';


SELECT 
    clientes.pais, COUNT(pedidos.id_pedido) AS num_pedidos
FROM
    pedidos
        JOIN
    clientes ON clientes.id_cliente = pedidos.id_cliente
GROUP BY clientes.pais
ORDER BY COUNT(pedidos.id_pedido) DESC;

SELECT 
    productos.categoria,
    COUNT(DISTINCT (detalle_pedido.id_producto)) AS cantidad
FROM
    productos
        JOIN
    detalle_pedido ON detalle_pedido.id_producto = productos.id_producto
GROUP BY productos.categoria;

SELECT 
    productos.nombre
FROM
    clientes
        JOIN
    pedidos ON clientes.id_cliente = pedidos.id_cliente
        JOIN
    detalle_pedido ON detalle_pedido.id_pedido = pedidos.id_pedido
        JOIN
    productos ON productos.id_producto = detalle_pedido.id_producto
WHERE
    clientes.nombre = 'ana torres';
    
-- Obten el listado de los pedidos que han solicitado más de 10 productos en total

use tienda_online;

SELECT 
    id_pedido,
    COUNT(DISTINCT (id_producto)) AS productos_diferentes,
    SUM(cantidad) AS cantidad_total
FROM
    detalle_pedido
GROUP BY id_pedido
HAVING SUM(cantidad) > 10;

-- 1) Listado de cada id del pedido con el nombre del cliente que lo realizó.
	-- Orden: cliente ASC, y a igualdad de cliente por pedido ASC.
SELECT 
    clientes.nombre, pedidos.id_pedido
FROM
    pedidos
        JOIN
    clientes ON clientes.id_cliente = pedidos.id_cliente
ORDER BY clientes.nombre ASC , pedidos.id_pedido ASC; 

-- 2) Listado de cada línea de detalle con el nombre del producto y el id del pedido.
--    Columnas EXACTAS y alias:
--      - producto (pr.nombre)
--      - pedido   (dp.id_pedido)
--    Orden: producto ASC, y a igualdad de producto por pedido ASC.
SELECT 
    productos.nombre AS pr_nombre,
    detalle_pedido.id_pedido AS dp_id_pedido
FROM
    detalle_pedido
        JOIN
    productos ON productos.id_producto = detalle_pedido.id_producto
ORDER BY productos.nombre ASC , id_pedido ASC;

-- 3) Listar cada pedido con el nombre del cliente y su coste total.
--    Columnas EXACTAS y alias:
--      - cliente      (c.nombre)
--      - pedido       (p.id_pedido)
--      - coste_total  (p.coste_total)
--    Orden: coste_total DESC y, en empates, pedido ASC.
SELECT 
    clientes.nombre as "c.nombre", pedidos.id_pedido as "p.id_pedido", coste_total as "p.coste_total"
FROM
    pedidos
        JOIN
    clientes ON clientes.id_cliente = pedidos.id_cliente
		JOIN
	pagos ON pagos.id_pedido = pedidos.id_pedido
ORDER BY pedidos.coste_total DESC, pedidos.id_pedido ASC
LIMIT 10;

-- 4) Listar pedidos realizados a partir del 1 de enero de 2024 (incluido), con nombre del cliente y fecha.
--    Columnas y alias:
--      - pedido        (p.id_pedido)
--      - cliente       (c.nombre)
--      - fecha_pedido  (p.fecha_pedido)
--    Orden: fecha_pedido ASC; en empate, pedido ASC.
SELECT 
       pedidos.id_pedido AS "p.id_pedido",
       clientes.nombre AS "c.nombre",
    pedidos.fecha_pedido AS "p.fecha_pedido"
FROM
    pedidos
        JOIN
    clientes ON clientes.id_cliente = pedidos.id_cliente
WHERE
	pedidos.fecha_pedido >= "2024-01-01"
ORDER BY pedidos.fecha_pedido ASC, id_pedido ASC;

-- 5) Listar pedidos cuyo estado sea 'cancelado' o 'pendiente', con cliente y coste_total.
--    Columnas y alias:
--      - pedido       (p.id_pedido)
--      - cliente      (c.nombre)
--      - estado       (p.estado)
--      - coste_total  (p.coste_total)
--    Orden: estado ASC (ojo: no es orden alfabético. Ordena con otro criterio por el tipo de dato. Te lo contaré en clase), y dentro de cada estado coste_total DESC.

SELECT 
	pedidos.id_pedido AS "p.id_pedido",
    clientes.nombre AS "c.nombre",
    pedidos.estado AS "p.estado",
    pedidos.coste_total AS "p.coste_total"
FROM 
	pedidos
		JOIN
	clientes ON clientes.id_cliente = pedidos.id_cliente
    ORDER BY pedidos.estado ASC, pedidos.coste_total DESC;

-- 6) Listar pagos con su pedido y cliente, mostrando el método de pago.
--    Columnas y alias:
--      - pedido       (p.id_pedido)
--      - cliente      (c.nombre)
--      - metodo_pago  (pa.metodo_pago)
--    Orden: pedido ASC.

SELECT 
	pedidos.id_pedido AS "p.id_pedido",
    clientes.nombre AS "c.nombre",
    pagos.metodo_pago AS "pa.metodo_pago"
FROM 
	pagos 
		JOIN
	pedidos ON pedidos.id_pedido = pagos.id_pedido
		JOIN
    clientes ON clientes.id_cliente = pedidos.id_cliente
ORDER BY pedidos.id_pedido ASC;

-- 7) Listar las líneas del pedido con id 10, incluyendo nombre del producto, cantidad y precio unitario.
--    Columnas y alias:
--      - producto         (pr.nombre)
--      - cantidad         (dp.cantidad)
--      - precio_unitario  (dp.precio_unitario)
--    Orden: producto ASC.

SELECT 
	productos.nombre AS "pr.nombre",
	detalle_pedido.cantidad AS "dp.cantidad",
    detalle_pedido.precio_unitario AS "dp.precio_unitario"
FROM
	detalle_pedido
		JOIN
	productos ON productos.id_producto = detalle_pedido.id_producto
WHERE detalle_pedido.id_pedido = 10
ORDER BY productos.nombre ASC;

-- 8) Listar pedidos con estado 'entregado' con nombre del cliente y fecha del pedido.
--    Columnas y alias:
--      - pedido        (p.id_pedido)
--      - cliente       (c.nombre)
--      - fecha_pedido  (p.fecha_pedido)
--    Orden: fecha_pedido ASC; en empate, pedido ASC.

SELECT 
	pedidos.id_pedido AS "p.id_pedido",
    clientes.nombre AS "c.nombre",
	pedidos.fecha_pedido AS "p.fecha_pedido"
FROM
	pedidos 
		JOIN 
	clientes ON clientes.id_cliente = pedidos.id_cliente
WHERE pedidos.estado = "entregado"
ORDER BY pedidos.fecha_pedido ASC, pedidos.id_pedido ASC;

-- 9) Calcular la suma total pagada por cada pedido que tenga al menos un pago.
--    Columnas y alias:
--      - pedido        (p.id_pedido)
--      - total_pagado  (SUM(pa.total_pagado))
--    Agrupación: por p.id_pedido exclusivamente.
--    Orden: total_pagado DESC; en empate, pedido ASC.

SELECT 
	pedidos.id_pedido AS "p.id_pedido",
    SUM(pagos.total_pagado) AS "SUM(pa.total_pagado)"
FROM 
	pedidos
		JOIN
	pagos ON pagos.id_pedido = pedidos.id_pedido
	WHERE fecha_pago IS NOT NULL
GROUP BY pedidos.id_pedido
ORDER BY sum(pagos.total_pagado)DESC, pedidos.id_pedido ASC;

-- 10) Contar el número de pedidos realizados por cada cliente.
--     Columnas y alias:
--       - cliente        (c.nombre)
--       - total_pedidos  (COUNT(p.id_pedido))
--     Agrupación: por c.id_cliente y c.nombre (ambos campos, para evitar ambigüedad).
--     Orden: total_pedidos DESC; en empate, cliente ASC.
    
SELECT 
	clientes.nombre AS "c.nombre",
    count(pedidos.id_pedido) AS "(COUNT(p.id_pedido))"
FROM 
	pedidos
		JOIN
	clientes ON clientes.id_cliente = pedidos.id_cliente
GROUP BY clientes.id_cliente , clientes.nombre
ORDER BY count(pedidos.id_pedido) DESC, clientes.nombre ASC;

-- 11) Listar los clientes que poseen MÁS DE 3 pedidos (estrictamente > 3).
--     Columnas y alias:
--       - cliente        (c.nombre)
--       - total_pedidos  (COUNT(p.id_pedido))
--     Agrupación: por c.id_cliente y c.nombre.
--     Orden: total_pedidos DESC; en empate, cliente ASC.

SELECT 
	clientes.nombre AS "c.nombre",
    count(pedidos.id_pedido) AS "(COUNT(p.id_pedido))"
FROM 
	clientes 
		JOIN	
	pedidos ON pedidos.id_cliente = clientes.id_cliente
GROUP BY clientes.id_cliente, clientes.nombre
HAVING 	COUNT(pedidos.id_pedido) > 3
ORDER BY count(pedidos.id_pedido) DESC, clientes.nombre ASC;
-- 12) Calcular los ingresos totales por cada producto (cantidad * precio_unitario)
--     Columnas y alias:
--       - producto  (pr.nombre)
--       - ingresos  (SUM(dp.cantidad * dp.precio_unitario))
--     Agrupación: por pr.id_producto y pr.nombre.
--     Orden: ingresos DESC; en empate, producto ASC.

SELECT 
    productos.nombre AS producto,
    SUM(detalle_pedido.cantidad * detalle_pedido.precio_unitario) AS ingresos
FROM
    productos
        JOIN
    detalle_pedido ON detalle_pedido.id_producto = productos.id_producto
GROUP BY productos.id_producto , productos.nombre
ORDER BY   ingresos DESC , productos.nombre ASC;
