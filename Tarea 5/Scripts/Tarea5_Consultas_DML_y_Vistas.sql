
-- PARTE 1. REGLAS DE NOMENCLATURA DE ALIAS

-- Los alias permiten identificar de forma sencilla las tablas
-- y presentar los resultados con nombres descriptivos.

-- ALIAS DE TABLAS:
-- e  = estudiante
-- p  = publicacion
-- c  = comentario
-- i  = interes
-- ei = estudiante_interes
-- eh = estudiante_habilidad
-- h  = habilidad
-- g  = grupo
-- m  = membresia
-- ev = evento
-- pe = participacion_evento

-- ALIAS DE COLUMNAS:
-- Se utilizan nombres en minúsculas y separados por guion bajo.
--
-- nombre_completo: nombre y apellido del estudiante.
-- nombre_interes: nombre del interés registrado.
-- cantidad_estudiantes: total de estudiantes por interés.
-- nombre_habilidad: habilidad registrada.
-- nivel_habilidad: nivel de dominio de la habilidad.
-- nombre_grupo: nombre del grupo.
-- cantidad_integrantes: total de integrantes por grupo.
-- nombre_evento: nombre del evento.
-- total_participantes: total de estudiantes inscritos.
-- total_comentarios: total de comentarios por publicación.

-- NOMENCLATURA DE VISTAS:
-- Se utiliza el prefijo vw_ para identificar las vistas.
-- Los nombres son descriptivos y están escritos en minúsculas.



-- PARTE 2. CONSULTAS DML


-- ------------------------------------------------------------
-- CONSULTA 1. PUBLICACIONES Y CANTIDAD DE COMENTARIOS
--
-- PREGUNTA DE NEGOCIO:
-- ¿Qué publicaciones han realizado los estudiantes y cuántos
-- comentarios ha recibido cada publicación?
--
-- TABLAS Y CAMPOS UTILIZADOS:
--
-- estudiante:
--   id_estudiante INTEGER
--   nombre        VARCHAR(100)
--   apellido      VARCHAR(100)
--
-- publicacion:
--   id_publicacion    INTEGER
--   id_estudiante     INTEGER
--   contenido         TEXT
--   fecha_publicacion TIMESTAMP WITHOUT TIME ZONE
--
-- comentario:
--   id_comentario INTEGER
--   id_publicacion INTEGER
--
-- ALIAS Y TIPOS DE DATOS CALCULADOS:
-- nombre_completo: TEXT (concatenación de nombre y apellido).
-- total_comentarios: BIGINT (resultado de COUNT).
--
-- JUSTIFICACIÓN:
-- INNER JOIN relaciona las publicaciones con sus autores.
-- LEFT JOIN permite incluir publicaciones sin comentarios.
-- COUNT calcula la cantidad de comentarios recibidos.
-- GROUP BY agrupa los registros por publicación.
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

-- JUSTIFICACIÓN DE ALIAS:
-- nombre_completo identifica al estudiante que realizó
-- la publicación.
-- total_comentarios representa el número de comentarios recibidos.


-- ------------------------------------------------------------
-- CONSULTA 2. INTERESES DE LOS ESTUDIANTES
--
-- PREGUNTA DE NEGOCIO:
-- ¿Cuántos estudiantes están asociados a cada interés?
--
-- TABLAS Y CAMPOS UTILIZADOS:
--
-- interes:
--   id_interes INTEGER
--   nombre     VARCHAR(100)
--
-- estudiante_interes:
--   id_estudiante INTEGER
--   id_interes    INTEGER
--
-- ALIAS Y TIPOS DE DATOS CALCULADOS:
-- nombre_interes: VARCHAR(100).
-- cantidad_estudiantes: BIGINT (resultado de COUNT).
--
-- JUSTIFICACIÓN:
-- LEFT JOIN permite mostrar intereses que todavía no tienen
-- estudiantes asociados.
-- COUNT calcula el número de estudiantes relacionados.
-- GROUP BY agrupa los registros por interés.
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

-- JUSTIFICACIÓN DE ALIAS:
-- nombre_interes facilita identificar el interés consultado.
-- cantidad_estudiantes muestra cuántos estudiantes se relacionan
-- con cada interés.


