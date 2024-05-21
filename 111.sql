-- Tabla Restaurante
CREATE TABLE Restaurante (
    RestauranteID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Direccion VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20) NOT NULL
);

-- Tabla Empleado
CREATE TABLE Empleado (
    EmpleadoID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Puesto VARCHAR(50) NOT NULL,
    FechaContratacion DATE NOT NULL,
    RestauranteID INT,
    FOREIGN KEY (RestauranteID) REFERENCES Restaurante(RestauranteID)
);

-- Tabla Cliente
CREATE TABLE Cliente (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    Email VARCHAR(50) NOT NULL
);

-- Tabla Proveedor
CREATE TABLE Proveedor (
    ProveedorID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Direccion VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    Email VARCHAR(50) NOT NULL
);

-- Tabla Categoria
CREATE TABLE Categoria (
    CategoriaID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(100)
);

-- Tabla Plato
CREATE TABLE Plato (
    PlatoID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(100) NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    CategoriaID INT,
    FOREIGN KEY (CategoriaID) REFERENCES Categoria(CategoriaID)
);

-- Tabla Ingrediente
CREATE TABLE Ingrediente (
    IngredienteID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(100),
    Unidad VARCHAR(20) NOT NULL,
    PrecioUnidad DECIMAL(10, 2) NOT NULL,
    ProveedorID INT,
    FOREIGN KEY (ProveedorID) REFERENCES Proveedor(ProveedorID)
);

-- Tabla PlatoIngrediente
CREATE TABLE PlatoIngrediente (
    PlatoID INT,
    IngredienteID INT,
    Cantidad DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (PlatoID, IngredienteID),
    FOREIGN KEY (PlatoID) REFERENCES Plato(PlatoID),
    FOREIGN KEY (IngredienteID) REFERENCES Ingrediente(IngredienteID)
);

-- Tabla Pedido
CREATE TABLE Pedido (
    PedidoID INT AUTO_INCREMENT PRIMARY KEY,
    FechaPedido DATE NOT NULL,
    ClienteID INT,
    EmpleadoID INT,
    RestauranteID INT,
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID),
    FOREIGN KEY (EmpleadoID) REFERENCES Empleado(EmpleadoID),
    FOREIGN KEY (RestauranteID) REFERENCES Restaurante(RestauranteID)
);

-- Tabla PedidoPlato
CREATE TABLE PedidoPlato (
    PedidoID INT,
    PlatoID INT,
    Cantidad INT NOT NULL,
    PRIMARY KEY (PedidoID, PlatoID),
    FOREIGN KEY (PedidoID) REFERENCES Pedido(PedidoID),
    FOREIGN KEY (PlatoID) REFERENCES Plato(PlatoID)
);

-- Tabla Factura
CREATE TABLE Factura (
    FacturaID INT AUTO_INCREMENT PRIMARY KEY,
    FechaFactura DATE NOT NULL,
    Total DECIMAL(10, 2) NOT NULL,
    PedidoID INT,
    FOREIGN KEY (PedidoID) REFERENCES Pedido(PedidoID)
);

-- Tabla MetodoPago
CREATE TABLE MetodoPago (
    MetodoPagoID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(100)
);

-- Tabla FacturaMetodoPago
CREATE TABLE FacturaMetodoPago (
    FacturaID INT,
    MetodoPagoID INT,
    Monto DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (FacturaID, MetodoPagoID),
    FOREIGN KEY (FacturaID) REFERENCES Factura(FacturaID),
    FOREIGN KEY (MetodoPagoID) REFERENCES MetodoPago(MetodoPagoID)
);

-- Tabla Mesa
CREATE TABLE Mesa (
    MesaID INT AUTO_INCREMENT PRIMARY KEY,
    NumeroMesa INT NOT NULL,
    Capacidad INT NOT NULL,
    RestauranteID INT,
    FOREIGN KEY (RestauranteID) REFERENCES Restaurante(RestauranteID)
);

-- Tabla Reserva
CREATE TABLE Reserva (
    ReservaID INT AUTO_INCREMENT PRIMARY KEY,
    FechaReserva DATE NOT NULL,
    HoraReserva TIME NOT NULL,
    ClienteID INT,
    MesaID INT,
    EmpleadoID INT,
    RestauranteID INT,
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID),
    FOREIGN KEY (MesaID) REFERENCES Mesa(MesaID),
    FOREIGN KEY (EmpleadoID) REFERENCES Empleado(EmpleadoID),
    FOREIGN KEY (RestauranteID) REFERENCES Restaurante(RestauranteID)
);

-- Tabla Comentario
CREATE TABLE Comentario (
    ComentarioID INT AUTO_INCREMENT PRIMARY KEY,
    Texto VARCHAR(500) NOT NULL,
    Calificacion INT NOT NULL,
    FechaComentario DATE NOT NULL,
    ClienteID INT,
    RestauranteID INT,
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID),
    FOREIGN KEY (RestauranteID) REFERENCES Restaurante(RestauranteID)
);

-- Tabla Inventario
CREATE TABLE Inventario (
    InventarioID INT AUTO_INCREMENT PRIMARY KEY,
    Cantidad DECIMAL(10, 2) NOT NULL,
    FechaInventario DATE NOT NULL,
    IngredienteID INT,
    RestauranteID INT,
    FOREIGN KEY (IngredienteID) REFERENCES Ingrediente(IngredienteID),
    FOREIGN KEY (RestauranteID) REFERENCES Restaurante(RestauranteID)
);

-- Tabla Turno
CREATE TABLE Turno (
    TurnoID INT AUTO_INCREMENT PRIMARY KEY,
    Descripcion VARCHAR(50) NOT NULL,
    HoraInicio TIME NOT NULL,
    HoraFin TIME NOT NULL
);

-- Tabla EmpleadoTurno
CREATE TABLE EmpleadoTurno (
    EmpleadoID INT,
    TurnoID INT,
    FechaAsignacion DATE NOT NULL,
    PRIMARY KEY (EmpleadoID, TurnoID, FechaAsignacion),
    FOREIGN KEY (EmpleadoID) REFERENCES Empleado(EmpleadoID),
    FOREIGN KEY (TurnoID) REFERENCES Turno(TurnoID)
);

-- Tabla Menu
CREATE TABLE Menu (
    MenuID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(100),
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
    RestauranteID INT,
    FOREIGN KEY (RestauranteID) REFERENCES Restaurante(RestauranteID)
);

-- Tabla MenuPlato
CREATE TABLE MenuPlato (
    MenuID INT,
    PlatoID INT,
    PRIMARY KEY (MenuID, PlatoID),
    FOREIGN KEY (MenuID) REFERENCES Menu(MenuID),
    FOREIGN KEY (PlatoID) REFERENCES Plato(PlatoID)
);
