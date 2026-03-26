DROP DATABASE IF EXISTS taller_autorepair;
CREATE DATABASE taller_autorepair;
USE taller_autorepair;

CREATE TABLE personas(
	id_persona TINYINT UNSIGNED AUTO_INCREMENT,
    dni VARCHAR(9) UNIQUE NOT NULL,
    nombre_completo VARCHAR(80) NOT NULL,
    email VARCHAR (50) UNIQUE NOT NULL,
    CONSTRAINT pk_id_persona PRIMARY KEY(id_persona),
    CONSTRAINT chk_dni CHECK(LENGTH(dni) = 9),
    CONSTRAINT chk_email CHECK(email LIKE '%@%')
);

CREATE TABLE empleados(
	id_persona TINYINT UNSIGNED,
    num_ss VARCHAR(12) UNIQUE NOT NULL,
    capacitaciones SET('MOTOR', 'CHAPA', 'PINTURA', 'ELECTRICIDAD'),
    id_jefe TINYINT UNSIGNED, -- incompleto
    CONSTRAINT pk_empleados_personas PRIMARY KEY(id_persona),
    CONSTRAINT fk_empleados_personas FOREIGN KEY(id_persona)
		REFERENCES personas(id_persona),
	CONSTRAINT fk_jefe_empleados FOREIGN KEY(id_jefe)
		REFERENCE empleados(id_persona) -- incompleto
);