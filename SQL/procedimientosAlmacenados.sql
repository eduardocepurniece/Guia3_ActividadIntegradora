CREATE PROCEDURE sp_ListarClientes
AS
BEGIN
    SELECT * FROM cliente;
END;

CREATE PROCEDURE sp_BuscarCliente
    @idcliente INT
AS
BEGIN
    SELECT * 
    FROM cliente
    WHERE idcliente = @idcliente;
END;


CREATE PROCEDURE sp_TotalPedidos
AS
BEGIN
    SELECT COUNT(*) AS total_pedidos
    FROM pedidos;
END;