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
SELECT *FROM Colaboradores;

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
('561-260590-1002L', 'Juan Franciso', 'Perez Lozano', 15000.00, 'F', '1', 'juanperez564@gmail.com', '8452 5698', 1), --solicitud aprobada "1"
('201-150494-2556P', 'Maria Lucia', 'Gomez Solorzano', 9000.00, 'T', '1', 'maria.Solor132@gmail.com', '7896 5832', 2), --tiene un prestamo activo "1"
('001-301100-2005Q', 'Ana Lucia', 'Martinez Ruiz', 8000.00, 'T', '1', 'ana2martinez@gmail.com', '8387 5521', 3), --prestamo aprobado queda en "1"
('401-090879-1336Q', 'Patricia Lorena', 'Vargas Trujillo', 18000.00, 'F', '1', 'patriciavargas453@yahoo.com', '7999 6651', 4),--solicitud aprobada "1"
('001-160695-1359k', 'Fernando Jose', 'Mendoza Gutierrez', 12000.00, 'F', '0', 'fernando.mendoza249@yahoo.com', '9658 8564', 5),--solicitud aprobada "1"
('401-050579-1352W', 'Carlos Rafael', 'Rivas Alvarez', 7800.00, 'T', '1', 'RivasCarlos13@yahoo.com', '7975 6651', 11),--solicitud aprobada "1"
('001-160395-1489H', 'Romario Rafael', 'Mendieta Lopez', 22000.00, 'F', '1', 'LopezMendieta24@yahoo.com', '8924 8564', 6),--    solicitud aprobada "1"
('561-220979-1009F', 'Oscar Armando', 'Reyes Lozano', 22000.00, 'F', '0', 'oscarreyes985@yahoo.com', '7996 5594', 4),--cancelado "0"
('201-291184-1006L', 'Raul Ramiro', 'Ortega Murillo', 18000.00, 'F', '0', 'raul.ortega@gmail.com', '9636 6625', 11),--cancelado "0"
('561-010180-0056H', 'Javier Jose', 'Ramirez Rivas', 19000.00, 'F', '0', 'javramirezrr@yahoo.com', '9012 5598', 9),--cancelado "0"
('401-010985-1009W', 'Carlos Roberto', 'Lopez Amador', 14000.00, 'F', '0', 'carlolopez44$$@yahoo.com', '8896 7450', 7), --cancelado"0"
('401-241295-3000P', 'Pedro Pablo', 'Rodriguez Ocampo', 13000.00, 'F', '0', 'pedrocampo99@yahoo.com', '7793 6842', 8), --negada la solicitud "0"
('409-200996-2009I', 'Lorena Lucia', 'Amarillo Carrion', 9500.00, 'T', '0', 'CarrionLucia@gmail.com', '7964 5635', 9),--negada la solicitud "0"
('561-220579-1115Z', 'Armando Patricio', 'Rayo baltodano', 9000.00, 'T', '0', 'baltodanoRayo@hotmail.com', '7985 6787', 10);--negada la solicitud "0"

