DROP DATABASE IF EXISTS gestion_universidad;
CREATE DATABASE gestion_universidad;
USE gestion_universidad;

CREATE TABLE facultades(
	id_facultad TINYINT UNSIGNED AUTO_INCREMENT,
    codigo VARCHAR(4) UNIQUE NOT NULL,
    nombre VARCHAR(40) UNIQUE NOT NULL,
    id_decano TINYINT UNSIGNED NULL,
    CONSTRAINT pk_id_facultad PRIMARY KEY(id_facultad),
    CONSTRAINT chk_codigo CHECK(LENGTH(codigo) = 4)
);

CREATE TABLE profesores(
	id_profesor TINYINT UNSIGNED AUTO_INCREMENT,
    nif VARCHAR(9) UNIQUE NOT NULL,
    nombre_completo VARCHAR(100) NOT NULL,
    salario DECIMAL(10,2) DEFAULT 2000.00,
    id_facultad TINYINT UNSIGNED NOT NULL,
    CONSTRAINT pk_id_profesor PRIMARY KEY(id_profesor),
    CONSTRAINT fk_id_facultad FOREIGN KEY(id_facultad)
		REFERENCES facultades(id_facultad),
	CONSTRAINT chk_salario CHECK (salario > 0),
    CONSTRAINT chk_nif CHECK(LENGTH(nif) = 9)
);

ALTER TABLE facultades ADD CONSTRAINT fk_id_profesor
	FOREIGN KEY(id_decano) REFERENCES profesores(id_profesor);
    
CREATE TABLE grados(
	id_grado TINYINT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(40) UNIQUE NOT NULL,
    id_facultad TINYINT UNSIGNED NOT NULL,
    CONSTRAINT pk_id_grado PRIMARY KEY(id_grado),
    CONSTRAINT fk_grados_facultades FOREIGN KEY(id_facultad)
		REFERENCES facultades(id_facultad)
);

CREATE TABLE asignaturas(
	id_asignatura TINYINT UNSIGNED AUTO_INCREMENT,
    codig_asig VARCHAR(10) UNIQUE NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    creditos TINYINT DEFAULT 6,
    CONSTRAINT pk_id_asignatura PRIMARY KEY(id_asignatura),
    CONSTRAINT chk_creditos CHECK(creditos >= 3)
);

CREATE TABLE imparten(
	id_profesor TINYINT UNSIGNED,
    id_asignatura TINYINT UNSIGNED,
    tipo_grupo ENUM('TEORIA', 'PRACTICA') DEFAULT 'TEORIA',
    CONSTRAINT pk_imparten PRIMARY KEY(id_profesor, id_asignatura),
    CONSTRAINT fk_imparten_profesor FOREIGN KEY(id_profesor)
		REFERENCES profesores(id_profesor) ON DELETE CASCADE,
	CONSTRAINT fk_id_asignatura FOREIGN KEY(id_asignatura)
		REFERENCES asignaturas(id_asignatura) ON DELETE CASCADE
);