CREATE TABLE `Producto` (
precio FLOAT NOT NULL,
cantidad SMALLINT UNSIGNED NOT NULL,
nombre VARCHAR(50) NOT NULL,
idVendedor SMALLINT NOT NULL,
fecha DATE NOT NULL,
idProducto SMALLINT UNSIGNED,
PRIMARY KEY (idProducto),
CONSTRAINT fk_Producto_Usuario FOREIGN KEY (idVendedor)
	REFERENCES Usuario(idUsuario)
);

CREATE TABLE `Compra` (
FechaHora DATETIME,
cantidad SMALLINT UNSIGNED NOT NULL,
precio DECIMAL(10,2) NOT NULL,
idComprador SMALLINT,
idProducto SMALLINT UNSIGNED,
PRIMARY KEY (idComprador),
CONSTRAINT fk_Compra_Producto FOREIGN KEY (idProducto)	
	REFERENCES Producto(idProducto),
CONSTRAINT fk_Compra_Usuario FOREIGN KEY (idComprador)
	REFERENCES Usuario(idUsuario)
);

-- Restricciones de Unicidad

ALTER TABLE `Usuario`
ADD CONSTRAINT `UQ_Usuario_email` UNIQUE (`email`);
