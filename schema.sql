-- Crear tabla de Categorías
CREATE TABLE Categorías (
    CategoriaID INT PRIMARY KEY AUTO_INCREMENT,
    NombreCategoria VARCHAR(100) NOT NULL
);

-- Crear tabla de Productos
CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY AUTO_INCREMENT,
    NombreProducto VARCHAR(100) NOT NULL,
    Descripción TEXT,
    Precio DECIMAL(10, 2) NOT NULL,
    Stock INT DEFAULT 0,
    CategoriaID INT,
    FOREIGN KEY (CategoriaID) REFERENCES Categorías(CategoriaID)
);

-- Crear tabla de Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Dirección TEXT
);

-- Crear tabla de Pedidos
CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY AUTO_INCREMENT,
    ClienteID INT,
    FechaPedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Crear tabla de Detalles de Pedidos
CREATE TABLE DetallesPedido (
    DetalleID INT PRIMARY KEY AUTO_INCREMENT,
    PedidoID INT,
    ProductoID INT,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

-- Crear tabla de Facturación
CREATE TABLE Facturación (
    FacturaID INT PRIMARY KEY AUTO_INCREMENT,
    PedidoID INT,
    FechaFactura DATETIME DEFAULT CURRENT_TIMESTAMP,
    Total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID)
);

-- Crear tabla de Productos Relacionados (para recomendaciones)
CREATE TABLE ProductosRelacionados (
    ProductoBaseID INT,
    ProductoRelacionadoID INT,
    Relevancia INT,
    PRIMARY KEY (ProductoBaseID, ProductoRelacionadoID),
    FOREIGN KEY (ProductoBaseID) REFERENCES Productos(ProductoID),
    FOREIGN KEY (ProductoRelacionadoID) REFERENCES Productos(ProductoID)
);

-- Crear tabla de Reseñas y Calificaciones
CREATE TABLE Reseñas (
    ReseñaID INT PRIMARY KEY AUTO_INCREMENT,
    ProductoID INT,
    ClienteID INT,
    Calificación INT CHECK (Calificación BETWEEN 1 AND 5),
    Comentario TEXT,
    FechaReseña DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Crear tabla de Descuentos Personalizados
CREATE TABLE DescuentosPersonalizados (
    DescuentoID INT PRIMARY KEY AUTO_INCREMENT,
    ClienteID INT,
    ProductoID INT,
    Descuento DECIMAL(5, 2),
    FechaInicio DATETIME,
    FechaFin DATETIME,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);
