
-- =========================================================
-- PROYECTO PASCUALINA - TAREA 4
-- SGBD: MySQL
-- Script DDL para crear las 12 tablas
-- Incluye metadatos de tipo JSON en la tabla evento
-- No elimina ni modifica la base de datos original.
-- =========================================================


-- 1. ESTUDIANTE
CREATE TABLE estudiante (
    id_estudiante INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL,
    fecha_nacimiento DATE NULL,
    CONSTRAINT pk_estudiante PRIMARY KEY (id_estudiante),
    CONSTRAINT uq_estudiante_correo UNIQUE (correo)
) ENGINE=InnoDB;

-- 2. INTERES
CREATE TABLE interes (
    id_interes INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NULL,
    CONSTRAINT pk_interes PRIMARY KEY (id_interes)
) ENGINE=InnoDB;

-- 3. HABILIDAD
CREATE TABLE habilidad (
    id_habilidad INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NULL,
    nivel VARCHAR(50) NULL,
    CONSTRAINT pk_habilidad PRIMARY KEY (id_habilidad)
) ENGINE=InnoDB;

-- 4. GRUPO
CREATE TABLE grupo (
    id_grupo INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NULL,
    tipo VARCHAR(50) NULL,
    fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_grupo PRIMARY KEY (id_grupo)
) ENGINE=InnoDB;

-- 5. EVENTO
CREATE TABLE evento (
    id_evento INT AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    lugar VARCHAR(200) NULL,
    metadatos JSON NULL,
    CONSTRAINT pk_evento PRIMARY KEY (id_evento)
) ENGINE=InnoDB;

-- 6. PUBLICACION
CREATE TABLE publicacion (
    id_publicacion INT AUTO_INCREMENT,
    id_estudiante INT NOT NULL,
    contenido TEXT NOT NULL,
    fecha_publicacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tipo VARCHAR(50) NULL,
    CONSTRAINT pk_publicacion PRIMARY KEY (id_publicacion),
    CONSTRAINT fk_publicacion_estudiante
        FOREIGN KEY (id_estudiante)
        REFERENCES estudiante(id_estudiante)
) ENGINE=InnoDB;

-- 7. COMENTARIO
CREATE TABLE comentario (
    id_comentario INT AUTO_INCREMENT,
    id_publicacion INT NOT NULL,
    id_estudiante INT NOT NULL,
    contenido TEXT NOT NULL,
    fecha_comentario DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_comentario PRIMARY KEY (id_comentario),
    CONSTRAINT fk_comentario_estudiante
        FOREIGN KEY (id_estudiante)
        REFERENCES estudiante(id_estudiante),
    CONSTRAINT fk_comentario_publicacion
        FOREIGN KEY (id_publicacion)
        REFERENCES publicacion(id_publicacion)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- 8. ESTUDIANTE_INTERES
CREATE TABLE estudiante_interes (
    id_estudiante INT NOT NULL,
    id_interes INT NOT NULL,
    CONSTRAINT pk_estudiante_interes
        PRIMARY KEY (id_estudiante, id_interes),
    CONSTRAINT fk_estudiante_interes_estudiante
        FOREIGN KEY (id_estudiante)
        REFERENCES estudiante(id_estudiante)
        ON DELETE CASCADE,
    CONSTRAINT fk_estudiante_interes_interes
        FOREIGN KEY (id_interes)
        REFERENCES interes(id_interes)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- 9. ESTUDIANTE_HABILIDAD
CREATE TABLE estudiante_habilidad (
    id_estudiante INT NOT NULL,
    id_habilidad INT NOT NULL,
    CONSTRAINT pk_estudiante_habilidad
        PRIMARY KEY (id_estudiante, id_habilidad),
    CONSTRAINT fk_estudiante_habilidad_estudiante
        FOREIGN KEY (id_estudiante)
        REFERENCES estudiante(id_estudiante)
        ON DELETE CASCADE,
    CONSTRAINT fk_estudiante_habilidad_habilidad
        FOREIGN KEY (id_habilidad)
        REFERENCES habilidad(id_habilidad)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- 10. SEGUIMIENTO
CREATE TABLE seguimiento (
    id_seguidor INT NOT NULL,
    id_seguido INT NOT NULL,
    id_seguimiento INT AUTO_INCREMENT,
    fecha_seguimiento DATETIME NULL,
    CONSTRAINT pk_seguimiento PRIMARY KEY (id_seguimiento),
    CONSTRAINT uq_seguimiento_pareja
        UNIQUE (id_seguidor, id_seguido),
    CONSTRAINT ck_seguimiento_distinto
        CHECK (id_seguidor <> id_seguido),
    CONSTRAINT fk_seguimiento_seguidor
        FOREIGN KEY (id_seguidor)
        REFERENCES estudiante(id_estudiante)
        ON DELETE CASCADE,
    CONSTRAINT fk_seguimiento_seguido
        FOREIGN KEY (id_seguido)
        REFERENCES estudiante(id_estudiante)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- 11. MEMBRESIA
CREATE TABLE membresia (
    id_estudiante INT NOT NULL,
    id_grupo INT NOT NULL,
    fecha_ingreso DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_membresia INT AUTO_INCREMENT,
    rol VARCHAR(50) NULL,
    CONSTRAINT pk_membresia PRIMARY KEY (id_membresia),
    CONSTRAINT uq_membresia_estudiante_grupo
        UNIQUE (id_estudiante, id_grupo),
    CONSTRAINT fk_membresia_estudiante
        FOREIGN KEY (id_estudiante)
        REFERENCES estudiante(id_estudiante)
        ON DELETE CASCADE,
    CONSTRAINT fk_membresia_grupo
        FOREIGN KEY (id_grupo)
        REFERENCES grupo(id_grupo)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- 12. PARTICIPACION_EVENTO
CREATE TABLE participacion_evento (
    id_estudiante INT NOT NULL,
    id_evento INT NOT NULL,
    fecha_inscripcion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_participacion_evento
        PRIMARY KEY (id_estudiante, id_evento),
    CONSTRAINT fk_participacion_estudiante
        FOREIGN KEY (id_estudiante)
        REFERENCES estudiante(id_estudiante)
        ON DELETE CASCADE,
    CONSTRAINT fk_participacion_evento
        FOREIGN KEY (id_evento)
        REFERENCES evento(id_evento)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- FIN DEL SCRIPT DDL DE MYSQL


