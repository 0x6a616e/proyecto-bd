import datetime
import hashlib
from os import getenv
from flask import Flask, render_template, current_app, jsonify, request, redirect, session
from flaskext.mysql import MySQL
from werkzeug.security import check_password_hash, generate_password_hash

app = Flask(__name__)
app.secret_key = getenv("FLASK_SECRET_KEY")
mysql = MySQL(app, host = "localhost", user = getenv("DB_USER"), password = getenv("DB_PASSWORD"), db = getenv("DB_NAME"))

def authenticate():
        try:
                user = session["user"]
                exp = session["exp"]
                signature = session["signature"]
                if datetime.date.today() > datetime.datetime.strptime(exp, "%Y-%m-%d").date():
                        log_off()
                        return False
                signature2 = user + exp + getenv("FLASK_SALT")
                signature2 = hashlib.sha256(signature2.encode())
                signature2 = signature2.hexdigest()
                if (signature != signature2):
                        log_off()
                        return False
                return True
        except:
                return False

@app.route("/log_off", methods = [ "GET" ])
def log_off():
        session.pop("user", default = None)
        session.pop("exp", default = None)
        session.pop("signature", default = None)
        return index()

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
                        session["user"] = usuario
                        exp_date = (datetime.datetime.now() + datetime.timedelta(days = 2)).strftime("%Y-%m-%d")
                        session["exp"] = exp_date
                        signature = usuario + exp_date + getenv("FLASK_SALT")
                        signature = hashlib.sha256(signature.encode())
                        signature = signature.hexdigest()
                        session["signature"] = signature
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

### RUTAS DE ADMNISTRADOR A SITIOS

@app.route("/admin_pacientes", methods = [ "GET" ])
def admin_pacientes():
        if authenticate():
                cursor = mysql.get_db().cursor()
                cursor.execute("CALL show_patients()")
                pacientes = cursor.fetchall()
                #pacientes = [ list(pacientes[i]) + [ i + 1 ] for i in range(len(pacientes)) ]
                cursor.execute("CALL show_cares()")
                cuidados = cursor.fetchall()
                #cuidados = [ list(cuidados[i]) + [ i + 1 ] for i in range(len(cuidados)) ]
                cursor.execute("CALL show_patients_cares()")
                ce_pac = cursor.fetchall()
                #ce_pac = [ list(ce_pac[i]) + [ i + 1 ] for i in range(len(ce_pac)) ]
                cursor.close()
                return render_template("admin_pacientes.html", pacientes = pacientes, cuidados = cuidados, ce_pac = ce_pac)
        return index()

@app.route("/admin_sucursales", methods = [ "GET" ])
def admin_sucursales():
        if authenticate():
                cursor = mysql.get_db().cursor()
                cursor.execute("CALL show_branch_offices()")
                sucursal = cursor.fetchall()
                cursor.close()
                return render_template("admin_sucursales.html", sucursal = sucursal)
        return index()

@app.route("/admin_horarios", methods = [ "GET" ])
def admin_horarios():
        if authenticate():
                cursor = mysql.get_db().cursor()
                cursor.execute("CALL show_schedules()")
                schedules = cursor.fetchall()
                cursor.close()
                return render_template("admin_horarios.html", schedules = schedules)
        return index()

@app.route("/admin_recetas", methods = [ "GET" ])
def admin_recetas():
        if authenticate():
                cursor = mysql.get_db().cursor()
                cursor.execute("CALL show_prescriptions()")
                prescriptions = cursor.fetchall()
                cursor.close()
                return render_template("admin_recetas.html", prescriptions = prescriptions)
        return index()

@app.route("/admin_notas", methods = [ "GET" ])
def admin_notas():
        if authenticate():
                cursor = mysql.get_db().cursor()
                cursor.execute("CALL show_notes()")
                notes = cursor.fetchall()
                cursor.close()
                return render_template("admin_notas.html", notes = notes)
        return index()

@app.route("/admin_registrar_paciente", methods = [ "POST" ])
def admin_registrar_paciente():
        if authenticate():
                first_name = request.form["first-name"]
                last_name1 = request.form["last-name1"]
                last_name2 = request.form["last-name2"]
                phone = request.form["tel-field"]
                email = request.form["email-field"]
                birthdate = request.form["birthdate-field"]
                cursor = mysql.get_db().cursor()
                cursor.callproc("sign_patient", (first_name, last_name1, last_name2, phone, email, birthdate))
                mysql.get_db().commit()
                cursor.callproc("get_patient", (email, ))
                valido = cursor.fetchone()
                return admin_pacientes()
        return index()

