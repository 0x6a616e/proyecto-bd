from flask import Flask, render_template, request, jsonify
from flaskext.mysql import MySQL
import datetime

app = Flask(__name__)
mysql = MySQL(app, host='localhost', user='u_dent', password='4rt3D3nt4!', db='arte_dental')

### Vamos a configurar el acceso a la base de datos

print("Conexion exitosa")

@app.route('/', methods=['GET'])

def prueba():
    cur = mysql.get_db().cursor()
    cur.execute('''SELECT eid, nombres, apellidoM, apellidoP FROM dentistas ''')
    Autos = cur.fetchall()
    cur.execute("SELECT serid, ")
    return render_template('pagina.html', Autos=Autos)

@app.route('/buscar/<string:fecha>&<string:doctor>', methods=['GET'])
def horarios(fecha,doctor):
    nombre=doctor.split()
    #f=fecha.split("-")
    #fe=str(datetime.date(int(f[0]), int(f[1]),int(f[2])))
    cur = mysql.get_db().cursor()
    cur.execute(" SELECT hora_inicio, hora_fin FROM dentistas INNER JOIN horarios ON dentistas.eid=horarios.eid WHERE dentistas.eid=%s AND WEEKDAY(%s)=dia_semana AND estatus=1", (nombre[0], fecha))
    A=cur.fetchall()
    cur.execute(" SELECT hora_inicio, duracion FROM clin")
    print(str(A[0][0]) + ", " + str(A[0][1]))
    return "Hola"

if(__name__=='__main__'):
      app.run(debug=True)