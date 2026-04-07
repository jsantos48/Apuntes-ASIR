use sakila;
-- ==============================================
-- SECCIÓN A) 30 CONSULTAS CON JOIN DE 2 TABLAS
-- ==============================================
-- 1:  Para cada actor, muestra el número total de películas en las que aparece; es decir, cuenta cuántas filas de film_actor corresponden a cada actor.
SELECT 
    actor.first_name,
    actor.last_name,
    COUNT(film_actor.film_id) AS num_peliculas
FROM
    actor
        JOIN
    film_actor USING (actor_id)
GROUP BY actor.actor_id 
/* Para agruparlo por cada actor, se coge el id del actor para que coja toda la información, si se agrupara por el nombre, 
si hay nombres repetidos, cogería todos esos nombres.*/

-- 2:  Lista solo los actores que participan en 20 o más películas (umbral alto) con su conteo.
SELECT 
	actor.first_name, actor.last_name, count(film_actor.film_id) AS num_peliculas
FROM 
	actor
		JOIN
	film_actor USING(actor_id)
GROUP BY actor.actor_id
HAVING num_peliculas >= 20;

-- 3:  Para cada idioma, indica cuántas películas están catalogadas en ese idioma.
SELECT 
	language.name, count(film.film_id) AS num_peliculas
FROM 
	language
		JOIN
	film USING(language_id)
GROUP BY language.language_id;

-- 4:  Muestra el promedio de duración (length) de las películas por idioma y filtra aquellos idiomas con duración media estrictamente mayor a 110 minutos.
SELECT
	avg(film.length) AS promedio_duracion, language.name 
FROM 
	film
		JOIN
	language USING(language_id)
GROUP BY language.name
HAVING promedio_duracion > 110;
/*En este ejercicio tenemos que tener en cuenta que no solo clasificamos por idioma, como es el caso del ejercicio anterior,
sino que también por el tiempo, que se añade como un condicional a la hora de agrupar. En este caso, solo hay un idioma, 
por lo que solo habrá un resultado */

-- 5:  Para cada película, muestra cuántas copias hay en el inventario.
SELECT
	film.title, count(inventory.film_id) AS copias
FROM
	film
		JOIN
	inventory USING(film_id)
GROUP BY film.title;

-- 6:  Lista solo las películas que tienen al menos 5 copias en inventario.
SELECT
	film.title, count(inventory.film_id) AS copias
FROM
	film
		JOIN
	inventory USING(film_id)
GROUP BY film.title
HAVING copias >= 5;
/* Este ejercicio se realiza de la misma manera que el anterior, lo único que cambia es que queremos mostrar las únicas películas cuyas copias sean al menos 
de 5 en el inventario. Por ende, añadimos "having", para que tenga esto en cuenta a la hora de agruparlo
*/

-- 7:  Para cada artículo de inventario, cuenta cuántos alquileres se han realizado.
SELECT 
	inventory_id, count(rental_id) AS num_alquileres
FROM 
	inventory
		JOIN
	rental USING(inventory_id)
GROUP BY inventory_id;

-- 8:  Para cada cliente, muestra cuántos alquileres ha realizado en total.
SELECT
	customer.first_name, customer.last_name, count(rental_id) AS num_alquileres
FROM 
	customer
		JOIN
	rental USING(customer_id)
GROUP BY customer_id;
/* ATENCIÓN: si usas "rental_id", no te contará la cantidad de alquileres que ha hecho cada cliente, hay que hacerlo con el "customer_id", para que lo agrupe 
por el cliente y cuente cuantos alquileres ha hecho cada uno. */

-- 9:  Lista los clientes con 30 o más alquileres acumulados.
SELECT
	customer.first_name, customer.last_name, count(rental_id) AS num_alquileres
FROM 
	customer
		JOIN
	rental USING(customer_id)
GROUP BY customer_id
HAVING num_alquileres >= 30;
/* Este ejercicio es el mismo que el anterior con la diferencia que esta vez nos pide mostrar los clientes que tengan 30 o más alquileres, por ello usamos 
"having". */

-- 10:  Para cada cliente, muestra el total de pagos (suma en euros/dólares) que ha realizado.
SELECT 
	customer.first_name, customer.last_name, sum(payment.amount)  AS total_pagado 
FROM 
	customer
		JOIN
	payment USING(customer_id)
GROUP BY customer_id;

-- 11:  Muestra los clientes cuyo importe total pagado es al menos 200.
SELECT 
	customer.first_name, customer.last_name, sum(payment.amount)  AS total_pagado 
FROM 
	customer
		JOIN
	payment USING(customer_id)
GROUP BY customer_id
HAVING total_pagado >= 200;
/* El procedimineto de este ejercicio es el mismo que el anterior. Sin embargo, como se ha hecho en anteriores ejercicios, se le añade un condicional para que agrupe aquellos clientes que superen un 
importe de al menos 200 */

