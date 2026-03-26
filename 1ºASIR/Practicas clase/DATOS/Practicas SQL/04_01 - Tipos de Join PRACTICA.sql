-- 18) Productos NUNCA vendidos
-- Enunciado: Lista todos los productos que nunca han sido vendidos, es decir, aquellos que no aparecen en ninguna fila de detalle_pedido.
SELECT
	DISTINCT(productos.nombre) AS producto
FROM
	productos
		LEFT JOIN
	detalle_pedido USING (id_producto)
WHERE
	detalle_pedido.id_producto IS NULL
ORDER BY producto ASC;

-- EJERCICIOS PRACTICA GUIA
-- EJERCICIO 1
-- Enunciado:Listado de alumnos con sus id_curso (solo emparejados) 
SELECT 
	nombre,
    id_curso
FROM
	alumnos 
		INNER JOIN
	matriculas USING (id_alumno)
GROUP BY id_alumno, id_curso;

-- EJERCICIO 2
-- Enunciado: Alumnos sin ninguna matricula
SELECT
	id_alumno,
    nombre
FROM
	alumnos
		LEFT JOIN
	matriculas USING (id_alumno)
WHERE
	id_matricula IS NULL
GROUP BY id_alumno;

-- EJERCICIO 3
-- Enunciado: Matrículas sin alumno (huérfanas)
SELECT
	id_matricula,
	id_alumno,
    id_curso
FROM
	alumnos
		RIGHT JOIN
	matriculas USING (id_alumno)
WHERE alumnos.id_alumno IS NULL;

-- EJERCICIO 4
-- Enunciado: Cursos del catálogo sin ninguna matrícula.
SELECT
	id_curso,
    nombre_curso
FROM
	cursos
		LEFT JOIN
	matriculas USING (id_curso)
WHERE id_matricula IS NULL
GROUP BY id_curso;
-- EJERCICIO 5
-- Enunciado: Número de matrículas por alumno 
SELECT
	id_alumno, 
    nombre,
    COUNT(id_matricula) AS n_matriculas
FROM
	matriculas
		LEFT JOIN
	alumnos USING (id_alumno)
WHERE nombre IS NOT NULL
GROUP BY id_alumno
UNION 
SELECT
	id_alumno, 
    nombre,
    COUNT(id_matricula) AS n_matriculas
FROM
	matriculas
		RIGHT JOIN
	alumnos USING (id_alumno)
GROUP BY id_alumno;

-- EJERCICIO 6
-- Enunciado: Alumnos con más de un curso 
SELECT
	alumnos.id_alumno,
    nombre,
    COUNT(id_curso) AS n_cursos
FROM
	alumnos
		INNER JOIN
	matriculas USING (id_alumno)
GROUP BY alumnos.id_alumno, nombre
HAVING COUNT(id_curso) > 1;

-- EJERCICIO 7
-- Enunciado: FULL OUTER JOIN emulado (alumnos y sus matrículas, incluyendo huérfanas)
SELECT
	id_alumno,
    id_matricula
FROM
	alumnos 
		LEFT JOIN
	matriculas USING (id_alumno)
UNION
SELECT
	id_alumno,
    id_matricula
FROM
	alumnos 
		RIGHT JOIN
	matriculas USING (id_alumno);

-- EJERCICIO 8
-- Enunciado: Para cada curso del catálogo, número de alumnos con matrícula válida (alumno y curso existen)
SELECT
	id_curso,
    nombre_curso,
    COUNT(alumnos.id_alumno) AS n_alumnos
FROM
	cursos 
		LEFT JOIN
	matriculas USING (id_curso)
		LEFT JOIN
	alumnos USING (id_alumno)
GROUP BY id_curso;

