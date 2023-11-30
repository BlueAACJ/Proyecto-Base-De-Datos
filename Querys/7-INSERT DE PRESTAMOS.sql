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
SELECT * FROM Prestamos;