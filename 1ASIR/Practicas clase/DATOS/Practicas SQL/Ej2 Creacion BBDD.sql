DROP DATABASE IF EXISTS ejercicio2;
CREATE DATABASE ejercicio2;
USE ejercicio2;

/* Contexto: Tienes dos entidades: investigador y laboratorio.
Un laboratorio es dirigido por un investigaor (FK de laboratorio a investigador), y un investigador 
trabaja en un laboratorio principal (FK de investigador a laboratorio) 

Tarea:

1. Generar un script SQL estructurado que permita la creación de ambas tablas de forma exitosa.
2. Todas las restricciones deben estar debidamente nombradas.
3. El script debe incluir una cabecera DROP TABLE IF EXISTS... en el orden correcto para poder
ejecutarse de forma interativa en la terminal de Linux sin generar errores*/

DROP TABLE IF EXISTS investigador;
CREATE TABLE investigador (
	id_investigador INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    id_lab INT UNSIGNED,
    CONSTRAINT pk_id_investigador PRIMARY KEY (id_investigador)
);

DROP TABLE IF EXISTS laboratorio;
CREATE TABLE laboratorio (
	id_lab INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    id_investigador INT UNSIGNED,
    CONSTRAINT pk_id_lab PRIMARY KEY (id_lab),
    CONSTRAINT fk_id_investigador FOREIGN KEY (id_investigador) 
		REFERENCES investigador(id_investigador)
);

ALTER TABLE investigador ADD CONSTRAINT fk_id_laboratorio 
    FOREIGN KEY (id_lab) REFERENCES laboratorio(id_lab);

/* Cuando haya dependencias circulares, se añade el alter. Lo que hace es alterar las 
tablas y así añadir las claves foráneas */