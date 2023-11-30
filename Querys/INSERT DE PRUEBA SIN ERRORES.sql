
------INSERTANDO UNIADES DE NEGOCIO-------
INSERT INTO UnidadDeNegocio (nombreUnidadDeNegocio, cantidadDeSucursales)
VALUES ('Mi Viejo Ranchito', 4);

INSERT INTO UnidadDeNegocio (nombreUnidadDeNegocio, cantidadDeSucursales)
VALUES ('El Zócalo', 3);

INSERT INTO UnidadDeNegocio (nombreUnidadDeNegocio, cantidadDeSucursales)
VALUES ('La Nani Café', 2);

INSERT INTO UnidadDeNegocio (nombreUnidadDeNegocio, cantidadDeSucursales)
VALUES ('Setenta Grados', 1);

INSERT INTO UnidadDeNegocio (nombreUnidadDeNegocio, cantidadDeSucursales)
VALUES ('La Sureña', 1);



----INSERTANDO SUCURSALES----------------

--	SUCURSALES MI RANCHITO
INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('Mi Viejo Ranchito', 'Rivas', '2560 2137', 1);

INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('Mi Viejo Ranchito', 'Catarina', '2558 0473', 1);

INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('Mi Viejo Ranchito', 'Masaya', '2279 2865', 1);

INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('Mi Viejo Ranchito', 'Galeria', '8590 3886', 1);

--	SUCURSALES EL ZOCALO
INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('El Zócalo', 'Masaya', '7530 6452', 2);

INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('El Zócalo', 'Villa Fontana', '7530 6452', 2);

INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('El Zócalo', 'Galeria', '7530 6452', 2);

--	SUCURSALES LA NANI
INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('La Nani Café', 'Rivas', '8881 4246', 3);

INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('La Nani Café', 'Masaya', '2522 0239', 3);

--	SUCURSALES SETENTA GRADOS
INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('Setenta Grados', 'Rivas', '8244 5592', 4);

--	SUCURSALES LA SUREÑA
INSERT INTO Sucursales (nombreDeSucursal, direccionSucursal, numeroTelefonoSucursal, IdUnidadDeNegocio)
VALUES ('La Sureña', 'Rivas', '7620 5533', 5);


--	INSERTANDO ADMINISTRADORES
--	usuario: alejandro  contraseña: admin1
--  usuario: edwing	    contraseña: admin2
--  usuario: carlos     contraseña: admin3

INSERT INTO Administrador (CedulaAdmimistrador, NombresAdministrador, ApellidosAdministrador, CorreoAdministrador, NumeroTelefonoAdministrador, Usuario, Contrasenia, IdSucursal)
VALUES ('121-160803-1001N', 'Edwing Antonio', 'Jarquin Fitoria', 'edwing@uni.com', '00001111', 'edwing', PWDENCRYPT('admin1'), 1),
	   ('366-000011-1000H', 'Alejandro Antonio', 'Castillo Jacamo', 'bluemonster@gmail.com', '11110000','alejandro',PWDENCRYPT('admin2'),2),
	   ('561-210703-1040L', 'Carlos Ernesto', 'Mora Rodriguez', 'cmora2023@gmail.com', '10101010','carlos',PWDENCRYPT('admin3'),7);

-- VER INFORMACION DE LOS ADMINISTRADORES INSERTADOS
/*
select * from Administrador where Usuario ='alejandro' and PWDCOMPARE('admin2', contrasenia)= 1
select * from Administrador where Usuario ='carlos' and PWDCOMPARE('admin1', contrasenia)= 1
select * from Administrador where Usuario ='edwing' and PWDCOMPARE('admin3', contrasenia)= 1  */


----	INSERTANDO COLABORADORES -------

