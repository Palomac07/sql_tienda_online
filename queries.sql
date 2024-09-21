-- Consulta para mostrar los productos más vendidos
SELECT p.NombreProducto, SUM(dp.Cantidad) AS TotalVendido
FROM DetallesPedido dp
JOIN Productos p ON dp.ProductoID = p.ProductoID
GROUP BY p.NombreProducto
ORDER BY TotalVendido DESC;

-- Consultar clientes y su total de compras
SELECT c.Nombre, SUM(f.Total) AS TotalCompras
FROM Facturación f
JOIN Pedidos p ON f.PedidoID = p.PedidoID
JOIN Clientes c ON p.ClienteID = c.ClienteID
GROUP BY c.Nombre
ORDER BY TotalCompras DESC;

-- Consultar productos con menos de 10 unidades en stock
SELECT NombreProducto, Stock
FROM Productos
WHERE Stock < 10;

-- Recomendación de productos basados en compras anteriores
SELECT p.NombreProducto, COUNT(dp2.ProductoID) AS CompradosJuntos
FROM DetallesPedido dp1
JOIN DetallesPedido dp2 ON dp1.PedidoID = dp2.PedidoID AND dp1.ProductoID != dp2.ProductoID
JOIN Productos p ON dp2.ProductoID = p.ProductoID
WHERE dp1.ProductoID = 1 -- ID del producto actual
GROUP BY p.NombreProducto
ORDER BY CompradosJuntos DESC;

-- Consultar productos más populares dentro de la misma categoría
SELECT p.NombreProducto, COUNT(dp.ProductoID) AS Popularidad
FROM DetallesPedido dp
JOIN Productos p ON dp.ProductoID = p.ProductoID
WHERE p.CategoriaID = (SELECT CategoriaID FROM Productos WHERE ProductoID = 1) -- Producto actual
GROUP BY p.NombreProducto
ORDER BY Popularidad DESC;
