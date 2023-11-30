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

SELECT * FROM SolicitudesPrestamos;