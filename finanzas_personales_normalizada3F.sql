-- Crear la base de datos
CREATE DATABASE finanzas_personales;

-- Usar la base de datos
USE finanzas_personales;

-- Crear la tabla Usuario
CREATE TABLE Usuario (
    ID_Usuario INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100),
    Correo_Electronico VARCHAR(100) UNIQUE,
    Contraseña VARCHAR(100),
    Numero_Identificacion VARCHAR(50) UNIQUE,
    Telefono VARCHAR(20),
    Fecha_Creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Fecha_Modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Crear la tabla Gasto
CREATE TABLE Gasto (
    ID_Gasto INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT,
    Categoria VARCHAR(50),
    Cantidad DECIMAL(10, 2),
    Recurrencia VARCHAR(50),
    Cantidad_Cuotas INT,
    Fecha_Gasto DATE,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario)
);

-- Crear la tabla Inversión
CREATE TABLE Inversión (
    ID_Inversión INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT,
    Tipo_Inversión VARCHAR(50),
    Monto DECIMAL(10, 2),
    Porcentaje_Mensual DECIMAL(5, 2),
    Fecha_Inversión DATE,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario)
);

-- Crear la tabla Meta_Ahorro
CREATE TABLE Meta_Ahorro (
    ID_Meta INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT,
    Monto_Ahorro DECIMAL(10, 2),
    Cuotas INT,
    Plazo INT,
    Categoria VARCHAR(50),
    Fecha_Meta DATE,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario)
);

-- Crear la tabla Categoría
CREATE TABLE Categoría (
    ID_Categoría INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT,
    Nombre_Categoría VARCHAR(50),
    Tipo ENUM('Ingreso', 'Pasivo'),
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario)
);

-- Crear la tabla Tarjeta_Crédito
CREATE TABLE Tarjeta_Crédito (
    ID_Tarjeta INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT,
    Numero_Tarjeta VARCHAR(20),
    Fecha_Expiracion DATE,
    CVV VARCHAR(4),
    Cupo_Disponible DECIMAL(10, 2),
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario)
);

-- Crear la tabla Movimiento_Tarjeta
CREATE TABLE Movimiento_Tarjeta (
    ID_Movimiento INT AUTO_INCREMENT PRIMARY KEY,
    ID_Tarjeta INT,
    Monto DECIMAL(10, 2),
    Intereses DECIMAL(5, 2),
    Cantidad_Cuotas INT,
    Fecha_Movimiento DATE,
    FOREIGN KEY (ID_Tarjeta) REFERENCES Tarjeta_Crédito(ID_Tarjeta)
);

-- Crear la tabla Reporte
CREATE TABLE Reporte (
    ID_Reporte INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT,
    Tipo_Reporte ENUM('Gastos', 'Ingresos', 'Inversiones'),
    Fecha_Reporte DATE,
    Detalle TEXT,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario)
);

-- Ver las tablas en la base de datos
SHOW TABLES;

-- Ver el contenido de la tabla CATEGORIA
SELECT * FROM CATEGORÍA;

