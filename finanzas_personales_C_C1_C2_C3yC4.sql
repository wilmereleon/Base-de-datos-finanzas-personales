-- Crear la base de datos
CREATE DATABASE finanzas_personales_C;

-- Usar la base de datos
USE finanzas_personales_C;

-- Documentación: Bloque de creación de tablas y atributos
-- Nota: Este bloque no incluye definición de llaves primarias, llaves foráneas ni condiciones de nulidad.

-- Crear la tabla Usuario
CREATE TABLE Usuario (
    Nombre VARCHAR(100),
    Correo_Electronico VARCHAR(100),
    Contraseña VARCHAR(100),
    Numero_Identificacion VARCHAR(50),
    Telefono VARCHAR(20),
    Fecha_Creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Fecha_Modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Crear la tabla Gasto
CREATE TABLE Gasto (
    Monto DECIMAL(10,2),
    Fecha_Gasto DATE,
    Descripción VARCHAR(255),
    ID_Categoría INT
);

-- Crear la tabla Inversión
CREATE TABLE Inversión (
    Monto DECIMAL(10, 2),
    Porcentaje_Mensual DECIMAL(5, 2),
    Fecha_Inversión DATE
);

-- Crear la tabla Meta_Ahorro
CREATE TABLE Meta_Ahorro (
    Monto DECIMAL(10,2),
    Fecha_Meta DATE,
    Descripción VARCHAR(255)
);

-- Crear la tabla Categoría
CREATE TABLE Categoría (
    Nombre VARCHAR(50),
    Descripción VARCHAR(255)
);

-- Crear la tabla Tarjeta_Crédito
CREATE TABLE Tarjeta_Crédito (
    Numero_Tarjeta VARCHAR(20),
    Fecha_Expiración DATE,
    CVV VARCHAR(5)
);

-- Crear la tabla Movimiento_Tarjeta
CREATE TABLE Movimiento_Tarjeta (
    Monto DECIMAL(10,2),
    Fecha_Movimiento DATE,
    Descripción VARCHAR(255)
);

-- Crear la tabla Reporte
CREATE TABLE Reporte (
    Fecha_Reporte DATE,
    Descripción VARCHAR(255)
);

-- Documentación: Bloque de modificación de tablas
-- Nota: Este bloque incluye la definición de llaves primarias, llaves foráneas y condiciones de nulidad.
ALTER TABLE Usuario ADD ID_Usuario INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE Usuario MODIFY Correo_Electronico VARCHAR(100) NOT NULL UNIQUE;
ALTER TABLE Usuario MODIFY Numero_Identificacion VARCHAR(50) NOT NULL UNIQUE;

-- Agregar ID_Gasto como llave primaria y ID_Usuario como llave foránea a la tabla Gasto
ALTER TABLE Gasto ADD ID_Gasto INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE Gasto ADD ID_Usuario INT;
ALTER TABLE Gasto ADD FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario);

-- Agregar ID_Inversión como llave primaria y ID_Usuario como llave foránea a la tabla Inversión
ALTER TABLE Inversión ADD ID_Inversión INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE Inversión ADD ID_Usuario INT;
ALTER TABLE Inversión ADD FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario);

-- Agregar ID_Meta como llave primaria y ID_Usuario como llave foránea a la tabla Meta_Ahorro
ALTER TABLE Meta_Ahorro ADD ID_Meta INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE Meta_Ahorro ADD ID_Usuario INT;
ALTER TABLE Meta_Ahorro ADD FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario);

-- Agregar ID_Categoría como llave primaria y ID_Usuario como llave foránea a la tabla Categoría
ALTER TABLE Categoría ADD ID_Categoría INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE Categoría ADD ID_Usuario INT;
ALTER TABLE Categoría ADD FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario);

-- Establecer la relación de llave foránea con la tabla Categoría
ALTER TABLE Gasto ADD FOREIGN KEY (ID_Categoría) REFERENCES Categoría(ID_Categoría);

-- Agregar ID_Tarjeta como llave primaria y ID_Usuario como llave foránea a la tabla Tarjeta_Crédito
ALTER TABLE Tarjeta_Crédito ADD ID_Tarjeta INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE Tarjeta_Crédito ADD ID_Usuario INT;
ALTER TABLE Tarjeta_Crédito ADD FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario);

-- Agregar ID_Movimiento como llave primaria y ID_Tarjeta como llave foránea a la tabla Movimiento_Tarjeta
ALTER TABLE Movimiento_Tarjeta ADD ID_Movimiento INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE Movimiento_Tarjeta ADD ID_Tarjeta INT;
ALTER TABLE Movimiento_Tarjeta ADD FOREIGN KEY (ID_Tarjeta) REFERENCES Tarjeta_Crédito(ID_Tarjeta);

-- Agregar ID_Reporte como llave primaria y ID_Usuario como llave foránea a la tabla Reporte
ALTER TABLE Reporte ADD ID_Reporte INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE Reporte ADD ID_Usuario INT;
ALTER TABLE Reporte ADD FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario);

-- Documentación: Bloque de inclusión de índices adicionales
-- Nota: Este bloque incluye la creación de índices para optimizar las consultas.

CREATE INDEX idx_correo ON Usuario(Correo_Electronico);
CREATE INDEX idx_identificacion ON Usuario(Numero_Identificacion);
CREATE INDEX idx_usuario_gasto ON Gasto(ID_Usuario);

-- Índices para la tabla Inversión
CREATE INDEX idx_usuario_inversion ON Inversión(ID_Usuario);

-- Índices para la tabla Meta_Ahorro
CREATE INDEX idx_usuario_meta ON Meta_Ahorro(ID_Usuario);

-- Índices para la tabla Categoría
CREATE INDEX idx_usuario_categoria ON Categoría(ID_Usuario);

-- Índices para la tabla Tarjeta_Crédito
CREATE INDEX idx_usuario_tarjeta ON Tarjeta_Crédito(ID_Usuario);
CREATE INDEX idx_numero_tarjeta ON Tarjeta_Crédito(Numero_Tarjeta);

-- Índices para la tabla Movimiento_Tarjeta
CREATE INDEX idx_tarjeta_movimiento ON Movimiento_Tarjeta(ID_Tarjeta);
CREATE INDEX idx_fecha_movimiento ON Movimiento_Tarjeta(Fecha_Movimiento);

-- Índices para la tabla Reporte
CREATE INDEX idx_usuario_reporte ON Reporte(ID_Usuario);

-- Fin del script