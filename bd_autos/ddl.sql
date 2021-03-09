-- CREACIÓN DE LA TABLA CLIENTE
CREATE TABLE cliente(
	cod_cliente serial NOT NULL,
	nit character varying(10) DEFAULT 'C/F',
	nombre character varying(150) NOT NULL,
	apellido character varying(150) NOT NULL,
	direccion character varying (150),
	primary key(cod_cliente)
);

-- CREACIÓN DE LA TABLA EMPLEADO
CREATE TABLE empleado(
	cod_empleado serial NOT NULL,
	dpi character varying(16) NOT NULL,
	nombre character varying(150) NOT NULL,
	apellido character varying(150) NOT NULL,
	telefono character varying(30)
);

ALTER TABLE empleado ADD PRIMARY KEY(cod_empleado);


-- 

CREATE TABLE auto(
	no_placa character varying(7) NOT NULL,
	marca character varying(150) NOT NULL,
	modelo integer,
	primary key (no_placa)
);

--

CREATE TABLE factura(
	cod_factura serial NOT NULL,
	fec_factura date NOT NULL,
	cod_empleado integer NOT NULL,
	no_placa character varying(7) NOT NULL,
	cod_cliente integer NOT NULL,
	primary key (cod_factura),
	CONSTRAINT fk_empleado_factura 
		FOREIGN KEY(cod_empleado) 
			REFERENCES empleado(cod_empleado)
);

ALTER TABLE factura ADD CONSTRAINT fk_auto_factura
FOREIGN KEY(no_placa) REFERENCES auto(no_placa);

ALTER TABLE factura ADD CONSTRAINT fk_cliente_factura
FOREIGN KEY(cod_cliente) REFERENCES cliente(cod_cliente);

ALTER TABLE factura
	ADD COLUMN monto DECIMAL(12,2) NOT NULL DEFAULT 0;
	
ALTER TABLE factura
	ADD COLUMN descripcion character varying(150);

--- Eliminar tablas

-- DROP TABLE factura;
-- DROP TABLE auto;
-- DROP TABLE cliente;
-- DROP TABLE empleado;


--- INSERTS

INSERT INTO auto(no_placa,marca,modelo) 
VALUES('C-7BC5D','Toyota',1999);

INSERT INTO auto(no_placa,marca,modelo) 
VALUES('C-9RC6D','Mazda',2011);

INSERT INTO auto(no_placa,marca,modelo) 
VALUES('M-9RC6D','Bajaj',2010);

INSERT INTO auto(no_placa,marca,modelo) 
VALUES('C-987RD','Chevrolet',2020);

INSERT INTO auto(no_placa,marca,modelo) 
VALUES('C-658QR','Audi',2016);

--- SELECT

SELECT *
FROM auto;

-- UPDATE
UPDATE auto SET modelo=2011 WHERE no_placa = 'C-658QR' ;

-- DELETE

DELETE FROM auto WHERE no_placa = 'R-55894';
DELETE FROM auto WHERE modelo < 2010;


--- INSERTS CLIENTES

INSERT INTO cliente( nit, nombre, apellido, direccion) 
VALUES('455654-3', 'Juan Carlos', 'Lopez', 'Ciudad');

INSERT INTO cliente( nit, nombre, apellido, direccion) 
VALUES('788989-5', 'Daniel', 'Sagastume', 'Ciudad');

INSERT INTO cliente( nit, nombre, apellido, direccion) 
VALUES('557997-4', 'Estuardo', 'Gutierrez', 'Ciudad');

INSERT INTO cliente( nit, nombre, apellido, direccion) 
VALUES('456653-4', 'Manolo', 'Lopez', 'Ciudad');

INSERT INTO cliente( nombre, apellido, direccion) 
VALUES('Julio', 'Ordoñez', 'Ciudad');

-- INSERTS EMPLEADOS

INSERT INTO empleado(dpi, nombre, apellido, telefono) 
VALUES('5466 55546 5879', 'Marlon', 'Ramirez', '1800-55546');

INSERT INTO empleado(dpi, nombre, apellido, telefono) 
VALUES('1342 22342 1234', 'David', 'Urrutia', '1800-12345');

INSERT INTO empleado(dpi, nombre, apellido, telefono) 
VALUES('5432 11233 4432', 'Carlos', 'Chub', '1800-98755');

INSERT INTO empleado(dpi, nombre, apellido, telefono) 
VALUES('5432 55546 5483', 'Luis', 'Bac', '1800-68879');

INSERT INTO empleado(dpi, nombre, apellido, telefono) 
VALUES('7642 43232 5879', 'Diego', 'Alcantara', '1800-88895');

-- INSERTS FACTURAS

INSERT INTO factura(fec_factura, cod_empleado, no_placa, cod_cliente, monto, descripcion)
VALUES (current_date, 1,'C-9RC6D', 1, 3500, 'Reparación de motor');

INSERT INTO factura(fec_factura, cod_empleado, no_placa, cod_cliente, monto, descripcion)
VALUES (current_date, 2,'C-987RD', 2, 1800, 'Servicio general');

INSERT INTO factura(fec_factura, cod_empleado, no_placa, cod_cliente, monto, descripcion)
VALUES (current_date, 1,'C-658QR', 3, 5000, 'Cambio de transmisión');