-- DML
-- SQL

-- Sintaxis

SELECT *
FROM public.cliente;

SELECT nit, nombre
FROM public.cliente;

-- Alias

SELECT cl.nit, cl.nombre, f.fec_factura
FROM public.cliente AS cl, public.factura AS f;

SELECT cl.nit AS no_nit, 
cl.nombre AS nombre_cliente, 
f.fec_factura AS fecha_factura
FROM public.cliente AS cl, public.factura AS f;

--- FUNCIONES DE AGREGACIÓN

SELECT COUNT(*)
FROM public.auto;

SELECT MIN(monto)
FROM public.factura;

SELECT MAX(monto)
FROM public.factura;

SELECT SUM(monto)
FROM public.factura;

SELECT AVG(monto)
FROM public.factura;

SELECT abstime(NOW()) 

SELECT to_char( now(), 'HH24:MI:SS') 

SELECT to_datetime('05 Dec 2000 13', 'DD Mon YYYY HH')

SELECT date_part('year', timestamp '2001-02-16 20:38:40')

SELECT EXTRACT(year FROM age(timestamp 'now()', date('1979-04-20')))

SELECT EXTRACT(DAY FROM age(timestamp 'now()', fa.fec_factura)) no_dias
FROM factura AS fa;

-- JOIN

SELECT fa.cod_factura, fa.fec_factura, fa.monto, cl.cod_cliente, cl.nombre, cl.apellido, emp.nombre || ' ' || emp.apellido AS empleado
FROM factura fa 
INNER JOIN cliente cl ON fa.cod_cliente = cl.cod_cliente
INNER JOIN empleado emp ON fa.cod_empleado = emp.cod_empleado;

SELECT cl.cod_cliente, cl.nombre || ' ' || cl.apellido cliente, fa.cod_factura, fa.fec_factura, fa.monto
FROM cliente cl 
LEFT JOIN factura fa ON cl.cod_cliente = fa.cod_cliente;

SELECT cl.cod_cliente, cl.nombre || ' ' || cl.apellido cliente, fa.cod_factura, fa.fec_factura, fa.monto
FROM cliente cl 
LEFT JOIN factura fa ON cl.cod_cliente = fa.cod_cliente
WHERE fa.cod_cliente IS NULL;

-- PRODUCTO CARTESIANO
SELECT cl.*, fa.*
FROM factura fa, cliente cl
WHERE fa.cod_cliente = cl.cod_cliente;

-- ORDER BY

SELECT *
FROM auto
ORDER BY modelo DESC, marca DESC;

SELECT cod_factura, fec_factura, no_placa, monto * 3 AS valor
FROM factura
ORDER BY valor ASC

-- GROUP BY, HAVING

SELECT cl.nombre || ' ' || cl.apellido AS cliente, SUM(fa.monto) AS total
FROM factura fa
INNER JOIN cliente cl ON fa.cod_cliente = cl.cod_cliente
GROUP BY cliente
ORDER BY total DESC

SELECT fec_factura, SUM(monto) AS total
FROM factura
GROUP BY fec_factura

SELECT emp.nombre || ' ' || emp.apellido AS empleado, SUM(fa.monto) AS total
FROM factura fa
INNER JOIN empleado emp ON fa.cod_empleado = emp.cod_empleado
GROUP BY empleado
ORDER BY total DESC


-- HAVING

SELECT emp.nombre || ' ' || emp.apellido AS empleado, SUM(fa.monto) AS total
FROM factura fa
INNER JOIN empleado emp ON fa.cod_empleado = emp.cod_empleado
GROUP BY empleado
HAVING SUM(fa.monto) > 1900
ORDER BY total DESC

-- LIKE, UPPER, INITCAP, LOWER

SELECT cod_cliente, INITCAP(nombre || ' ' || apellido) AS cliente
FROM cliente
WHERE UPPER(nombre || ' ' || apellido) LIKE UPPER('%AR%')

-- BETWEEN

SELECT * 
FROM factura
WHERE fec_factura BETWEEN DATE('2021-02-27') AND DATE('2021-03-05')


--- VISTAS

DROP  VIEW vw_venta_empleado;

CREATE VIEW vw_venta_empleado AS
SELECT emp.nombre || ' ' || emp.apellido AS empleado, SUM(fa.monto) AS total
FROM factura fa
INNER JOIN empleado emp ON fa.cod_empleado = emp.cod_empleado
GROUP BY empleado
ORDER BY total DESC;

SELECT *
FROM vw_venta_empleado;