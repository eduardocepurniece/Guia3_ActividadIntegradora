SELECT
    c.nombre,
    SUM(p.importe) AS total_comprado
FROM cliente c
INNER JOIN pedidos p ON c.idcliente = p.idcliente
GROUP BY c.nombre;



SELECT
    c.nombre,
    COUNT(p.nopedido) AS cantidad_pedidos
FROM cliente c
INNER JOIN pedidos p ON c.idcliente = p.idcliente
GROUP BY c.nombre;



SELECT nombre
FROM cliente
WHERE idcliente IN (
    SELECT idcliente
    FROM pedidos
    GROUP BY idcliente
    HAVING SUM(importe) > (
        SELECT AVG(importe) FROM pedidos
    )
);



-- CLIENTES
SELECT 
    c.nombre,
    o.ciudad
FROM cliente c
INNER JOIN oficina o ON c.idoficina = o.idoficina

UNION

-- SUPLIDORES
SELECT 
    s.nombre,
    LTRIM(SUBSTRING(s.direccion, CHARINDEX(',', s.direccion) + 1, LEN(s.direccion))) AS ciudad
FROM suplidor s;

