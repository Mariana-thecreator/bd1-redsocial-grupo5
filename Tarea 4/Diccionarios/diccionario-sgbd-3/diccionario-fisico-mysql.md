# Diccionario de Datos Físico — MySQL

## 1. Descripción

Este documento describe la adaptación física de la base de datos Pascualina a MySQL. Se mantienen las doce tablas del modelo y se documentan sus atributos, tipos de datos, claves y restricciones.

El campo `metadatos` de la tabla `evento` se incorpora como propuesta para la Tarea 4. No forma parte de la base de datos PostgreSQL original.

## 2. Diccionario por tabla

### 2.1. Tabla `estudiante`

Almacena los datos básicos de los estudiantes.

| Campo | Tipo de dato MySQL | Nulo | Clave o restricción |
|---|---|---|---|
| id_estudiante | INT AUTO_INCREMENT | No | PK |
| nombre | VARCHAR(100) | No | — |
| apellido | VARCHAR(100) | No | — |
| correo | VARCHAR(150) | No | UNIQUE |
| fecha_nacimiento | DATE | Sí | — |

**Justificación:** `INT` identifica cada estudiante, `AUTO_INCREMENT` genera identificadores automáticamente, `VARCHAR` almacena texto de longitud variable y `DATE` representa fechas.

### 2.2. Tabla `publicacion`

Registra las publicaciones creadas por los estudiantes.

| Campo | Tipo de dato MySQL | Nulo | Clave o restricción |
|---|---|---|---|
| id_publicacion | INT AUTO_INCREMENT | No | PK |
| id_estudiante | INT | No | FK → estudiante |
| contenido | TEXT | No | — |
| fecha_publicacion | DATETIME | No | DEFAULT CURRENT_TIMESTAMP |
| tipo | VARCHAR(50) | Sí | — |

**Justificación:** `TEXT` permite almacenar contenido extenso y `DATETIME` registra la fecha y hora de publicación.

### 2.3. Tabla `comentario`

Almacena los comentarios realizados en las publicaciones.

| Campo | Tipo de dato MySQL | Nulo | Clave o restricción |
|---|---|---|---|
| id_comentario | INT AUTO_INCREMENT | No | PK |
| id_publicacion | INT | No | FK → publicacion |
| id_estudiante | INT | No | FK → estudiante |
| contenido | TEXT | No | — |
| fecha_comentario | DATETIME | No | DEFAULT CURRENT_TIMESTAMP |

**Justificación:** permite guardar comentarios extensos, identificar a su autor y registrar cuándo se crearon.

### 2.4. Tabla `interes`

Contiene el catálogo de intereses.

| Campo | Tipo de dato MySQL | Nulo | Clave o restricción |
|---|---|---|---|
| id_interes | INT AUTO_INCREMENT | No | PK |
| nombre | VARCHAR(100) | No | — |
| descripcion | TEXT | Sí | — |

**Justificación:** centraliza los intereses para evitar repetir sus descripciones en cada perfil.

### 2.5. Tabla `estudiante_interes`

Relaciona estudiantes con sus intereses.

| Campo | Tipo de dato MySQL | Nulo | Clave o restricción |
|---|---|---|---|
| id_estudiante | INT | No | PK compuesta y FK → estudiante |
| id_interes | INT | No | PK compuesta y FK → interes |

**Justificación:** la clave primaria compuesta evita repetir una misma combinación de estudiante e interés.

### 2.6. Tabla `habilidad`

Contiene el catálogo de habilidades.

| Campo | Tipo de dato MySQL | Nulo | Clave o restricción |
|---|---|---|---|
| id_habilidad | INT AUTO_INCREMENT | No | PK |
| nombre | VARCHAR(100) | No | — |
| descripcion | TEXT | Sí | — |
| nivel | VARCHAR(50) | Sí | — |

**Justificación:** permite registrar las habilidades disponibles, su descripción y el nivel correspondiente.

### 2.7. Tabla `estudiante_habilidad`

Relaciona estudiantes con sus habilidades.

| Campo | Tipo de dato MySQL | Nulo | Clave o restricción |
|---|---|---|---|
| id_estudiante | INT | No | PK compuesta y FK → estudiante |
| id_habilidad | INT | No | PK compuesta y FK → habilidad |

**Justificación:** la clave primaria compuesta impide duplicar una misma habilidad para un estudiante.

### 2.8. Tabla `seguimiento`

Registra las relaciones de seguimiento entre estudiantes.

| Campo | Tipo de dato MySQL | Nulo | Clave o restricción |
|---|---|---|---|
| id_seguidor | INT | No | FK → estudiante |
| id_seguido | INT | No | FK → estudiante |
| id_seguimiento | INT AUTO_INCREMENT | No | PK |
| fecha_seguimiento | DATETIME | Sí | — |

**Restricciones adicionales:** `UNIQUE(id_seguidor, id_seguido)` y `CHECK (id_seguidor <> id_seguido)` en versiones compatibles con la aplicación efectiva de restricciones `CHECK`.

**Justificación:** el identificador generado distingue cada registro, la restricción única evita duplicar una pareja de seguimiento y la condición `CHECK` impide que un estudiante se siga a sí mismo.

### 2.9. Tabla `grupo`

Almacena grupos académicos y sociales.

