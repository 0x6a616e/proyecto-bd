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

DROP PROCEDURE IF EXISTS sign_user //
CREATE PROCEDURE sign_user(IN first_name VARCHAR(64), IN last_name1 VARCHAR(64), IN last_name2 VARCHAR(64), phone VARCHAR(16), IN mail VARCHAR(64), IN birth_date DATE)
BEGIN
INSERT INTO pacientes (nombres, apellidoP, apellidoM, telefono, correo, fecha_nacimiento)
VALUES (first_name, last_name1, last_name2, phone, mail, birth_date);
END //

DROP PROCEDURE IF EXISTS get_user //
CREATE PROCEDURE get_user(IN mail VARCHAR(64))
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

DROP PROCEDURE IF EXISTS show_patients_cares //
CREATE PROCEDURE show_patients_cares()
BEGIN
SELECT *
FROM ce_pac;
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

DROP PROCEDURE IF EXISTS show_dentists_specialties //
CREATE PROCEDURE show_dentists_specialties()
BEGIN
SELECT *
FROM den_esp;
END //

DROP PROCEDURE IF EXISTS show_branch_offices //
CREATE PROCEDURE show_branch_offices()
BEGIN
SELECT *
FROM clinicas;
END //

DROP PROCEDURE IF EXISTS show_dentists_offices //
CREATE PROCEDURE show_dentists_offices()
BEGIN
SELECT *
FROM den_clin;
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
SELECT *
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
SELECT *
FROM servicios;
END //

DROP PROCEDURE IF EXISTS show_medicines //
CREATE PROCEDURE show_medicines()
BEGIN
SELECT *
FROM medicamentos;
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

/*
-----------------------------TERMINAR PROCEDURES PARA MOSTRAR DATOS
*/
