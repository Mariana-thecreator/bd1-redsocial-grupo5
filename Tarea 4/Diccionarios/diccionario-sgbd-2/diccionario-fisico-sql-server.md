# Diccionario de Datos Físico — Microsoft SQL Server

## 1. Descripción

Este documento presenta la adaptación física de la base de datos Pascualina a Microsoft SQL Server. Se conservan las doce tablas del modelo y se documentan sus campos, tipos de datos, claves y restricciones.

La estructura se basa en el modelo PostgreSQL existente. El campo `metadatos` de la tabla `evento` es una propuesta nueva para la Tarea 4 y no pertenece a la base de datos original.

## 2. Diccionario por tabla

### 2.1. Tabla `estudiante`

Almacena la información básica de los estudiantes.

| Campo | Tipo de dato SQL Server | Nulo | Clave o restricción |
|---|---|---|---|
| id_estudiante | INT IDENTITY(1,1) | No | PK |
| nombre | VARCHAR(100) | No | — |
| apellido | VARCHAR(100) | No | — |
| correo | VARCHAR(150) | No | UNIQUE |
| fecha_nacimiento | DATE | Sí | — |

**Justificación:** `INT` identifica los registros, `IDENTITY` genera identificadores automáticamente, `VARCHAR` almacena texto de longitud variable y `DATE` representa fechas.

### 2.2. Tabla `publicacion`

Registra las publicaciones creadas por los estudiantes.

| Campo | Tipo de dato SQL Server | Nulo | Clave o restricción |
|---|---|---|---|
| id_publicacion | INT IDENTITY(1,1) | No | PK |
| id_estudiante | INT | No | FK → estudiante |
| contenido | NVARCHAR(MAX) | No | — |
| fecha_publicacion | DATETIME2 | No | DEFAULT SYSDATETIME() |
| tipo | VARCHAR(50) | Sí | — |

**Justificación:** `NVARCHAR(MAX)` permite almacenar contenido extenso con caracteres Unicode; `DATETIME2` registra fecha y hora con precisión configurable.

### 2.3. Tabla `comentario`

Almacena los comentarios realizados en las publicaciones.

| Campo | Tipo de dato SQL Server | Nulo | Clave o restricción |
|---|---|---|---|
| id_comentario | INT IDENTITY(1,1) | No | PK |
| id_publicacion | INT | No | FK → publicacion |
| id_estudiante | INT | No | FK → estudiante |
| contenido | NVARCHAR(MAX) | No | — |
| fecha_comentario | DATETIME2 | No | DEFAULT SYSDATETIME() |

**Justificación:** permite almacenar comentarios extensos y registrar su fecha y hora de creación.

### 2.4. Tabla `interes`

Contiene el catálogo de intereses.

| Campo | Tipo de dato SQL Server | Nulo | Clave o restricción |
|---|---|---|---|
| id_interes | INT IDENTITY(1,1) | No | PK |
| nombre | VARCHAR(100) | No | — |
| descripcion | NVARCHAR(MAX) | Sí | — |

### 2.5. Tabla `estudiante_interes`

Relaciona estudiantes con sus intereses.

| Campo | Tipo de dato SQL Server | Nulo | Clave o restricción |
|---|---|---|---|
| id_estudiante | INT | No | PK compuesta y FK → estudiante |
| id_interes | INT | No | PK compuesta y FK → interes |

**Justificación:** la clave primaria compuesta impide repetir la misma relación entre estudiante e interés.

### 2.6. Tabla `habilidad`

Contiene el catálogo de habilidades.

| Campo | Tipo de dato SQL Server | Nulo | Clave o restricción |
|---|---|---|---|
| id_habilidad | INT IDENTITY(1,1) | No | PK |
| nombre | VARCHAR(100) | No | — |
| descripcion | NVARCHAR(MAX) | Sí | — |
| nivel | VARCHAR(50) | Sí | — |

### 2.7. Tabla `estudiante_habilidad`

Relaciona estudiantes con sus habilidades.

| Campo | Tipo de dato SQL Server | Nulo | Clave o restricción |
|---|---|---|---|
| id_estudiante | INT | No | PK compuesta y FK → estudiante |
| id_habilidad | INT | No | PK compuesta y FK → habilidad |

**Justificación:** la clave primaria compuesta evita duplicar una misma habilidad para un estudiante.

### 2.8. Tabla `seguimiento`

Registra las relaciones de seguimiento entre estudiantes.

| Campo | Tipo de dato SQL Server | Nulo | Clave o restricción |
|---|---|---|---|
| id_seguidor | INT | No | FK → estudiante |
| id_seguido | INT | No | FK → estudiante |
| id_seguimiento | INT IDENTITY(1,1) | No | PK |
| fecha_seguimiento | DATETIME2 | Sí | — |

**Restricciones adicionales:** `UNIQUE(id_seguidor, id_seguido)` y `CHECK (id_seguidor <> id_seguido)`.