@app.route("/admin_registrar_cuidado", methods = [ "POST" ])
def admin_registrar_cuidado():
        if authenticate():
                descripcion = request.form["in-cuidado"]
                cursor = mysql.get_db().cursor()
                cursor.callproc("create_care", (descripcion, ))
                mysql.get_db().commit()
                return admin_pacientes()
        return index()

@app.route("/admin_registrar_nota", methods = [ "POST" ])
def admin_registrar_nota():
        if authenticate():
                id_cid = request.form["id_cita"]
                nota = request.form["nota"]
                cursor = mysql.get_db().cursor()
                cursor.callproc("create_note", (id_cid,nota))
                mysql.get_db().commit()
                return admin_notas()
        return index()

@app.route("/admin_registrar_receta", methods = [ "POST" ])
def admin_registrar_receta():
        if authenticate():
                id_cid = request.form["id_cid"]
                id_mid = request.form["id_mid"]
                frecuencia = request.form["frecuencia"]
                print(id_cid+" "+id_mid+" "+frecuencia)
                cursor = mysql.get_db().cursor()
                cursor.callproc("create_receta", (id_cid, id_mid, frecuencia))
                mysql.get_db().commit()
                return admin_recetas()
        return index()

@app.route("/admin_registrar_cuidado_paciente", methods = [ "POST" ])
def admin_registrar_cuidado_paciente():
        if authenticate():
                id_paciente = request.form["id-patient"]
                id_cuidado = request.form["id-care"]
                cursor = mysql.get_db().cursor()
                cursor.callproc("sign_cuidado_paciente", (id_paciente, id_cuidado))
                mysql.get_db().commit()
                return admin_pacientes()
        return index()

@app.route("/admin_registrar_clinica", methods = [ "POST" ])
def admin_registra_clinica():
        if authenticate():
                nombre = request.form["nombre"]
                direccion = request.form["direccion"]
                telefono = request.form["telefono"]
                cursor = mysql.get_db().cursor()
                cursor.callproc("registrar_sucursal", (direccion, nombre, telefono))
                mysql.get_db().commit()
                return admin_pacientes()
        return index()
        
@app.route("/admin_registrar_horario", methods = [ "POST" ])
def registrar_horario():
        if authenticate():
                id_den = request.form["id_den"]
                dia = request.form["dia"]
                horai = request.form["horai"]
                horaf = request.form["horaf"]
                cursor = mysql.get_db().cursor()
                cursor.callproc("create_schedule", (id_den, dia, horai, horaf))
                mysql.get_db().commit()
                return admin_horarios()
        return index()
        

@app.route("/admin_modificar", methods = [ "POST" ])
def admin_modificar():
        if authenticate():
                tabla = request.form["tabla"]
                id_nombre = request.form["id_nombre"]
                id = request.form["id"]
                atributo = request.form["atributo"]
                valor = request.form["valor"]
                cursor = mysql.get_db().cursor()
                cursor.execute("UPDATE {0} SET {1}='{2}' WHERE {3}={4}".format(tabla, atributo, valor,id_nombre, id))
                mysql.get_db().commit()
                return admin_pacientes()
        return index()

@app.route("/admin_modificarb", methods = [ "POST" ])
def admin_modificarb():
        if authenticate():
                tabla = request.form["tabla"]
                id_nombre = request.form["id_nombre"]
                id = request.form["id"]
                atributo = request.form["atributo"]
                valor = request.form["valor"]
                cursor = mysql.get_db().cursor()
                cursor.execute("UPDATE {0} SET {1}=b'{2}' WHERE {3}={4}".format(tabla, atributo, valor,id_nombre, id))
                mysql.get_db().commit()
                return admin_pacientes()
        return index()

@app.route("/admin_modificarc", methods = [ "POST" ])
def admin_modificarc():
        if authenticate():
                tabla = request.form["tabla"]
                id_cid = request.form["id_cid"]
                id_mid = request.form["id_mid"]
                atributo = request.form["atributo"]
                valor = request.form["valor"]
                cursor = mysql.get_db().cursor()
                cursor.execute("UPDATE {0} SET {1}='{2}' WHERE cid={3} AND mid={4}".format(tabla, atributo, valor,id_cid, id_mid))
                mysql.get_db().commit()
                return admin_recetas()
        return index()

