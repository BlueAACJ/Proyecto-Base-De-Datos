from flask import *
import pyodbc
from funciones import calcular_pagos
from datetime import datetime

#Conexion Base de Datos TODOS DEBEN TERNER LA MISMA BASE DE DATOS Y CAMBIAR El NOMBRES DE USUARIO PARA QUE SIRVA EN SU MAQUINA  
try:
    # conexion a la Base de Datos 
    connection = pyodbc.connect('DRIVER={SQL Server};SERVER=DESKTOP-QSDIA4P\MSSQLSERVER01;DATABASE=GrupoTalse;Trusted_Connection=yes;')
    # db es el objeto para las ejecuciones de la base de datos 
    db = connection.cursor()
    # Impresion de Error
except Exception as ex:
    print("Error durante la conexión: {}".format(ex))

app = Flask(__name__)
app.secret_key = 'MessiTheGoat'

@app.route('/', methods = ['GET', 'POST'])
def login():
    session.clear()
    if request.method == 'POST':
        usuario = request.form['usuario']
        contrasena = request.form['contrasena']
        rows = db.execute("select * from Administrador where Usuario = ? and PWDCOMPARE(?, contrasenia)= 1", usuario, contrasena)

        # Obtiene las filas y las columnas
        rows = db.fetchall()
        columns = [column[0] for column in db.description]

        # Convierte las filas a una lista de diccionarios
        rows = [dict(zip(columns, row)) for row in rows]

        if rows != []:
            session["id"] = rows[0]["IdAdministrador"]
            return redirect(url_for('index'))
        else:
            flash('Contrasena o usuario equivocado', 'error')
            return render_template('login.html')
    else:
        return render_template('login.html')

@app.route('/index', methods = ['GET', 'POST'])
def index():
    if request.method == "GET":
        # Ejecuta la consulta SQL
        db.execute("SELECT P.FechaDeAprobacion, C.CedulaColaborador, C.NombresColaborador, C.ApellidosColaborador, Pr.EstadoPrestamo, Pr.Capital AS Monto, S.IdColaborador FROM Prestamos AS P JOIN SolicitudesPrestamos AS S ON P.IdSolicitudesPrestamos = S.IdSolicitudesPrestamos JOIN Colaboradores AS C ON S.IdColaborador = C.IdColaborador JOIN Prestamos AS Pr ON S.IdSolicitudesPrestamos = Pr.IdSolicitudesPrestamos WHERE Pr.EstadoPrestamo = 'A'")
        rows = db.fetchall()

        # Obtiene las filas y las columnas
        columns = [column[0] for column in db.description]
        rows = [dict(zip(columns, row)) for row in rows]

        for i in range(len(rows)):
            if rows[i]['EstadoPrestamo'] == 'A':
                rows[i]['EstadoPrestamo'] = 'Activo'
            else:
                rows[i]['EstadoPrestamo'] = 'Cancelado'
        
        # Pasa los datos a la plantilla HTML para ser renderizados
        return render_template('index.html', rows=rows)
    else:
        return render_template('index.html')

@app.route("/logout", methods = ['GET', 'POST'])
def logout():
    # cerramos sesion 
    session.clear()
    # redireccionamos al login 
    return redirect("/")

@app.route("/Prestamo_Detallado/<string:CedulaColaborador>", methods = ['GET', 'POST'])
def Prestamo_Detallado(CedulaColaborador):
    if request.method =="GET":
        # verificacion existencia del colaborador 
        rows = db.execute("select * from Colaboradores where CedulaColaborador = ?", CedulaColaborador)
        rows = db.fetchall()
        # Obtiene las filas y las columnas
        columns = [column[0] for column in db.description]

        # Convierte las filas a una lista de diccionarios
        rows = [dict(zip(columns, row)) for row in rows]
        
        # Si rows != [] El colaborador no esxite 
        if rows != []:
            info = db.execute("SELECT Pr.IdPrestamo,CONCAT(C.NombresColaborador, ' ', C.ApellidosColaborador) AS Colaborador, SP.PlazoDePago AS PlazoDePago, S.nombreDeSucursal AS Sucursal, S.direccionSucursal AS Direccion, Pr.Capital, Pr.Intereses, Pr.CosteTotal, Pr.Cuotas, Pr.EstadoPrestamo FROM Prestamos AS Pr JOIN SolicitudesPrestamos AS SP ON Pr.IdSolicitudesPrestamos = SP.IdSolicitudesPrestamos JOIN Colaboradores AS C ON SP.IdColaborador = C.IdColaborador JOIN Sucursales AS S ON C.IdSucursal = S.IdSucursal WHERE C.CedulaColaborador = ?",CedulaColaborador)
            info = db.fetchall()

            columnsinfo = [columninfo[0] for columninfo in db.description]

            # Convierte las filas a una lista de diccionarios
            info = [dict(zip(columnsinfo, rowinfo)) for rowinfo in info]

            for i in range(len(info)):
                if info[i]['EstadoPrestamo'] == 'A':
                    info[i]['EstadoPrestamo'] = 'Activo'
                else:
                    info[i]['EstadoPrestamo'] = 'Cancelado'

            tabla = db.execute("SELECT P.FechaDeAprobacion, SP.PlazoDePago, P.Capital, P.Intereses FROM Prestamos P JOIN SolicitudesPrestamos SP ON P.IdSolicitudesPrestamos = SP.IdSolicitudesPrestamos JOIN Colaboradores C ON SP.IdColaborador = C.IdColaborador WHERE C.CedulaColaborador = ?",CedulaColaborador)
            tabla = db.fetchall()
            
            datos = calcular_pagos(tabla)

            return render_template('prestamo_detallado.html',info=info, datos=datos)
        else:
            return render_template('Error.html')
    else:
        return render_template('prestamo_detallado.html')

