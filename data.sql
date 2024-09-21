-- Insertar Categorías
INSERT INTO Categorías (NombreCategoria) VALUES ('Electrónica'), ('Ropa'), ('Hogar');

-- Insertar Productos
INSERT INTO Productos (NombreProducto, Descripción, Precio, Stock, CategoriaID)
VALUES 
('Smartphone', 'Teléfono inteligente con pantalla de 6 pulgadas', 299.99, 50, 1),
('Televisor', 'Televisor de 50 pulgadas 4K', 599.99, 30, 1),
('Pantalón', 'Pantalón de algodón para hombre', 29.99, 100, 2),
('Mesa de comedor', 'Mesa de madera para 6 personas', 199.99, 20, 3);

-- Insertar Clientes
INSERT INTO Clientes (Nombre, Email, Dirección)
VALUES 
('Jorge Álvarez', 'jorge@example.com', 'Calle Falsa 123, Ciudad'),
('María Pérez', 'maria@example.com', 'Av. Siempre Viva 456, Ciudad');

-- Insertar Pedidos y Detalles
INSERT INTO Pedidos (ClienteID) VALUES (1), (2);

INSERT INTO DetallesPedido (PedidoID, ProductoID, Cantidad, PrecioUnitario)
VALUES 
(1, 1, 2, 299.99),
(1, 3, 1, 29.99),
(2, 2, 1, 599.99),
(2, 4, 1, 199.99);

-- Insertar Facturas
INSERT INTO Facturación (PedidoID, Total) VALUES (1, 629.97), (2, 799.98);

-- Insertar Reseñas
INSERT INTO Reseñas (ProductoID, ClienteID, Calificación, Comentario)
VALUES
(1, 1, 4, 'Buen teléfono, aunque esperaba una mejor batería.'),
(3, 2, 5, 'Muy cómodo y de buena calidad.');

-- Insertar Productos Relacionados
INSERT INTO ProductosRelacionados (ProductoBaseID, ProductoRelacionadoID, Relevancia)
VALUES 
(1, 2, 5), -- Smartphone y Televisor (asociación alta)
(3, 4, 3); -- Pantalón y Mesa de comedor (asociación moderada)