@app.route("/admin_modificar_dentistas", methods = [ "POST" ])
def admin_modificar_dentistas():
        if authenticate():
                tabla = request.form["tabla"]
                id_nombre = request.form["id_nombre"]
                id = request.form["id"]
                atributo = request.form["atributo"]
                valor = request.form["valor"]
                cursor = mysql.get_db().cursor()
                cursor.execute("UPDATE {0} SET {1}='{2}' WHERE {3}={4}".format(tabla, atributo, valor,id_nombre, id))
                mysql.get_db().commit()
                return admin_dentistas()
        return index()

@app.route("/admin_dentistas", methods = [ "GET" ])
def admin_dentistas():
        if authenticate():
                cursor = mysql.get_db().cursor()
                cursor.execute("CALL show_dentists()")
                dentistas = cursor.fetchall()
                cursor.execute("CALL show_specialties()")
                especialidades = cursor.fetchall()
                cursor.execute("CALL show_dentists_specialties()")
                den_esp = cursor.fetchall()
                cursor.close()
                return render_template("admin_dentistas.html", dentistas = dentistas, especialidades = especialidades, den_esp = den_esp)
        return index()

@app.route("/admin_registrar_dentista", methods = [ "POST" ])
def admin_registrar_dentista():
        if authenticate():
                first_name = request.form["first-name"]
                last_name1 = request.form["last-name1"]
                last_name2 = request.form["last-name2"]
                tel_field = request.form["tel-field"]
                address_field = request.form["address-field"]
                cedula_field = request.form["cedula-field"]
                rfc_field = request.form["rfc-field"]
                user_field = request.form["user-field"]
                pass_field = request.form["pass-field"]
                pass_field = generate_password_hash(pass_field)
                
                cursor = mysql.get_db().cursor()
                cursor.callproc("sign_dentista", (rfc_field, first_name, last_name1, last_name2, address_field, tel_field, cedula_field))
                mysql.get_db().commit()
                cursor.callproc("get_dentist_id", (rfc_field, ))
                eid = cursor.fetchone()
                cursor.callproc("sign_user", (user_field, pass_field, eid))
                mysql.get_db().commit()
                return admin_dentistas()
        return index()

@app.route("/admin_registrar_especialidad", methods = [ "POST" ])
def admin_registrar_especialidad():
        if authenticate():
                id_specialties = request.form["id-specialties"]
                specialties_desc = request.form["specialties-desc"]
                cursor = mysql.get_db().cursor()
                cursor.callproc("create_specialty", (id_specialties, specialties_desc))
                mysql.get_db().commit()
                return admin_dentistas()
        return index()

@app.route("/admin_registrar_den_esp", methods = [ "POST" ])
def admin_registrar_den_esp():
        if authenticate():
                id_dentist = request.form["id-dentist"]
                id_specialty = request.form["id-specialty"]
                cursor = mysql.get_db().cursor()
                cursor.callproc("create_dentist_specialty", (id_dentist, id_specialty))
                mysql.get_db().commit()
                return admin_dentistas()
        return index()

@app.route("/admin_servmed", methods = [ "GET" ])
def admin_servmed():
        if authenticate():
                cursor = mysql.get_db().cursor()
                cursor.execute("CALL show_services()")
                servicios = cursor.fetchall()
                cursor.execute("CALL show_medicines()")
                medicinas = cursor.fetchall()
                cursor.close()
                return render_template("admin_servmed.html", servicios = servicios, medicinas = medicinas)
        return index()

@app.route("/admin_registrar_servicio", methods = [ "POST" ])
def admin_registrar_servicio():
        if authenticate():
                nombre = request.form["serv-name"]
                descripcion = request.form["serv-desc"]
                duracion = request.form["serv-dur"]
                esBasico = request.form["is-basic"]
                categoria = request.form["serv-cat"]
                cursor = mysql.get_db().cursor()
                cursor.callproc("create_service", (nombre, descripcion, duracion, esBasico, categoria))
                mysql.get_db().commit()
                return admin_servmed()
        return index()

