from os import getenv
from flask import Flask, render_template, current_app, jsonify, request, redirect
from flaskext.mysql import MySQL
from werkzeug.security import check_password_hash

app = Flask(__name__)
mysql = MySQL(app, host = "localhost", user = getenv("DB_USER"), password = getenv("DB_PASSWORD"), db = getenv("DB_NAME"))

@app.route('/', methods = [ "GET" ])
def index():
        return current_app.send_static_file("html/index.html")

@app.route("/conocenos", methods = [ "GET" ])
def about():
        return current_app.send_static_file("html/conocenos.html")

@app.route("/servicios", methods = [ "GET" ])
def services():
        cursor = mysql.get_db().cursor()
        cursor.execute("CALL get_services(%s)", ("Estético", ))
        servicios_esteticos = cursor.fetchall()
        servicios_esteticos = [ list(servicios_esteticos[i]) + [ i + 1 ] for i in range(len(servicios_esteticos)) ]
        cursor.execute("CALL get_services(%s)", ("Salud", ))
        servicios_salud = cursor.fetchall()
        servicios_salud = [ list(servicios_salud[i]) + [ i + 1 ] for i in range(len(servicios_salud)) ]
        cursor.execute("CALL get_services(%s)", ("General", ))
        general = cursor.fetchall()
        cursor.close()
        return render_template("servicios.html", general = general, e_services = servicios_esteticos, s_services = servicios_salud)

@app.route("/sucursales", methods = [ "GET" ])
def sucursales():
        return current_app.send_static_file("html/sucursales.html")

@app.route("/agendar", methods = [ "GET" ])
def agendar():
        return current_app.send_static_file("html/agendar.html")

@app.route("/login_dentistas", methods = [ "GET" ])
def login_dentistas():
        return current_app.send_static_file("html/login_dentistas.html")

@app.route("/val_dentista/<string:usuario>&<string:contrasenia>", methods = [ "GET" ])
def val_dentista(usuario, contrasenia):
        cursor = mysql.get_db().cursor()
        cursor.callproc("validate_user", (usuario, ))
        valido = cursor.fetchone()
        if (valido is None):
                response = jsonify(validado = False)
        else:
                if (check_password_hash(valido[0], contrasenia)):
                        # id = 1 => 17092001 => 0xabcf3
                        response = jsonify(validado = True)
                else:
                        response = jsonify(validado = False)

        response.headers.add("Access-Control-Allow-Origin", "*")
        cursor.close()
        return response

@app.route("/val_usuario/<string:correo>", methods = [ "GET" ])
def val_usuario(correo):
        cursor = mysql.get_db().cursor()
        cursor.callproc("validate_mail", (correo, ))
        valido = cursor.fetchone()
        if (valido is None):
                response = jsonify(validado = "")
        else:
                response = jsonify(validado = hex(17092002 + valido[0]))
        response.headers.add("Access-Control-Allow-Origin", "*")
        cursor.close()
        return response

@app.route("/menu_admin", methods = [ "GET" ])
def menu_admin():
        return current_app.send_static_file("html/menu_admin.html")

### RUTAS DE ADMNISTRADOR A SITIOS

@app.route("/admin_pacientes", methods = [ "GET" ])
def admin_pacientes():
        cursor = mysql.get_db().cursor()
        cursor.execute("CALL show_patients()")
        pacientes = cursor.fetchall()
        pacientes = [ list(pacientes[i]) + [ i + 1 ] for i in range(len(pacientes)) ]
        cursor.execute("CALL show_cares()")
        cuidados = cursor.fetchall()
        cuidados = [ list(cuidados[i]) + [ i + 1 ] for i in range(len(cuidados)) ]
        cursor.execute("CALL show_patients_cares()")
        ce_pac = cursor.fetchall()
        ce_pac = [ list(ce_pac[i]) + [ i + 1 ] for i in range(len(ce_pac)) ]
        cursor.close()
        return render_template("admin_pacientes.html", pacientes = pacientes, cuidados = cuidados, ce_pac = ce_pac)

#@app.route("/administrar/<string:>", methods = [ "GET" ])
#def admin_citas():       
#        return render_template("admin_citas.html")

@app.route("/registrar", methods = [ "POST" ])
def registrar():
        first_name = request.form["first-name"]
        last_name1 = request.form["last-name1"]
        last_name2 = request.form["last-name2"]
        phone = request.form["tel-field"]
        email = request.form["email-field"]
        birthdate = request.form["birthdate-field"]
        cursor = mysql.get_db().cursor()
        cursor.callproc("sign_user", (first_name, last_name1, last_name2, phone, email, birthdate))
        mysql.get_db().commit()
        cursor.callproc("get_user", (email, ))
        valido = cursor.fetchone()
        return redirect("http://localhost:5000/citas/" + str(valido[0]), code = 307)

