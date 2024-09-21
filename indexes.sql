-- Índices para optimización de consultas
CREATE INDEX idx_cliente_email ON Clientes (Email);
CREATE INDEX idx_producto_categoria ON Productos (CategoriaID);
CREATE INDEX idx_pedido_cliente ON Pedidos (ClienteID);
CREATE INDEX idx_detalle_pedido ON DetallesPedido (PedidoID);
