
-- =========================================================
-- PROYECTO PASCUALINA - TAREA 4
-- SGBD: Microsoft SQL Server
-- Script DDL para crear las 12 tablas
-- Incluye metadatos JSON validado
-- =========================================================

-- 1. ESTUDIANTE
CREATE TABLE estudiante (
    id_estudiante INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL,
    fecha_nacimiento DATE NULL,
    CONSTRAINT pk_estudiante PRIMARY KEY (id_estudiante),
    CONSTRAINT uq_estudiante_correo UNIQUE (correo)
);

-- 2. INTERES
CREATE TABLE interes (
    id_interes INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion NVARCHAR(MAX) NULL,
    CONSTRAINT pk_interes PRIMARY KEY (id_interes)
);

-- 3. HABILIDAD
CREATE TABLE habilidad (
    id_habilidad INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion NVARCHAR(MAX) NULL,
    nivel VARCHAR(50) NULL,
    CONSTRAINT pk_habilidad PRIMARY KEY (id_habilidad)
);

-- 4. GRUPO
CREATE TABLE grupo (
    id_grupo INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion NVARCHAR(MAX) NULL,
    tipo VARCHAR(50) NULL,
    fecha_creacion DATETIME2 NOT NULL
        CONSTRAINT df_grupo_fecha_creacion DEFAULT SYSDATETIME(),
    CONSTRAINT pk_grupo PRIMARY KEY (id_grupo)
);

-- 5. EVENTO
CREATE TABLE evento (
    id_evento INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    descripcion NVARCHAR(MAX) NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    lugar VARCHAR(200) NULL,
    metadatos NVARCHAR(MAX) NULL,
    CONSTRAINT pk_evento PRIMARY KEY (id_evento),
    CONSTRAINT ck_evento_metadatos_json
        CHECK (metadatos IS NULL OR ISJSON(metadatos) = 1)
);

-- 6. PUBLICACION
CREATE TABLE publicacion (
    id_publicacion INT IDENTITY(1,1) NOT NULL,
    id_estudiante INT NOT NULL,
    contenido NVARCHAR(MAX) NOT NULL,
    fecha_publicacion DATETIME2 NOT NULL
        CONSTRAINT df_publicacion_fecha DEFAULT SYSDATETIME(),
    tipo VARCHAR(50) NULL,
    CONSTRAINT pk_publicacion PRIMARY KEY (id_publicacion),
    CONSTRAINT fk_publicacion_estudiante
        FOREIGN KEY (id_estudiante)
        REFERENCES estudiante(id_estudiante)
);

-- 7. COMENTARIO
CREATE TABLE comentario (
    id_comentario INT IDENTITY(1,1) NOT NULL,
    id_publicacion INT NOT NULL,
    id_estudiante INT NOT NULL,
    contenido NVARCHAR(MAX) NOT NULL,
    fecha_comentario DATETIME2 NOT NULL
        CONSTRAINT df_comentario_fecha DEFAULT SYSDATETIME(),
    CONSTRAINT pk_comentario PRIMARY KEY (id_comentario),
    CONSTRAINT fk_comentario_estudiante
        FOREIGN KEY (id_estudiante)
        REFERENCES estudiante(id_estudiante),
    CONSTRAINT fk_comentario_publicacion
        FOREIGN KEY (id_publicacion)
        REFERENCES publicacion(id_publicacion)
        ON DELETE CASCADE
);

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
);

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
);

-- 10. SEGUIMIENTO
CREATE TABLE seguimiento (
    id_seguidor INT NOT NULL,
    id_seguido INT NOT NULL,
    id_seguimiento INT IDENTITY(1,1) NOT NULL,
    fecha_seguimiento DATETIME2 NULL,
    CONSTRAINT pk_seguimiento PRIMARY KEY (id_seguimiento),
    CONSTRAINT uq_seguimiento_pareja UNIQUE (id_seguidor, id_seguido),
    CONSTRAINT ck_seguimiento_distinto CHECK (id_seguidor <> id_seguido),
    CONSTRAINT fk_seguimiento_seguidor
        FOREIGN KEY (id_seguidor)
        REFERENCES estudiante(id_estudiante)
        ON DELETE CASCADE,
    CONSTRAINT fk_seguimiento_seguido
        FOREIGN KEY (id_seguido)
        REFERENCES estudiante(id_estudiante)
        ON DELETE CASCADE
);

-- 11. MEMBRESIA
CREATE TABLE membresia (
    id_estudiante INT NOT NULL,
    id_grupo INT NOT NULL,
    fecha_ingreso DATETIME2 NOT NULL
        CONSTRAINT df_membresia_fecha DEFAULT SYSDATETIME(),
    id_membresia INT IDENTITY(1,1) NOT NULL,
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
);

-- 12. PARTICIPACION_EVENTO
CREATE TABLE participacion_evento (
    id_estudiante INT NOT NULL,
    id_evento INT NOT NULL,
    fecha_inscripcion DATETIME2 NOT NULL
        CONSTRAINT df_participacion_fecha DEFAULT SYSDATETIME(),
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
);

-- FIN DEL SCRIPT DDL DE SQL SERVER

