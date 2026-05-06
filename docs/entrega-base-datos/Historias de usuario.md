# Backlog organizado - Historias de usuario

## 1. Planificacion e infraestructura

| HU   | Historia                                                            |
| ---- | ------------------------------------------------------------------- |
| HU-1 | Crear repositorio Git con ramas `main`, `qa` y `dev`.         |
| HU-2 | Crear plan de trabajo y documento de seguimiento.                   |
| HU-3 | Identificar dominios.                                               |
| HU-4 | Crear ADRs.                                                         |
| HU-5 | Estructura GitHub Actions.                                          |
| HU-6 | Agregar Docker Compose y PostgreSQL.                                |
| HU-7 | Agregar Liquibase.                                                  |
| HU-8 | Separacion de DDL e implementacion de extensiones, schemas y types. |

## 2. Modelo de datos

| HU    | Historia                                                                  |
| ----- | ------------------------------------------------------------------------- |
| HU-9  | Implementacion de tablas dominio: parametrizacion y seguridad.            |
| HU-10 | Implementacion de tablas dominio: distribucion y prestacion de servicios. |
| HU-11 | Implementacion de tablas dominio: inventario y facturacion.               |
| HU-12 | Implementacion de tablas dominio: notificacion y mantenimiento.           |
| HU-13 | Crear views, materialized views y functions.                              |
| HU-14 | Crear procedures, triggers e indices.                                     |

## 3. Carga de datos y seguridad

| HU    | Historia                                                                                                                                |
| ----- | --------------------------------------------------------------------------------------------------------------------------------------- |
| HU-15 | Crear DML insert: parametrizacion y seguridad.                                                                                          |
| HU-16 | Crear DML insert: distribucion y prestacion de servicios.                                                                               |
| HU-17 | Crear DML insert: inventario y facturacion.                                                                                             |
| HU-18 | Crear DML insert: notificacion y mantenimiento.                                                                                         |
| HU-19 | Crear DCL roles. Nota: el rol de Ariel solo debe tener permisos controlados en DDL y DML, y no debe poder crear nuevos administradores. |
| HU-20 | DCL grants.                                                                                                                             |
| HU-21 | DCL policies.                                                                                                                           |
| HU-22 | Crear TCL.                                                                                                                              |

## 4. Validacion final

| HU    | Historia                                                   |
| ----- | ---------------------------------------------------------- |
| HU-23 | Verificar que todo este funcional y revisar documentacion. |

## Dominios oficiales

La base debe mantenerse en 8 dominios, alineados con la documentacion del sistema hotelero:

1. Parametrizacion
2. Distribucion
3. Prestacion de servicio
4. Facturacion
5. Inventario
6. Notificacion
7. Seguridad
8. Mantenimiento