-- ------------------------------------------------------------
-- CONSULTA 3. HABILIDADES DE LOS ESTUDIANTES
--
-- PREGUNTA DE NEGOCIO:
-- ¿Qué habilidades tiene cada estudiante y cuál es su nivel?
--
-- TABLAS Y CAMPOS UTILIZADOS:
--
-- estudiante:
--   id_estudiante INTEGER
--   nombre        VARCHAR(100)
--   apellido      VARCHAR(100)
--
-- estudiante_habilidad:
--   id_estudiante INTEGER
--   id_habilidad  INTEGER
--
-- habilidad:
--   id_habilidad INTEGER
--   nombre       VARCHAR(100)
--   nivel        VARCHAR(50)
--
-- ALIAS Y TIPOS DE DATOS CALCULADOS:
-- nombre_completo: TEXT (concatenación de nombre y apellido).
-- nombre_habilidad: VARCHAR(100).
-- nivel_habilidad: VARCHAR(50).
--
-- JUSTIFICACIÓN:
-- Los INNER JOIN relacionan los estudiantes con sus habilidades
-- mediante la tabla intermedia estudiante_habilidad.
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

-- JUSTIFICACIÓN DE ALIAS:
-- nombre_completo identifica al estudiante.
-- nombre_habilidad muestra la habilidad registrada.
-- nivel_habilidad permite identificar el nivel de dominio.


-- ------------------------------------------------------------
-- CONSULTA 4. GRUPOS Y CANTIDAD DE INTEGRANTES
--
-- PREGUNTA DE NEGOCIO:
-- ¿Cuántos estudiantes pertenecen a cada grupo?
--
-- TABLAS Y CAMPOS UTILIZADOS:
--
-- grupo:
--   id_grupo INTEGER
--   nombre   VARCHAR(100)
--
-- membresia:
--   id_estudiante INTEGER
--   id_grupo      INTEGER
--
-- ALIAS Y TIPOS DE DATOS CALCULADOS:
-- nombre_grupo: VARCHAR(100).
-- cantidad_integrantes: BIGINT (resultado de COUNT).
--
-- JUSTIFICACIÓN:
-- LEFT JOIN permite incluir grupos sin integrantes.
-- COUNT calcula el número de estudiantes asociados a cada grupo.
-- GROUP BY agrupa los resultados por grupo.
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

-- JUSTIFICACIÓN DE ALIAS:
-- nombre_grupo identifica el grupo consultado.
-- cantidad_integrantes muestra el número de estudiantes asociados.


-- ------------------------------------------------------------
-- CONSULTA 5. EVENTOS Y PARTICIPANTES
--
-- PREGUNTA DE NEGOCIO:
-- ¿Cuántos estudiantes participan en cada evento?
--
-- TABLAS Y CAMPOS UTILIZADOS:
--
-- evento:
--   id_evento INTEGER
--   nombre    VARCHAR(150)
--   fecha     DATE
--   hora      TIME WITHOUT TIME ZONE
--   lugar     VARCHAR(200)
--
-- participacion_evento:
--   id_estudiante INTEGER
--   id_evento     INTEGER
--
-- ALIAS Y TIPOS DE DATOS CALCULADOS:
-- nombre_evento: VARCHAR(150).
-- total_participantes: BIGINT (resultado de COUNT).
--
-- JUSTIFICACIÓN:
-- LEFT JOIN permite mostrar eventos aunque no tengan participantes.
-- COUNT calcula el total de estudiantes inscritos.
-- GROUP BY agrupa los registros por evento.
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

-- JUSTIFICACIÓN DE ALIAS:
-- nombre_evento identifica el evento.
-- total_participantes muestra la cantidad de estudiantes inscritos.


-- PARTE 3. CREACIÓN DE VISTAS

-- ------------------------------------------------------------
-- VISTA 1. PERFILES E INTERESES
--
-- NOMBRE: vw_perfiles_intereses
--
-- OBJETIVO:
-- Consultar los estudiantes y los intereses asociados a ellos.
--
-- TABLAS Y CAMPOS UTILIZADOS:
--
-- estudiante:
--   id_estudiante INTEGER
--   nombre        VARCHAR(100)
--   apellido      VARCHAR(100)
--   correo        VARCHAR(150)
--
-- estudiante_interes:
--   id_estudiante INTEGER
--   id_interes    INTEGER
--
-- interes:
--   id_interes INTEGER
--   nombre     VARCHAR(100)
--
-- COLUMNAS RESULTANTES:
-- id_estudiante: INTEGER.
-- nombre_completo: TEXT (dato calculado).
-- correo: VARCHAR(150).
-- nombre_interes: VARCHAR(100).
--
-- JUSTIFICACIÓN:
-- La vista facilita consultar los perfiles y sus intereses
-- sin escribir nuevamente las relaciones entre las tres tablas.
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

