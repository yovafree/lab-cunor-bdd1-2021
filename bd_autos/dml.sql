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
