---LOGIN
select * from Administrador where Usuario = ""?"" and PWDCOMPARE(""?"", contrasenia)= 1

---INDEX
SELECT P.FechaDeAprobacion, C.CedulaColaborador, C.NombresColaborador, C.ApellidosColaborador, Pr.EstadoPrestamo, Pr.Capital AS Monto, S.IdColaborador FROM Prestamos AS P JOIN SolicitudesPrestamos AS S ON P.IdSolicitudesPrestamos = S.IdSolicitudesPrestamos JOIN Colaboradores AS C ON S.IdColaborador = C.IdColaborador JOIN Prestamos AS Pr ON S.IdSolicitudesPrestamos = Pr.IdSolicitudesPrestamos WHERE Pr.EstadoPrestamo = 'A'

---PRESTAMO DETALLADO
select * from Colaboradores where CedulaColaborador = "?"
SELECT Pr.IdPrestamo,CONCAT(C.NombresColaborador, ' ', C.ApellidosColaborador) AS Colaborador, SP.PlazoDePago AS PlazoDePago, S.nombreDeSucursal AS Sucursal, S.direccionSucursal AS Direccion, Pr.Capital, Pr.Intereses, Pr.CosteTotal, Pr.Cuotas, Pr.EstadoPrestamo FROM Prestamos AS Pr JOIN SolicitudesPrestamos AS SP ON Pr.IdSolicitudesPrestamos = SP.IdSolicitudesPrestamos JOIN Colaboradores AS C ON SP.IdColaborador = C.IdColaborador JOIN Sucursales AS S ON C.IdSucursal = S.IdSucursal WHERE C.CedulaColaborador = "?"
SELECT P.FechaDeAprobacion, SP.PlazoDePago, P.Capital, P.Intereses FROM Prestamos P JOIN SolicitudesPrestamos SP ON P.IdSolicitudesPrestamos = SP.IdSolicitudesPrestamos JOIN Colaboradores C ON SP.IdColaborador = C.IdColaborador WHERE C.CedulaColaborador = "?"

---PRESTAMOS CANCELADOS
SELECT P.FechaDeAprobacion, C.CedulaColaborador, C.NombresColaborador, C.ApellidosColaborador, Pr.EstadoPrestamo, Pr.Capital AS Monto, S.IdColaborador FROM Prestamos AS P JOIN SolicitudesPrestamos AS S ON P.IdSolicitudesPrestamos = S.IdSolicitudesPrestamos JOIN Colaboradores AS C ON S.IdColaborador = C.IdColaborador JOIN Prestamos AS Pr ON S.IdSolicitudesPrestamos = Pr.IdSolicitudesPrestamos WHERE Pr.EstadoPrestamo = 'C'

---AGREGAR SOLICITUD
DECLARE @IdColaborador INT;INSERT INTO Colaboradores (CedulaColaborador, NombresColaborador, ApellidosColaborador, SalarioColaborador, TipoDeContrato, EstadoCrediticio, CorreoColaborador, NumeroTelefonoColaborador, IdSucursal) VALUES ("?", "?", "?", "?", "?", "?", "?", "?", "?");SET @IdColaborador = SCOPE_IDENTITY();INSERT INTO SolicitudesPrestamos (FechaDeSolicitud, MontoSolicitado, PlazoDePago, MotivoPrestamo, EstadoSolicitud, IdColaborador, IdAdministrador) VALUES ("?", "?", "?", "?", 'E', @IdColaborador, 1)

---SOLICITUD ESPERA
SELECT SP.FechaDeSolicitud, C.CedulaColaborador, C.NombresColaborador, C.ApellidosColaborador, SP.MontoSolicitado, SP.PlazoDePago, SP.IdColaborador,SP.IdSolicitudesPrestamos FROM SolicitudesPrestamos AS SP JOIN Colaboradores AS C ON SP.IdColaborador = C.IdColaborador WHERE SP.EstadoSolicitud = 'E'