| Campo | Tipo de dato MySQL | Nulo | Clave o restricción |
|---|---|---|---|
| id_grupo | INT AUTO_INCREMENT | No | PK |
| nombre | VARCHAR(100) | No | — |
| descripcion | TEXT | Sí | — |
| tipo | VARCHAR(50) | Sí | — |
| fecha_creacion | DATETIME | No | DEFAULT CURRENT_TIMESTAMP |

**Justificación:** permite almacenar el nombre, la descripción, el tipo y la fecha de creación de cada grupo.

### 2.10. Tabla `membresia`

Registra la pertenencia de los estudiantes a los grupos.

| Campo | Tipo de dato MySQL | Nulo | Clave o restricción |
|---|---|---|---|
| id_estudiante | INT | No | FK → estudiante |
| id_grupo | INT | No | FK → grupo |
| fecha_ingreso | DATETIME | No | DEFAULT CURRENT_TIMESTAMP |
| id_membresia | INT AUTO_INCREMENT | No | PK |
| rol | VARCHAR(50) | Sí | — |

**Restricción adicional:** `UNIQUE(id_estudiante, id_grupo)`.

**Justificación:** `id_membresia` identifica cada registro y la restricción única impide registrar más de una membresía del mismo estudiante en el mismo grupo.

### 2.11. Tabla `evento`

Almacena información de eventos académicos y sociales.

| Campo | Tipo de dato MySQL | Nulo | Clave o restricción |
|---|---|---|---|
| id_evento | INT AUTO_INCREMENT | No | PK |
| nombre | VARCHAR(150) | No | — |
| descripcion | TEXT | Sí | — |
| fecha | DATE | No | — |
| hora | TIME | No | — |
| lugar | VARCHAR(200) | Sí | — |
| metadatos | JSON | Sí | Atributo propuesto para la Tarea 4 |

**Justificación:** `DATE` almacena la fecha, `TIME` la hora y `JSON` permite guardar información adicional flexible en formato JSON. Los metadatos podrían incluir modalidad del evento, recursos digitales o información asociada a dispositivos conectados.

### 2.12. Tabla `participacion_evento`

Registra la inscripción de estudiantes en eventos.

| Campo | Tipo de dato MySQL | Nulo | Clave o restricción |
|---|---|---|---|
| id_estudiante | INT | No | PK compuesta y FK → estudiante |
| id_evento | INT | No | PK compuesta y FK → evento |
| fecha_inscripcion | DATETIME | No | DEFAULT CURRENT_TIMESTAMP |

**Justificación:** la clave primaria compuesta evita registrar más de una inscripción del mismo estudiante al mismo evento.

## 3. Claves y restricciones

- **PK:** identifican de forma única cada registro.
- **FK:** mantienen la integridad referencial entre las tablas relacionadas.
- **UNIQUE:** evita duplicados en el correo de los estudiantes y en las combinaciones de membresía y seguimiento indicadas.
- **CHECK:** permite validar condiciones como impedir que un estudiante se siga a sí mismo, cuando la versión de MySQL aplica esta restricción.
- **AUTO_INCREMENT:** genera identificadores enteros automáticamente.
- **DEFAULT CURRENT_TIMESTAMP:** asigna la fecha y hora actuales en los campos correspondientes.

Las claves foráneas deben conservar las reglas de eliminación definidas en el modelo de referencia, incluidas las relaciones que usan `ON DELETE CASCADE`.

## 4. Diferencias respecto a PostgreSQL y SQL Server

1. MySQL utiliza `AUTO_INCREMENT` para generar identificadores, mientras que PostgreSQL y SQL Server utilizan mecanismos de identidad con sintaxis propia.
2. MySQL utiliza `DATETIME` como alternativa para guardar fechas y horas; PostgreSQL utiliza `TIMESTAMP WITHOUT TIME ZONE` y SQL Server puede utilizar `DATETIME2`.
3. MySQL dispone de `TEXT` para contenido extenso y de `VARCHAR(n)` para texto con longitud limitada.
4. MySQL dispone de un tipo nativo `JSON`, que valida los documentos JSON almacenados. PostgreSQL ofrece `JSONB` y SQL Server puede guardar JSON en texto y validarlo con `ISJSON` en versiones compatibles.
5. La sintaxis de las restricciones, los valores predeterminados y las reglas de integridad referencial debe adaptarse al motor y a su versión.

## 5. Datos semiestructurados y Big Data

El atributo propuesto `evento.metadatos` permite almacenar información complementaria cuyo contenido puede variar entre eventos. Por ejemplo, un evento virtual podría incluir una plataforma de conexión, mientras que otro podría contener datos sobre recursos o dispositivos utilizados.

Esta flexibilidad puede ser útil en aplicaciones que integran información de distintas fuentes y dispositivos conectados, escenarios relacionados con Big Data e IoT. Los datos almacenados deben validarse y documentarse para mantener su calidad.

## 6. Consideraciones de implementación

1. El diccionario conserva las doce tablas del modelo de Pascualina.
2. `metadatos` es un atributo nuevo propuesto para la comparación; deberá incluirse en el nuevo script DDL.
3. Antes de ejecutar el script se deben verificar la versión de MySQL, las restricciones admitidas y las reglas de eliminación.
4. La base de datos original de PostgreSQL no debe modificarse durante esta actividad.
