use sakila;
-- Consultas SQL con JOINs en la base de datos Sakila
-- Consulta 1: Clientes con al menos un alquiler
-- El gerente de la tienda desea conocer qué clientes han realizado alquileres de películas, sin incluir a aquellos que no han alquilado nada.
SELECT
	store_id AS tienda,
	customer.first_name AS nombre,
    customer.last_name AS apellidos,
    COUNT(rental_id) AS peliculas_alquiladas 
FROM
	customer
		LEFT JOIN
	rental USING (customer_id)
WHERE rental_id IS NOT NULL AND store_id = 1
GROUP BY customer_id
ORDER BY peliculas_alquiladas DESC;

-- Consulta 2: Todos los clientes y sus alquileres
-- El encargado de atención al cliente quiere un listado de todos los clientes registrados en el almacén 1 y el número de alquileres que han hecho, incluyendo clientes sin alquileres.
SELECT
	store_id AS tienda,
	customer.first_name AS nombre,
    customer.last_name AS apellidos,
    COUNT(rental_id) AS peliculas_alquiladas 
FROM
	customer
		INNER JOIN
	rental USING (customer_id)
		INNER JOIN
	store USING (store_id)
WHERE store_id = 1
GROUP BY customer_id;

-- Consulta 3: Actores y sus películas
-- El gerente de casting necesita un reporte de los actores y las películas en las que han actuado. Además, quiere incluir actores que aún no han participado en ninguna película.
SELECT
	actor.first_name AS nombre,
    actor.last_name AS apellido,
    film.title AS titulo
FROM
	actor
		LEFT JOIN
	film_actor USING (actor_id)
		LEFT JOIN
	film USING (film_id)
GROUP BY nombre, apellido, titulo;

-- Consulta 4: Categorías y películas
-- El analista de inventario requiere un informe que muestre todas las categorías de películas junto con las películas asignadas a cada categoría. 
-- Es posible que existan categorías sin ninguna película asignada y (aunque en Sakila es poco común) películas sin categoría.
SELECT
	category.name AS categorias,
    film.title AS pelicula
FROM
	category
		LEFT JOIN
	film_category USING (category_id)
		LEFT JOIN
	film USING (film_id)
UNION
SELECT
	category.name AS categorias,
    film.title AS pelicula
FROM
	category
		RIGHT JOIN
	film_category USING (category_id)
		RIGHT JOIN
	film USING (film_id)
GROUP BY category_id, film_id;

-- Consulta 5: Películas y sus actores
-- El director de contenido quiere un listado de las películas y los actores que participan en cada una, pero incluyendo películas que aún no tengan actor asignado.
SELECT
	film.title AS pelicula,
    actor.first_name AS nombre,
    actor.last_name AS apellido
FROM
	film
		LEFT JOIN
	film_actor USING (film_id)
		LEFT JOIN
	actor USING (actor_id)
GROUP BY film_id, actor_id;