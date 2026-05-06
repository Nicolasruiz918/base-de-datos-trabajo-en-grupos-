# Base de datos - Sistema de gestion hotelera

Entrega organizada para PostgreSQL con 8 dominios oficiales.

## Estado objetivo

- Motor objetivo: PostgreSQL 16
- Base de datos: `sistema_hotelero`
- Changelog maestro SQL: `changelog/changelog-master.sql`
- Changelog maestro Liquibase: `changelog/changelog-master.yaml`
- Usuario de autenticacion del sistema: `ariel5253`
- Password de autenticacion del sistema: `ariel5253`
- El usuario `ariel5253` no hereda el rol `administrador`; usa permisos controlados.

## Estructura clave

- DDL separado por extensiones, schemas, types, tablas, views, materialized views, functions, procedures, triggers e indexes.
- DML separado en inserts, updates, deletes, upserts y patches.
- DCL separado en roles, grants y policies.
- TCL y rollbacks incluidos.
- Docker Compose preparado con PostgreSQL y Liquibase.

## Ejecucion recomendada

Desde `entregables/estructura-base-datos/db-structure 1/docker`:

```bash
docker compose up liquibase
```

Smoke test:

```bash
docker compose exec postgres psql -U admin -d sistema_hotelero -f /scripts/smoke-test.sql
```

## Configuracion de servicios

| Servicio | Imagen | Uso |
|----------|--------|-----|
| `postgres` | `postgres:16` | Base de datos `sistema_hotelero` expuesta en `localhost:25432`. |
| `liquibase` | `liquibase/liquibase:4.25` | Ejecuta `changelog/changelog-master.yaml`. |

## Credenciales de ambiente Docker

| Elemento | Valor |
|----------|-------|
| Usuario PostgreSQL | `admin` |
| Password PostgreSQL | `admin123` |
| JDBC URL | `jdbc:postgresql://postgres:5432/sistema_hotelero` |

## Documentos principales

- `planning.md`: planning Markdown consolidado para la entrega de base de datos.
- `Historias de usuario.md`: backlog organizado.
- `seguimientos.md`: estado, decisiones y evidencias pendientes.
- `dor_dod.md`: Definition of Ready y Definition of Done.
- `guia_ejecucion_y_validacion.md`: pasos de ejecucion y smoke test.
- ADR/ADR-001-migracion-postgresql.md: decision de migracion a PostgreSQL.
- ADR/ADR-002-identificadores-estados-auditoria-eliminacion.md: decision de UUID, status, auditoria y eliminacion logica.
- ADR/ADR-003-cambio-idioma-base-datos-ingles.md: decision de cambio de idioma tecnico de la base de datos a ingles, manteniendo la documentacion en espanol.

## Changelogs maestros por bloque

- `01_ddl/changelog-master.yaml`
- `02_dml/changelog-master.yaml`
- `03_dcl/changelog-master.yaml`
- `04_tcl/changelog-master.yaml`

El maestro global `changelog/changelog-master.yaml` incluye los cuatro maestros anteriores.


