from flask import *
import pyodbc

#Conexion Base de Datos TODOS DEBEN TERNER LA MISMA BASE DE DATOS Y CAMBIAR El NOMBRES DE USUARIO PARA QUE SIRVA EN SU MAQUINA  
try:
    # conexion a la Base de Datos 
    connection = pyodbc.connect('DRIVER={SQL Server};SERVER=DESKTOP-QSDIA4P\MSSQLSERVER01;DATABASE=GrupoTalse;Trusted_Connection=yes;')
    # db es el objeto para las ejecuciones de la base de datos 
    db = connection.cursor()
    """  # Ejecucion de Query de prueba 
    rows = db.execute("SELECT * FROM Tabla1")
    #Impresion 
    for row in rows:
        print(row)
    # Impresion de Error """

except Exception as ex:
    print("Error durante la conexión: {}".format(ex))

app = Flask(__name__)
app.secret_key = 'EdwingMaricon'  # Reemplaza con una clave secreta segura

@app.route('/', methods = ['GET', 'POST'])
def login():
    session.clear()
    if request.method == 'POST':
        usuario = request.form.get['usuario']
        contrasena = request.form.get['contrasena']

        # Buscar los datos en la base de datos en la tabla de administradores 
        rows = db.execute("SELECT * FROM users WHERE username = :username AND hash = :hash", {"usuario": usuario, "hash": contrasena}).fetchall()
        if len(rows) == 1:
            session["id"] = rows[0]["id"]
            return render_template("index.html")
        else:
            flash('Contrasena o usuario equivocada vuelva a intentarlo')
            return redirect(url_for('login'))
    else:
        return render_template('login.html') 
    
@app.route('/index', methods=['GET', 'POST'])
def index():
    if request.method == "GET":
        # Ejecucion de Query de prueba 
        #db.execute("SELECT * FROM Tabla1")
        # rows =  db.fetchall
        # columns = [column[0] for column in db.description]
        
        """ CHAT GPT
        # Ejecuta la consulta SQL
        db.execute("SELECT * FROM Tabla1")

        # Obtiene las filas y las columnas
        rows = db.fetchall()
        columns = [column[0] for column in db.description]

        # Convierte las filas a una lista de diccionarios
        rows = [dict(zip(columns, row)) for row in rows]

        # Pasa los datos a la plantilla HTML para ser renderizados
        return render_template('index.html', rows=rows)
        """

        #rows = [dict(zip(columns, row)) for row in db.fetchall()]
        #return render_template('index.html', rows=rows)
    
@app.route("/logout", methods = ['GET', 'POST'])
def logout():
    # cerramos sesion 
    session.clear()
    # redireccionamos al login 
    return redirect("/")

@app.route("/agregar_prestamo", methods = ['GET', 'POST'])
def agregar_prestamo():
    return "AGREGAR PRESTAMO"

@app.route("/Historial", methods = ['GET', 'POST'])
def Historial():
    return "Historial Historial"

@app.route("/Prestamo_Detallado", methods = ['GET', 'POST'])
def Historial():
    return "Prestamo_Detallado"