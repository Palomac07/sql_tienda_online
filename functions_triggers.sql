-- Trigger para actualizar el stock después de realizar un pedido
CREATE TRIGGER actualizar_stock
AFTER INSERT ON DetallesPedido
FOR EACH ROW
BEGIN
    UPDATE Productos
    SET Stock = Stock - NEW.Cantidad
    WHERE ProductoID = NEW.ProductoID;
END;

-- Trigger para validar fecha de vencimiento de descuentos personalizados
CREATE TRIGGER validar_descuento
BEFORE INSERT ON DescuentosPersonalizados
FOR EACH ROW
BEGIN
    IF NEW.FechaFin <= NEW.FechaInicio THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de fin debe ser posterior a la fecha de inicio';
    END IF;
END;

-- Trigger para detectar y registrar productos duplicados en un pedido
CREATE TRIGGER prevenir_productos_duplicados
BEFORE INSERT ON DetallesPedido
FOR EACH ROW
BEGIN
    DECLARE producto_existe INT;

    -- Verificar si el producto ya existe en este pedido
    SELECT COUNT(*) INTO producto_existe
    FROM DetallesPedido
    WHERE PedidoID = NEW.PedidoID AND ProductoID = NEW.ProductoID;

    -- Si el producto ya existe, registrar el intento y bloquear la inserción
    IF producto_existe > 0 THEN
        -- Registrar el intento de duplicado
        INSERT INTO ProductosDuplicados (PedidoID, ProductoID, CantidadIntentada, PrecioUnitario)
        VALUES (NEW.PedidoID, NEW.ProductoID, NEW.Cantidad, NEW.PrecioUnitario);

        -- Bloquear la inserción duplicada
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede agregar el mismo producto dos veces al mismo pedido';
    END IF;
END;
