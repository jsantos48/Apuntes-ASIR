DROP DATABASE IF EXISTS gestion_proyectos;
CREATE DATABASE gestion_proyectos;
USE gestion_proyectos;

DROP TABLE IF EXISTS empleados;
CREATE TABLE empleados (
	id_empleado TINYINT UNSIGNED AUTO_INCREMENT,
    dni VARCHAR(9) UNIQUE NOT NULL,
    salario DECIMAL(6,2) DEFAULT 1200.00,
    estado ENUM('ACTIVO', 'INACTIVO') DEFAULT 'ACTIVO',
    CONSTRAINT pk_empleado PRIMARY KEY (id_empleado)
);

DROP TABLE IF EXISTS departamentos;
CREATE TABLE departamentos (
	id_departamento TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    codigo_dpto VARCHAR(5) UNIQUE NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    presupuesto DECIMAL(10,2) NOT NULL,
    CONSTRAINT lim_presupuesto CHECK (presupuesto > 0)
);

DROP TABLE IF EXISTS proyectos;
CREATE TABLE proyectos (
	id_proyecto TINYINT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(40) NOT NULL UNIQUE,
    id_departamento TINYINT UNSIGNED NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NULL,
	CONSTRAINT pk_id_proyecto PRIMARY KEY (id_proyecto),
    CONSTRAINT fk_id_departamento FOREIGN KEY (id_departamento) 
		REFERENCES departamentos(id_departamento),
	CONSTRAINT date_chk CHECK (fecha_fin > fecha_inicio)
);

DROP TABLE IF EXISTS asignaciones;
CREATE TABLE asignaciones (
    id_empleado TINYINT UNSIGNED,
    id_proyecto TINYINT UNSIGNED,
    horas_asignadas TINYINT DEFAULT 0,
    CONSTRAINT pk_asignaciones PRIMARY KEY (id_empleado,id_proyecto),
    CONSTRAINT fk_asignacion_empleado FOREIGN KEY (id_empleado)
		REFERENCES empleados(id_empleado) ON DELETE CASCADE,
    CONSTRAINT fk_asignacion_proyecto FOREIGN KEY (id_proyecto) 
		REFERENCES proyectos(id_proyecto) ON DELETE CASCADE
);