---ACEPTAR
UPDATE SolicitudesPrestamos SET EstadoSolicitud = 'A' WHERE IdColaborador IN (SELECT IdColaborador FROM Colaboradores WHERE CedulaColaborador = "?");",CedulaColaborador)

    query1="""
    DECLARE @CedulaColaborador varchar(25) = "?"; -- Reemplaza con la cédula del colaborador
-- Obtener IdSolicitudesPrestamos correspondiente a la cédula del colaborador
DECLARE @IdSolicitudPrestamo INT;
SET @IdSolicitudPrestamo = (SELECT IdSolicitudesPrestamos 
                            FROM SolicitudesPrestamos 
                            WHERE IdColaborador = (SELECT IdColaborador FROM Colaboradores WHERE CedulaColaborador = @CedulaColaborador));

-- Obtener los valores necesarios para la creación del préstamo
DECLARE @FechaDeAprobacion DATE;
DECLARE @Capital DECIMAL(15,2);
DECLARE @PlazoDePago_Meses INT;

SET @FechaDeAprobacion = (SELECT FechaDeSolicitud FROM SolicitudesPrestamos WHERE IdSolicitudesPrestamos = @IdSolicitudPrestamo);
SET @Capital = (SELECT MontoSolicitado FROM SolicitudesPrestamos WHERE IdSolicitudesPrestamos = @IdSolicitudPrestamo);
SET @PlazoDePago_Meses = (SELECT PlazoDePago FROM SolicitudesPrestamos WHERE IdSolicitudesPrestamos = @IdSolicitudPrestamo);

-- Calcular otros valores necesarios
DECLARE @Intereses DECIMAL(15,2);
DECLARE @Cuotas INT;
DECLARE @CosteTotal DECIMAL(15,2);

SET @Intereses = 0.10; -- 10.00%
SET @Cuotas = @PlazoDePago_Meses * 2;
SET @CosteTotal = @Capital * (1 + @Intereses * @PlazoDePago_Meses);

-- Insertar un nuevo registro en la tabla de préstamos
INSERT INTO Prestamos (FechaDeAprobacion, Capital, Intereses, CosteTotal, Cuotas, PlazoDePago_Meses, EstadoPrestamo, IdSolicitudesPrestamos, IdAdministrador)
VALUES (
    @FechaDeAprobacion,
    @Capital,
    @Intereses,
    @CosteTotal,
    @Cuotas,
    @PlazoDePago_Meses,
    'A', -- EstadoPrestamo (Aprobado)
    @IdSolicitudPrestamo,
    (SELECT IdAdministrador FROM SolicitudesPrestamos WHERE IdSolicitudesPrestamos = @IdSolicitudPrestamo)
);

---SOLICITUD ACEPTADA
 SELECT 
                SP.FechaDeSolicitud AS FechaDeAprobacion,
                C.CedulaColaborador,
                C.NombresColaborador,
                C.ApellidosColaborador,
                SP.EstadoSolicitud,
                SP.MontoSolicitado,
                P.Capital,
                P.PlazoDePago_Meses,
                P.Cuotas
            FROM 
                SolicitudesPrestamos SP 
            JOIN 
                Colaboradores C ON SP.IdColaborador = C.IdColaborador 
            LEFT JOIN 
                Prestamos P ON SP.IdSolicitudesPrestamos = P.IdSolicitudesPrestamos
            WHERE 
                SP.EstadoSolicitud = 'A';

---SOLICITUD DENEGADA
SELECT
            SP.FechaDeSolicitud,
            C.CedulaColaborador,
            C.NombresColaborador,
            C.ApellidosColaborador,
            SP.MontoSolicitado,
            SP.PlazoDePago
        FROM
            SolicitudesPrestamos AS SP
        JOIN
            Colaboradores AS C ON SP.IdColaborador = C.IdColaborador
        WHERE
            SP.EstadoSolicitud = 'D'

---NEGAR
UPDATE SolicitudesPrestamos SET EstadoSolicitud = 'D' WHERE IdColaborador IN (SELECT IdColaborador FROM Colaboradores WHERE CedulaColaborador = "?");

---GENERAR PRESTAMO
UPDATE Prestamos SET EstadoPrestamo = 'P' FROM Prestamos AS Pr INNER JOIN SolicitudesPrestamos AS SP ON Pr.IdSolicitudesPrestamos = SP.IdSolicitudesPrestamos INNER JOIN Colaboradores AS C ON SP.IdColaborador = C.IdColaborador WHERE C.CedulaColaborador = "?" AND Pr.EstadoPrestamo = 'A')
