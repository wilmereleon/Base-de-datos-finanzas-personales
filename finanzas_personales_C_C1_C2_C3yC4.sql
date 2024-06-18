-- Crear la base de datos
CREATE DATABASE finanzas_personales_C;

-- Usar la base de datos
USE finanzas_personales_c;

-- Documentación: Bloque de creación de tablas y atributos
-- Nota: Este bloque no incluye definición de llaves primarias, llaves foráneas ni condiciones de nulidad.

-- Crear la tabla Usuario
CREATE TABLE Usuario (
    ID_Usuario INT AUTO_INCREMENT,
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
    ID_Gasto INT AUTO_INCREMENT,
    ID_Usuario INT,
    Categoria VARCHAR(50),
    Cantidad DECIMAL(10, 2),
    Recurrencia VARCHAR(50),
    Cantidad_Cuotas INT,
    Fecha_Gasto DATE
);

-- Crear la tabla Inversión
CREATE TABLE Inversión (
    ID_Inversión INT AUTO_INCREMENT,
    ID_Usuario INT,
    Tipo_Inversión VARCHAR(50),
    Monto DECIMAL(10, 2),
    Porcentaje_Mensual DECIMAL(5, 2),
    Fecha_Inversión DATE
);

-- Crear la tabla Meta_Ahorro
CREATE TABLE Meta_Ahorro (
    ID_Meta INT AUTO_INCREMENT,
    ID_Usuario INT,
    Monto_Ahorro DECIMAL(10, 2),
    Cuotas INT,
    Plazo INT,
    Categoria VARCHAR(50),
    Fecha_Meta DATE
);

-- Crear la tabla Categoría
CREATE TABLE Categoría (
    ID_Categoría INT AUTO_INCREMENT,
    ID_Usuario INT,
    Nombre_Categoría VARCHAR(50),
    Tipo ENUM('Ingreso', 'Pasivo')
);

-- Crear la tabla Tarjeta_Crédito
CREATE TABLE Tarjeta_Crédito (
ID_Tarjeta INT AUTO_INCREMENT,
    ID_Usuario INT,
    Numero_Tarjeta VARCHAR(20),
    Fecha_Expiracion DATE,
    CVV VARCHAR(4),
    Cupo_Disponible DECIMAL(10, 2)
);

-- Crear la tabla Movimiento_Tarjeta
CREATE TABLE Movimiento_Tarjeta (
    ID_Movimiento INT AUTO_INCREMENT,
    ID_Tarjeta INT,
    Monto DECIMAL(10, 2),
    Intereses DECIMAL(5, 2),
    Cantidad_Cuotas INT,
    Fecha_Movimiento DATE
);

-- Crear la tabla Reporte
CREATE TABLE Reporte (
    ID_Reporte INT AUTO_INCREMENT,
    ID_Usuario INT,
    Tipo_Reporte ENUM('Gastos', 'Ingresos', 'Inversiones'),
    Fecha_Reporte DATE,
    Detalle TEXT
);

-- Documentación: Bloque de modificación de tablas
-- Nota: Este bloque incluye la definición de llaves primarias, llaves foráneas y condiciones de nulidad.

ALTER TABLE Usuario ADD PRIMARY KEY (ID_Usuario);
ALTER TABLE Usuario MODIFY Correo_Electronico VARCHAR(100) NOT NULL UNIQUE;
ALTER TABLE Usuario MODIFY Numero_Identificacion VARCHAR(50) NOT NULL UNIQUE;
ALTER TABLE Usuario ADD FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario);

ALTER TABLE Gasto ADD PRIMARY KEY (ID_Gasto);
ALTER TABLE Gasto MODIFY ID_Usuario INT NOT NULL;
ALTER TABLE Gasto MODIFY Categoria VARCHAR(50) NOT NULL;
ALTER TABLE Gasto MODIFY Fecha_Gasto DATE NOT NULL;
ALTER TABLE Gasto ADD FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario);

