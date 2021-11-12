delimiter $$
CREATE PROCEDURE altaUsuario (unnombre VARCHAR(50),
							 unapellido VARCHAR(50),
							 untelefono INT,
                             unemail VARCHAR(50),
                             unidUsuario SMALLINT,
                             unpass CHAR(64))
BEGIN 
	 INSERT INTO Usuario (nombre, apellido, telefono, email, idUsuario,pass)
			     VALUES   (unnombre, unapellido, untelefono, unemail,unidUsuario,sha2(unpass,256));
END $$
CREATE PROCEDURE altaProducto (unprecio DECIMAL(10,2),
							  unacantidad SMALLINT UNSIGNED,
                              unnombre VARCHAR(50),
                              unidVendedor SMALLINT,
                              unafecha DATE,
                              unidProducto SMALLINT UNSIGNED)
BEGIN
	 INSERT INTO Producto (precio, cantidad, nombre, idVendedor, fecha, idProducto)
				 VALUES   (unprecio, unacantidad, unnombre, unidVendedor, unafecha, unidProducto);
END $$
CREATE PROCEDURE altaCompra (unaFechaHora DATETIME,
							 unacantidad SMALLINT UNSIGNED,
                             unprecio DECIMAL(10,2),
                             idComprador SMALLINT,
                             idProducto SMALLINT UNSIGNED)
BEGIN
	 INSERT INTO Compra (FechaHora, cantidad , precio, idComprador, idProducto)
				 VALUES (unaFechaHora, unacantidad, unprecio, idComprador, idProducto);
END $$
DELIMITER $$
CREATE FUNCTION recaudacionPara (unidProducto SMALLINT UNSIGNED,
								  unaFecha DATE,
                                  otraFecha DATE) returns decimal(10,2)
BEGIN
	DECLARE Recaudacion decimal(10,2);
    
    SELECT sum(cantidad*Precio) into Recaudacion
    FROM Compra
    WHERE unidProducto = Producto 
    AND FechaHora BETWEEN unaFecha and otraFecha;
    
    RETURN Recaudacion;
END $$
DELIMITER $$
CREATE PROCEDURE BuscarProducto (unNombre VARCHAR(50))
BEGIN
	 select unNombre
     from Producto
     where MATCH (idProducto) AGAINST (unNombre)
     and unNombre = Producto;
END $$
DELIMITER $$
CREATE PROCEDURE Ventasde (idUsuario SMALLINT)
BEGIN
	 select Compra.FechaHora 'FechaHora' , Compra.cantidad 'cantidad' , Cantidad.Precio 'Precio' , Cantidad.idComprador 'idComprador' , Cantidad.idProducto 'idProducto'
     from Compra.idComprador, Compra.idProducto
     inner join Producto.idProducto on Compra.idProducto = Producto.idProducto
     where unidUsuario = idVendedor
     order by DATE DESC;
END $$
DELIMITER $$
CREATE PROCEDURE ComprasDe (idUsuario SMALLINT)
BEGIN
	 select Compra.FechaHora 'FechaHora' , Compra.cantidad 'cantidad' , Cantidad.Precio 'Precio' , Cantidad.idComprador 'idComprador' , Cantidad.idProducot 'idProducto'
     from Compra
     inner join Usuario.nombre on Compra.idComprador = Usuario.idUsuario
     where unidUsuario = idComprador
     order by DATE DESC;
END $$