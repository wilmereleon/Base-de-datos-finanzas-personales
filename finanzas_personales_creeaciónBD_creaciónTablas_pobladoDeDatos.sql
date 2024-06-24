-- Crear la base de datos
CREATE DATABASE finanzas_personales_C;

-- Usar la base de datos
USE finanzas_personales_C;

-- (C1)
-- Documentación: Bloque de creación de tablas y atributos


-- (C2)
-- Nota: Este bloque no incluye definición de llaves primarias, llaves foráneas ni condiciones de nulidad, por lo tanto, se agreganlas columnas
-- con las llaves primarias y foráneas con instrucciones ALTER TABLE para garantizar que el código de la creación genere las relaciones correctas
-- entre cada una de las tablas.

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

-- (C3)
-- Documentación: Bloque de modificación de tablas
-- Nota: Este bloque incluye la definición de llaves primarias, llaves foráneas y condiciones de nulidad (se modifican dos atributos de cada tabla conm la instrucción MODIFY
-- en la tabla usuario, se crean las columnas con su llave primaria para poder efectuar las relaciones y se crean las llaves foráneas).
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
-- Nota: Este bloque incluye la creación de índices para optimizar las consultas (se establecen las más importantes y que puedan ser relevantes para la
-- optimización de búsquedas y captación de datos vitales para el negocio).

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

-- (D)
-- Documentación: Bloque de poblado de base de datos

-- Inserciones en la tabla Usuario
INSERT INTO Usuario (Nombre, Correo_Electronico, Contraseña, Numero_Identificacion, Telefono)
VALUES
    ('Juan A. Pérez', 'juanA@example.com', 'secretos123', '20145852', '3214785512'),
    ('María Rodríguez', 'maria@example.com', 'clave456', '1022714559', '3147318590'),
    ('Carlos María López', 'carlosM@example.com', 'contrasenna789', '1021416652', '3118452201'),
    ('Sebastián Téllez', 'sebaste@example.com', 'contrasenna985', '1025895410', '3154857401'),
    ('David González', 'judazalez@example.com', 'admin1234', '1024581436', '3054108736')
    ;

-- Inserciones en la tabla Inversión
INSERT INTO Inversión (Monto, Porcentaje_Mensual, Fecha_Inversión, ID_Usuario)
VALUES
    (500000.00, 0.20, '2024-06-15', 1),
    (300000.00, 0.10, '2024-06-18', 2),
    (200000.00, 0.15, '2024-06-20', 3),
    (600000.00, 0.40, '2024-06-20', 4),
    (120000.00, 0.25, '2024-06-22', 5)
    ;

-- Inserciones en la tabla Meta_Ahorro
INSERT INTO Meta_Ahorro (Monto, Fecha_Meta, Descripción, ID_Usuario)
VALUES
    (200000.00, '2024-06-30', 'Vacaciones', 1),
    (150000.00, '2024-07-15', 'Electrodomésticos', 2),
    (1000000.00, '2024-06-25', 'Mejoras en la vivienda', 3),
    (100000.00, '2024-06-30', 'Emergencia', 4),
    (550000.00, '2024-06-15', 'Inicio de negocio', 5)
    ;

-- Inserciones en la tabla Categoría
INSERT INTO Categoría (Nombre, Descripción, ID_Usuario)
VALUES
    ('Alimentación', 'Gastos relacionados con comida', 1),
    ('Transporte', 'Gastos de transporte público o gasolina', 2),
    ('Entretenimiento', 'Cine, conciertos, etc.', 3),
    ('Impuestos', 'Renta, Predial, Movilidad', 4),
    ('Donaciones', 'Poli, IDRD, CRAC', 5)
    ;

-- Inserciones en la tabla Tarjeta_Crédito
INSERT INTO Tarjeta_Crédito (Numero_Tarjeta, Fecha_Expiración, CVV, ID_Usuario)
VALUES
    ('4025654178451024', '2025-12-31', '123', 1),
    ('4215741585691025', '2026-06-30', '456', 2),
    ('4178851299601026', '2025-09-30', '789', 3),
    ('4023418975121027', '2025-09-30', '801', 4),
    ('4458187456921028', '2025-09-30', '122', 5)
    ;

-- Inserciones en la tabla Movimiento_Tarjeta
INSERT INTO Movimiento_Tarjeta (Monto, Fecha_Movimiento, Descripción, ID_Tarjeta)
VALUES
    (150000.00, '2024-06-22', 'Compra en línea', 1),
    (75500.00, '2024-06-23', 'Restaurante', 2),
    (800000.00, '2024-06-24', 'Tienda de ropa Koaj', 3),
    (500000.00, '2024-06-25', 'Tienda de ropa Koaj', 4),
    (514000.00, '2024-06-27', 'Tienda de ropa Arena', 5)
    ;

-- Inserciones en la tabla Reporte
INSERT INTO Reporte (Fecha_Reporte, Descripción, ID_Usuario)
VALUES
    ('2024-06-30', 'Resumen mensual de gastos', 1),
    ('2024-06-30', 'Informe de inversiones', 2),
    ('2024-06-30', 'Estado de metas de ahorro', 3),
    ('2024-06-30', 'Estado de metas de ahorro', 4),
    ('2024-06-30', 'Informe de inversiones', 5)
    ;
    
    -- Inserciones en la tabla Gasto
INSERT INTO Gasto (Monto, Fecha_Gasto, Descripción, ID_Categoría, ID_Usuario)
VALUES
    (185000.00, '2024-06-20', 'Comida', 1, 1),
    (985630.00, '2024-06-21', 'Transporte', 2, 2),
    (789000.00, '2024-06-22', 'Entretenimiento', 3, 3),
    (150000.00, '2024-06-23', 'Ropa', 4, 4),
    (1200000.00, '2024-06-24', 'Arriendo', 5, 5)
    ;

-- Consultas simples
SHOW TABLES;

SELECT * FROM categoría;

SELECT * FROM gasto;

SELECT * FROM inversión;

SELECT * FROM meta_ahorro;

SELECT * FROM movimiento_tarjeta;

SELECT * FROM reporte;

SELECT * FROM tarjeta_crédito;

SELECT * FROM usuario;
