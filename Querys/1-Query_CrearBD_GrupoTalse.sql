CREATE DATABASE GrupoTalse;

USE GrupoTalse;

CREATE TABLE UnidadDeNegocio (
	IdUnidadDeNegocio INT IDENTITY(1,1) PRIMARY KEY,
	nombreUnidadDeNegocio varchar(50) NOT NULL,
	cantidadDeSucursales int NOT NULL
);

CREATE TABLE Sucursales (
	IdSucursal INT IDENTITY(1,1) PRIMARY KEY,
	nombreDeSucursal varchar(50) NOT NULL,
	direccionSucursal varchar(50) NOT NULL,
	numeroTelefonoSucursal varchar(10) NOT NULL,
	IdUnidadDeNegocio INT NOT NULL,
	CONSTRAINT FK_UnidadDeNegocioSucursal FOREIGN KEY (IdUnidadDeNegocio) REFERENCES UnidadDeNegocio(IdUnidadDeNegocio)
);

CREATE TABLE Colaboradores (
	IdColaborador INT IDENTITY(1,1) PRIMARY KEY,
	CedulaColaborador varchar(25) NOT NULL,
	NombresColaborador varchar(50) NOT NULL,
	ApellidosColaborador varchar(50) NOT NULL,
	SalarioColaborador DECIMAL(15,2) NOT NULL,
	TipoDeContrato char(1) NOT NULL,
	EstadoCrediticio char(1) NOT NULL,
	CorreoColaborador varchar(50) NOT NULL,
	NumeroTelefonoColaborador varchar(10) NOT NULL,
	IdSucursal INT NOT NULL,
	CONSTRAINT FK_SucursalColaborador FOREIGN KEY (IdSucursal) REFERENCES Sucursales(IdSucursal)
);

CREATE TABLE Administrador (
	IdAdministrador INT IDENTITY(1,1) PRIMARY KEY,
	CedulaAdmimistrador varchar(25) NOT NULL,
	NombresAdministrador varchar(50) NOT NULL,
	ApellidosAdministrador varchar(50) NOT NULL,
	CorreoAdministrador varchar(50) NOT NULL,
	NumeroTelefonoAdministrador varchar(10) NOT NULL,
	Usuario varchar(10) NOT NULL,
	Contrasenia VARBINARY(MAX) NOT NULL,
	IdSucursal INT NOT NULL,
	CONSTRAINT FK_SucursalAdministrador FOREIGN KEY (IdSucursal) REFERENCES Sucursales(IdSucursal)
);


CREATE TABLE SolicitudesPrestamos (
	IdSolicitudesPrestamos INT IDENTITY(1,1) PRIMARY KEY,
	FechaDeSolicitud DATE NOT NULL,
	MontoSolicitado DECIMAL(15,2) NOT NULL,
	PlazoDePago INT NOT NULL,
	MotivoPrestamo varchar(50) NOT NULL,
	EstadoSolicitud char(1) NOT NULL,
	IdColaborador INT NOT NULL,
	IdAdministrador INT NOT NULL,
	CONSTRAINT FK_ColaboradorSolicitudPrestamo FOREIGN KEY (IdColaborador) REFERENCES Colaboradores(IdColaborador),
	CONSTRAINT FK_AdministradorSolicitudPrestamo FOREIGN KEY (IdAdministrador) REFERENCES Administrador(IdAdministrador)
);

CREATE TABLE Prestamos (
	IdPrestamo INT IDENTITY(1,1) PRIMARY KEY,
	FechaDeAprobacion DATE NOT NULL,
	Capital DECIMAL(15,2) NOT NULL,
	Intereses DECIMAL(15,2) NOT NULL,
	CosteTotal DECIMAL(15,2) NOT NULL,
	Cuotas INT NOT NULL,
	PlazoDePago_Meses INT NOT NULL,
	EstadoPrestamo char(1) NOT NULL,
	IdSolicitudesPrestamos INT NOT NULL,
	IdAdministrador INT NOT NULL,
	CONSTRAINT FK_SolicitudPrestamoPrestamo FOREIGN KEY (IdSolicitudesPrestamos) REFERENCES SolicitudesPrestamos(IdSolicitudesPrestamos),
	CONSTRAINT FK_AdministradorPrestamo FOREIGN KEY (IdAdministrador) REFERENCES Administrador(IdAdministrador)
);

CREATE TABLE RegistroPagos(
	IdRegistroPago INT IDENTITY(1,1) PRIMARY KEY,
	NumeroDeCuota INT NOT NULL,
	FechaDePago DATE NOT NULL,
	IdPrestamo INT NOT NULL,
	IdColaborador INT NOT NULL,
	CONSTRAINT FK_PrestamosRegistroPagos FOREIGN KEY (IdPrestamo) REFERENCES Prestamos(IdPrestamo),
	CONSTRAINT FK_ColaboradorRegistroPagos FOREIGN KEY (IdColaborador) REFERENCES Colaboradores(IdColaborador)
);