-- 12:  Para cada empleado (staff), muestra el número de pagos que ha procesado.
SELECT 
	staff.first_name, staff.last_name, count(payment_id) AS pagos_procesasdos
FROM 
	staff 
		JOIN
	payment USING(staff_id)
GROUP BY staff_id;
/* ATENCIÓN: no buscas la cantidad de dinero, sino la cantidad de pagos que se han supervisado */

-- 13:  Para cada empleado, muestra el importe total procesado.
SELECT 
	staff.first_name, staff.last_name, sum(payment.amount) AS importe_total
FROM 
	staff 
		JOIN
	payment USING(staff_id)
GROUP BY staff_id;
/* Este ejercicio es muy similar al anterior, ya que la única diferencia que tienen es que uno busca sumar la cantidad de dinero procesado (sum(payment.amount)) y el otro la cantidad de pedidos
(count(payment.id)) */

-- 14:  Para cada tienda, cuenta cuántos artículos de inventario tiene.
SELECT 
	store_id, count(inventory_id) AS inventario 
FROM
	store
		JOIN
	inventory USING(store_id)
GROUP BY store_id;

-- 15:  Para cada tienda, cuenta cuántos clientes tiene asignados.
SELECT 
	store_id, count(customer_id) AS clientes
FROM 
	store
		JOIN
	customer USING(store_id)
GROUP BY store_id;

-- 16:  Para cada tienda, cuenta cuántos empleados (staff) tiene asignados.
SELECT 
	store_id, count(staff_id) AS empleados
FROM 
	store 
		JOIN
	staff USING(store_id)
GROUP BY store_id;

-- 17:  Para cada dirección (address), cuenta cuántas tiendas hay ubicadas ahí (debería ser 0/1 en datos estándar).
SELECT 
	address, count(store_id) AS tiendas
FROM
	address 
		JOIN
	store USING(address_id)
GROUP BY store_id;

-- 18:  Para cada dirección, cuenta cuántos empleados residen en esa dirección.
SELECT 
	address, count(staff_id) AS empleados
FROM 
	address 
		JOIN
	staff USING(address_id)
GROUP BY address;

-- 19:  Para cada dirección, cuenta cuántos clientes residen ahí.
SELECT 
	address, count(customer_id) AS clientes
FROM
	address
		JOIN
	customer USING(address_id)
GROUP BY address;

-- 20:  Para cada ciudad, cuenta cuántas direcciones hay registradas.
SELECT 
	city, count(address) AS direcciones
FROM
	city
		JOIN
	address USING(city_id)
GROUP BY city;

-- 21:  Para cada país, cuenta cuántas ciudades existen.
SELECT 
	country, count(city_id) AS ciudades
FROM
	country
		JOIN
	city USING(country_id)
GROUP BY country;

-- 22:  Para cada idioma, calcula la duración media de películas y muestra solo los idiomas con media entre 90 y 120 inclusive.
SELECT 
	language.name, 
    avg(film.length) AS media_duracion
FROM
	language
		JOIN
	film USING(language_id)
GROUP BY language.name
HAVING media_duracion BETWEEN 90 AND 120;

-- 23:  Para cada película, cuenta el número de alquileres que se han hecho de cualquiera de sus copias (usando inventario).
SELECT 
	film.title, 
    count(rental_id) AS num_alquileres
FROM 
	film
		JOIN
	inventory USING(film_id)
		JOIN
	rental USING(inventory_id)
GROUP BY film.title;
/* En este caso no se puede hacer solo con 2 tablas ya que no podemos sacar el id de los alquileres con la tabla "inventory" */

-- 24:  Para cada cliente, cuenta cuántos pagos ha realizado en 2005 (usando el año de payment_date).
SELECT
	customer.first_name, customer.last_name, count(payment_id) AS pagos_realizados_2005
FROM
	customer 
		JOIN
	payment USING(customer_id)
WHERE YEAR(payment_date) = 2005
GROUP BY customer_id;

-- 25:  Para cada película, muestra el promedio de tarifa de alquiler (rental_rate) de las copias existentes (es un promedio redundante pero válido).
SELECT
	film.title, AVG(rental_rate) AS tarifa_promedio
FROM
	film
GROUP BY film.title;

-- 26:  Para cada actor, muestra la duración media (length) de sus películas.
SELECT
	first_name,last_name, AVG(film.length) AS duracion_media
FROM
	actor
		JOIN
	film_actor USING(actor_id)
		JOIN
	film USING(film_id)
GROUP BY actor_id;
/* En este caso no se puede hacer con 2 tablas ya que necesitamos tanto los nombres de los actores como la longitud de la pelicula y para ello necesitamos coger ambas tablas */

-- 27:  Para cada ciudad, cuenta cuántos clientes hay (usando la relación cliente->address->city requiere 3 tablas; aquí contamos direcciones por ciudad).
SELECT 
	city, count(customer_id) AS clientes