INSERT INTO Colaboradores (
	CedulaColaborador, 
	NombresColaborador, 
	ApellidosColaborador,
	SalarioColaborador, 
	TipoDeContrato, 
	EstadoCrediticio, 
	CorreoColaborador,
	NumeroTelefonoColaborador, 
	IdSucursal
)
VALUES
('561-260590-1002L', 'Juan Franciso', 'Perez Lozano', 9000.00, 'F', '1', 'juanperez564@gmail.com', '8452 5698', 1), --rivas
('201-150494-2556P', 'Maria Lucia', 'Gomez Solorzano', 8000.00, 'T', '1', 'maria.Solor132@gmail.com', '7896 5832', 2), --granada
('401-010985-1009W', 'Carlos Roberto', 'Lopez Amador', 14000.00, 'F', '0', 'carlolopez44$$@yahoo.com', '8896 7450', 3), --masaya
('001-301100-2005Q', 'Ana Lucia', 'Martinez Ruiz', 9500.00, 'T', '0', 'ana2martinez@gmail.com', '8387 5521', 4), --galeria
('401-241295-3000P', 'Pedro Pablo', 'Rodriguez Ocampo', 13000.00, 'F', '0', 'pedrocampo99@yahoo.com', '7793 6842', 5),
/*
	una persona que tenga un prestamo activo debe tener estado crediticio en 1 porque debe, tambi[en una solicitud aprobada
	y un prestamo activo

	una persona que ya cancelo su prestamo debe tener estado crediticio en 0, una solicitud aprobada y un prestamo cancelado

	una persona a la cual se le deneg[o una solicitud de prestamo debe tener 0 en estado crediticio
**/
---- INSERTANDO SOLICITUDES DE PRESTAMOS -------

INSERT INTO SolicitudesPrestamos (
	FechaDeSolicitud, 
	MontoSolicitado, 
	PlazoDePago, 
	MotivoPrestamo, 
	EstadoSolicitud, 
	IdColaborador, 
	IdAdministrador
)
VALUES 
('2023-10-01', 3000.00, 2, 'Compra de electrodomésticos', 'A', 1, 1),
('2022-08-15', 4000.00, 3, 'Reparaciones en el hogar', 'A', 2, 2),
('2023-08-10', 8000.00, 4, 'Educación de los hijos', 'E', 3, 3),
('2023-09-05', 4000.00, 4, 'Consolidación de deudas', 'E', 4, 1),
('2023-05-20', 14000.00, 3, 'Viaje de vacaciones', 'D', 5, 2),
/*aca ya no agregues solicitudes en espera solo las aprobadas y denegadas*/

-- INSERTANDO PRESTAMOS---

/* formula interes Capital * interes 2%,3%, 5% y 6% * cantidad de meses
   2% 20000 A MAS, 3% 13000-19999. 6% 3000-7999, 5% 8000-12999 */

INSERT INTO Prestamos (
	FechaDeAprobacion, 
	Capital, 
	Intereses, 
	CosteTotal, 
	Cuotas, 
	PlazoDePago_Meses, 
	EstadoPrestamo, 
	IdSolicitudesPrestamos, 
	IdAdministrador)
VALUES 
('2023-10-05', 3200.00, 384.00, 3584.00, 4, 2, 'A', 1, 1), 
('2022-08-20', 4200.00, 756.00, 4956.00, 6, 3, 'C', 2, 2);

-- SELECT * FROM SolicitudesPrestamos WHERE EstadoSolicitud = 'A';

-- INSERTANDO LOS REGISTROS DE PAGO
INSERT INTO RegistroPagos (NumeroDeCuota, FechaDePago, IdPrestamo, IdColaborador)
VALUES
(1, '2023-10-30', 1, 1),
(2, '2023-11-14', 1, 1),
(3, '2023-11-29', 1, 1),
(4, '2023-12-14', 1, 1),
(1, '2022-09-04', 2, 2),
(2, '2022-09-29', 2, 2),
(3, '2022-10-14', 2, 2),
(4, '2022-10-29', 2, 2),
(5, '2022-11-13', 2, 2),
(6, '2022-11-28', 2, 2);

