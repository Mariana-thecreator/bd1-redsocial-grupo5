# Diccionario de Datos General — Red Social Pascualina

## 1. Descripción

La base de datos Pascualina representa una red social académica que permite a los estudiantes crear perfiles, compartir publicaciones, registrar intereses y habilidades, seguir a otros estudiantes, participar en grupos y asistir a eventos.

Este diccionario general sirve como referencia para comparar la implementación física de la base de datos en PostgreSQL, Microsoft SQL Server y MySQL.

## 2. Entidades del sistema

| Tabla | Descripción |
|---|---|
| estudiante | Almacena la información básica de los estudiantes. |
| publicacion | Registra las publicaciones creadas por los estudiantes. |
| comentario | Almacena los comentarios realizados en las publicaciones. |
| interes | Contiene el catálogo de intereses. |
| estudiante_interes | Relaciona estudiantes con sus intereses. |
| habilidad | Contiene el catálogo de habilidades. |
| estudiante_habilidad | Relaciona estudiantes con sus habilidades. |
| seguimiento | Registra las relaciones de seguimiento entre estudiantes. |
| grupo | Almacena los grupos académicos y sociales. |
| membresia | Registra la pertenencia de los estudiantes a los grupos. |
| evento | Almacena información de eventos académicos y sociales. |
| participacion_evento | Registra la inscripción de estudiantes a eventos. |

## 3. Criterios generales

- Se conservarán las doce tablas del modelo físico existente.
- Se respetarán las claves primarias, las claves foráneas y las restricciones de unicidad del modelo.
- Los tipos de datos se adaptarán a las características de cada SGBD.
- Se documentarán las diferencias entre PostgreSQL, Microsoft SQL Server y MySQL.
- Los cambios requeridos para la comparación se implementarán en scripts independientes, sin modificar la base de datos original.

## 4. Incorporación de datos semiestructurados

Para cumplir el requisito de utilizar un tipo de dato semiestructurado, se propone incorporar el atributo `metadatos` a la tabla `evento`.

Este atributo permitirá almacenar información adicional flexible sobre los eventos, por ejemplo, modalidad, recursos digitales, información de conexión o datos relacionados con dispositivos utilizados durante una actividad.

El tipo físico se adaptará a cada SGBD: `JSONB` en PostgreSQL, texto validado con `ISJSON` en versiones compatibles de SQL Server y `JSON` en MySQL.

Esta propuesta facilita almacenar información que puede variar entre eventos sin tener que crear una columna fija para cada dato adicional. También puede servir para representar metadatos procedentes de aplicaciones o dispositivos conectados, relacionados con escenarios de Big Data e IoT.

## 5. Alcance

Este documento describe el modelo general. Los diccionarios físicos específicos incluirán los nombres de los campos, sus tipos de datos, tamaños, nulabilidad, claves y restricciones correspondientes a cada SGBD.