FROM
	customer
		JOIN
	address USING(address_id)
		JOIN
	city USING(city_id)
GROUP BY city;
/* En este caso no se puede hacer con 2 tablas ya que necesitamos el nombre de la ciudad, por lo que tambien hay que cojer dicha tabla */

-- 28:  Para cada película, cuenta cuántos actores tiene asociados.
SELECT
	film.title, count(actor_id) AS actor
FROM
	film
		JOIN
	film_actor USING(film_id)
GROUP BY film.title;

-- 29:  Para cada categoría (por id), cuenta cuántas películas pertenecen a ella (sin nombre de categoría para mantener 2 tablas).
SELECT
	category_id, count(film_id) AS peliculas
FROM 
	film
		JOIN
	film_category USING(film_id)
GROUP BY category_id;

-- 30:  Para cada tienda, cuenta cuántos alquileres totales se originan en su inventario.
SELECT 
	store_id, count(rental_id) AS alquileres_totales
FROM
	inventory 
		JOIN
	rental USING(inventory_id)
GROUP BY store_id;

-- ==============================================
-- SECCIÓN B) 30 CONSULTAS CON JOIN DE 3 TABLAS
-- ==============================================
-- 31:  Para cada actor, cuenta cuántas películas tiene y muestra solo los que superan 15 películas.
SELECT 
	actor.first_name, actor.last_name, count(film_id) AS peliculas
FROM
	actor
		JOIN
	film_actor USING(actor_id)
		JOIN
	film USING(film_id)
GROUP BY actor_id
HAVING peliculas > 15;
/* ATENCIÓN: se usa el id del actor para agrupar, no el de las películas, ya que queremos saber cuantas peliculas tiene cada actor, no al revés. */

-- 32:  Para cada categoría (por nombre), cuenta cuántas películas hay en esa categoría.
SELECT 
    category.name, COUNT(film_id) AS peliculas
FROM
    category
        JOIN
    film_category USING (category_id)
        JOIN
    film USING (film_id)
GROUP BY category_id;

-- 33:  Para cada película, cuenta cuántos alquileres se han hecho de sus copias.
SELECT 
    film.title, COUNT(rental_id) AS alquileres_totales
FROM
    film
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
GROUP BY film_id;

-- 34:  Para cada cliente, suma el importe pagado en 2005 y filtra clientes con total >= 150.
SELECT 
    customer.first_name,
    customer.last_name,
    SUM(payment.amount) AS importe_pagado_2005
FROM
    customer
        JOIN
    payment USING (customer_id)
WHERE
    YEAR(payment_date) = 2005
GROUP BY customer_id
HAVING importe_pagado_2005 >= 150;

-- 35:  Para cada tienda, suma el importe cobrado por todos sus empleados.
SELECT 
    store_id, SUM(payment.amount) AS importe_cobrado
FROM
    store
        JOIN
    staff USING (store_id)
		JOIN
	payment USING(staff_id)
GROUP BY store_id;

-- 36:  Para cada ciudad, cuenta cuántos empleados residen ahí (staff -> address -> city).
SELECT 
	city,
    COUNT(staff_id) AS empleados
FROM
	city
		JOIN
	address USING(city_id)
		JOIN
	staff USING(address_id)
GROUP BY city_id;

-- 37:  Para cada ciudad, cuenta cuántas tiendas existen (store -> address -> city).
SELECT 
	city,
    COUNT(store_id) AS tiendas
FROM
	city
		JOIN
	address USING(city_id)
		JOIN
	store USING(address_id)
GROUP BY city_id;

-- 38:  Para cada actor, calcula la duración media de sus películas del año 2006.
SELECT 
	actor.first_name, 
    actor.last_name,
    AVG(film.length) AS media_duracion
FROM
	actor
		JOIN
	film_actor USING(actor_id)
		JOIN
	film USING(film_id) 
WHERE
	YEAR(release_year) = 2006
GROUP BY actor_id;
/* No me aparece ningun resultado y no encuentro el error, ya que según las soluciones debería de haber resultados */

-- 39:  Para cada categoría, calcula la duración media y muestra solo las que superan 120.
SELECT
	category.name,
    AVG(film.length) AS duracion_media
FROM 
	category
		JOIN
	film_category USING(category_id)
		JOIN
	film USING(film_id)
GROUP BY category_id
HAVING
	duracion_media > 120;
    
-- 40:  Para cada idioma, suma las tarifas de alquiler (rental_rate) de todas sus películas.
SELECT
	language.name,
    SUM(rental_rate) AS tarifa
FROM
	language
		JOIN
	film USING(language_id)
		JOIN
	inventory USING(film_id)
GROUP BY language_id;

-- 41:  Para cada cliente, cuenta cuántos alquileres realizó en fines de semana (SÁB-DO) usando DAYOFWEEK (1=Domingo).
SELECT
	first_name, 
    last_name, 
    COUNT(DAYOFWEEK(rental_date)) AS alquileres_findesemana
