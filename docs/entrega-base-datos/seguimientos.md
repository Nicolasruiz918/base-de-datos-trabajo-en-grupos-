# Seguimientos del proyecto

## Corte actual

| Aspecto              | Estado     | Evidencia                                                                                                                                          |
| -------------------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| Dominios oficiales   | Completado | La base conserva 8 dominios: parametrizacion, distribucion, prestacion_servicio, facturacion, inventario, notificacion, seguridad y mantenimiento. |
| Estructura DDL       | Completado | DDL separado en extensions, schemas, types, tables, views, materialized views, functions, procedures, triggers e indexes.                          |
| Estructura DML       | Completado | Inserts separados por dominio y operaciones adicionales en updates, deletes, upserts y patches.                                                    |
| Seguridad DCL        | Completado | Roles, grants y policies separados.`ariel5253` queda con permisos controlados y no hereda `administrador`.                                     |
| TCL y rollbacks      | Completado | TCL separado y `05_rollbacks` organizado como espejo de DDL, DML, DCL y TCL.                                                                     |
| Changelogs Liquibase | Completado | Changelog maestro global y maestros por bloque DDL, DML, DCL y TCL.                                                                                |
| Ambiente Docker      | Preparado  | `docker/docker-compose.yml` levanta PostgreSQL y ejecuta Liquibase.                                                                              |

## Decisiones registradas

- La base se trabaja en PostgreSQL.
- No se crea schema tecnico adicional.
- Parametrizacion queda como un solo dominio.
- Notificacion y mantenimiento quedan como dominios separados.
- Cada view, materialized view, function, procedure y trigger vive en archivo propio.

## Seguimiento por bloque

| Bloque                          | Responsable      | Avance                                                                           |
| ------------------------------- | ---------------- | -------------------------------------------------------------------------------- |
| Planificacion e infraestructura | Nicolas / Emily  | Documentacion base, ADR, Docker, PostgreSQL y Liquibase preparados.              |
| Modelo de datos                 | Brayan / Nicolas | DDL organizado por dominios y objetos avanzados separados por archivo.           |
| Carga de datos y seguridad      | Frenier / Brayan | DML, DCL y TCL organizados con rollbacks.                                        |
| Validacion final                | Emily            | Liquibase y smoke test ejecutados correctamente en Docker. |

## Pendiente de validacion

- Ejecutar `docker compose up liquibase` desde la carpeta `docker`.
- Ejecutar `scripts/smoke-test.sql` contra la base `hotel_management`.
- Validar autenticacion con usuario `ariel5253`.
- Registrar resultado de ejecucion en este documento cuando se tenga la evidencia.

## Evidencia esperada

| Validacion            | Resultado esperado                                                |
| --------------------- | ----------------------------------------------------------------- |
| Schemas creados       | 8                                                                 |
| Tablas creadas        | 46                                                                |
| Estados de habitacion | 6                                                                 |
| Tipos de habitacion   | 3                                                                 |
| Modulos de seguridad  | 8                                                                 |
| Usuario `ariel5253` | 1 registro en `security.user_account` y login PostgreSQL disponible |

