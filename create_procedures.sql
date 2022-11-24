DELIMITER //

DROP PROCEDURE IF EXISTS get_services //
CREATE PROCEDURE get_services(IN categoria_buscada VARCHAR(64))
BEGIN
SELECT nombreServicio, descripcion
FROM servicios
WHERE categoria = categoria_buscada;
END //

DROP PROCEDURE IF EXISTS validate_mail //
CREATE PROCEDURE validate_mail(IN correo_validar VARCHAR(64))
BEGIN
SELECT pid
FROM pacientes
WHERE correo = correo_validar;
END //

DROP PROCEDURE IF EXISTS validate_user //
CREATE PROCEDURE validate_user(IN usuario_validar VARCHAR(64))
BEGIN
SELECT contrasenia
FROM usuarios
WHERE usuario = usuario_validar;
END //

DROP PROCEDURE IF EXISTS sign_patient //
CREATE PROCEDURE sign_patient(IN first_name VARCHAR(64), IN last_name1 VARCHAR(64), IN last_name2 VARCHAR(64), phone VARCHAR(16), IN mail VARCHAR(64), IN birth_date DATE)
BEGIN
INSERT INTO pacientes (nombres, apellidoP, apellidoM, telefono, correo, fecha_nacimiento)
VALUES (first_name, last_name1, last_name2, phone, mail, birth_date);
END //

DROP PROCEDURE IF EXISTS registrar_sucursal //
CREATE PROCEDURE registrar_sucursal (IN d VARCHAR(128), IN n VARCHAR(64), IN t VARCHAR(16))
BEGIN
INSERT INTO clinicas (direccion, nombre, telefono) VALUES (d, n, t);
END //

-- DROP PROCEDURE IF EXISTS change_user //
-- CREATE PROCEDURE change_user(IN first_name VARCHAR(64))
-- BEGIN
-- END //

DROP PROCEDURE IF EXISTS get_patient //
CREATE PROCEDURE get_patient(IN mail VARCHAR(64))
BEGIN
SELECT pid
FROM pacientes
WHERE correo = mail;
END //

DROP PROCEDURE IF EXISTS basic_patient //
CREATE PROCEDURE basic_patient(IN basic_pid INT)
BEGIN
SELECT EXISTS (
        SELECT cid
        FROM citas
        WHERE pid = basic_pid
);
END //

DROP PROCEDURE IF EXISTS exists_patient //
CREATE PROCEDURE exists_patient(IN exists_pid INT)
BEGIN
SELECT EXISTS (
        SELECT pid
        FROM pacientes
        WHERE pid = exists_pid
);
END //

/*
-----------------------------COMIENZAN PROCEDURES PARA MOSTRAR DATOS
*/

DROP PROCEDURE IF EXISTS show_patients //
CREATE PROCEDURE show_patients()
BEGIN
SELECT *
FROM pacientes;
END //

DROP PROCEDURE IF EXISTS show_cares //
CREATE PROCEDURE show_cares()
BEGIN
SELECT *
FROM cuidados_especiales;
END //

DROP PROCEDURE IF EXISTS create_care //
CREATE PROCEDURE create_care(IN in_descripcion VARCHAR(256))
BEGIN
INSERT INTO cuidados_especiales (descripcion)
VALUES (in_descripcion);
END //

DROP PROCEDURE IF EXISTS show_patients_cares //
CREATE PROCEDURE show_patients_cares()
BEGIN
SELECT pid, descripcion
FROM ce_pac, cuidados_especiales
WHERE ce_pac.ceid = cuidados_especiales.ceid;
END //

DROP PROCEDURE IF EXISTS show_dentists //
CREATE PROCEDURE show_dentists()
BEGIN
SELECT *
FROM dentistas;
END //

DROP PROCEDURE IF EXISTS show_specialties //
CREATE PROCEDURE show_specialties()
BEGIN
SELECT *
FROM especialidades;
END //

DROP PROCEDURE IF EXISTS create_specialty //
CREATE PROCEDURE create_specialty(IN in_specialtie VARCHAR(128), IN in_descripcion TEXT)
BEGIN
INSERT INTO especialidades (nombre, descripcion)
VALUES (in_specialtie, in_descripcion);
END //

DROP PROCEDURE IF EXISTS show_dentists_specialties //
CREATE PROCEDURE show_dentists_specialties()
BEGIN
SELECT den_esp.eid, nombre
FROM den_esp, especialidades
WHERE den_esp.espid = especialidades.espid
ORDER BY den_esp.eid;
END //

DROP PROCEDURE IF EXISTS create_dentist_specialty //
CREATE PROCEDURE create_dentist_specialty(IN id_dentist INT, IN id_specialty INT)
BEGIN
INSERT INTO den_esp (eid, espid)
VALUES (id_dentist, id_specialty);
END //
/*
DROP PROCEDURE IF EXISTS show_dentists_specialties //
CREATE PROCEDURE show_dentists_specialties()
BEGIN
SELECT *
FROM den_esp;
END //
*/

DROP PROCEDURE IF EXISTS show_branch_offices //
CREATE PROCEDURE show_branch_offices()
BEGIN
SELECT *
FROM clinicas;
END //

