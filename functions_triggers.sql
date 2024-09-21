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
