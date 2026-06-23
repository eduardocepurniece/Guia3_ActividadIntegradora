SELECT
    c.nombre AS nombre_cliente,
    p.nopedido,
    p.fecha,
    p.importe
FROM pedidos p
INNER JOIN cliente c ON p.idcliente = c.idcliente;



SELECT
    e.nombre AS nombre_empleado,
    e.puesto,
    o.ciudad
FROM empleados e
INNER JOIN oficina o ON e.idoficina = o.idoficina;



SELECT
    c.nombre AS nombre_cliente,
    p.nopedido,
    p.fecha,
    p.importe
FROM cliente c
LEFT JOIN pedidos p ON c.idcliente = p.idcliente;