DROP PROCEDURE IF EXISTS show_dentists_status //
CREATE PROCEDURE show_dentists_status()
BEGIN
SELECT *
FROM dentistas_estatus;
END //

DROP PROCEDURE IF EXISTS show_schedules //
CREATE PROCEDURE show_schedules()
BEGIN
SELECT hid, eid, dia_semana, hora_inicio, hora_fin, CAST(estatus AS UNSIGNED) AS estatus
FROM horarios;
END //

DROP PROCEDURE IF EXISTS show_users //
CREATE PROCEDURE show_users()
BEGIN
SELECT *
FROM usuarios;
END //

DROP PROCEDURE IF EXISTS show_services //
CREATE PROCEDURE show_services()
BEGIN
SELECT serid, nombreServicio, descripcion, duracion, CAST(esBasico AS UNSIGNED) AS esBasico, categoria
FROM servicios;
END //

DROP PROCEDURE IF EXISTS create_service //
CREATE PROCEDURE create_service(IN in_nom VARCHAR(64), IN in_desc VARCHAR(128), IN in_dur INT, IN in_bas INT, IN in_cat VARCHAR(64))
BEGIN
INSERT INTO servicios (nombreServicio, descripcion, duracion, esBasico,  categoria)
VALUES (in_nom, in_desc, in_dur, in_bas, in_cat);
END //

DROP PROCEDURE IF EXISTS create_schedule //
CREATE PROCEDURE create_schedule(IN e INT, IN dia INT, IN horai TIME, IN horaf TIME)
BEGIN
INSERT INTO horarios (eid, dia_semana, hora_inicio, hora_fin, estatus)
VALUES (e, dia, horai, horaf, 1);
END//

DROP PROCEDURE IF EXISTS show_medicines //
CREATE PROCEDURE show_medicines()
BEGIN
SELECT *
FROM medicamentos;
END //

DROP PROCEDURE IF EXISTS create_medicine //
CREATE PROCEDURE create_medicine(IN in_nom VARCHAR(64), IN in_via VARCHAR(64), IN in_desc VARCHAR(256), IN in_dos VARCHAR(128))
BEGIN
INSERT INTO medicamentos (nombre, via_aplicacion, descripcion,  dosis)
VALUES (in_nom, in_via, in_desc, in_dos);
END //

DROP PROCEDURE IF EXISTS create_note //
CREATE PROCEDURE create_note (IN c INT, IN n TEXT)
BEGIN
INSERT INTO notas (cid, notas)
VALUES (c, n);
END //

DROP PROCEDURE IF EXISTS create_receta //
CREATE PROCEDURE create_receta (IN c INT, IN m INT, IN f VARCHAR(100))
BEGIN
INSERT INTO recetas (cid, mid, frecuencia)
VALUES (c,m,f);
END //

DROP PROCEDURE IF EXISTS show_appointments //
CREATE PROCEDURE show_appointments()
BEGIN
SELECT *
FROM citas;
END //

DROP PROCEDURE IF EXISTS show_notes //
CREATE PROCEDURE show_notes()
BEGIN
SELECT *
FROM notas;
END //

DROP PROCEDURE IF EXISTS show_prescriptions //
CREATE PROCEDURE show_prescriptions()
BEGIN
SELECT *
FROM recetas;
END //

DROP PROCEDURE IF EXISTS sign_cuidado_paciente //
CREATE PROCEDURE sign_cuidado_paciente(IN id_paciente INT, IN id_cuidado INT)
BEGIN
INSERT INTO ce_pac (pid, ceid)
VALUES (id_paciente, id_cuidado);
END //

DROP PROCEDURE IF EXISTS sign_dentista //
CREATE PROCEDURE sign_dentista(IN rfc_field VARCHAR(16), IN nombres_field VARCHAR(64), IN apellidoP_field VARCHAR(32), IN apellidoM_field VARCHAR(32), IN direccion_field VARCHAR(128), IN telefono_field VARCHAR(16), IN cedula_field VARCHAR(16))
BEGIN
INSERT INTO dentistas (rfc, nombres, apellidoP, apellidoM, direccion, telefono, cedula)
VALUES (rfc_field, nombres_field, apellidoP_field, apellidoM_field, direccion_field, telefono_field, cedula_field);
END //

DROP PROCEDURE IF EXISTS sign_user //
CREATE PROCEDURE sign_user(IN usuario_field VARCHAR(32), IN contrasenia_field VARCHAR(256), IN eid_field INT)
BEGIN
INSERT INTO usuarios (usuario, contrasenia, eid)
VALUES (usuario_field, contrasenia_field, eid_field);
END //

DROP PROCEDURE IF EXISTS get_dentist_id //
CREATE PROCEDURE get_dentist_id(IN rfc_field VARCHAR(16))
BEGIN
SELECT eid
FROM dentistas
WHERE rfc = rfc_field;
END //

DROP PROCEDURE IF EXISTS delete_appointment //
CREATE PROCEDURE delete_appointment(IN cid_field INT)
BEGIN
DELETE FROM citas WHERE cid = cid_field;
END //