@app.route("/admin_registrar_medicamento", methods = [ "POST" ])
def admin_registrar_medicamento():
        if authenticate():
                nombre = request.form["med-name"]
                via = request.form["a-route"]
                descripcion = request.form["med-desc"]
                dosis = request.form["med-dose"]
                cursor = mysql.get_db().cursor()
                cursor.callproc("create_medicine", (nombre, via, descripcion, dosis))
                mysql.get_db().commit()
                return admin_servmed()
        return index()

@app.route("/admin_modificarServmed", methods = [ "POST" ])
def admin_modificarServmed():
        if authenticate():
                tabla = request.form["tabla"]
                id_nombre = request.form["id_nombre"]
                id = request.form["id"]
                atributo = request.form["atributo"]
                valor = request.form["valor"]
                cursor = mysql.get_db().cursor()
                if(atributo != "esBasico"):
                        cursor.execute("UPDATE {0} SET {1}='{2}' WHERE {3}={4}".format(tabla, atributo, valor,id_nombre, id))
                else:
                        cursor.execute("UPDATE {0} SET {1}=b'{2}' WHERE {3}={4}".format(tabla, atributo, valor,id_nombre, id))
                mysql.get_db().commit()
                return admin_servmed()
        return index()

@app.route("/admin_borrar_cita", methods = [ "POST" ])
def admin_borrar_cita():
        if authenticate():
                cid = request.form["cid-field"]
                cursor = mysql.get_db().cursor()
                cursor.callproc("delete_appointment", (cid, ))
                mysql.get_db().commit()
                cursor.close()
                return admin_citas()
        return index

@app.route("/admin_modificar_citas", methods = [ "POST" ])
def admin_modificar_citas():
        if authenticate():
                tabla = request.form["tabla"]
                id_nombre = request.form["id_nombre"]
                id = request.form["id"]
                atributo = request.form["atributo"]
                valor = request.form["valor"]
                cursor = mysql.get_db().cursor()
                cursor.execute("UPDATE {0} SET {1}='{2}' WHERE {3}={4}".format(tabla, atributo, valor,id_nombre, id))
                mysql.get_db().commit()
                return admin_citas()
        return index()

@app.route("/admin_citas", methods = [ "GET" ])
def admin_citas():
        if authenticate():
                cursor = mysql.get_db().cursor()
                cursor.execute("CALL show_appointments()")
                citas = cursor.fetchall()
                return render_template("admin_citas.html", citas = citas)
        return index()

#@app.route("/administrar/<string:>", methods = [ "GET" ])
#def admin_citas():       
#        return render_template("admin_citas.html")

### TERMINA RUTAS DE ADMINISTRADOR A SITIOS

@app.route("/registrar", methods = [ "POST" ])
def registrar():
        first_name = request.form["first-name"]
        last_name1 = request.form["last-name1"]
        last_name2 = request.form["last-name2"]
        phone = request.form["tel-field"]
        email = request.form["email-field"]
        birthdate = request.form["birthdate-field"]
        cursor = mysql.get_db().cursor()
        cursor.callproc("sign_patient", (first_name, last_name1, last_name2, phone, email, birthdate))
        mysql.get_db().commit()
        cursor.callproc("get_patient", (email, ))
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
                                hora = str(int(i // 1)) + (":30" if i % 1 != 0.0 else ":00")
                                if hora in horas:
                                        horas.remove(hora)
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
        cliente = request.form["id_cliente"]
        fecha = request.form["fecha"]
        doctor = request.form["doctor"].split()
        servicio = request.form["servicio"].split()
        horario = request.form["horario"]
        print(cliente +" " + fecha+ " " + doctor[0] + " " + servicio[0] + " "+ horario)
        cursor = mysql.get_db().cursor()
        cursor.execute("INSERT INTO citas (pid, eid, serid, fecha, hora_inicio) VALUES (%s,%s,%s,%s,%s)", (cliente, doctor[0], servicio[0],fecha,horario))
        mysql.get_db().commit()
        return current_app.send_static_file("html/exit_success.html")

@app.route("/terminos", methods = [ "GET" ])
def terminos():
        return current_app.send_static_file("html/terminos.html")

@app.route("/privacidad", methods = [ "GET" ])
def privacidad():
        return current_app.send_static_file("html/privacidad.html")

@app.route("/contacto", methods = [ "GET" ])
def contacto():
        return current_app.send_static_file("html/contacto.html")

if __name__ == "__main__":
        app.run(debug = True)
