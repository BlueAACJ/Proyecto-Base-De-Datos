
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

SELECT *FROM Colaboradores;