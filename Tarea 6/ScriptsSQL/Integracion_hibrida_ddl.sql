-- 1. Tabla para almacenar publicaciones multimedia.
CREATE TABLE publicacion_multimedia (
    id_multimedia SERIAL PRIMARY KEY,
    id_publicacion INTEGER NOT NULL,
    tipo_archivo VARCHAR(30) NOT NULL,
    url_archivo TEXT NOT NULL,
    metadatos JSONB NOT NULL,
    fecha_subida TIMESTAMP WITH TIME ZONE,

    CONSTRAINT fk_multimedia_publicacion
        FOREIGN KEY (id_publicacion)
        REFERENCES publicacion(id_publicacion)
        ON DELETE CASCADE
);

-- 2. Tabla para registrar la actividad de los estudiantes.
CREATE TABLE actividad_usuario (
    id_actividad BIGSERIAL PRIMARY KEY,
    id_estudiante INTEGER NOT NULL,
    tipo_actividad VARCHAR(50) NOT NULL,
    datos_adicionales JSONB NOT NULL,
    fecha_actividad TIMESTAMP WITH TIME ZONE NOT NULL,

    CONSTRAINT fk_actividad_estudiante
        FOREIGN KEY (id_estudiante)
        REFERENCES estudiante(id_estudiante)
        ON DELETE CASCADE
);

-- 3. Tabla para registrar los dispositivos IoT del campus.
CREATE TABLE dispositivo_iot (
    id_dispositivo SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo_dispositivo VARCHAR(50) NOT NULL,
    ubicacion VARCHAR(150) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    configuracion JSONB NOT NULL
);

-- 4. Tabla para almacenar las lecturas de los sensores IoT.
CREATE TABLE lectura_iot (
    id_lectura BIGSERIAL PRIMARY KEY,
    id_dispositivo INTEGER NOT NULL,
    datos_sensor JSONB NOT NULL,
    fecha_lectura TIMESTAMP WITH TIME ZONE NOT NULL,

    CONSTRAINT fk_lectura_dispositivo
        FOREIGN KEY (id_dispositivo)
        REFERENCES dispositivo_iot(id_dispositivo)
        ON DELETE CASCADE
);

-- 5. Indices GIN para optimizar las busquedas en campos JSONB.
CREATE INDEX idx_multimedia_metadatos
ON publicacion_multimedia USING GIN (metadatos);

CREATE INDEX idx_actividad_jsonb
ON actividad_usuario USING GIN (datos_adicionales);

CREATE INDEX idx_dispositivo_configuracion
ON dispositivo_iot USING GIN (configuracion);

CREATE INDEX idx_lectura_datos_sensor
ON lectura_iot USING GIN (datos_sensor);

-- FIN DEL SCRIPT DDL
