DROP DATABASE IF EXISTS almacen ; 
GO 
 
CREATE DATABASE almacen ; 
GO 
 
USE almacen ; 
GO 
 
/*  TABLA SUPERIOR */ 
CREATE TABLE superior ( 
    idsuperior INT IDENTITY (1,1) NOT NULL PRIMARY KEY, 
    nombre VARCHAR(50) NOT NULL, 
    cuota DECIMAL (10,2) NOT NULL 
); 
GO 
 
/*  TABLA SUPERVISOR    */ 
CREATE TABLE supervisor ( 
    idsupervisor INT IDENTITY (1,1) NOT NULL PRIMARY KEY, 
    nombre VARCHAR(50) NOT NULL, 
    cuota DECIMAL (10,2) NOT NULL 
); 
GO 
 
/*  TABLA OFICINA     */ 
CREATE TABLE oficina ( 
    idoficina INT IDENTITY (1,1) NOT NULL PRIMARY KEY, 
    descripcion VARCHAR(50) NOT NULL, 
    ciudad VARCHAR(50) NOT NULL, 
    region VARCHAR(50) NOT NULL, 
    idsupervisor INT NULL, 
    objetivo DECIMAL (12,2) NULL, 
 
    CONSTRAINT rel_soficina 
    FOREIGN KEY( idsupervisor ) 
    REFERENCES supervisor ( idsupervisor ) 
); 
GO 
 
/*  TABLA EMPLEADOS     */ 
CREATE TABLE empleados ( 
    idempleado INT IDENTITY (1,1) NOT NULL PRIMARY KEY, 
    idoficina INT NULL, 
    idsuperior INT NULL, 
    idjefe INT NULL, 
    nombre VARCHAR(50) NOT NULL, 
    email VARCHAR(150) NOT NULL UNIQUE, 
    fechanac DATE, 
    puesto VARCHAR(45), 
    contacto VARCHAR(12),cuota DECIMAL (10,2) NULL, 
    ventas DECIMAL (10,2) NULL, 
    fechacontrato DATE, 
 
    CONSTRAINT chk_empleado_cuota 
    CHECK (cuota >= 0), 
 
    CONSTRAINT chk_empleado_ventas 
    CHECK (ventas >= 0), 
 
    CONSTRAINT rel_eoficina 
    FOREIGN KEY( idoficina ) 
    REFERENCES oficina ( idoficina ), 
 
    CONSTRAINT rel_esuperior 
    FOREIGN KEY( idsuperior ) 
    REFERENCES superior ( idsuperior ), 
 
    CONSTRAINT rel_ejefe 
    FOREIGN KEY( idjefe ) 
    REFERENCES empleados ( idempleado ) 
); 
GO 
 
/*  TABLA CLIENTE     */ 
CREATE TABLE cliente ( 
    idcliente INT IDENTITY (1,1) NOT NULL PRIMARY KEY, 
    idoficina INT NULL, 
    nombre VARCHAR(50) NOT NULL, 
    limite_credito DECIMAL(12,2) NULL, 
 
    CONSTRAINT rel_coficina 
    FOREIGN KEY( idoficina ) 
    REFERENCES oficina ( idoficina ) 
); 
GO 
 
/*   TABLA SUPLIDOR    */ 
CREATE TABLE suplidor ( 
    idsuplidor INT IDENTITY (1,1) NOT NULL PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL, 
    direccion VARCHAR(255), 
    telefono VARCHAR(15), 
    email VARCHAR(100), 
    fechaRegistro DATE 
); 
GO 
 
/*     TABLA PRODUCTOS    */ 
CREATE TABLE productos ( 
    idproducto INT IDENTITY (1,1) NOT NULL PRIMARY KEY, 
    idsuplidor INT NULL, 
    descripcion VARCHAR(45) NOT NULL, 
    preciocompra DECIMAL(10,2) NOT NULL, 
    ganancia DECIMAL (5,2) NOT NULL, 
    preciov AS ( 
        preciocompra + 
        (preciocompra * ganancia / 100) 
    ), 
    itb DECIMAL (5,2), 
    existencia DECIMAL (10,2), 
    stock DECIMAL (10,2), 
    CONSTRAINT chk_producto_ganancia 
    CHECK (ganancia >= 0), 
 
    CONSTRAINT rel_psuplidor 
    FOREIGN KEY( idsuplidor ) 
    REFERENCES suplidor ( idsuplidor ) 
); 
GO 
 
/*    TABLA PEDIDOS    */ 
CREATE TABLE pedidos ( 
    nopedido INT IDENTITY (1,1) NOT NULL PRIMARY KEY, 
    fecha DATE NOT NULL, 
    idcliente INT NULL, 
    idempleado INT NULL, 
    importe DECIMAL (12,2) NULL, 
    condiciones VARCHAR(45), 
    CONSTRAINT rel_pcliente 
    FOREIGN KEY( idcliente ) 
    REFERENCES cliente ( idcliente ), 
 
    CONSTRAINT rel_pempleado 
    FOREIGN KEY( idempleado ) 
    REFERENCES empleados ( idempleado ) 
); 
GO 
 
/*    TABLA DETALLE PEDIDO   */ 
CREATE TABLE detpedido ( 
    nopedido INT NOT NULL, 
    idproducto INT NOT NULL, 
    descripcion VARCHAR(45), 
    cantidad DECIMAL (10,2) NOT NULL, 
    precio DECIMAL (10,2) NOT NULL, 
    total AS (cantidad * precio ) PERSISTED , 
    itbis AS (( cantidad * precio ) * 0.18 ) PERSISTED , 
    importe AS ( 
        (cantidad * precio ) + 
        (( cantidad * precio ) * 0.18 ) 
    ) PERSISTED , 
 
    CONSTRAINT pk_detpedido 
    PRIMARY KEY (nopedido , idproducto ), 
 
    CONSTRAINT rel_dpedido 
    FOREIGN KEY(nopedido ) 
    REFERENCES pedidos (nopedido ), 
 
    CONSTRAINT rel_dproductos 
    FOREIGN KEY( idproducto ) 
    REFERENCES productos ( idproducto ) 
); 
GO 
 
/*    ÍNDICES     */ 
CREATE INDEX idx_cliente_oficina 
ON cliente ( idoficina ); 
GO 
 
CREATE INDEX idx_pedido_cliente 
ON pedidos ( idcliente ); 
GO 
 
CREATE INDEX idx_pedido_empleado 
ON pedidos ( idempleado ); 
GO 
 
CREATE INDEX idx_producto_suplidor 
ON productos ( idsuplidor ); 
GO 
 
CREATE INDEX idx_empleado_oficina 
ON empleados ( idoficina ); 
GO 