FROM
	customer
		JOIN
	rental USING(customer_id)
WHERE DAYOFWEEK(rental_date) IN(1,7)
GROUP BY customer_id;

-- 42:  Para cada actor, muestra el total de títulos distintos en los que participa (equivale a COUNT DISTINCT, sin subconsulta).
SELECT
	first_name,
    last_name,
    COUNT(DISTINCT(film.title)) AS titulos_distintos
FROM 
	actor
		JOIN
	film_actor USING(actor_id)
		JOIN
	film USING(film_id)
GROUP BY actor_id;

-- 43:  Para cada ciudad, cuenta cuántos clientes residen ahí (customer -> address -> city).
SELECT
	city,
    COUNT(customer_id) AS clientes
FROM 
	customer
		JOIN
	address USING(address_id)
		JOIN
	city USING(city_id)
GROUP BY city;

-- 44:  Para cada categoría, muestra cuántos actores distintos participan en películas de esa categoría.
SELECT
	category.name,
    COUNT(DISTINCT(actor_id)) AS actores
FROM
	category
		JOIN
	film_category USING(category_id)
		JOIN
	film USING(film_id)
		JOIN
	film_actor USING(film_id)
GROUP BY category.name;
/* En este caso no se puede hacer con 3 tablas ya que el nombre de las categorías */

-- 45:  Para cada tienda, cuenta cuántas copias totales (inventario) tiene de películas en 2006.
SELECT
	store_id,
    COUNT(inventory_id) AS copiar_totales
FROM
	store
		JOIN
	inventory USING(store_id)
		JOIN
	film USING(film_id)
WHERE release_year = 2006
GROUP BY store_id;

-- 46:  Para cada cliente, suma el total pagado por alquileres cuyo empleado pertenece a la tienda 1.
SELECT
	customer.first_name,
    customer.last_name,
    SUM(payment.amount) AS total_pagado
FROM
	customer 
		JOIN
	payment USING(customer_id)
		JOIN
	store USING(store_id)
WHERE staff_id = 1
GROUP BY customer_id;

-- 47:  Para cada película, cuenta cuántos actores tienen el apellido de longitud >= 5.
SELECT 
	film.title,
    COUNT(actor_id) AS actores
FROM 
	actor
		JOIN
	film_actor USING (actor_id)
		JOIN
	film USING(film_id)
WHERE 
	LENGTH(last_name) >= 5
GROUP BY title;

-- 48:  Para cada categoría, suma la duración total (length) de sus películas.
SELECT 
	category.name,
    SUM(length) AS duracion_total
FROM
	film
		JOIN
	film_category USING(film_id)
		JOIN
	category USING(category_id)
GROUP BY category_id;

-- 49:  Para cada ciudad, suma los importes pagados por clientes que residen en esa ciudad.
SELECT 
	city,
    SUM(amount) AS importes_pagados
FROM
	city 
		JOIN
	address USING(city_id)
		JOIN
	customer USING(address_id)
		JOIN
	payment USING(customer_id)
GROUP BY city_id;
/* En este caso no se puede hacer con 3 tablas */

-- 50:  Para cada idioma, cuenta cuántos actores distintos participan en películas de ese idioma.
SELECT 
	language.name,
    COUNT(DISTINCT(actor_id)) AS actores_distintos
FROM
	language
		JOIN
	film USING(language_id)
		JOIN
	film_actor USING(film_id)
GROUP BY language_id;

-- 51:  Para cada tienda, cuenta cuántos clientes activos (active=1) tiene.
SELECT 
	store_id,
    COUNT(customer_id) AS clientes_activos
FROM 
	customer
		JOIN
	store USING(store_id)
WHERE
	customer.active=1
GROUP BY store_id;

-- 52:  Para cada cliente, cuenta en cuántas categorías distintas ha alquilado (aprox. vía film_category; requiere 4 tablas, aquí contamos películas 2006 por inventario).
SELECT
	customer.first_name,
    customer.last_name,
    COUNT(DISTINCT(category_id)) AS categorias_alquiladas
FROM
	customer
		JOIN
	rental USING(customer_id)
		JOIN
	inventory USING(inventory_id)
		JOIN
	film USING(film_id)
		JOIN 
	film_category USING(film_id)
WHERE
	YEAR(rental_date)= 2006
GROUP BY customer_id;

-- 53:  Para cada empleado, cuenta cuántos clientes diferentes le han pagado.
SELECT
	staff.first_name,
    staff.last_name,
    COUNT(DISTINCT(payment.customer_id)) AS clientes_diferentes
FROM
	staff
		JOIN
	store USING(store_id)
		JOIN
	payment USING(staff_id)
GROUP BY staff.staff_id;

-- 54:  Para cada ciudad, cuenta cuántas películas del año 2006 han sido alquiladas por residentes en esa ciudad.
SELECT
	city,
    COUNT(film_id) AS peliculas_alquiladas
