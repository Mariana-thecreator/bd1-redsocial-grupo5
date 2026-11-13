-- ============================================================
-- TAREA 5 - BASES DE DATOS 1 - RED SOCIAL ESTUDIANTIL PASCUALINA
-- BORRADOR INICIAL - INTEGRANTE 1
-- Este archivo contiene propuestas iniciales de consultas y vistas.
-- Los nombres de las tablas y campos corresponden al modelo físico
-- implementado en PostgreSQL.
-- ============================================================

-- ------------------------------------------------------------
-- CONSULTA 1. ¿Qué publicaciones realizaron los estudiantes y
-- cuántos comentarios recibió cada publicación?
-- Tablas: estudiante, publicacion, comentario.
-- Campos utilizados:
--   estudiante.id_estudiante INTEGER
--   estudiante.nombre VARCHAR(100)
--   estudiante.apellido VARCHAR(100)
--   publicacion.id_publicacion INTEGER
--   publicacion.id_estudiante INTEGER
--   publicacion.contenido TEXT
--   comentario.id_comentario INTEGER
--   comentario.id_publicacion INTEGER
-- Alias:
--   nombre_estudiante: nombre y apellido del autor.
--   total_comentarios: cantidad calculada de comentarios.
-- ------------------------------------------------------------

SELECT
    e.nombre || ' ' || e.apellido AS nombre_estudiante,
    p.contenido AS contenido_publicacion,
    COUNT(c.id_comentario) AS total_comentarios
FROM estudiante AS e
INNER JOIN publicacion AS p
    ON e.id_estudiante = p.id_estudiante
LEFT JOIN comentario AS c
    ON p.id_publicacion = c.id_publicacion
GROUP BY
    e.id_estudiante,
    e.nombre,
    e.apellido,
    p.id_publicacion,
    p.contenido
ORDER BY total_comentarios DESC;


-- ------------------------------------------------------------
-- CONSULTA 2. ¿Qué intereses están registrados y cuántos
-- estudiantes tienen asociado cada interés?
-- Tablas: interes, estudiante_interes, estudiante.
-- Campos utilizados:
--   interes.id_interes INTEGER
--   interes.nombre VARCHAR(100)
--   estudiante_interes.id_interes INTEGER
--   estudiante_interes.id_estudiante INTEGER
--   estudiante.id_estudiante INTEGER
-- Alias:
--   nombre_interes: nombre del interés.
--   cantidad_estudiantes: total calculado de estudiantes
--   asociados al interés.
-- ------------------------------------------------------------

SELECT
    i.nombre AS nombre_interes,
    COUNT(ei.id_estudiante) AS cantidad_estudiantes
FROM interes AS i
LEFT JOIN estudiante_interes AS ei
    ON i.id_interes = ei.id_interes
LEFT JOIN estudiante AS e
    ON ei.id_estudiante = e.id_estudiante
GROUP BY i.id_interes, i.nombre
ORDER BY cantidad_estudiantes DESC;


-- ------------------------------------------------------------
-- VISTA 1. Perfiles e intereses de los estudiantes.
-- Objetivo inicial: consultar en una sola estructura el nombre,
-- correo e intereses asociados a cada estudiante.
-- Tablas: estudiante, estudiante_interes, interes.
-- Campos y tipos:
--   estudiante.id_estudiante INTEGER
--   estudiante.nombre VARCHAR(100)
--   estudiante.apellido VARCHAR(100)
--   estudiante.correo VARCHAR(150)
--   interes.nombre VARCHAR(100)
-- Alias:
--   nombre_estudiante: nombre completo.
--   nombre_interes: interés asociado.
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW vw_perfiles_intereses AS
SELECT
    e.id_estudiante,
    e.nombre || ' ' || e.apellido AS nombre_estudiante,
    e.correo,
    i.nombre AS nombre_interes
FROM estudiante AS e
LEFT JOIN estudiante_interes AS ei
    ON e.id_estudiante = ei.id_estudiante
LEFT JOIN interes AS i
    ON ei.id_interes = i.id_interes;

-- Verificación inicial de la vista:
SELECT * FROM vw_perfiles_intereses;
