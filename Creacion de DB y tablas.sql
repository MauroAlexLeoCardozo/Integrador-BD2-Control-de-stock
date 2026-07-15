create database ControlStockVeta
go

use ControlStockVeta
go

CREATE TABLE Empresa (
    ID INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(150) NOT NULL,
    Estado BIT NOT NULL CONSTRAINT DF_Empresa_Estado DEFAULT 1,
    CONSTRAINT PK_Empresa PRIMARY KEY (ID)
);
go

CREATE TABLE Rango (
    ID INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Estado BIT NOT NULL CONSTRAINT DF_Rango_Estado DEFAULT 1,
    CONSTRAINT PK_Rango PRIMARY KEY (ID)
);
go

CREATE TABLE TipoAcceso (
    ID INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Estado BIT NOT NULL CONSTRAINT DF_TipoAcceso_Estado DEFAULT 1,
    CONSTRAINT PK_TipoAcceso PRIMARY KEY (ID)
);
go

CREATE TABLE Persona (
    ID INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    DNI VARCHAR(20) NOT NULL,
    Nacimiento DATE NOT NULL,
    Estado BIT NOT NULL CONSTRAINT DF_Persona_Estado DEFAULT 1,
    CONSTRAINT PK_Persona PRIMARY KEY (ID)
);
go

CREATE TABLE Proveedor (
    ID INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(150) NOT NULL,
    Estado BIT NOT NULL CONSTRAINT DF_Proveedor_Estado DEFAULT 1,
    CONSTRAINT PK_Proveedor PRIMARY KEY (ID)
);
go

CREATE TABLE Departamento (
    ID INT IDENTITY(1,1) NOT NULL,
    IDEmpresa INT NOT NULL,
    Nombre VARCHAR(150) NOT NULL,
    Estado BIT NOT NULL CONSTRAINT DF_Departamento_Estado DEFAULT 1,
    CONSTRAINT PK_Departamento PRIMARY KEY (ID),
    CONSTRAINT FK_Departamento_Empresa FOREIGN KEY (IDEmpresa) 
        REFERENCES Empresa(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
);
go

CREATE TABLE Insumo (
    ID INT IDENTITY(1,1) NOT NULL,
    IDEmpresa INT NOT NULL,
    Nombre VARCHAR(150) NOT NULL,
    Stock INT NOT NULL CONSTRAINT DF_Insumo_Stock DEFAULT 0, -- Caché de stock físico rápido
    Estado BIT NOT NULL CONSTRAINT DF_Insumo_Estado DEFAULT 1,
    CONSTRAINT PK_Insumo PRIMARY KEY (ID),
    CONSTRAINT FK_Insumo_Empresa FOREIGN KEY (IDEmpresa) 
        REFERENCES Empresa(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
);
go

CREATE TABLE Empleado (
    ID INT IDENTITY(1,1) NOT NULL,
    IDPersona INT NOT NULL,
    IDDepartamento INT NOT NULL,
    IDRango INT NOT NULL,
    IDAcceso INT NOT NULL,
    Estado BIT NOT NULL CONSTRAINT DF_Empleado_Estado DEFAULT 1,
    CONSTRAINT PK_Empleado PRIMARY KEY (ID),
    CONSTRAINT FK_Empleado_Persona FOREIGN KEY (IDPersona) 
        REFERENCES Persona(ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Empleado_Departamento FOREIGN KEY (IDDepartamento) 
        REFERENCES Departamento(ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Empleado_Rango FOREIGN KEY (IDRango) 
        REFERENCES Rango(ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Empleado_TipoAcceso FOREIGN KEY (IDAcceso) 
        REFERENCES TipoAcceso(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
);
go

CREATE TABLE Ingreso (
    ID INT IDENTITY(1,1) NOT NULL,
    IDInsumo INT NOT NULL,
    IDProveedor INT NULL, -- NULL para permitir ajustes de stock manuales
    Precio DECIMAL(18,2) NOT NULL, -- Costo de adquisición de este lote específico
    Cantidad INT NOT NULL, -- Historial de entrada original
    CantDisponible INT NOT NULL, -- Cantidad disponible para consumo FIFO
    Fecha DATE NOT NULL CONSTRAINT DF_Ingreso_Fecha DEFAULT GETDATE(),
    Estado BIT NOT NULL CONSTRAINT DF_Ingreso_Estado DEFAULT 1,
    CONSTRAINT PK_Ingreso PRIMARY KEY (ID),
    CONSTRAINT FK_Ingreso_Insumo FOREIGN KEY (IDInsumo) 
        REFERENCES Insumo(ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Ingreso_Proveedor FOREIGN KEY (IDProveedor) 
        REFERENCES Proveedor(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
);
go

CREATE TABLE Consumo (
    ID INT IDENTITY(1,1) NOT NULL,
    IDInsumo INT NOT NULL,
    IDSolicitante INT NOT NULL,
    IDAprobador INT NULL, -- NULL por defecto, representa el estado "Pendiente"
    Cantidad INT NOT NULL,
    CostoTotal DECIMAL(18,2) NOT NULL, -- Calculado por C# aplicando FIFO entre los lotes
    Fecha DATE NOT NULL CONSTRAINT DF_Consumo_Fecha DEFAULT GETDATE(),
    Estado BIT NOT NULL CONSTRAINT DF_Consumo_Estado DEFAULT 1,
    CONSTRAINT PK_Consumo PRIMARY KEY (ID),
    CONSTRAINT FK_Consumo_Insumo FOREIGN KEY (IDInsumo) 
        REFERENCES Insumo(ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Consumo_Solicitante FOREIGN KEY (IDSolicitante) 
        REFERENCES Empleado(ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT FK_Consumo_Aprobador FOREIGN KEY (IDAprobador) 
        REFERENCES Empleado(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
);
go