FROM
	city
		JOIN
	address USING(city_id)
		JOIN
	customer USING(address_id)
		JOIN
	rental USING(customer_id)
		JOIN
	inventory USING(inventory_id)
		JOIN
	film USING(film_id)
WHERE
	YEAR(rental_date) = 2006
GROUP BY city_id;

-- 55:  Para cada categoría, calcula el promedio de replacement_cost de sus películas.
SELECT
	category.name,
    AVG(replacement_cost) AS replacement_cost
FROM
	category
		JOIN
	film_category USING(category_id)
		JOIN
	film USING(film_id)
GROUP BY category_id;

-- 56:  Para cada tienda, suma los importes cobrados en 2006 (vía empleados de esa tienda).
SELECT
	store_id,
    SUM(payment.amount) AS importes_cobrados
FROM
	store
		JOIN
	staff USING(store_id)
		JOIN
	payment USING(staff_id)
WHERE 
	YEAR(payment_date) = 2006
GROUP BY store_id;

-- 57:  Para cada actor, cuenta cuántas películas tienen título de más de 12 caracteres.
SELECT	
	actor.first_name,
    actor.last_name,
    COUNT(film_id) AS peliculas
FROM
	actor
		JOIN
	film_actor USING(actor_id)
		JOIN
	film USING(film_id)
WHERE LENGTH(film.title) > 12
GROUP BY actor_id;

-- 58:  Para cada ciudad, calcula la suma de pagos de 2005 y filtra las ciudades con total >= 300.
SELECT
	city,
	SUM(payment.amount) AS pagos_2005
FROM
	city 
		JOIN
	address USING(city_id)
		JOIN
	customer USING(address_id)
		JOIN
	payment USING(customer_id)
GROUP BY city_id
HAVING
	pagos_2005 >= 300;

-- 59:  Para cada categoría, cuenta cuántas películas tienen rating 'PG' o 'PG-13'.
SELECT
	category.name,
	COUNT(film_id) AS peliculas
FROM 
	film 
		JOIN
	film_category USING(film_id)
		JOIN
	category USING(category_id)
WHERE
	rating LIKE 'PG' OR rating LIKE 'PG-13'
GROUP BY category_id;

-- 60:  Para cada cliente, calcula el total pagado en pagos procesados por el empleado 2.
SELECT
	customer.first_name,
    customer.last_name,
    SUM(payment.amount) AS total_pagado
FROM
	customer 
		JOIN
	payment USING(customer_id)
		JOIN
	staff USING(staff_id)
WHERE staff_id = 2
GROUP BY customer_id;
/* Es igual que el ejercicio 46, sin embargo aquí buscas los pagos procesados por el empleado 2 y en el otro por el empleado 1 */

-- ==============================================
-- SECCIÓN C) 20 CONSULTAS CON JOIN DE 4 TABLAS
-- ==============================================
-- 61:  Para cada ciudad, cuenta cuántos clientes hay y muestra solo ciudades con 10 o más clientes.
SELECT
	city,
    COUNT(customer_id) AS clientes
FROM 
	city
		JOIN
	address USING(city_id)
		JOIN
	customer USING(address_id)
GROUP BY city_id
HAVING 
	clientes >= 10;

-- 62:  Para cada actor, cuenta cuántos alquileres totales suman todas sus películas.
SELECT 
    actor.first_name,
    actor.last_name,
    COUNT(payment.amount) AS alquileres_totales
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
        JOIN
    payment USING (rental_id)
GROUP BY actor_id;
/* Comparando algunos resultados con las soluciones, coinciden. Sin embargo, el orden no es el mismo y desconozco el porque */

-- 63:  Para cada categoría, suma los importes pagados derivados de películas de esa categoría.
SELECT 
	category.name,
    SUM(payment.amount) AS importes_pagados
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
GROUP BY category_id;

-- 64:  Para cada ciudad, suma los importes pagados por clientes residentes en esa ciudad en 2005.
SELECT
	city,
    SUM(payment.amount) AS importes_pagados
FROM 
	customer
		JOIN
	address USING (address_id)
		JOIN
	city USING (city_id)
		JOIN
	payment USING (customer_id)
GROUP BY city_id;
/* A la hora de comprobar los resultados, la mayoría están bien, pero hay algunos que superan o le faltan poco para obtener el resultado esperado
(por ejemplo, si se espera 17$ a mi me aparece 18$), como es el caso de Nantou o Masqat */

-- 65:  Para cada tienda, cuenta cuántos actores distintos aparecen en las películas de su inventario.
SELECT
	store_id,
    COUNT(DISTINCT(actor_id)) 
FROM
	actor
		JOIN
	film_actor USING (actor_id)
		JOIN
	film USING (film_id)
		JOIN
	inventory USING (film_id)
		JOIN
	store USING (store_id)
