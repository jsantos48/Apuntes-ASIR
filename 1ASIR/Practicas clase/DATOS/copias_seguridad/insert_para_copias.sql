USE empresa_segura;

INSERT INTO `empresa_segura`.`empleados`
(`nombre`,
`email`)
VALUES
('Roberto',
'a@a.a');

FLUSH LOGS;

SHOW MASTER STATUS;

INSERT INTO `empresa_segura`.`empleados`
(`nombre`,
`email`)
VALUES
('Marta',
'b@b.b');

FLUSH LOGS;

SHOW MASTER STATUS;
