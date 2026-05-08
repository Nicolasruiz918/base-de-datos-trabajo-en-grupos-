# Base de datos - Sistema de gestion hotelera

Entrega organizada para PostgreSQL con 8 dominios oficiales.

## Estado objetivo

- Motor objetivo: PostgreSQL 16
- Base de datos: `hotel_management`
- Changelog maestro SQL: `changelog/changelog-master.sql`
- Changelog maestro Liquibase: `changelog/changelog-master.yaml`
- Usuario de autenticacion del sistema: `ariel5253`
- Password de autenticacion del sistema: `ariel5253`
- El usuario `ariel5253` no hereda el rol `administrador`; usa permisos controlados.

## Documentos principales	

| Documento                            | Uso                                                                                        |
| ------------------------------------ | ------------------------------------------------------------------------------------------ |
| `Historias de usuario.md`          | HU tecnicas con titulo, descripcion, entregables, criterios, checklist y MoSCoW.           |
| `plan_trabajo_inicial.md`          | Plan del sprint y entregables por dia.                                                     |
| `seguimientos.md`                  | Seguimiento diario, avances, bloqueos y evidencias.                                        |
| `analisis_dominios.md`             | Explicacion de los 8 dominios oficiales y sus tablas relacionadas.                         |
| `gestion_equipo.md`                | Planteamiento, roles, responsabilidades, tablero del equipo y evidencias esperadas.        |
| `guia_tecnica_ejecucion.md`        | Estructura de BD, orden de carga, Docker, Liquibase, smoke test y cuidado de FKs.          |
| `flujo_git_por_historias.md`       | Guia para subir el proyecto por HU, ramas, commits, PRs y promocion `dev -> qa -> main`. |
| `matriz_trazabilidad_hu.md`        | Relacion entre HU tecnicas, dominios, entregables y dependencias.                          |
| `dor_dod.md`                       | Definition of Ready y Definition of Done.                                                  |
| `ADR/`                             | Decisiones tecnicas importantes: PostgreSQL, UUID/auditoria/eliminacion e idioma tecnico.  |
| `tablero_azure_trello_clickup.csv` | Tablero importable con HU tecnicas.                                                        |
| `plan_subida_hu_tecnicas.csv`      | Orden sugerido de ramas, archivos y validaciones por HU.                                   |

## Ejecucion rapida

Desde `entregables/estructura-base-datos/db-structure 1/docker`:

```bash
docker-compose down -v
docker-compose up --abort-on-container-exit liquibase
```

Entrar a la base de datos:

```bash
docker-compose exec postgres psql -U admin -d hotel_management
```

Smoke test:

```bash
docker-compose exec postgres psql -U admin -d hotel_management -f /scripts/smoke-test.sql
```

## Estructura clave

- DDL separado por extensiones, schemas, types, tablas, views, materialized views, functions, procedures, triggers e indexes.
- DML separado en inserts, updates, deletes, upserts y patches.
- DCL separado en roles, grants y policies.
- TCL y rollbacks incluidos.
- Docker Compose preparado con PostgreSQL y Liquibase.
- Historias de usuario tecnicas documentadas y listas para subir por partes.

## Changelogs maestros por bloque

- `01_ddl/changelog-master.yaml`
- `02_dml/changelog-master.yaml`
- `03_dcl/changelog-master.yaml`
- `04_tcl/changelog-master.yaml`

El maestro global `changelog/changelog-master.yaml` incluye los cuatro maestros anteriores.