**Justificación:** el identificador generado distingue cada registro; la restricción única evita duplicados y la condición `CHECK` impide que un estudiante se siga a sí mismo.

### 2.9. Tabla `grupo`

Almacena los grupos académicos y sociales.

| Campo | Tipo de dato SQL Server | Nulo | Clave o restricción |
|---|---|---|---|
| id_grupo | INT IDENTITY(1,1) | No | PK |
| nombre | VARCHAR(100) | No | — |
| descripcion | NVARCHAR(MAX) | Sí | — |
| tipo | VARCHAR(50) | Sí | — |
| fecha_creacion | DATETIME2 | No | DEFAULT SYSDATETIME() |

### 2.10. Tabla `membresia`

Registra la pertenencia de los estudiantes a los grupos.

| Campo | Tipo de dato SQL Server | Nulo | Clave o restricción |
|---|---|---|---|
| id_estudiante | INT | No | FK → estudiante |
| id_grupo | INT | No | FK → grupo |
| fecha_ingreso | DATETIME2 | No | DEFAULT SYSDATETIME() |
| id_membresia | INT IDENTITY(1,1) | No | PK |
| rol | VARCHAR(50) | Sí | — |

**Restricción adicional:** `UNIQUE(id_estudiante, id_grupo)`.

**Justificación:** cada membresía tiene un identificador propio y la restricción única evita registrar varias membresías del mismo estudiante en el mismo grupo.

### 2.11. Tabla `evento`

Almacena información de eventos académicos y sociales.

| Campo | Tipo de dato SQL Server | Nulo | Clave o restricción |
|---|---|---|---|
| id_evento | INT IDENTITY(1,1) | No | PK |
| nombre | VARCHAR(150) | No | — |
| descripcion | NVARCHAR(MAX) | Sí | — |
| fecha | DATE | No | — |
| hora | TIME | No | — |
| lugar | VARCHAR(200) | Sí | — |
| metadatos | NVARCHAR(MAX) | Sí | JSON validado con CHECK |

**Restricción propuesta:** `CHECK (metadatos IS NULL OR ISJSON(metadatos) = 1)`.

**Justificación:** SQL Server puede almacenar el documento JSON como texto en `NVARCHAR(MAX)` y validar su formato con `ISJSON` en versiones compatibles. Así se pueden conservar metadatos flexibles, como modalidad del evento, recursos digitales o información relacionada con dispositivos conectados.

### 2.12. Tabla `participacion_evento`

Registra la inscripción de estudiantes en eventos.

| Campo | Tipo de dato SQL Server | Nulo | Clave o restricción |
|---|---|---|---|
| id_estudiante | INT | No | PK compuesta y FK → estudiante |
| id_evento | INT | No | PK compuesta y FK → evento |
| fecha_inscripcion | DATETIME2 | No | DEFAULT SYSDATETIME() |

**Justificación:** la clave primaria compuesta impide registrar más de una inscripción del mismo estudiante al mismo evento.

## 3. Claves y relaciones

- **PK:** identifican de manera única los registros.
- **FK:** mantienen la integridad referencial entre las tablas.
- **UNIQUE:** evita valores duplicados en el correo y en las combinaciones de membresía y seguimiento indicadas.
- **CHECK:** valida condiciones específicas, como impedir el seguimiento a uno mismo y validar el formato JSON.
- **IDENTITY(1,1):** genera automáticamente identificadores enteros.
- **DEFAULT SYSDATETIME():** asigna la fecha y hora actuales en los campos correspondientes.

Las claves foráneas deberán conservar las reglas de eliminación definidas en el modelo de referencia. En particular, algunas relaciones utilizan `ON DELETE CASCADE`, mientras que otras mantienen el comportamiento restrictivo predeterminado.

## 4. Diferencias respecto a PostgreSQL

1. PostgreSQL utiliza `INTEGER`, mientras que SQL Server utiliza `INT`; ambos permiten almacenar enteros dentro de rangos compatibles.
2. PostgreSQL utiliza `TIMESTAMP WITHOUT TIME ZONE`; su equivalente aproximado en SQL Server es `DATETIME2`.
3. PostgreSQL dispone de `TEXT`, mientras que en SQL Server puede utilizarse `NVARCHAR(MAX)` para contenido extenso con Unicode.
4. PostgreSQL permite `JSONB`; SQL Server puede almacenar JSON en texto y validarlo mediante `ISJSON` en versiones compatibles.
5. La generación de identificadores se implementa con `IDENTITY` en ambos sistemas, aunque existen diferencias en la inserción explícita de valores de identidad.

## 5. Consideraciones

Este diccionario describe la adaptación propuesta. Antes de ejecutar el script DDL de SQL Server, se deben comprobar la versión del motor, la sintaxis de las restricciones y las reglas de integridad referencial. Este trabajo no modifica la base de datos original de PostgreSQL.