@app.route("/citas/<string:id>", methods = [ "GET" ])
def citas(id):
        id = int(id, 16) - 17092002
        if id < 0:
                return redirect("http://localhost:5000/agendar", code = 403)
        id = str(id)
        cur = mysql.get_db().cursor()
        cur.callproc("exists_patient", (id, ))
        existe = cur.fetchone()[0]
        if existe == 0:
                return redirect("http://localhost:5000/agendar", code = 403)
        cur.execute('''SELECT eid, nombres, apellidoM, apellidoP FROM dentistas ''')
        Autos = cur.fetchall()
        cur.callproc("basic_patient", (id, ))
        basico = int(cur.fetchone()[0])
        if basico == 1:
                cur.execute('''SELECT serid, nombreServicio FROM servicios ''')
        else:
                cur.execute('''SELECT serid, nombreServicio FROM servicios WHERE esBasico = %s''', (basico, ))
        Servicios=cur.fetchall()
        cur.close()
        return render_template('pagina.html', Autos=Autos, Servicios=Servicios, id=id)

@app.route('/buscar/<string:f>&<string:doctor>&<string:servicio>', methods=['GET'])
def horarios(f,doctor, servicio):
        nombre=doctor.split()
        cur = mysql.get_db().cursor()
        cur.execute(" SELECT hora_inicio, hora_fin FROM dentistas INNER JOIN horarios ON dentistas.eid=horarios.eid WHERE dentistas.eid=%s AND WEEKDAY(%s)=dia_semana AND estatus=1", (nombre[0], f))
        A=cur.fetchall()
        cur.execute(" SELECT hora_inicio, duracion FROM citas INNER JOIN servicios ON citas.serid=servicios.serid WHERE fecha=%s AND eid=%s", (f, nombre[0]))
        B=cur.fetchall()
        ser=servicio.split()
        cur.execute("SELECT duracion FROM servicios WHERE serid=%s", ser[0])
        C=cur.fetchall()
        C=C[0][0]
        horas = []
        h = []
        d = []
        if A:
                i = str(A[0][0]).split(':')
                j = str(A[0][1]).split(':')
                i = float(i[0] + (".5" if i[1] != "00" else ".0"))
                j = float(j[0] + (".5" if j[1] != "00" else ".0"))

                while i < j:
                        horas.append(str(int(i // 1)) + (":30" if i % 1 != 0.0 else ":00"))
                        i += 0.5
                
                # print(horas)
                
                for cita in B:
                        i = str(cita[0]).split(':')
                        i = float(i[0] + (".5" if i[1] != "00" else ".0"))
                        j = i + 0.5 * cita[1] + 0.5
                        i -= 0.5
                        while i <= j:
                                horas.remove(str(int(i // 1)) + (":30" if i % 1 != 0.0 else ":00"))
                                i += 0.5
                aux = [ float(i.split(':')[0] + (".0" if i.split(':')[1] == "00" else ".5")) for i in horas ]
                h.append(0)
                for i in range(1, len(aux)):
                        h.append(aux[i] - aux[i - 1])
                for i in range(len(aux)):
                        valido = True
                        if len(aux) - i < C:
                                valido = False
                        else:
                                for j in range(i, i + C - 1):
                                        if h[j] > 0.5:
                                                valido = False
                                                break
                        if valido:
                                d.append(horas[i])
                # print(C)
                # print(horas)
                # print(aux)
                # print(h)
                # print(d)
                        
                        # [ 10:00 10:30 11:00 14:00 16:00 ]
                        # [   0     30    30   3:00  2:00 ]
                                
                        
                # print(horas)
        response = jsonify(horas = d)
        response.headers.add("Access-Control-Allow-Origin", "*")
        return response
        
@app.route("/registrar_cita", methods=['POST'])
def registrar_cita():
        print(request.form)
        
        # cliente = request.form["id_cliente"]
        # fecha = request.form["fecha"]
        # doctor = request.form["doctor"]
        # servicio = request.form["servicio"]
        # horario = request.form["horario"]
        # print(cliente +" " + fecha+ " " + doctor + " " + servicio + " "+ horario)
        # #cursor = mysql.get_db().cursor()
        # #cursor.execute("INSERT INTO citas VALUES (pid, eid, serid, fecha, hora_inicio) VALUES (%s,%s,%s,%s) ")
        # mysql.get_db().commit()
        return "Hola"

if __name__ == "__main__":
        app.run(debug = True)
