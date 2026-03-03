--CREATE DATABASE HelpDeskDB
--GO

USE HelpDeskDB
GO

--TABLA Persona
CREATE TABLE Persona(
    IdPersona INT NOT NULL IDENTITY(1,1) PRIMARY KEY ,
    PrimerNombre VARCHAR(MAX),
	SegundoNombre VARCHAR(MAX),
	ApellidoPaterno VARCHAR(MAX),
	ApellidoMaterno VARCHAR(MAX),
	Celular VARCHAR(MAX)
)
GO

--TABLA Usuario
CREATE TABLE Usuario(
    IdUsuario INT NOT NULL IDENTITY(1,1) PRIMARY KEY ,
	IdPersona INT,
    FOREIGN KEY (IdPersona) REFERENCES Persona(IdPersona),
    Correo VARCHAR(MAX),
	PasswordHash BINARY(64) NOT NULL,
	Activo BIT
)
GO


--TABLA Rol
CREATE TABLE Rol(
    IdRol INT NOT NULL IDENTITY(1,1) PRIMARY KEY ,		
    Nombre VARCHAR(MAX),
	Activo BIT
)
GO

--TABLA Usuario Rol
CREATE TABLE UsuarioRol(
    IdUsuarioRol INT NOT NULL IDENTITY(1,1) PRIMARY KEY ,  
	IdUsuario INT,
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
	IdRol INT,
    FOREIGN KEY (IdRol) REFERENCES Rol(IdRol),
	Activo BIT
)
GO

--TABLA Ruta
CREATE TABLE Ruta(
    IdRoute INT NOT NULL IDENTITY(1,1) PRIMARY KEY ,
	IdParentRoute INT,
    Name VARCHAR(20),
	Url VARCHAR(MAX),
	Icon VARCHAR(MAX),
	Level INT,
	Active BIT NOT NULL DEFAULT 1
)
GO

--TABLA Ruta
CREATE TABLE Permiso(
    IdPermiso INT NOT NULL IDENTITY(1,1) PRIMARY KEY ,
	IdRol INT,
	IdRuta INT,	
)
GO