@app.route("/Prestamos Cancelados", methods = ['GET', 'POST'])
def Prestamos_Cancelados():
    if request.method == "GET":
        # Ejecuta la consulta SQL
        db.execute("SELECT P.FechaDeAprobacion, C.CedulaColaborador, C.NombresColaborador, C.ApellidosColaborador, Pr.EstadoPrestamo, Pr.Capital AS Monto, S.IdColaborador FROM Prestamos AS P JOIN SolicitudesPrestamos AS S ON P.IdSolicitudesPrestamos = S.IdSolicitudesPrestamos JOIN Colaboradores AS C ON S.IdColaborador = C.IdColaborador JOIN Prestamos AS Pr ON S.IdSolicitudesPrestamos = Pr.IdSolicitudesPrestamos WHERE Pr.EstadoPrestamo = 'C'")
        rows = db.fetchall()

        # Obtiene las filas y las columnas
        columns = [column[0] for column in db.description]
        rows = [dict(zip(columns, row)) for row in rows]

        for i in range(len(rows)):
            if rows[i]['EstadoPrestamo'] == 'C':
                rows[i]['EstadoPrestamo'] = 'Cancelado'
            else:
                rows[i]['EstadoPrestamo'] = 'Activo'
        
        # Pasa los datos a la plantilla HTML para ser renderizados
        return render_template('Prestamos Cancelados.html', rows=rows)
    else:
        return render_template('Prestamos Cancelados.html')

@app.route("/Agregar Solicitud", methods=['GET', 'POST'])
def Agregar_Solicitud():
    if request.method == 'GET':
        return render_template("Agregar Solicitud.html")
    elif request.method == 'POST':
        CedulaColaborador = request.form.get('CedulaColaborador')
        NombresColaborador = request.form.get('NombresColaborador')
        ApellidosColaborador = request.form.get('ApellidosColaborador')
        SalarioColaborador = request.form.get('SalarioColaborador')
        IdSucursal = request.form.get('IdSucursal')
        TipoDeContrato = request.form.get('TipoDeContrato')
        EstadoCrediticio = request.form.get('EstadoCrediticio')
        CorreoColaborador = request.form.get('CorreoColaborador')
        NumeroTelefonoColaborador = request.form.get('NumeroTelefonoColaborador')

        # SEGUNDO FORM
        FechaDeSolicitud = request.form.get('FechaDeSolicitud')
        MontoSolicitado = request.form.get('MontoSolicitado')
        PlazoDePago = request.form.get('PlazoDePago')
        MotivoPrestamo = request.form.get('MotivoPrestamo')

        if CedulaColaborador != ''  and NombresColaborador != '' and ApellidosColaborador != '' and SalarioColaborador != '' and CorreoColaborador != '' and NumeroTelefonoColaborador != '' and FechaDeSolicitud != '' and MontoSolicitado != '' and PlazoDePago != '' and MotivoPrestamo != '':
            # Insersion Base de Datos
            db.execute("DECLARE @IdColaborador INT;INSERT INTO Colaboradores (CedulaColaborador, NombresColaborador, ApellidosColaborador, SalarioColaborador, TipoDeContrato, EstadoCrediticio, CorreoColaborador, NumeroTelefonoColaborador, IdSucursal) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);SET @IdColaborador = SCOPE_IDENTITY();INSERT INTO SolicitudesPrestamos (FechaDeSolicitud, MontoSolicitado, PlazoDePago, MotivoPrestamo, EstadoSolicitud, IdColaborador, IdAdministrador) VALUES (?, ?, ?, ?, 'E', @IdColaborador, 1);", CedulaColaborador, NombresColaborador, ApellidosColaborador, SalarioColaborador, TipoDeContrato, EstadoCrediticio, CorreoColaborador, NumeroTelefonoColaborador, IdSucursal, FechaDeSolicitud, MontoSolicitado, PlazoDePago, MotivoPrestamo)
            db.commit()
            return redirect(url_for('index'))
        else:
            return render_template("Agregar Solicitud.html")

