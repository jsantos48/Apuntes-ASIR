-- Consultas con subconsulta
-- 1) Película(s) más larga(s) por categoría
SELECT 
    category.name AS categoria,
    film.title AS titulo,
    film.length AS duracion
FROM 
	film 
		JOIN 
	film_category fc USING (film_id)
		JOIN 
	category USING (category_id)
WHERE film.length = (
    SELECT 
		MAX(film.length)
    FROM 
		film
			JOIN 
		film_category fc2 USING (film_id)
    WHERE fc2.category_id = fc.category_id
)
ORDER BY category.name ASC;

-- 2) Número de películas sin stock disponible en ninguna tienda
SELECT 
	COUNT(pelicula) AS num_unavailable_films
FROM
	(SELECT
		film_id AS pelicula
	FROM
		film
			LEFT JOIN
		inventory USING (film_id)
			LEFT JOIN
		store USING (store_id)
	WHERE store_id IS NULL
	GROUP BY film_id ) AS subc;
-- 3) Recaudación mensual por categoría en 2024
SELECT
	categoria,
    fecha,
    total_pago 
FROM (
	SELECT
		category_id AS categoria,
		payment_date fecha,
		SUM(payment.amount) total_pago
	FROM 
		category
			JOIN
		film_category USING (category_id)
			JOIN
		film USING (film_id)
			JOIN
		inventory USING (film_id)
			JOIN
		rental USING (inventory_id)
			JOIN
		payment USING (rental_id)
	GROUP BY categoria, fecha ) sub
WHERE YEAR(fecha) = 2024;