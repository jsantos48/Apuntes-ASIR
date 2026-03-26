use sakila;

-- 1) Obtener para cada idioma, cuántas películas tienen rating 'R'.
SELECT
	l.name AS Idioma,
    COUNT(f.title) AS Peliculas_R
FROM
	language l
		JOIN
	film f USING(language_id)
WHERE
	f.rating = 'R'
GROUP BY 
	Idioma;
    
/* 2) El **encargado de atención al cliente** quiere un listado de *todos* los
clientes registrados en el almacén 1 y el número de alquileres que han
hecho, incluyendo clientes sin alquileres. */
SELECT
	c.first_name AS Nombre,
    c.last_name AS Apellido,
    COUNT(rental_id) AS Num_alquileres
FROM
	customer c
		LEFT JOIN
	rental r USING(customer_id)
WHERE
	c.store_id = 1
GROUP BY 
	c.customer_id;
    
/* 3) El **gerente de la tienda** desea conocer qué clientes han realizado
alquileres de películas, sin incluir a aquellos que no han alquilado nada. */
SELECT
	c.first_name AS Nombre,
    c.last_name AS Apellido,
    COUNT(rental_id) AS Num_alquileres
FROM
	customer c
		JOIN
	rental r USING(customer_id)
WHERE
	rental_id IS NOT NULL
GROUP BY 
	c.customer_id;

-- 4) Obtener el título de la película más larga para cada una de las categorías.
SELECT
	c.name AS Categoria,
    f.title AS Titulo,
    f.length AS Duracion
FROM
	category c
		JOIN
	film_category fc USING(category_id)
		JOIN
	film f USING(film_id)
WHERE 
	f.length = (
    SELECT
		MAX(f2.length)
	FROM
		film f2
			JOIN
		film_category fc2 USING(film_id)
	WHERE
		fc.category_id = fc2.category_id
	);

-- 5) Obtener para cada país la suma de los pagos (amount) realizados en 2005.
SELECT
	co.country AS Pais,
    SUM(p.amount) AS Sum_pagos_2005
FROM 
	country co 
		JOIN
	city ci USING(country_id)
		JOIN
	address ad USING(city_id)
		JOIN
	customer c USING(address_id)
		JOIN
	payment p USING(customer_id)
WHERE
	YEAR(p.payment_date) = 2005
GROUP BY 
	Pais;