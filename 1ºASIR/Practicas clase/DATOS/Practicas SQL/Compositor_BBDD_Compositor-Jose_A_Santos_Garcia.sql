-- CREAR UNA BASE DE DATOS

DROP DATABASE discosEjercicio5Relacional;

CREATE DATABASE	discosEjercicio5Relacional;

USE discosEjercicio5Relacional;

DROP TABLE compositor;

CREATE TABLE compositor (
	-- nombre tipo restricciones ,
	id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(40) UNIQUE NOT NULL,
    año_nacimiento DECIMAL(4,0),
    nacionalidad VARCHAR(4), -- CÓDIGO DE PAIS: ES, FR, IT...
    -- PRIMARY KEY (id) -- sin coma si va úiltimo. Es otra forma de indicar la clave primaria
    CONSTRAINT pk_compositor PRIMARY KEY (id)
);

DROP TABLE director;

CREATE TABLE director (
	-- nombre tipo restricciones ,
	id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(40) UNIQUE NOT NULL,
    año_nacimiento DECIMAL(4,0),
    nacionalidad VARCHAR(4), -- CÓDIGO DE PAIS: ES, FR, IT...
    CONSTRAINT pk_director PRIMARY KEY (id)
);

DROP TABLE interprete;

CREATE TABLE interprete (
	-- nombre tipo restricciones ,
	id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(40) UNIQUE NOT NULL,
    año_nacimiento DECIMAL(4,0),
    nacionalidad VARCHAR(4), -- CÓDIGO DE PAIS: ES, FR, IT...
    CONSTRAINT pk_interprete PRIMARY KEY (id)
);

DROP TABLE obra;

CREATE TABLE obra (
	id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(50) NOT NULL,
    tipo VARCHAR(50),
    tonalidad ENUM('DoMayor', 'Domenor', 'Do#Mayor', 'Do#menor', 'Re'), -- y me aburro, pero hay que terminarlo
    modo VARCHAR(50),
    id_compositor TINYINT UNSIGNED,
    -- CONSTRAINT pk_obra PRIMARY KEY(id) -- sin coma si va último. Otra manera de indicar la PK
    PRIMARY KEY (id),
    CONSTRAINT fk_obra_compositor FOREIGN KEY (id_compositor)
		REFERENCES compositor(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

DROP TABLE version;

CREATE TABLE version (
	id_version TINYINT UNSIGNED NOT NULL,
    id_obra TINYINT UNSIGNED NOT NULL,
    id_director TINYINT UNSIGNED,
    id_interprete TINYINT UNSIGNED NOT NULL,
    CONSTRAINT pk_id_verison PRIMARY KEY (id_version),
    CONSTRAINT fk_id_obra FOREIGN KEY (id_obra)
		REFERENCES obra(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_version_director FOREIGN KEY (id_director)
		REFERENCES director(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_version_interprete FOREIGN KEY (id_interprete)
		REFERENCES interprete(id) ON DELETE RESTRICT ON UPDATE CASCADE
);