-- Definición de llaves primarias y foráneas para la tabla Inversión
ALTER TABLE Inversión ADD PRIMARY KEY (ID_Inversión);
ALTER TABLE Inversión MODIFY ID_Usuario INT NOT NULL;
ALTER TABLE Inversión ADD FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario);

-- Definición de llaves primarias y foráneas para la tabla Meta_Ahorro
ALTER TABLE Meta_Ahorro ADD PRIMARY KEY (ID_Meta);
ALTER TABLE Meta_Ahorro MODIFY ID_Usuario INT NOT NULL;
ALTER TABLE Meta_Ahorro ADD FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario);

-- Definición de llaves primarias y foráneas para la tabla Categoría
ALTER TABLE Categoría ADD PRIMARY KEY (ID_Categoría);
ALTER TABLE Categoría MODIFY ID_Usuario INT NOT NULL;
ALTER TABLE Categoría ADD FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario);

-- Definición de llaves primarias y foráneas para la tabla Tarjeta_Crédito
ALTER TABLE Tarjeta_Crédito ADD PRIMARY KEY (ID_Tarjeta);
ALTER TABLE Tarjeta_Crédito MODIFY ID_Usuario INT NOT NULL;
ALTER TABLE Tarjeta_Crédito ADD FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario);

-- Definición de llaves primarias y foráneas para la tabla Movimiento_Tarjeta
ALTER TABLE Movimiento_Tarjeta ADD PRIMARY KEY (ID_Movimiento);
ALTER TABLE Movimiento_Tarjeta MODIFY ID_Tarjeta INT NOT NULL;
ALTER TABLE Movimiento_Tarjeta ADD FOREIGN KEY (ID_Tarjeta) REFERENCES Tarjeta_Crédito(ID_Tarjeta);

-- Definición de llaves primarias y foráneas para la tabla Reporte
ALTER TABLE Reporte ADD PRIMARY KEY (ID_Reporte);
ALTER TABLE Reporte MODIFY ID_Usuario INT NOT NULL;
ALTER TABLE Reporte ADD FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario);

-- Documentación: Bloque de inclusión de índices adicionales
-- Nota: Este bloque incluye la creación de índices para optimizar las consultas.

CREATE INDEX idx_correo ON Usuario(Correo_Electronico);
CREATE INDEX idx_identificacion ON Usuario(Numero_Identificacion);
CREATE INDEX idx_usuario_gasto ON Gasto(ID_Usuario);
CREATE INDEX idx_categoria_gasto ON Gasto(Categoria);

-- Índices para la tabla Inversión
CREATE INDEX idx_usuario_inversion ON Inversión(ID_Usuario);
CREATE INDEX idx_tipo_inversion ON Inversión(Tipo_Inversión);

-- Índices para la tabla Meta_Ahorro
CREATE INDEX idx_usuario_meta ON Meta_Ahorro(ID_Usuario);
CREATE INDEX idx_categoria_meta ON Meta_Ahorro(Categoria);

-- Índices para la tabla Categoría
CREATE INDEX idx_usuario_categoria ON Categoría(ID_Usuario);
CREATE INDEX idx_nombre_categoria ON Categoría(Nombre_Categoría);

-- Índices para la tabla Tarjeta_Crédito
CREATE INDEX idx_usuario_tarjeta ON Tarjeta_Crédito(ID_Usuario);
CREATE INDEX idx_numero_tarjeta ON Tarjeta_Crédito(Numero_Tarjeta);

-- Índices para la tabla Movimiento_Tarjeta
CREATE INDEX idx_tarjeta_movimiento ON Movimiento_Tarjeta(ID_Tarjeta);
CREATE INDEX idx_fecha_movimiento ON Movimiento_Tarjeta(Fecha_Movimiento);

-- Índices para la tabla Reporte
CREATE INDEX idx_usuario_reporte ON Reporte(ID_Usuario);
CREATE INDEX idx_tipo_reporte ON Reporte(Tipo_Reporte);

-- Fin del script