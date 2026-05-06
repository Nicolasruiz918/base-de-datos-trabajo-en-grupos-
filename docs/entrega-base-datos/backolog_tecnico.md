# Backlog tecnico - Sistema hotelero

El backlog tecnico queda alineado con las 23 HU del backlog organizado y con la estructura real del entregable de base de datos.

## Resumen por bloque

| Bloque                          | HU            | Objetivo tecnico                                                         | Responsable principal                         |
| ------------------------------- | ------------- | ------------------------------------------------------------------------ | --------------------------------------------- |
| Planificacion e infraestructura | HU-1 a HU-8   | Documentar plan, dominios, ADR, ambiente PostgreSQL, Docker y Liquibase. | Nicolas Estid Ruiz Sastoque                   |
| Modelo de datos                 | HU-9 a HU-14  | Crear DDL por parejas de dominios y separar objetos avanzados por archivo.          | Brayan Perdomo                                |
| Carga de datos y seguridad      | HU-15 a HU-22 | Poblar datos, crear roles, grants, policies, TCL y rollbacks.            | Frenier Steven Cardona Perez / Brayan Perdomo |
| Validacion final                | HU-23         | Ejecutar smoke test, revisar documentacion y confirmar cierre.           | Emily Sharith Amezquita Saavedra              |

## Items tecnicos principales

| Item       | Entregable                                                     | Criterio de aceptacion                                                                |
| ---------- | -------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| PostgreSQL | `docker/docker-compose.yml`                                  | El servicio `postgres` levanta la base `sistema_hotelero` en el puerto `25432`. |
| Liquibase  | `liquibase.properties` y `changelog/changelog-master.yaml` | El servicio `liquibase` ejecuta los changeSets contra PostgreSQL.                   |
| DDL        | `01_ddl`                                                     | Cada dominio y objeto avanzado queda separado por carpeta y archivo.                  |
| DML        | `02_dml`                                                     | Los inserts quedan separados por dominio y las operaciones adicionales por tipo.      |
| DCL        | `03_dcl`                                                     | Ariel puede autenticarse con permisos controlados sin heredar `administrador`.      |
| Rollback   | `05_rollbacks`                                               | Cada changeSet YAML referencia un rollback individual.                                |
| Validacion | `scripts/smoke-test.sql`                                     | Las consultas minimas retornan los conteos esperados.                                 |

## Reglas de control

- Mantener 8 dominios oficiales.
- No crear schema tecnico adicional.
- Mantener los changelogs maestros por bloque: DDL, DML, DCL y TCL.

