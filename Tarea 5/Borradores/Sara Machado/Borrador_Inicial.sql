-- ============================================================
-- TAREA 5 - BASES DE DATOS 1 - RED SOCIAL ESTUDIANTIL PASCUALINA
-- BORRADOR INICIAL - INTEGRANTE 2
-- Este archivo contiene propuestas iniciales de consultas y vistas.
-- Los nombres de las tablas y campos corresponden al modelo físico
-- implementado en PostgreSQL.
-- ============================================================

-- ------------------------------------------------------------
-- CONSULTA 3. ¿Qué habilidades y niveles de dominio tienen
-- registradas los estudiantes?
-- Tablas: estudiante, estudiante_habilidad, habilidad.
-- Campos utilizados:
--   estudiante.id_estudiante INTEGER
--   estudiante.nombre VARCHAR(100)
--   estudiante.apellido VARCHAR(100)
--   estudiante_habilidad.id_estudiante INTEGER
--   estudiante_habilidad.id_habilidad INTEGER
--   habilidad.id_habilidad INTEGER
--   habilidad.nombre VARCHAR(100)
--   habilidad.nivel VARCHAR(50)
-- Alias:
--   nombre_estudiante: nombre completo del estudiante.
--   nombre_habilidad: habilidad asociada.
--   nivel_habilidad: nivel registrado.
-- ------------------------------------------------------------

SELECT
    e.nombre || ' ' || e.apellido AS nombre_estudiante,
    h.nombre AS nombre_habilidad,
    h.nivel AS nivel_habilidad
FROM estudiante AS e
INNER JOIN estudiante_habilidad AS eh
    ON e.id_estudiante = eh.id_estudiante
INNER JOIN habilidad AS h
    ON eh.id_habilidad = h.id_habilidad
ORDER BY nombre_estudiante, nombre_habilidad;


-- ------------------------------------------------------------
-- CONSULTA 4. ¿Cuántos estudiantes pertenecen a cada grupo?
-- Tablas: grupo, membresia, estudiante.
-- Campos utilizados:
--   grupo.id_grupo INTEGER
--   grupo.nombre VARCHAR(100)
--   membresia.id_grupo INTEGER
--   membresia.id_estudiante INTEGER
--   estudiante.id_estudiante INTEGER
-- Alias:
--   nombre_grupo: nombre del grupo.
--   total_integrantes: cantidad calculada de integrantes.
-- ------------------------------------------------------------

SELECT
    g.nombre AS nombre_grupo,
    COUNT(m.id_estudiante) AS total_integrantes
FROM grupo AS g
LEFT JOIN membresia AS m
    ON g.id_grupo = m.id_grupo
LEFT JOIN estudiante AS e
    ON m.id_estudiante = e.id_estudiante
GROUP BY g.id_grupo, g.nombre
ORDER BY total_integrantes DESC;


-- ------------------------------------------------------------
-- CONSULTA 5. ¿Qué estudiantes están inscritos en cada evento?
-- Tablas: evento, participacion_evento, estudiante.
-- Campos utilizados:
--   evento.id_evento INTEGER
--   evento.nombre VARCHAR(150)
--   evento.fecha DATE
--   evento.hora TIME WITHOUT TIME ZONE
--   evento.lugar VARCHAR(200)
--   participacion_evento.id_evento INTEGER
--   participacion_evento.id_estudiante INTEGER
--   participacion_evento.fecha_inscripcion TIMESTAMP WITHOUT TIME ZONE
--   estudiante.id_estudiante INTEGER
--   estudiante.nombre VARCHAR(100)
--   estudiante.apellido VARCHAR(100)
-- Alias:
--   nombre_evento: nombre del evento.
--   nombre_estudiante: nombre completo del participante.
--   fecha_registro: fecha y hora de inscripción.
-- ------------------------------------------------------------

SELECT
    ev.nombre AS nombre_evento,
    ev.fecha,
    ev.hora,
    ev.lugar,
    e.nombre || ' ' || e.apellido AS nombre_estudiante,
    pe.fecha_inscripcion AS fecha_registro
FROM evento AS ev
INNER JOIN participacion_evento AS pe
    ON ev.id_evento = pe.id_evento
INNER JOIN estudiante AS e
    ON pe.id_estudiante = e.id_estudiante
ORDER BY ev.fecha, ev.hora, nombre_estudiante;


-- ------------------------------------------------------------
-- VISTA 2. Actividad de publicaciones y comentarios.
-- Objetivo inicial: mostrar las publicaciones, sus autores y
-- la cantidad de comentarios recibidos.
-- Tablas: estudiante, publicacion, comentario.
-- Campos y tipos:
--   estudiante.id_estudiante INTEGER
--   estudiante.nombre VARCHAR(100)
--   estudiante.apellido VARCHAR(100)
--   publicacion.id_publicacion INTEGER
--   publicacion.contenido TEXT
--   publicacion.tipo VARCHAR(50)
--   publicacion.fecha_publicacion TIMESTAMP WITHOUT TIME ZONE
--   comentario.id_comentario INTEGER
--   comentario.id_publicacion INTEGER
-- Alias:
--   autor_publicacion: nombre completo del autor.
--   total_comentarios: cantidad calculada de comentarios.
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW vw_actividad_publicaciones AS
SELECT
    p.id_publicacion,
    e.nombre || ' ' || e.apellido AS autor_publicacion,
    p.contenido,
    p.tipo,
    p.fecha_publicacion,
    COUNT(c.id_comentario) AS total_comentarios
FROM publicacion AS p
INNER JOIN estudiante AS e
    ON p.id_estudiante = e.id_estudiante
LEFT JOIN comentario AS c
    ON p.id_publicacion = c.id_publicacion
GROUP BY
    p.id_publicacion,
    e.nombre,
    e.apellido,
    p.contenido,
    p.tipo,
    p.fecha_publicacion;

-- Verificación inicial de la vista:
SELECT * FROM vw_actividad_publicaciones;


-- ------------------------------------------------------------
-- VISTA 3. Participación de estudiantes en eventos.
-- Objetivo inicial: consultar los eventos y los estudiantes
-- inscritos, junto con la fecha de inscripción.
-- Tablas: evento, participacion_evento, estudiante.
-- Campos y tipos:
--   evento.id_evento INTEGER
--   evento.nombre VARCHAR(150)
--   evento.fecha DATE
--   participacion_evento.id_estudiante INTEGER
--   participacion_evento.id_evento INTEGER
--   participacion_evento.fecha_inscripcion TIMESTAMP WITHOUT TIME ZONE
--   estudiante.id_estudiante INTEGER
--   estudiante.nombre VARCHAR(100)
--   estudiante.apellido VARCHAR(100)
-- Alias:
--   nombre_estudiante: nombre completo del participante.
--   fecha_registro: fecha y hora de inscripción.
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW vw_participacion_eventos AS
SELECT
    ev.id_evento,
    ev.nombre AS nombre_evento,
    ev.fecha,
    ev.hora,
    ev.lugar,
    e.id_estudiante,
    e.nombre || ' ' || e.apellido AS nombre_estudiante,
    pe.fecha_inscripcion AS fecha_registro
FROM evento AS ev
INNER JOIN participacion_evento AS pe
    ON ev.id_evento = pe.id_evento
INNER JOIN estudiante AS e
    ON pe.id_estudiante = e.id_estudiante;

-- Verificación inicial de la vista:
SELECT * FROM vw_participacion_eventos;
