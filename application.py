from flask import *
import pyodbc

#Conexion Base de Datos TODOS DEBEN TERNER LA MISMA BASE DE DATOS Y CAMBIAR El NOMBRES DE USUARIO PARA QUE SIRVA EN SU MAQUINA  
try:
    # conexion a la Base de Datos 
    connection = pyodbc.connect('DRIVER={SQL Server};SERVER=DESKTOP-QSDIA4P\MSSQLSERVER01;DATABASE=PruebaProyecto;Trusted_Connection=yes;')
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
        usuario = request.form['usuario']
        contraseña = request.form['contraseña']

        # Reemplazar esto con tu lógica de autenticación
        if usuario == 'tu_usuario' and contraseña == '123':
            session['usuario'] = usuario
            return redirect("index")
    else:
        return render_template('login.html') 
    
@app.route('/index', methods=['GET', 'POST'])
def index():
    if request.method == "GET":
        # Ejecucion de Query de prueba 
        db.execute("SELECT * FROM Tabla1")
        rows =  db.fetchall
        columns = [column[0] for column in db.description]
        
        rows = [dict(zip(columns, row)) for row in db.fetchall()]
        return render_template('index.html', rows=rows)
    
