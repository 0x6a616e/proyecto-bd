CREATE TABLE clinicas (clid INT PRIMARY KEY AUTO_INCREMENT, direccion VARCHAR(128), nombre VARCHAR(64), telefono VARCHAR(16));

CREATE TABLE cuidados_especiales (ceid INT PRIMARY KEY AUTO_INCREMENT, descripcion VARCHAR(200));

CREATE TABLE pacientes (pid INT PRIMARY KEY AUTO_INCREMENT, nombres VARCHAR(50), apellidoP VARCHAR(50), apellidoM VARCHAR(50), telefono VARCHAR(15), correo VARCHAR(50), fecha_nacimiento DATE);

CREATE TABLE ce_pac (pid INT, ceid INT, PRIMARY KEY (pid, ceid), FOREIGN KEY (pid) REFERENCES pacientes (pid), FOREIGN KEY (ceid) REFERENCES cuidados_especiales (ceid));

CREATE TABLE servicios (serid INT PRIMARY KEY AUTO_INCREMENT, nombreServicio VARCHAR(50), descripcion VARCHAR(100), duracion INT, esBasico BIT, categoria VARCHAR(50));

CREATE TABLE medicamentos (mid INT PRIMARY KEY AUTO_INCREMENT, nombre VARCHAR(50), via_aplicacion VARCHAR(50), descripcion VARCHAR(200), dosis VARCHAR(100));

CREATE TABLE especialidades (espid INT PRIMARY KEY AUTO_INCREMENT, nombre VARCHAR(128), descripcion TEXT);

CREATE TABLE dentistas (eid INT PRIMARY KEY AUTO_INCREMENT, rfc VARCHAR(16), nombres VARCHAR(64), apellidoP VARCHAR(32), apellidoM VARCHAR(32), direccion VARCHAR(128), telefono VARCHAR(16), cedula VARCHAR(10));

CREATE TABLE den_clin (clid INT, eid INT, PRIMARY KEY (clid, eid), FOREIGN KEY (clid) REFERENCES clinicas (clid), FOREIGN KEY (eid) REFERENCES dentistas (eid));

CREATE TABLE dentistas_estatus (eid INT, fecha_contratacion DATE, estatus VARCHAR(32), PRIMARY KEY (eid, fecha_contratacion), FOREIGN KEY (eid) REFERENCES dentistas (eid));

CREATE TABLE horarios (hid INT PRIMARY KEY AUTO_INCREMENT, eid INT, dia_semana INT, hora_inicio TIME, hora_fin TIME, estatus BIT, FOREIGN KEY (eid) REFERENCES dentistas (eid));

CREATE TABLE den_esp (eid INT, espid INT, PRIMARY KEY (eid, espid), FOREIGN KEY (eid) REFERENCES dentistas(eid), FOREIGN KEY (espid) REFERENCES especialidades(espid));

CREATE TABLE usuarios (usuario VARCHAR(32) PRIMARY KEY, contrasenia VARCHAR(256), eid INT, FOREIGN KEY (eid) REFERENCES dentistas (eid));

CREATE TABLE citas (cid INT PRIMARY KEY AUTO_INCREMENT, pid INT, eid INT, serid INT, fecha DATE, hora_inicio TIME, numero_sala INT, FOREIGN KEY (pid) REFERENCES pacientes (pid), FOREIGN KEY (eid) REFERENCES dentistas (eid), FOREIGN KEY (serid) REFERENCES servicios (serid));

CREATE TABLE notas (cid INT PRIMARY KEY , notas TEXT, FOREIGN KEY (cid) REFERENCES citas (cid));

CREATE TABLE recetas (cid INT, mid INT, frecuencia varchar(100), PRIMARY KEY (cid, mid), FOREIGN KEY (cid) REFERENCES citas (cid), FOREIGN KEY (mid) REFERENCES medicamentos (mid));


