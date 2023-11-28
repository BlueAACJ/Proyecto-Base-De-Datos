from flask import *
import pyodbc

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
            return render_template("index.html")
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
        print(CedulaColaborador)

        # verificacion existencia del colaborador 
        rows = db.execute("select * from Colaboradores where CedulaColaborador = ?", CedulaColaborador)
        rows = db.fetchall()
        # Obtiene las filas y las columnas
        columns = [column[0] for column in db.description]

        # Convierte las filas a una lista de diccionarios
        rows = [dict(zip(columns, row)) for row in rows]
        print(rows)
        
        if rows != []:
            db.execute("SELECT Pr.IdPrestamo,CONCAT(C.NombresColaborador, ' ', C.ApellidosColaborador) AS Colaborador, SP.PlazoDePago AS PlazoDePago, S.nombreDeSucursal AS Sucursal, S.direccionSucursal AS Direccion, Pr.Capital, Pr.Intereses, Pr.CosteTotal, Pr.Cuotas, Pr.EstadoPrestamo FROM Prestamos AS Pr JOIN SolicitudesPrestamos AS SP ON Pr.IdSolicitudesPrestamos = SP.IdSolicitudesPrestamos JOIN Colaboradores AS C ON SP.IdColaborador = C.IdColaborador JOIN Sucursales AS S ON C.IdSucursal = S.IdSucursal WHERE C.CedulaColaborador = ?",CedulaColaborador)

            return render_template('prestamo_detallado.html')
        else:
            return render_template('Error.html')
    else:
        return render_template('prestamo_detallado.html')

@app.route("/Historial", methods = ['GET', 'POST'])
def Historial():
    return "Historial Historial"

"""
@app.route("/agregar_prestamo", methods = ['GET', 'POST'])
def agregar_prestamo():
    return "AGREGAR PRESTAMO"
"""