# Diccionario de Datos Físico — PostgreSQL

## 1. Descripción

Este documento describe la estructura física de la base de datos Pascualina implementada en PostgreSQL. Presenta las doce tablas, sus atributos, tipos de datos, tamaños, nulabilidad, claves y restricciones.

El diccionario se basa en el script SQL de la implementación existente. El atributo `metadatos` se incluye como una propuesta para la comparación de la Tarea 4; deberá incorporarse al nuevo script DDL y no a la base de datos original.

## 2. Diccionario por tabla

### 2.1. Tabla `estudiante`

Almacena los datos básicos de los estudiantes.

| Campo | Tipo de dato | Nulo | Clave o restricción |
|---|---|---|---|
| id_estudiante | INTEGER | No | PK, identidad |
| nombre | VARCHAR(100) | No | — |
| apellido | VARCHAR(100) | No | — |
| correo | VARCHAR(150) | No | UNIQUE |
| fecha_nacimiento | DATE | Sí | — |

**Justificación:** `INTEGER` permite identificar cada estudiante; los campos `VARCHAR` limitan la longitud de los textos y `DATE` almacena fechas sin hora.

### 2.2. Tabla `publicacion`

Almacena las publicaciones creadas por los estudiantes.

| Campo | Tipo de dato | Nulo | Clave o restricción |
|---|---|---|---|
| id_publicacion | INTEGER | No | PK, identidad |
| id_estudiante | INTEGER | No | FK → estudiante |
| contenido | TEXT | No | — |
| fecha_publicacion | TIMESTAMP WITHOUT TIME ZONE | No | DEFAULT CURRENT_TIMESTAMP |
| tipo | VARCHAR(50) | Sí | — |

**Justificación:** `TEXT` admite contenido de longitud variable; `TIMESTAMP` registra fecha y hora, y `tipo` permite clasificar las publicaciones.

### 2.3. Tabla `comentario`

Registra los comentarios realizados por estudiantes en publicaciones.

| Campo | Tipo de dato | Nulo | Clave o restricción |
|---|---|---|---|
| id_comentario | INTEGER | No | PK, identidad |
| id_publicacion | INTEGER | No | FK → publicacion |
| id_estudiante | INTEGER | No | FK → estudiante |
| contenido | TEXT | No | — |
| fecha_comentario | TIMESTAMP WITHOUT TIME ZONE | No | DEFAULT CURRENT_TIMESTAMP |

**Justificación:** permite almacenar comentarios extensos, identificar a su autor y registrar el momento en que fueron creados.

### 2.4. Tabla `interes`

Contiene el catálogo de intereses disponibles.

| Campo | Tipo de dato | Nulo | Clave o restricción |
|---|---|---|---|
| id_interes | INTEGER | No | PK, identidad |
| nombre | VARCHAR(100) | No | — |
| descripcion | TEXT | Sí | — |

**Justificación:** separa los intereses de los perfiles para evitar repetir su descripción en cada estudiante.

### 2.5. Tabla `estudiante_interes`

Relaciona estudiantes con sus intereses.

| Campo | Tipo de dato | Nulo | Clave o restricción |
|---|---|---|---|
| id_estudiante | INTEGER | No | PK compuesta y FK → estudiante |
| id_interes | INTEGER | No | PK compuesta y FK → interes |

**Justificación:** la clave primaria compuesta impide registrar dos veces la misma combinación de estudiante e interés.

### 2.6. Tabla `habilidad`

Contiene el catálogo de habilidades.

| Campo | Tipo de dato | Nulo | Clave o restricción |
|---|---|---|---|
| id_habilidad | INTEGER | No | PK, identidad |
| nombre | VARCHAR(100) | No | — |
| descripcion | TEXT | Sí | — |
| nivel | VARCHAR(50) | Sí | — |

**Justificación:** permite registrar habilidades y describir el nivel correspondiente.

### 2.7. Tabla `estudiante_habilidad`

Relaciona estudiantes con sus habilidades.

| Campo | Tipo de dato | Nulo | Clave o restricción |
|---|---|---|---|
| id_estudiante | INTEGER | No | PK compuesta y FK → estudiante |
| id_habilidad | INTEGER | No | PK compuesta y FK → habilidad |

**Justificación:** la clave primaria compuesta evita duplicar la misma habilidad para un estudiante.

### 2.8. Tabla `seguimiento`

Registra qué estudiantes siguen a otros estudiantes.

| Campo | Tipo de dato | Nulo | Clave o restricción |
|---|---|---|---|
| id_seguidor | INTEGER | No | FK → estudiante |
| id_seguido | INTEGER | No | FK → estudiante |
| id_seguimiento | INTEGER | No | PK, identidad |
| fecha_seguimiento | TIMESTAMP WITHOUT TIME ZONE | Sí | — |

**Restricciones adicionales:** existe una restricción `UNIQUE` sobre `(id_seguidor, id_seguido)` y una condición `CHECK` que impide que un estudiante se siga a sí mismo. Las dos claves foráneas hacen referencia a la tabla `estudiante`.

