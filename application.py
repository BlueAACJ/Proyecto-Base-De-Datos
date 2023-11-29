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
app.secret_key = 'MessiTheGoat'  # Reemplaza con una clave secreta segura

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
        db.execute("SELECT P.FechaDeAprobacion, C.CedulaColaborador, C.NombresColaborador, C.ApellidosColaborador, Pr.EstadoPrestamo, Pr.Capital AS Monto, S.IdColaborador FROM Prestamos AS P JOIN SolicitudesPrestamos AS S ON P.IdSolicitudesPrestamos = S.IdSolicitudesPrestamos JOIN Colaboradores AS C ON S.IdColaborador = C.IdColaborador JOIN Prestamos AS Pr ON S.IdSolicitudesPrestamos = Pr.IdSolicitudesPrestamos")
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

            print("*********************************",tabla)

            
            """
            columnstabla = [columntabla[0] for columntabla in db.description]

            # Convierte las filas a una lista de diccionarios
            # FechaDeAprobacion PlazoDePago Capital Intereses
            tabla = [dict(zip(columnstabla, rowtabla)) for rowtabla in tabla]
            print("******************************",tabla)"""

            tabla = calcular_pagos(tabla)

            print(tabla)

            return render_template('prestamo_detallado.html',info=info)
        else:
            return render_template('Error.html')
    else:
        return render_template('prestamo_detallado.html')

@app.route("/Prestamos Cancelados", methods = ['GET', 'POST'])
def Prestamos_Cancelados():
    if request.method == "GET":
        # Ejecuta la consulta SQL
        db.execute("SELECT SP.FechaDeSolicitud AS FechaDeAprobacion, C.CedulaColaborador, C.NombresColaborador, C.ApellidosColaborador, SP.EstadoSolicitud, SP.MontoSolicitado FROM SolicitudesPrestamos AS SP JOIN Colaboradores AS C ON SP.IdColaborador = C.IdColaborador WHERE SP.EstadoSolicitud = 'C';")
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
        return render_template('Prestamos Cancelados.html', rows=rows)
    else:
        return render_template('Prestamos Cancelados.html')

@app.route("/Agregar Prestamo", methods = ['GET', 'POST'])
def Agregar_Prestamo():
    return render_template("Agregar Prestamo.html")