GROUP BY store_id;

-- 66:  Para cada idioma, cuenta cuántos alquileres totales se han hecho de películas en ese idioma.
SELECT 
	language.name,
    COUNT(rental_id)
FROM
	language 
		JOIN
	film USING (language_id)
		JOIN
	inventory USING (film_id)
		JOIN
	rental USING (inventory_id)
GROUP BY language_id;

-- 67:  Para cada cliente, cuenta en cuántos meses distintos de 2005 realizó pagos (meses distintos).
SELECT
	customer.first_name,
    customer.last_name,
    COUNT(DISTINCT(MONTH(payment_date))) AS pagos_distintos_meses
FROM
	customer
		JOIN
	payment USING (customer_id)
GROUP BY customer_id;
/* Aquí tengo el mismo problema de antes, hay clientes que me aprecen con un mes más que en las soluciones */

-- 68:  Para cada categoría, calcula la duración media de las películas alquiladas (considerando solo películas alquiladas).
SELECT
	category.name,
    AVG(film.length) AS media_duracion
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
GROUP BY category_id;
		
-- 69:  Para cada país, cuenta cuántos clientes hay (country -> city -> address -> customer).
SELECT
	country,
    COUNT(customer_id) AS clientes
FROM
	country 
		JOIN
	city USING (country_id)
		JOIN 
	address USING (city_id)
		JOIN
	customer USING (address_id)
GROUP BY country_id;

-- 70:  Para cada país, suma los importes pagados por sus clientes.
SELECT 
	country,
    SUM(payment.amount) AS importe_pagado
FROM 
	country 
		JOIN
	city USING (country_id)
		JOIN 
	address USING (city_id)
		JOIN
	customer USING (address_id)
		JOIN
	payment USING (customer_id)
GROUP BY country_id;

-- 71:  Para cada tienda, cuenta cuántas categorías distintas existen en su inventario.
SELECT 
	store_id,
    COUNT(DISTINCT(category_id)) AS categorias_distintas
FROM
	category
		JOIN
	film_category USING (category_id)
		JOIN
	film USING (film_id)
		JOIN
	inventory USING (film_id)
		JOIN
	store USING (store_id)
GROUP BY store_id;
-- 72:  Para cada tienda, suma la recaudación por categoría (resultado agregado por tienda y categoría).
SELECT 
	store_id,
    category.name,
	SUM(payment.amount) AS recaudacion
FROM
	category 
		JOIN
	film_category USING (category_id)
		JOIN
	film USING (film_id)
		JOIN
	inventory USING (film_id)
		JOIN
	store USING (store_id)
	    JOIN
	rental USING (inventory_id)
		JOIN	
	payment USING (rental_id)
GROUP BY store_id, category_id
ORDER BY category.name ASC;
/* No me salen exactamente los mismos resultados por poco */

-- 73:  Para cada actor, cuenta en cuántas tiendas distintas se han alquilado sus películas.
SELECT 
	actor.first_name,
    actor.last_name,
    COUNT(DISTINCT(store_id)) AS alquiler_peliculas
FROM
	actor
		JOIN
	film_actor USING (actor_id)
		JOIN
	film USING (film_id)
		JOIN
	inventory USING (film_id)
		JOIN
	store USING (store_id)
GROUP BY actor_id;

-- 74:  Para cada categoría, cuenta cuántos clientes distintos han alquilado películas de esa categoría. 
SELECT 
	category.name,
    COUNT(DISTINCT(customer_id)) AS clientes_por_alquiler
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
	customer USING (customer_id)
GROUP BY category_id;
	

-- 75:  Para cada idioma, cuenta cuántos actores distintos participan en películas alquiladas en ese idioma.
SELECT 
	language.name,
    COUNT(DISTINCT(actor_id)) AS actores_participantes
FROM
	language 
		JOIN
	film USING (language_id)
		JOIN
	film_actor USING (film_id)
		JOIN
	actor USING (actor_id)
		JOIN
	inventory USING (film_id)
		JOIN
	rental USING (inventory_id)
GROUP BY language_id;
        
-- 76:  Para cada país, cuenta cuántas tiendas hay (país->ciudad->address->store).
SELECT 
	country,
	COUNT(store_id) AS tiendas
FROM 
	store
		JOIN
	address USING (address_id)
		JOIN
	city USING (city_id)
		JOIN
	country USING (country_id)
GROUP BY country_id;

-- 77:  Para cada cliente, cuenta los alquileres en los que la devolución (return_date) fue el mismo día del alquiler.
SELECT
	customer.first_name,
	customer.last_name,
    COUNT(rental_id) AS devolucion_alquiler
FROM
	customer
		JOIN
	rental USING (customer_id)
WHERE
	DAY(return_date) = DAY(rental_date)
GROUP BY customer_id;

