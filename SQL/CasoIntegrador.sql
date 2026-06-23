SELECT TOP 1
    c.nombre,
    SUM(p.importe) AS total_comprado
FROM cliente c
JOIN pedidos p ON c.idcliente = p.idcliente
GROUP BY c.nombre
ORDER BY total_comprado DESC;


SELECT TOP 1
    pr.descripcion,
    SUM(d.cantidad) AS total_vendido
FROM detpedido d
JOIN productos pr ON d.idproducto = pr.idproducto
GROUP BY pr.descripcion
ORDER BY total_vendido DESC;


SELECT TOP 1
    o.ciudad,
    SUM(p.importe) AS total_ventas
FROM oficina o
JOIN empleados e ON o.idoficina = e.idoficina
JOIN pedidos p ON e.idempleado = p.idempleado
GROUP BY o.ciudad
ORDER BY total_ventas DESC;

SELECT c.nombre, SUM(p.importe) AS total_compras
FROM cliente c
JOIN pedidos p ON c.idcliente = p.idcliente
GROUP BY c.nombre
HAVING SUM(p.importe) > (
    SELECT AVG(importe) FROM pedidos
);

CREATE VIEW vw_ReporteEjecutivo AS
SELECT 
    c.nombre AS cliente,
    COUNT(p.nopedido) AS cantidad_pedidos,
    SUM(p.importe) AS total_comprado,
    o.ciudad AS oficina
FROM cliente c
JOIN pedidos p ON c.idcliente = p.idcliente
JOIN oficina o ON c.idoficina = o.idoficina
GROUP BY c.nombre, o.ciudad;



CREATE PROCEDURE sp_ClientesDestacados
AS
BEGIN
    SELECT 
        c.nombre,
        SUM(p.importe) AS total_compras
    FROM cliente c
    JOIN pedidos p ON c.idcliente = p.idcliente
    GROUP BY c.nombre
    HAVING SUM(p.importe) > (
        SELECT AVG(importe) FROM pedidos
    );
END;