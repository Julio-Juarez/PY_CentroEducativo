create database CentroEducativo
go
use CentroEducativo
go
CREATE TABLE Estudiante (
    id_estudiante INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    fecha_nacimiento DATE,
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo VARCHAR(100),
    grado VARCHAR(50)
);
go
CREATE TABLE Profesor (
    id_profesor INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    fecha_nacimiento DATE,
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    correo VARCHAR(100)
);
go
CREATE TABLE Asignatura (
    id_asignatura INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50),
    codigo VARCHAR(20),
    descripcion VARCHAR(250)
);
go
CREATE TABLE Clase (
    id_clase INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50),
    codigo VARCHAR(20) UNIQUE,
    horario VARCHAR(50),
    id_asignatura INT,
    id_profesor INT,
    FOREIGN KEY (id_asignatura) REFERENCES Asignatura(id_asignatura),
    FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor)
);
go
CREATE TABLE TipoEvaluacion (
    id_tipo_evaluacion INT IDENTITY(1,1) PRIMARY KEY,
    descripcion VARCHAR(50)
);
go
CREATE TABLE Evaluacion (
    id_evaluacion INT IDENTITY(1,1) PRIMARY KEY,
    id_estudiante INT,
    id_clase INT,
    id_tipo_evaluacion INT,
    nota DECIMAL(5,2),
    fecha DATE,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante),
    FOREIGN KEY (id_clase) REFERENCES Clase(id_clase),
    FOREIGN KEY (id_tipo_evaluacion) REFERENCES TipoEvaluacion(id_tipo_evaluacion)
);
go
-- Tabla de Productos (pueden ser bienes o servicios)
CREATE TABLE Producto (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200),
    precio DECIMAL(10,2) NOT NULL,
    tipo VARCHAR(50) -- Ejemplo: 'Librería', 'Mensualidad', 'Inscripción', 'Examen'
);
go
-- Factura: encabezado
CREATE TABLE Factura (
    id_factura INT IDENTITY(1,1) PRIMARY KEY,
    id_estudiante INT NOT NULL,
    fecha DATE DEFAULT GETDATE(),
    total DECIMAL(12,2),
    FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante)
);
go
-- Detalle de factura
CREATE TABLE DetalleFactura (
    id_detalle INT IDENTITY(1,1) PRIMARY KEY,
    id_factura INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal AS (cantidad * precio_unitario) PERSISTED, -- Calculado automáticamente
    FOREIGN KEY (id_factura) REFERENCES Factura(id_factura),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);