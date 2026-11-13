-- PARTE 1. CONSULTAS DML

-- ------------------------------------------------------------
-- CONSULTA 1. PUBLICACIONES Y CANTIDAD DE COMENTARIOS
-- Pregunta de negocio:
-- ¿Qué publicaciones han realizado los estudiantes y cuántos
-- comentarios ha recibido cada publicación?
--
-- Tablas utilizadas:
-- estudiante, publicacion y comentario.
-- ------------------------------------------------------------

SELECT
    e.id_estudiante,
    e.nombre || ' ' || e.apellido AS nombre_completo,
    p.id_publicacion,
    p.contenido,
    p.fecha_publicacion,
    COUNT(c.id_comentario) AS total_comentarios
FROM estudiante e
INNER JOIN publicacion p
    ON e.id_estudiante = p.id_estudiante
LEFT JOIN comentario c
    ON p.id_publicacion = c.id_publicacion
GROUP BY
    e.id_estudiante,
    e.nombre,
    e.apellido,
    p.id_publicacion,
    p.contenido,
    p.fecha_publicacion
ORDER BY p.fecha_publicacion DESC;

-- Justificación de alias:
-- nombre_completo identifica al estudiante.
-- total_comentarios representa el conteo de comentarios.
-- LEFT JOIN permite incluir publicaciones sin comentarios.


-- ------------------------------------------------------------
-- CONSULTA 2. INTERESES DE LOS ESTUDIANTES
-- Pregunta de negocio:
-- ¿Cuántos estudiantes están asociados a cada interés?
--
-- Tablas utilizadas:
-- interes y estudiante_interes.
-- ------------------------------------------------------------

SELECT
    i.id_interes,
    i.nombre AS nombre_interes,
    COUNT(ei.id_estudiante) AS cantidad_estudiantes
FROM interes i
LEFT JOIN estudiante_interes ei
    ON i.id_interes = ei.id_interes
GROUP BY
    i.id_interes,
    i.nombre
ORDER BY cantidad_estudiantes DESC;

-- Justificación de alias:
-- nombre_interes facilita identificar el interés.
-- cantidad_estudiantes muestra el número de estudiantes
-- relacionados con cada interés.
-- LEFT JOIN incluye intereses aunque no tengan estudiantes.


-- ------------------------------------------------------------
-- CONSULTA 3. HABILIDADES DE LOS ESTUDIANTES
-- Pregunta de negocio:
-- ¿Qué habilidades tiene cada estudiante y cuál es su nivel?
--
-- Tablas utilizadas:
-- estudiante, estudiante_habilidad y habilidad.
-- ------------------------------------------------------------

SELECT
    e.id_estudiante,
    e.nombre || ' ' || e.apellido AS nombre_completo,
    h.nombre AS nombre_habilidad,
    h.nivel AS nivel_habilidad
FROM estudiante e
INNER JOIN estudiante_habilidad eh
    ON e.id_estudiante = eh.id_estudiante
INNER JOIN habilidad h
    ON eh.id_habilidad = h.id_habilidad
ORDER BY nombre_completo, nombre_habilidad;

-- Justificación de alias:
-- nombre_completo identifica al estudiante.
-- nombre_habilidad muestra la habilidad registrada.
-- nivel_habilidad permite identificar el nivel de dominio.


-- ------------------------------------------------------------
-- CONSULTA 4. GRUPOS Y CANTIDAD DE INTEGRANTES
-- Pregunta de negocio:
-- ¿Cuántos estudiantes pertenecen a cada grupo?
--
-- Tablas utilizadas:
-- grupo y membresia.
-- ------------------------------------------------------------

SELECT
    g.id_grupo,
    g.nombre AS nombre_grupo,
    COUNT(m.id_estudiante) AS cantidad_integrantes
FROM grupo g
LEFT JOIN membresia m
    ON g.id_grupo = m.id_grupo
GROUP BY
    g.id_grupo,
    g.nombre
ORDER BY cantidad_integrantes DESC, nombre_grupo;

-- Justificación de alias:
-- nombre_grupo identifica el grupo.
-- cantidad_integrantes muestra el número de estudiantes.
-- LEFT JOIN permite incluir grupos sin integrantes.


