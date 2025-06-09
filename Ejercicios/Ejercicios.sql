USE BDD_creditos_vehiculares
GO

--LISTA DE EJERCICIOS

--Ejercicio N°1
/*Obtener el nombre y descripción de los productos cuyo precio es mayor a 20,000.*/
SELECT*FROM producto;

SELECT nombre, descripcion, precio
	FROM producto 
	WHERE precio > 20000;


--Ejercicio N°2
/* Mostrar los créditos con monto mayor a 50,000. */
SELECT * FROM credito 
	WHERE monto > 50000;


--Ejercicio N°3
/* Listar todos los créditos con el interés aplicado mayor a 10%.*/
SELECT * FROM credito 
	WHERE interes > 10;


--Ejercicio N°4
/* Listar todas las garantías asociadas a un crédito específico (por ejemplo, id_credito=20).*/
SELECT*FROM garantia_credito;
SELECT g.* 
FROM garantia g
JOIN garantia_credito gc ON g.id_garantia = gc.id_garantia
WHERE gc.id_credito = 20;


--Ejercicio N°5
/* Mostrar los productos cuyo tipo sea 'SUV'.*/
SELECT * FROM producto
	WHERE tipo = 'SUV';


--Ejercicio N°6
/* Obtener los créditos otorgados después de una fecha específica (ejemplo: '2023-01-01').*/
SELECT * FROM credito 
	WHERE fecha_inicio > '2024-01-01';


--Ejercicio N°7
/* Mostrar los créditos que tienen asociado al menos una garantía.*/
SELECT DISTINCT c.* 
	FROM credito c
	JOIN garantia_credito gc ON c.id_credito = gc.id_credito
ORDER BY fecha_inicio DESC;


--Ejercicio N°8
/* Mostrar los clientes que han solicitado créditos.*/
SELECT DISTINCT cliente.* 
FROM cliente
JOIN credito ON cliente.id_cliente = credito.id_credito;


--Ejercicio N°9
/* Listar créditos con su monto, interés y la garantía asociada (nombre y descripción de la garantía).*/
SELECT c.id_credito, c.monto, c.interes, g.tipo AS garantia_tipo, g.descripcion AS garantia_descripcion
FROM credito c
JOIN garantia_credito gc ON c.id_credito = gc.id_credito
JOIN garantia g ON gc.id_garantia = g.id_garantia
ORDER BY interes ASC;


--Ejercicio N°10
/* Mostrar el total de stock disponible por producto sumando todas las sucursales y ordenar de mayor a menor.*/
SELECT p.id_producto, p.nombre, SUM(ps.stock) AS total_stock
FROM producto p
JOIN producto_sucursal ps ON p.id_producto = ps.id_producto
GROUP BY p.id_producto, p.nombre
ORDER BY total_stock DESC;


--Ejercicio N°11
/* Obtener el monto total de créditos otorgados por cada entidad financiera.*/
SELECT ef.nombre, SUM(c.monto) AS total_credito
FROM entidad_financiera ef
JOIN credito c ON ef.id_entidadFinanciera = c.id_credito
GROUP BY ef.nombre;


--Ejercicio N°12
/* Mostrar los productos que tienen 20 unidades de stock porsucursal.*/
SELECT p.id_producto, p.nombre, p.descripcion, COALESCE(ps.stock,20) AS stock 
FROM producto p
LEFT JOIN producto_sucursal ps ON p.id_producto = ps.id_producto
WHERE ps.stock IS NULL OR ps.stock = 20;


--Ejercicio N°13
/* Listar el promedio de monto de créditos por tipo de producto (por ejemplo, tipo vehículo).*/
SELECT p.tipo, AVG(c.monto) AS promedio_monto
FROM producto p
JOIN credito c ON p.id_producto = c.id_producto
GROUP BY p.tipo;


--Ejercicio N°14
/* Listar los clientes con la suma total de sus créditos y la cantidad de créditos que tienen.*/
SELECT TOP 10 cl.id_cliente, cl.nombre, COUNT(c.id_credito) AS cantidad_creditos, SUM(c.monto) AS suma_creditos
FROM cliente cl
JOIN credito c ON cl.id_cliente = c.id_cuenta
GROUP BY cl.id_cliente, cl.nombre
ORDER BY suma_creditos DESC;


--Ejercicio N°15
/* Listar las garantías más utilizadas y la cantidad de créditos que las usan.*/
SELECT g.tipo, COUNT(gc.id_credito) AS cantidad_usos
FROM garantia g
JOIN garantia_credito gc ON g.id_garantia = gc.id_garantia
GROUP BY g.tipo
ORDER BY cantidad_usos DESC;


--Ejercicio N°16
/* Mostrar el promedio de interés de créditos agrupado por tipo de producto.*/
SELECT p.tipo, AVG(c.interes) AS promedio_interes
FROM producto p
JOIN credito c ON p.id_producto = c.id_producto
GROUP BY p.tipo;


--Ejercicio N°17
/*Mostrar los productos con stock total mayor a 50 unidades.*/

SELECT p.nombre, SUM(ps.stock) AS stock_total
FROM producto p
JOIN producto_sucursal ps ON p.id_producto = ps.id_producto
GROUP BY p.id_producto, p.nombre
HAVING SUM(ps.stock) > 50;


--Ejercicio N°18
/*Mostrar los clientes con cuentas que tengan más de 2,000 de saldo*/
SELECT c.nombre, c.apellido, cu.saldo
FROM cliente c
JOIN cuenta cu ON c.id_cliente = cu.id_cliente
WHERE cu.saldo > 2000;


--Ejercicio N°19
/*ClieProductos tipo Motocicleta con precio menor a 10000 - Diana Llerena */
SELECT nombre, tipo, precio
FROM producto
WHERE tipo = 'Motocicleta' AND precio < 10000;


--Ejercicio N°20
/*Mostrar las entidades financieras con nombre que contenga 'Caja'*/
SELECT nombre, direccion
FROM entidad_financiera
WHERE nombre LIKE '%Caja%';


--Ejercicio N°21
/*Mostrar el total de créditos agrupados por tipo de producto */
SELECT pr.tipo, COUNT(cr.id_credito) AS total_creditos
FROM credito cr
JOIN producto pr ON cr.id_producto = pr.id_producto
GROUP BY pr.tipo;


--Ejercicio N°22
/*Contar cuántos productos hay por cada tipo*/
SELECT tipo, COUNT(*) AS cantidad
FROM producto
GROUP BY tipo;


--Ejercicio N°23
/*Listar los correos electrónicos de clientes que tienen cuenta en Banco Uno*/
SELECT cli.nombre, cli.apellido, cli.email
FROM cliente cli
JOIN cuenta cu ON cli.id_cliente = cu.id_cliente
JOIN entidad_financiera ef ON cu.id_entidadFinanciera = ef.id_entidadFinanciera
WHERE ef.nombre = 'Banco Uno';
