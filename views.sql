-- Vista general de productos duplicados detectados
CREATE VIEW vista_productos_duplicados AS
SELECT
    pd.DuplicadoID,
    pd.PedidoID,
    pd.ProductoID,
    p.NombreProducto,
    pd.CantidadIntentada,
    pd.PrecioUnitario,
    pd.FechaIntento
FROM ProductosDuplicados pd
JOIN Productos p ON pd.ProductoID = p.ProductoID
ORDER BY pd.FechaIntento DESC;

-- Vista detallada de productos duplicados con información del cliente
CREATE VIEW vista_duplicados_detallada AS
SELECT
    pd.DuplicadoID,
    ped.PedidoID,
    ped.FechaPedido,
    c.ClienteID,
    c.Nombre AS NombreCliente,
    c.Email AS EmailCliente,
    p.ProductoID,
    p.NombreProducto,
    cat.NombreCategoria,
    pd.CantidadIntentada,
    pd.PrecioUnitario,
    (pd.CantidadIntentada * pd.PrecioUnitario) AS TotalIntentado,
    pd.FechaIntento
FROM ProductosDuplicados pd
JOIN Pedidos ped ON pd.PedidoID = ped.PedidoID
JOIN Clientes c ON ped.ClienteID = c.ClienteID
JOIN Productos p ON pd.ProductoID = p.ProductoID
LEFT JOIN Categorías cat ON p.CategoriaID = cat.CategoriaID
ORDER BY pd.FechaIntento DESC;

-- Vista de productos más frecuentemente duplicados
CREATE VIEW vista_productos_mas_duplicados AS
SELECT
    p.ProductoID,
    p.NombreProducto,
    cat.NombreCategoria,
    COUNT(pd.DuplicadoID) AS TotalIntentosDuplicados,
    SUM(pd.CantidadIntentada) AS CantidadTotalIntentada,
    MIN(pd.FechaIntento) AS PrimerIntento,
    MAX(pd.FechaIntento) AS UltimoIntento
FROM ProductosDuplicados pd
JOIN Productos p ON pd.ProductoID = p.ProductoID
LEFT JOIN Categorías cat ON p.CategoriaID = cat.CategoriaID
GROUP BY p.ProductoID, p.NombreProducto, cat.NombreCategoria
ORDER BY TotalIntentosDuplicados DESC;

-- Vista de clientes con más intentos de duplicados
CREATE VIEW vista_clientes_con_duplicados AS
SELECT
    c.ClienteID,
    c.Nombre AS NombreCliente,
    c.Email,
    COUNT(pd.DuplicadoID) AS TotalIntentosDuplicados,
    MIN(pd.FechaIntento) AS PrimerIntento,
    MAX(pd.FechaIntento) AS UltimoIntento
FROM ProductosDuplicados pd
JOIN Pedidos ped ON pd.PedidoID = ped.PedidoID
JOIN Clientes c ON ped.ClienteID = c.ClienteID
GROUP BY c.ClienteID, c.Nombre, c.Email
ORDER BY TotalIntentosDuplicados DESC;

-- Vista de duplicados por pedido
CREATE VIEW vista_duplicados_por_pedido AS
SELECT
    ped.PedidoID,
    ped.FechaPedido,
    c.Nombre AS NombreCliente,
    COUNT(pd.DuplicadoID) AS TotalDuplicados,
    GROUP_CONCAT(p.NombreProducto SEPARATOR ', ') AS ProductosDuplicados
FROM ProductosDuplicados pd
JOIN Pedidos ped ON pd.PedidoID = ped.PedidoID
JOIN Clientes c ON ped.ClienteID = c.ClienteID
JOIN Productos p ON pd.ProductoID = p.ProductoID
GROUP BY ped.PedidoID, ped.FechaPedido, c.Nombre
ORDER BY ped.FechaPedido DESC;