-- 78:  Para cada tienda, cuenta cuántos clientes distintos realizaron pagos en 2005.
SELECT
	store_id,
    COUNT(DISTINCT(payment.customer_id)) AS pagos_2005
FROM
	store 
		JOIN
	inventory USING (store_id)
		JOIN
	rental USING (inventory_id)
		JOIN
	payment USING (rental_id)
WHERE 
	YEAR(payment_date) = 2005
GROUP BY store_id;

-- 79:  Para cada categoría, cuenta cuántas películas con título de longitud > 15 han sido alquiladas.
SELECT
	category.name,
    COUNT(film_id) AS longitud_titulo
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
WHERE
	LENGTH(film.title) > 15 
GROUP BY category.name;

-- 80:  Para cada país, suma los pagos procesados por los empleados de las tiendas ubicadas en ese país.
SELECT 
	country,
    SUM(payment.amount) AS pagos_procesados
FROM
	country
		JOIN
	city USING (country_id)
		JOIN
	address USING (city_id)
		JOIN
	store USING (address_id)
		JOIN
	staff USING (store_id)
		JOIN
	payment USING (staff_id)
GROUP BY country_id;

-- ==============================================
-- SECCIÓN D) 20 CONSULTAS EXTRA (DIFICULTAD +), <=4 JOINS
-- ==============================================
-- 81:  Para cada cliente, muestra el total pagado con IVA teórico del 21% aplicado (total*1.21), redondeado a 2 decimales.
SELECT
	customer.first_name,
    customer.last_name,
    ROUND(SUM(payment.amount)*1.21, 2) AS total_pagado_IVA
FROM
	customer
		JOIN
	payment USING (customer_id)
GROUP BY customer_id;

-- 82:  Para cada hora del día (0-23), cuenta cuántos alquileres se iniciaron en esa hora.
SELECT
	HOUR(rental_date) AS hora,
    COUNT(rental_id) AS alquileres
FROM
	rental
GROUP BY hora
ORDER BY hora ASC;

-- 83:  Para cada tienda, muestra la media de length de las películas alquiladas en 2005 y filtra las tiendas con media >= 100.
SELECT
	store_id,
    AVG(length) AS media_duracion
FROM
	store
		JOIN
	inventory USING (store_id)
		JOIN
	rental USING (inventory_id)
		JOIN
	film USING (film_id)
WHERE YEAR(rental_date) = 2005
GROUP BY store_id
HAVING media_duracion >= 100;

-- 84:  Para cada categoría, muestra la media de replacement_cost de las películas alquiladas un domingo.
SELECT 
	category.name,
    AVG(replacement_cost) AS reabastecimiento
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
WHERE DAYOFWEEK(rental_date) = 1
GROUP BY category_id;

-- 85:  Para cada empleado, muestra el importe total por pagos realizados entre las 00:00 y 06:00 (inclusive 00:00, exclusivo 06:00).
SELECT
	staff.first_name,
    staff.last_name,
    SUM(payment.amount) AS importe_total
FROM
	staff
		JOIN
	payment USING (staff_id)
WHERE TIME(payment_date) BETWEEN '00:00 'AND '06:00'
GROUP BY staff_id;

-- 86:  Para cada actor, cuenta cuántas de sus películas tienen un título que contiene la palabra 'LOVE' (mayúsculas).
SELECT
	actor.first_name,
    actor.last_name,
    COUNT(film_id) AS peliculas
FROM 
	actor
		JOIN
	film_actor USING (actor_id)
		JOIN
	film USING (film_id)
WHERE title LIKE '%LOVE%'
GROUP BY actor_id
ORDER BY actor_id ASC;

-- 87:  Para cada idioma, muestra el total de pagos de alquileres de películas en ese idioma.
SELECT 
	language.name,
    SUM(payment.amount) AS precio_alquileres
FROM
	language
		JOIN
	film USING (language_id)
		JOIN
	inventory USING (film_id)
		JOIN
	rental USING (inventory_id)
		JOIN
	payment USING (rental_id)
GROUP BY language_id;

-- 88:  Para cada cliente, cuenta en cuántos días distintos de 2005 realizó algún alquiler.
SELECT
	customer.first_name,
    customer.last_name,
    COUNT(DISTINCT(DAY(rental_date))) AS alquileres_dia
FROM
	customer
		JOIN
	rental USING (customer_id)
WHERE
	YEAR(rental_date) = 2005
GROUP BY customer_id;
/* No me da el resultado esperado, no sé si por algún error que no veo o por la ruta que he escogido */

-- 89:  Para cada categoría, calcula la longitud media de títulos (número de caracteres) de sus películas alquiladas.
SELECT
	category.name,
    AVG(LENGTH(title)) AS longitud_media
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
GROUP BY category_id;

-- 90:  Para cada tienda, cuenta cuántos clientes distintos alquilaron en el primer trimestre de 2006 (enero-marzo).
SELECT
	store_id,
    COUNT(DISTINCT(rental.customer_id)) AS clientes_prim_trim
