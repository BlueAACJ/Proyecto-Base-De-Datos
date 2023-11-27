-- Creacioon de tabla:
create database GrupoTalse;

use GrupoTalse;

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

-- INSERT --
--Unidades de negocio
use GrupoTalse;

INSERT INTO UnidadDeNegocio (nombreUnidadDeNegocio, cantidadDeSucursales)
VALUES ('Mi Ranchito', 3);

INSERT INTO UnidadDeNegocio (nombreUnidadDeNegocio, cantidadDeSucursales)
VALUES ('El Zócalo', 2);

INSERT INTO UnidadDeNegocio (nombreUnidadDeNegocio, cantidadDeSucursales)
VALUES ('La Nani Café', 2);

INSERT INTO UnidadDeNegocio (nombreUnidadDeNegocio, cantidadDeSucursales)
VALUES ('Setenta Grados', 1);

INSERT INTO UnidadDeNegocio (nombreUnidadDeNegocio, cantidadDeSucursales)
VALUES ('La Sureña', 1);

--Sucursales Mi Ranchito
INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('Mi Ranchito', 'Rivas', '00000000', 1);

INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('Mi Ranchito', 'Catarina', '00000000', 1);

INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('Mi Ranchito', 'Masaya', '00000000', 1);

--Sucursales El zocalo
INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('El Zócalo', 'Metrocentro', '11111111', 2);

INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('El Zócalo', 'Plaza la fe', '11111111', 2);

--Sucursales la Nani
INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('La Nani Café', 'Rivas', '22222222', 3);

INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('La Nani Café', 'Masaya', '22222222', 3);

--Sucursales Setenta grados
INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('Setenta Grados', 'Rivas', '33333333', 4);

--Sucursales Sureña
INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('La Sureña', 'Rivas', '44444444', 5);


--datos de pruba para Colaboradores
INSERT INTO Colaboradores (CedulaColaborador, NombresColaborador, ApellidosColaborador, SalarioColaborador, TipoDeContrato, EstadoCrediticio, CorreoColaborador, NumeroTelefonoColaborador, IdSucursal)
VALUES
('1234567890', 'Juan', 'Perez', 50000.00, 'F', '1', 'juan.perez@e.com', '1234567890', 1),
('2345678901', 'Maria', 'Gomez', 60000.00, 'T', '0', 'maria.gomez@e.com', '2345678901', 2),
('3456789012', 'Carlos', 'Lopez', 55000.00, 'F', '0', 'carlos.lopez@e.com', '3456789012', 3),
('4567890123', 'Ana', 'Martinez', 52000.00, 'T', '1', 'ana.martinez@e.com', '4567890123', 4),
('5678901234', 'Pedro', 'Rodriguez', 48000.00, 'F', '0', 'pedro.rodriguez@e.com', '5678901234', 5),
('6789012345', 'Laura', 'Hernandez', 53000.00, 'T', '1', 'laura.hernandez@e.com', '6789012345', 6),
('7890123456', 'Sergio', 'Diaz', 59000.00, 'F', '1', 'sergio.diaz@e.com', '7890123456', 7),
('8901234567', 'Isabel', 'Sanchez', 51000.00, 'T', '0', 'isabel.sanchez@e.com', '8901234567', 8),
('9012345678', 'Javier', 'Ramirez', 56000.00, 'F', '0', 'javier.ramirez@e.com', '9012345678', 9),
('0123456789', 'Carmen', 'Gonzalez', 58000.00, 'T', '1', 'carmen.gonzalez@e.com', '0123456789', 1),
('1122334455', 'Raul', 'Ortega', 54000.00, 'F', '0', 'raul.ortega@e.com', '1122334455', 2),
('2233445566', 'Patricia', 'Vargas', 60000.00, 'T', '1', 'patricia.vargas@e.com', '2233445566', 3),
('3344556677', 'Fernando', 'Mendoza', 51000.00, 'F', '1', 'fernando.mendoza@e.com', '3344556677', 4),
('4455667788', 'Lucia', 'Cruz', 53000.00, 'T', '0', 'lucia.cruz@e.com', '4455667788', 5),
('5566778899', 'Oscar', 'Reyes', 57000.00, 'F', '0', 'oscar.reyes@e.com', '5566778899', 6);

--Agrgando administradores 

INSERT INTO Administrador (CedulaAdmimistrador, NombresAdministrador, ApellidosAdministrador, CorreoAdministrador, NumeroTelefonoAdministrador, Usuario, Contrasenia, IdSucursal)
VALUES ('121-160803-1001N', 'Edwing Antonio', 'Jarquin Fitoria', 'edwing@uni.com', '00001111', 'edwing', PWDENCRYPT('admin1'), 1),
	   ('366-000011-1000H', 'Alejandro Antonio', 'Castillo Jacamo', 'bluemonster@gmail.com', '11110000','alejandro',PWDENCRYPT('admin2'),2);

-- Usuario: alejandro Contrasena:admin2

-- Usuario: edwing Contrasena:admin1

select * from Administrador where Usuario ='alejandro' and PWDCOMPARE('admin2', contrasenia)= 1

---------------PRUEBA CONTRASENA----------------------

create database Prueba;

use Prueba;

CREATE TABLE login
(
[IdLogin] [int] IDENTITY(1,1) PRIMARY KEY,
[IdUsuario] [varchar](255) NOT NULL,
[Contrasenia] [varbinary](max)NOT NULL
)

insert into login(IdUsuario, contrasenia) values('buhoos',PWDENCRYPT(12345678))

select * from login where IdUsuario ='buhoos' and PWDCOMPARE('12345678', contrasenia)= 1