-- CONSULTA DE LA VISTA 1:
SELECT *
FROM vw_perfiles_intereses;

-- JUSTIFICACIÓN DE ALIAS:
-- nombre_completo facilita identificar al estudiante.
-- nombre_interes muestra el interés relacionado con el perfil.


-- ------------------------------------------------------------
-- VISTA 2. ACTIVIDAD DE PUBLICACIONES
--
-- NOMBRE: vw_actividad_publicaciones
--
-- OBJETIVO:
-- Consultar las publicaciones, sus autores y la cantidad
-- de comentarios recibidos.
--
-- TABLAS Y CAMPOS UTILIZADOS:
--
-- publicacion:
--   id_publicacion    INTEGER
--   id_estudiante     INTEGER
--   contenido         TEXT
--   tipo              VARCHAR(50)
--   fecha_publicacion TIMESTAMP WITHOUT TIME ZONE
--
-- estudiante:
--   id_estudiante INTEGER
--   nombre        VARCHAR(100)
--   apellido      VARCHAR(100)
--
-- comentario:
--   id_comentario  INTEGER
--   id_publicacion INTEGER
--
-- COLUMNAS RESULTANTES:
-- id_publicacion: INTEGER.
-- id_estudiante: INTEGER.
-- nombre_completo: TEXT (dato calculado).
-- contenido: TEXT.
-- tipo: VARCHAR(50).
-- fecha_publicacion: TIMESTAMP WITHOUT TIME ZONE.
-- total_comentarios: BIGINT (resultado de COUNT).
--
-- JUSTIFICACIÓN:
-- La vista reúne la información de las publicaciones, sus autores
-- y la cantidad de comentarios, facilitando el análisis de actividad.
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

-- CONSULTA DE LA VISTA 2:
SELECT *
FROM vw_actividad_publicaciones;

-- JUSTIFICACIÓN DE ALIAS:
-- nombre_completo identifica al autor de la publicación.
-- total_comentarios muestra cuántos comentarios ha recibido.


-- ------------------------------------------------------------
-- VISTA 3. PARTICIPACIÓN EN EVENTOS
--
-- NOMBRE: vw_participacion_eventos
--
-- OBJETIVO:
-- Consultar los eventos y los estudiantes inscritos,
-- incluyendo la fecha de inscripción.
--
-- TABLAS Y CAMPOS UTILIZADOS:
--
-- evento:
--   id_evento INTEGER
--   nombre    VARCHAR(150)
--   fecha     DATE
--   hora      TIME WITHOUT TIME ZONE
--   lugar     VARCHAR(200)
--
-- participacion_evento:
--   id_estudiante     INTEGER
--   id_evento         INTEGER
--   fecha_inscripcion TIMESTAMP WITHOUT TIME ZONE
--
-- estudiante:
--   id_estudiante INTEGER
--   nombre        VARCHAR(100)
--   apellido      VARCHAR(100)
--
-- COLUMNAS RESULTANTES:
-- id_evento: INTEGER.
-- nombre_evento: VARCHAR(150).
-- fecha: DATE.
-- hora: TIME WITHOUT TIME ZONE.
-- lugar: VARCHAR(200).
-- id_estudiante: INTEGER.
-- nombre_completo: TEXT (dato calculado).
-- fecha_inscripcion: TIMESTAMP WITHOUT TIME ZONE.
--
-- JUSTIFICACIÓN:
-- La vista facilita consultar los eventos y sus participantes,
-- incluyendo la fecha en que cada estudiante se inscribió.
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

-- CONSULTA DE LA VISTA 3:
SELECT *
FROM vw_participacion_eventos;

-- JUSTIFICACIÓN DE ALIAS:
-- nombre_evento identifica el evento.
-- nombre_completo identifica al estudiante inscrito.


-- PARTE 4. VERIFICACIÓN DE LAS VISTAS


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