FROM
	store 
		JOIN
	inventory USING (store_id)
		JOIN
	rental USING (inventory_id)
WHERE MONTH(rental_date) BETWEEN 01 AND 03 AND YEAR(rental_date) = 2006
GROUP BY store_id;

-- 91:  Para cada país, cuenta cuántas categorías diferentes han sido alquiladas por clientes residentes en ese país.
SELECT
	country,
    COUNT(DISTINCT(category_id)) AS categorias 
FROM	
	country
		JOIN
	city USING (country_id)
		JOIN
	address USING (city_id)
		JOIN
	customer USING (address_id)
		JOIN
	rental USING (customer_id)
		JOIN
	inventory USING (inventory_id)
		JOIN
	film USING (film_id)
		JOIN
	film_category USING (film_id)
GROUP BY country_id;
/* No veo como llegar desde country hasta category con solo 4 JOINS (la verdad, no creo que se pueda) */

-- 92:  Para cada cliente, muestra el importe medio de sus pagos redondeado a 2 decimales, solo si ha hecho al menos 10 pagos.
SELECT
	customer.first_name,
    customer.last_name,
    ROUND(AVG(payment.amount), 2) AS importe_medio
FROM
	customer
		JOIN
	payment USING (customer_id)
GROUP BY customer_id
HAVING
	COUNT(payment_id) >= 10;

-- 93:  Para cada categoría, muestra el número de películas con replacement_cost > 20 que hayan sido alquiladas al menos una vez.
SELECT
	category.name,
    COUNT(DISTINCT(film_id)) AS peliculas
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
WHERE replacement_cost > 20
GROUP BY category_id;

-- 94:  Para cada tienda, suma los importes pagados en fines de semana.
SELECT
	store_id,
    SUM(payment.amount) AS importes_pagados
FROM
	store
		JOIN
	staff USING (store_id)
		JOIN
	payment USING (staff_id)
WHERE DAYOFWEEK(payment_date) IN(7,1)
GROUP BY store_id;

-- 95:  Para cada actor, cuenta cuántas películas suyas fueron alquiladas por al menos 5 clientes distintos (se cuenta alquileres y luego se filtra por HAVING).
SELECT
	actor.first_name,
    actor.last_name,
    COUNT(DISTINCT(customer_id)) AS peliculas_alquiladas
FROM
	actor
		JOIN
	film_actor USING (actor_id)
		JOIN
	film USING (film_id)
		JOIN
	inventory USING (film_id)
		JOIN
	rental USING (inventory_id)
GROUP BY actor_id
HAVING 
	COUNT(DISTINCT(rental_id)) >= 5;
    
-- 96:  Para cada idioma, muestra el número de películas cuyo título empieza por la letra 'A' y que han sido alquiladas.
SELECT 
    language.name, 
    COUNT(DISTINCT (film.title)) AS peliculas_A
FROM
    language
        JOIN
    film USING (language_id)
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
WHERE
    film.title LIKE 'A%'
GROUP BY language_id;


-- 97:  Para cada país, suma el importe total de pagos realizados por clientes residentes y filtra países con total >= 1000.
SELECT
	country,
    SUM(payment.amount) AS importe_total
FROM 
	country
		JOIN
	city USING (country_id)
		JOIN
	address USING (city_id)
		JOIN
	customer USING (address_id)
		JOIN
	payment USING (customer_id)
GROUP BY country_id
HAVING 
	importe_total >= 1000;

-- 98:  Para cada cliente, cuenta cuántos días han pasado entre su primer y su último alquiler en 2005 (diferencia de fechas), mostrando solo clientes con >= 5 alquileres en 2005.
--     (Se evita subconsulta calculando sobre el conjunto agrupado por cliente y usando MIN/MAX de rental_date en 2005).
SELECT
	customer.first_name,
    customer.last_name,
    COUNT(DATEDIFF(MAX(rental_date), MIN(rental_date))) AS dias_pasados
FROM
	customer
		JOIN
	rental USING (customer_id)
WHERE COUNT(rental.customer_id) >= 5 AND YEAR(rental_date) = 2005
GROUP BY rental.customer_id;

-- 99:  Para cada tienda, muestra la media de importes cobrados por transacción en el año 2006, con dos decimales.
SELECT
	store_id,
    ROUND(AVG(payment.amount), 2) AS media_importes
FROM
	store
		JOIN
	staff USING (store_id)
		JOIN
	payment USING (staff_id)
WHERE
	YEAR(payment_date) = 2006
GROUP BY store_id;
    
-- 100:  Para cada categoría, calcula la media de duración (length) de películas alquiladas en 2006 y ordénalas descendentemente por dicha media.
SELECT
	category.name,
    AVG(film.length) AS media_duracion
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
WHERE YEAR(rental_date) = 2006
GROUP BY category_id
ORDER BY media_duracion DESC;