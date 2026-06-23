CREATE VIEW vw_ClientesActivos AS
SELECT 
    c.idcliente,
    c.nombre,
    o.ciudad,
    c.limite_credito
FROM cliente c
LEFT JOIN oficina o ON c.idoficina = o.idoficina;

CREATE VIEW vw_VentasPorEmpleado AS
SELECT 
    e.nombre,
    COUNT(p.nopedido) AS cantidad_pedidos,
    SUM(p.importe) AS total_vendido
FROM empleados e
LEFT JOIN pedidos p ON e.idempleado = p.idempleado
GROUP BY e.nombre;

SELECT * FROM vw_ClientesActivos;

SELECT * FROM vw_VentasPorEmpleado;