@app.route("/Solicitud en Espera", methods = ['GET', 'POST'])
def SolicitudenEspera():
    if request.method == "GET":
        # Ejecuta la consulta SQL
        db.execute("SELECT SP.FechaDeSolicitud, C.CedulaColaborador, C.NombresColaborador, C.ApellidosColaborador, SP.MontoSolicitado, SP.PlazoDePago, SP.IdColaborador,SP.IdSolicitudesPrestamos FROM SolicitudesPrestamos AS SP JOIN Colaboradores AS C ON SP.IdColaborador = C.IdColaborador WHERE SP.EstadoSolicitud = 'E'")
        rows = db.fetchall()

        # Obtiene las filas y las columnas
        columns = [column[0] for column in db.description]
        rows = [dict(zip(columns, row)) for row in rows]

        # Pasa los datos a la plantilla HTML para ser renderizados
        return render_template("Solicitudes en Espera.html", rows=rows)
    else:
        return render_template("Solicitudes en Espera.htm")

@app.route("/aceptar/<string:CedulaColaborador>", methods = ['GET', 'POST'])
def aceptar(CedulaColaborador):
    db.execute("UPDATE SolicitudesPrestamos SET EstadoSolicitud = 'A' WHERE IdColaborador IN (SELECT IdColaborador FROM Colaboradores WHERE CedulaColaborador = ?);",CedulaColaborador)

    query1="""
    DECLARE @CedulaColaborador varchar(25) = ?; -- Reemplaza con la cédula del colaborador
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
    """
    db.execute(query1,CedulaColaborador)

    return redirect(url_for('index'))

@app.route("/Solicitud Aceptada", methods=['GET', 'POST'])
def Solicitud_Aceptada():
    if request.method == "GET":
            # Ejecuta la consulta SQL para obtener las solicitudes aceptadas
        query = """
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
        """
        db.execute(query)
        rows = db.fetchall()

            # Obtiene las filas y las columnas
        columns = [column[0] for column in db.description]
        rows = [dict(zip(columns, row)) for row in rows]

        print(rows)

        for i in range(len(rows)):
            if rows[i]['EstadoSolicitud'] == 'A':
                rows[i]['EstadoSolicitud'] = 'Aceptada'

            # Pasa los datos a la plantilla HTML para ser renderizados
        return render_template('Solicitud Aceptada.html', rows=rows)
    
    else:
        return render_template('Solicitud Aceptada.html')

@app.route("/Solicitud Denegadas", methods=['GET', 'POST'])
def solicitud_Denegada():
    if request.method == "GET":
        # Ejecuta la consulta SQL para obtener las solicitudes denegadas
        query = """
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
        """
        db.execute(query)
        rows = db.fetchall()

        # Obtiene las filas y las columnas
        columns = [column[0] for column in db.description]
        rows = [dict(zip(columns, row)) for row in rows]

        # Pasa los datos a la plantilla HTML para ser renderizados
        return render_template('Solicitud Denegadas.html', rows=rows)
    
    else:
        return render_template('Solicitud Denegadas.html')

@app.route("/negar/<string:CedulaColaborador>", methods = ['GET', 'POST'])
def negar(CedulaColaborador):
    db.execute("UPDATE SolicitudesPrestamos SET EstadoSolicitud = 'D' WHERE IdColaborador IN (SELECT IdColaborador FROM Colaboradores WHERE CedulaColaborador = ?);",CedulaColaborador)
    db.commit()
    return redirect(url_for('index'))

@app.route("/GenerarPrestamo/<string:CedulaColaborador>", methods = ['GET', 'POST'])
def GenerarPrestamo(CedulaColaborador):

    db.execute("UPDATE Prestamos SET EstadoPrestamo = 'P' FROM Prestamos AS Pr INNER JOIN SolicitudesPrestamos AS SP ON Pr.IdSolicitudesPrestamos = SP.IdSolicitudesPrestamos INNER JOIN Colaboradores AS C ON SP.IdColaborador = C.IdColaborador WHERE C.CedulaColaborador = ? AND Pr.EstadoPrestamo = 'A' ",CedulaColaborador )
    return redirect(url_for('index'))
