-- CONSULTA 1: Consultar los archivos multimedia academicos.
SELECT
    id_multimedia,
    metadatos ->> 'nombre' AS nombre_archivo,
    metadatos ->> 'categoria' AS categoria,
    metadatos ->> 'formato' AS formato
FROM publicacion_multimedia
WHERE metadatos ->> 'categoria' = 'Academica';


-- CONSULTA 2: Consultar las actividades realizadas por los estudiantes.
SELECT
    id_actividad,
    tipo_actividad,
    datos_adicionales ->> 'accion' AS accion,
    datos_adicionales ->> 'seccion' AS seccion,
    datos_adicionales ->> 'dispositivo' AS dispositivo,
    (datos_adicionales ->> 'duracion_segundos')::INTEGER
        AS duracion_segundos
FROM actividad_usuario;


-- CONSULTA 3: Consultar las lecturas de los sensores de ocupacion.
SELECT
    datos_sensor ->> 'personas' AS personas,
    datos_sensor ->> 'capacidad' AS capacidad,
    datos_sensor ->> 'ocupacion_porcentaje'
        AS ocupacion_porcentaje
FROM lectura_iot
WHERE datos_sensor ? 'ocupacion_porcentaje';


-- CONSULTA 4: Consultar las condiciones ambientales registradas.
SELECT
    datos_sensor ->> 'temperatura' AS temperatura,
    datos_sensor ->> 'unidad' AS unidad,
    datos_sensor ->> 'humedad' AS humedad
FROM lectura_iot
WHERE datos_sensor ? 'temperatura';


-- CONSULTA 5: Consultar la asistencia registrada mediante IoT.
SELECT
    datos_sensor ->> 'evento' AS evento,
    datos_sensor ->> 'metodo' AS metodo,
    (datos_sensor ->> 'asistencia_registrada')::BOOLEAN
        AS asistencia_registrada
FROM lectura_iot
WHERE datos_sensor ? 'asistencia_registrada';


-- CONSULTA 6: Consultar las lecturas por dispositivo IoT.
SELECT
    id_dispositivo,
    COUNT(*) AS total_lecturas,
    MIN(fecha_lectura) AS primera_lectura,
    MAX(fecha_lectura) AS ultima_lectura
FROM lectura_iot
GROUP BY id_dispositivo
ORDER BY id_dispositivo;


-- CONSULTA 7: Identificar las lecturas que contienen temperatura.
SELECT
    id_lectura,
    id_dispositivo,
    datos_sensor
FROM lectura_iot
WHERE datos_sensor ? 'temperatura';


-- CONSULTA 8: Simular un volumen de 30000 lecturas IoT.
-- Se generan 10000 fechas simuladas por cada dispositivo.
-- Esta consulta NO inserta registros en la base de datos.
SELECT
    COUNT(*) AS lecturas_simuladas,
    COUNT(DISTINCT id_dispositivo) AS dispositivos,
    MIN(fecha_simulada) AS primera_fecha,
    MAX(fecha_simulada) AS ultima_fecha
FROM (
    SELECT
        d.id_dispositivo,
        NOW() - (n * INTERVAL '1 minute') AS fecha_simulada
    FROM dispositivo_iot d
    CROSS JOIN generate_series(1, 10000) AS n
) AS simulacion;

-- FIN DEL SCRIPT DML