-- ------------------------------------------------------------
-- CONSULTA 5. EVENTOS Y PARTICIPANTES
-- Pregunta de negocio:
-- ¿Cuántos estudiantes participan en cada evento?
--
-- Tablas utilizadas:
-- evento y participacion_evento.
-- ------------------------------------------------------------

SELECT
    ev.id_evento,
    ev.nombre AS nombre_evento,
    ev.fecha,
    ev.hora,
    ev.lugar,
    COUNT(pe.id_estudiante) AS total_participantes
FROM evento ev
LEFT JOIN participacion_evento pe
    ON ev.id_evento = pe.id_evento
GROUP BY
    ev.id_evento,
    ev.nombre,
    ev.fecha,
    ev.hora,
    ev.lugar
ORDER BY ev.fecha, ev.hora;

-- Justificación de alias:
-- nombre_evento identifica el evento.
-- total_participantes muestra la cantidad de estudiantes inscritos.
-- LEFT JOIN permite mostrar eventos sin participantes.


-- PARTE 2. CREACIÓN DE VISTAS


-- ------------------------------------------------------------
-- VISTA 1. PERFILES E INTERESES
-- Objetivo:
-- Consultar los estudiantes y los intereses asociados a ellos.
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW vw_perfiles_intereses AS
SELECT
    e.id_estudiante,
    e.nombre || ' ' || e.apellido AS nombre_completo,
    e.correo,
    i.nombre AS nombre_interes
FROM estudiante e
INNER JOIN estudiante_interes ei
    ON e.id_estudiante = ei.id_estudiante
INNER JOIN interes i
    ON ei.id_interes = i.id_interes;

-- Consultar la primera vista.
SELECT *
FROM vw_perfiles_intereses;


-- ------------------------------------------------------------
-- VISTA 2. ACTIVIDAD DE PUBLICACIONES
-- Objetivo:
-- Consultar las publicaciones, sus autores y la cantidad
-- de comentarios recibidos.
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW vw_actividad_publicaciones AS
SELECT
    p.id_publicacion,
    e.id_estudiante,
    e.nombre || ' ' || e.apellido AS nombre_completo,
    p.contenido,
    p.tipo,
    p.fecha_publicacion,
    COUNT(c.id_comentario) AS total_comentarios
FROM publicacion p
INNER JOIN estudiante e
    ON p.id_estudiante = e.id_estudiante
LEFT JOIN comentario c
    ON p.id_publicacion = c.id_publicacion
GROUP BY
    p.id_publicacion,
    e.id_estudiante,
    e.nombre,
    e.apellido,
    p.contenido,
    p.tipo,
    p.fecha_publicacion;

-- Consultar la segunda vista.
SELECT *
FROM vw_actividad_publicaciones;


-- ------------------------------------------------------------
-- VISTA 3. PARTICIPACIÓN EN EVENTOS
-- Objetivo:
-- Consultar los eventos y los estudiantes inscritos,
-- incluyendo la fecha de inscripción.
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW vw_participacion_eventos AS
SELECT
    ev.id_evento,
    ev.nombre AS nombre_evento,
    ev.fecha,
    ev.hora,
    ev.lugar,
    e.id_estudiante,
    e.nombre || ' ' || e.apellido AS nombre_completo,
    pe.fecha_inscripcion
FROM evento ev
INNER JOIN participacion_evento pe
    ON ev.id_evento = pe.id_evento
INNER JOIN estudiante e
    ON pe.id_estudiante = e.id_estudiante;

-- Consultar la tercera vista.
SELECT *
FROM vw_participacion_eventos;

-- PARTE 3. VERIFICACIÓN DE LAS VISTAS

SELECT
    table_name AS nombre_vista
FROM information_schema.views
WHERE table_schema = 'public'
  AND table_name IN (
      'vw_perfiles_intereses',
      'vw_actividad_publicaciones',
      'vw_participacion_eventos'
  )
ORDER BY table_name;

-- ============================================================
-- FIN DEL SCRIPT TAREA 5
-- ============================================================
