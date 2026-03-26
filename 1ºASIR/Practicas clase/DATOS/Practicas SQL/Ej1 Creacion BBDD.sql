-- Ejercicio 1: Auditoría de Sintaxis y Refactorización
/* Contexto: Un desarrollador junior ha entregado el siguiente script que funciona, pero
incumple todos los estándares de buenas prácticas de administración de bases de datos. */

CREATE DATABASE ejercicio1;

-- lo que existe

CREATE TABLE vehiculos (
	id INT AUTO_INCREMENT PRIMARY KEY,
    matricula VARCHAR(10) UNIQUE,
    tipo VARCHAR(50),
    precio FLOAT,
    fecha_compra TIMESTAMP
);

-- lo que tendría que ser
CREATE TABLE vehiculos (
	id MEDIUMINT UNSIGNED AUTO_INCREMENT, 
    -- el UNSIGNED sirve para indicar que no hay signo (+/-)
    -- no hay NOT NULL debido a que se define en el constraint con el primary key
    matricula VARCHAR(10) UNIQUE,
    tipo VARCHAR(50),
    precio decimal (10,2),
    fecha_compra DATE,
    CONSTRAINT pk_id PRIMARY KEY (id), -- ya incluye not null y unique
	CONSTRAINT chk_matricula_alfanumerica CHECK (matricula REGEXP '^[A-Z0-9]{6,10}$' ),
	-- ^: Indica comienzo de la cadena.
    -- $: Indica final de la cadena.
    -- [A-Z0-9]: Indica los caracteres permitidos.
    -- {6,10}: Indica la longitud
    CONSTRAINT chk_precio_no_negativo CHECK (precio >= 0)
);
