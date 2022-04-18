use mysql;
select * from user;

-- Genero un nuevo usuario con el nombre de 'usuario1' y contraseña '123456'.
CREATE USER 'usuario1'@'localhost' IDENTIFIED BY '123456';

-- Le doy al 'usuario1' permiso para que pueda hacer consultas solamente en la BD fabrica_guitarras.
GRANT SELECT ON fabrica_guitarras.* TO 'usuario1'@'localhost';

-- Chequeo que el permiso dado haya quedado efectivamente activo.
SHOW GRANTS FOR 'usuario1'@'localhost';

-- Genero un nuevo usuario con el nombre de 'usuario2' y contraseña '234567'.
CREATE USER 'usuario2'@'localhost' IDENTIFIED BY '234567';

/* Le doy al 'usuario2' permiso para que pueda hacer consultas, inserts
y updates en la BD fabrica_guitarras.*/
GRANT SELECT, INSERT, UPDATE ON fabrica_guitarras.* TO 'usuario2'@'localhost';

-- Chequeo que los permisos dados hayan quedado efectivamente activos.
SHOW GRANTS FOR 'usuario2'@'localhost';

/* SCRIPTS DE PRUEBA PARA LOS USUARIOS

USUARIO 1, una vez generada la conexion con el mismo e ingresando desde el home:


Con esta query chequeamos que el usuario puede hacer consultas en la BD.

SELECT * FROM fabrica_guitarras.materiales;

Con estas 3 querys chequeamos que no puede hacer INSERTS, UPDATES o DELETES en la BD.

INSERT INTO materiales VALUES
(NULL, 'microfonos', 'Fender', 'Texas Special', 'Set x3 para electrica', '250', '5000');

UPDATE materiales
SET costo = 3000
WHERE id = 10;

DELETE FROM materiales
WHERE id = 10;


USUARIO 2, una vez generada la conexion con el mismo e ingresando desde el home:


Con esta query chequeamos que el usuario puede hacer consultas en la BD.

SELECT * FROM fabrica_guitarras.materiales;

Con esta query chequeamos que el usuario puede hacer INSERTS en la BD, también se puede
chequear la tabla movimientos_materiales para ver que el trigger se activa guardando la 
informacion del movimiento y podemos ver que el que lo realizo fue el usuario2.

INSERT INTO materiales VALUES
(NULL, 'microfonos', 'Fender', 'Texas Special', 'Set x3 para electrica', '250', '5000');

Con esta query chequeamos que el usuario puede hacer UPDATES en la BD, tambien se puede
chequear en la tabla movimientos_materiales para ver que el trigger se activa guardando la
informacion del movimiento y podemos ver que el que lo realizo fue el usuario2.

UPDATE materiales
SET costo = 3000
WHERE id = 10;

Con esta query chequeamos que el usuario no puede hacer DELETES en la BD.

DELETE FROM materiales
WHERE id = 10;

Pequeño rechequeo para verificar los UPDATES del usuario aumentando el stock de una guitarra. 

UPDATE guitarras
SET stock = stock + 100
WHERE id = 5;