**Justificación:** `id_seguimiento` identifica cada registro, mientras que la combinación única evita duplicar la misma relación de seguimiento.

### 2.9. Tabla `grupo`

Almacena grupos académicos y sociales.

| Campo | Tipo de dato | Nulo | Clave o restricción |
|---|---|---|---|
| id_grupo | INTEGER | No | PK, identidad |
| nombre | VARCHAR(100) | No | — |
| descripcion | TEXT | Sí | — |
| tipo | VARCHAR(50) | Sí | — |
| fecha_creacion | TIMESTAMP WITHOUT TIME ZONE | No | DEFAULT CURRENT_TIMESTAMP |

**Justificación:** admite nombres, descripciones y clasificaciones de los grupos, además de registrar su fecha de creación.

### 2.10. Tabla `membresia`

Registra la pertenencia de los estudiantes a los grupos.

| Campo | Tipo de dato | Nulo | Clave o restricción |
|---|---|---|---|
| id_membresia | INTEGER | No | PK, identidad |
| id_estudiante | INTEGER | No | FK → estudiante |
| id_grupo | INTEGER | No | FK → grupo |
| fecha_ingreso | TIMESTAMP WITHOUT TIME ZONE | No | DEFAULT CURRENT_TIMESTAMP |
| rol | VARCHAR(50) | Sí | — |

**Restricción adicional:** `UNIQUE(id_estudiante, id_grupo)` evita registrar más de una membresía para el mismo estudiante en el mismo grupo.

**Justificación:** `id_membresia` identifica cada registro y las claves foráneas mantienen la integridad de los datos relacionados.

### 2.11. Tabla `evento`

Almacena información de eventos académicos y sociales.

| Campo | Tipo de dato | Nulo | Clave o restricción |
|---|---|---|---|
| id_evento | INTEGER | No | PK, identidad |
| nombre | VARCHAR(150) | No | — |
| descripcion | TEXT | Sí | — |
| fecha | DATE | No | — |
| hora | TIME WITHOUT TIME ZONE | No | — |
| lugar | VARCHAR(200) | Sí | — |
| metadatos | JSONB | Sí | Atributo propuesto para la Tarea 4 |

**Justificación:** `DATE` almacena la fecha del evento, `TIME` su hora y `JSONB` permite guardar datos adicionales estructurados de forma flexible, como modalidad, recursos digitales o información asociada a dispositivos conectados.

**Nota:** `metadatos` no forma parte de la implementación original revisada. Se añadirá únicamente al nuevo script de comparación.

### 2.12. Tabla `participacion_evento`

Registra la inscripción de estudiantes en eventos.

| Campo | Tipo de dato | Nulo | Clave o restricción |
|---|---|---|---|
| id_estudiante | INTEGER | No | PK compuesta y FK → estudiante |
| id_evento | INTEGER | No | PK compuesta y FK → evento |
| fecha_inscripcion | TIMESTAMP WITHOUT TIME ZONE | No | DEFAULT CURRENT_TIMESTAMP |

**Justificación:** la clave primaria compuesta evita que un estudiante se inscriba más de una vez en el mismo evento.

## 3. Claves y restricciones

- **Claves primarias (PK):** identifican de forma única cada registro. En las tablas de asociación se utilizan claves primarias compuestas cuando corresponde.
- **Claves foráneas (FK):** garantizan la integridad referencial entre las tablas relacionadas.
- **Restricción UNIQUE:** evita duplicados en el correo de los estudiantes, las membresías por estudiante y grupo, y las parejas de seguimiento.
- **Restricción CHECK:** evita que un estudiante se siga a sí mismo.
- **IDENTITY:** genera automáticamente identificadores en las tablas que utilizan esta característica.
- **DEFAULT CURRENT_TIMESTAMP:** asigna automáticamente la fecha y hora actuales en los campos correspondientes.

## 4. Tipos de datos semiestructurados y Big Data

PostgreSQL ofrece el tipo `JSONB`, que permite almacenar documentos JSON en una representación binaria optimizada para operaciones y consultas. En Pascualina, el campo propuesto `evento.metadatos` permitiría guardar atributos adicionales que varían según cada evento.

Esta flexibilidad puede ser útil cuando una aplicación recibe información de distintas fuentes o dispositivos conectados, un escenario relacionado con Big Data e IoT. Su uso debe acompañarse de validaciones para mantener la calidad de los datos.

## 5. Observaciones de implementación

1. Este documento describe la estructura de las doce tablas del SQL original y la propuesta adicional `evento.metadatos`.
2. El atributo `metadatos JSONB` deberá aparecer en el nuevo DDL de PostgreSQL para que el diccionario y el script coincidan.
3. Las versiones de SQL Server y MySQL deberán documentar sus equivalencias de tipos de datos y restricciones.
4. La base de datos original `red_social_pascualina` no debe modificarse para realizar esta comparación.