/*
	una persona que tenga un prestamo activo debe tener estado crediticio en 1 porque debe, tambi[en una solicitud aprobada
	y un prestamo activo

	una persona que ya cancelo su prestamo debe tener estado crediticio en 0, una solicitud aprobada y un prestamo cancelado

	una persona a la cual se le deneg[o una solicitud de prestamo debe tener 0 en estado crediticio

	4 personas con prestamos activos 4 con prestamos cancelados y 4 con prestamos denegados
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
('2023-10-01', 15000.00, 4, 'Compra de electrodomésticos', 'A', 1, 1),--APROBADA--
('2022-08-15', 4000.00, 3, 'Reparaciones en el hogar', 'A', 2, 2),--APROBADA--
('2023-08-10', 5000.00, 3, 'Educación de los hijos', 'E', 3, 3),--ESPERA--
('2023-09-05', 8000.00, 4, 'Consolidación de deudas', 'E', 4, 1),--ESPERA--
('2023-05-20', 14000.00, 4, 'Viaje de vacaciones', 'D', 5, 2),--DENEGADA--
('2022-06-12', 4000.00, 4, 'Mejoras en la vivienda', 'A', 6, 3),--APROBADA--
('2022-07-08', 22000.00, 3, 'Inversión en motocicleta', 'A', 7, 1),--APROBADA--
('2022-08-03', 15000.00, 4, 'Compra de muebles', 'A', 8, 2),--APROBADA--
('2023-07-17', 8000.00, 3, 'Compras de temporada', 'A', 9, 1),--APROBADA--
('2023-08-08', 30000.00, 4, 'Gastos de mudanza', 'A', 10, 2), --APROBADA--
('2022-09-25', 25000.00, 3, 'Gastos médicos', 'A', 11, 3),--APROBADA--
('2022-10-18', 30500.00, 5, 'Mejoras en el automóvil', 'D', 12, 1),--DENEGADA
('2022-11-11', 10500.00, 4, 'Pago de gastos', 'D', 13, 2),--DENEGADA
('2022-12-04', 15000.00, 3, 'Compra de tecnología', 'D', 14, 3);--DENEGADA

-- INSERTANDO PRESTAMOS---

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

--6% 4000 - 7000 4% 7000 - 18000 3% 18000 a mas 
--FORMULA INTERES: monto aprobado * interes * plazoenmeses
('2023-10-15', 15000.00, 4.00, 17400.00, 8, 4, 'A', 1, 1), --4%
('2022-08-28', 4000.00, 6.00, 4720.00, 6, 3, 'A', 2, 2), --6%
('2022-06-14', 4000.00, 6.00, 4960.00, 8, 4, 'A', 6, 3), --6%
('2022-07-13', 22000.00, 3.00, 23980.00, 6 , 3, 'A', 7, 1), --3%
('2022-08-08', 15000.00, 4.00, 17400.00, 8, 4, 'C', 8, 2),--4%
('2023-07-22', 8000.00, 6.00 ,9140.00, 6, 3, 'C', 9, 3),--6%
('2023-08-12', 30000.00, 3.00, 33600.00, 8, 4, 'C', 10, 1),--3%
('2023-09-29', 25000.00, 3.00, 27250.00, 6, 3, 'C', 11, 2);--3%
-- SELECT * FROM SolicitudesPrestamos WHERE EstadoSolicitud = 'A';

-- INSERTANDO LOS REGISTROS DE PAGO
INSERT INTO RegistroPagos (NumeroDeCuota, FechaDePago, IdPrestamo, IdColaborador)
VALUES
-- Prestamo 1
(1, '2023-10-15', 1, 1),
(2, '2023-10-29', 1, 1),
(3, '2023-11-12', 1, 1),
(4, '2023-11-26', 1, 1),
(5, '2023-12-10', 1, 1),
(6, '2023-12-24', 1, 1),
(7, '2024-01-07', 1, 1),
(8, '2024-01-21', 1, 1),
-- Prestamo 2
(1, '2022-08-28', 2, 2),
(2, '2022-09-11', 2, 2),
(3, '2022-09-25', 2, 2),
(4, '2022-10-09', 2, 2),
(5, '2022-10-23', 2, 2),
(6, '2022-11-06', 2, 2),
-- Prestamo 3
(1, '2022-06-14', 3, 3),
(2, '2022-06-28', 3, 3),
(3, '2022-07-12', 3, 3),
(4, '2022-07-26', 3, 3),
(5, '2022-08-09', 3, 3),
(6, '2022-08-23', 3, 3),
(7, '2022-09-06', 3, 3),
(8, '2022-09-20', 3, 3),
-- Prestamo 4
(1, '2022-07-13', 4, 1),
(2, '2022-07-27', 4, 1),
(3, '2022-08-10', 4, 1),
(4, '2022-08-24', 4, 1),
(5, '2022-09-07', 4, 1),
(6, '2022-09-21', 4, 1),
-- Prestamo 5
(1, '2022-08-08', 5, 2),
(2, '2022-08-22', 5, 2),
(3, '2022-09-05', 5, 2),
(4, '2022-09-19', 5, 2),
(5, '2022-10-03', 5, 2),
(6, '2022-10-17', 5, 2),
(7, '2022-10-31', 5, 2),
(8, '2022-11-14', 5, 2),
-- Prestamo 6
(1, '2023-07-22', 6, 3),
(2, '2023-08-05', 6, 3),
(3, '2023-08-19', 6, 3),
(4, '2023-09-02', 6, 3),
(5, '2023-09-16', 6, 3),
(6, '2023-09-30', 6, 3),
-- Prestamo 7
(1, '2023-08-12', 7, 1),
(2, '2023-08-26', 7, 1),
(3, '2023-09-09', 7, 1),
(4, '2023-09-23', 7, 1),
(5, '2023-10-07', 7, 1),
(6, '2023-10-21', 7, 1),
(7, '2023-11-04', 7, 1),
(8, '2023-11-18', 7, 1),
-- Prestamo 8
(1, '2023-09-29', 8, 2),
(2, '2023-10-13', 8, 2),
(3, '2023-10-27', 8, 2),
(4, '2023-11-10', 8, 2),
(5, '2023-11-24', 8, 2),
(6, '2023-12-08', 8, 2),
(7, '2023-12-22', 8, 2),
(8, '2024-01-05', 8, 2);
