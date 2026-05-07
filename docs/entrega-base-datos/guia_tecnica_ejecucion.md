# Guia tecnica de estructura, ejecucion y validacion

## Proposito

Este documento consolida la estructura de base de datos, el orden de carga, la ejecucion con Docker/Liquibase y la validacion final.

## Estado objetivo

| Elemento | Valor |
|----------|-------|
| Motor | PostgreSQL 16 |
| Base de datos | `sistema_hotelero` |
| Usuario Docker | `admin` |
| Password Docker | `admin123` |
| Puerto local | `25432` |
| Usuario controlado | `ariel5253` |
| Password usuario controlado | `ariel5253` |
| Changelog maestro | `changelog/changelog-master.yaml` |

## Estructura de carpetas

```text
entregables/estructura-base-datos/db-structure 1/
  01_ddl/
    00_extensions/
    01_schemas/
    02_types/
    03_tables/
    04_views/
    05_materialized_views/
    06_functions/
    07_procedures/
    08_triggers/
    09_indexes/
  02_dml/
    00_inserts/
    01_updates/
    02_deletes/
    03_upserts/
    04_patches/
  03_dcl/
    00_roles/
    01_grants/
    02_policies/
  04_tcl/
    00_transaction_blocks/
    01_manual_recovery/
  05_rollbacks/
  changelog/
  docker/
  scripts/
```

## Orden logico de ejecucion

| Orden | Carpeta | Motivo |
|-------|---------|--------|
| 1 | `01_ddl/00_extensions` | Habilita capacidades como `pgcrypto` y `citext`. |
| 2 | `01_ddl/01_schemas` | Crea los 8 schemas oficiales. |
| 3 | `01_ddl/02_types` | Crea tipos o estados usados por tablas. |
| 4 | `01_ddl/03_tables` | Crea tablas, PK, FKs, constraints y auditoria. |
| 5 | `01_ddl/06_functions` | Crea funciones usadas por consultas o procesos. |
| 6 | `01_ddl/07_procedures` | Crea procesos de negocio y mantenimiento. |
| 7 | `01_ddl/08_triggers` | Crea validaciones automaticas sobre tablas existentes. |
| 8 | `01_ddl/04_views` | Crea consultas consolidadas. |
| 9 | `01_ddl/05_materialized_views` | Crea reportes materializados. |
| 10 | `01_ddl/09_indexes` | Crea indices de busqueda, unicidad y soporte a `ON CONFLICT`. |
| 11 | `02_dml` | Carga datos en orden padre-hijo. |
| 12 | `03_dcl` | Crea roles, grants y policies. |
| 13 | `04_tcl` | Ejecuta transacciones o recuperaciones controladas. |

## Changelogs disponibles

| Uso | Archivo |
|-----|---------|
| Ejecucion completa con Liquibase | `changelog/changelog-master.yaml` |
| Ejecucion completa con psql | `changelog/changelog-master.sql` |
| DDL | `01_ddl/changelog-master.yaml` |
| DML | `02_dml/changelog-master.yaml` |
| DCL | `03_dcl/changelog-master.yaml` |
| TCL | `04_tcl/changelog-master.yaml` |

## Ejecucion con Docker y Liquibase

Desde `entregables/estructura-base-datos/db-structure 1/docker`:

```bash
docker-compose down -v
docker-compose up --abort-on-container-exit liquibase
```

Si se quiere dejar PostgreSQL levantado para consultas:

```bash
docker-compose up -d postgres
docker-compose up liquibase
```

## Smoke test

Con PostgreSQL levantado:

```bash
docker-compose exec postgres psql -U admin -d sistema_hotelero -f /scripts/smoke-test.sql
```

El smoke test debe validar como minimo:

- Schemas creados.
- Tablas creadas.
- Datos base poblados.
- Usuario `ariel5253`.
- Relaciones principales disponibles.

## Cuidado con foreign keys

Las FKs no se rompen por subir archivos a Git. Se rompen si se ejecuta un script antes de sus dependencias.

Reglas:

- Crear tablas padre antes que tablas hijas.
- Insertar datos padre antes que datos hijos.
- Crear functions, procedures, triggers y views despues de las tablas que usan.
- Ejecutar rollbacks en orden inverso.
- Probar cada grupo de HU en una base limpia cuando toque SQL.

Ejemplos:

| Relacion | Orden seguro |
|----------|--------------|
| `sede -> empresa` | Empresa antes de sede. |
| `habitacion -> sede` | Sede antes de habitacion. |
| `reserva -> cliente/habitacion` | Cliente y habitacion antes de reserva. |
| `factura -> estadia` | Estadia antes de factura. |

## Validacion final

Checklist de cierre:

- [ ] `docker-compose down -v` ejecutado para limpiar la base.
- [ ] Liquibase ejecuta sin errores desde cero.
- [ ] Smoke test ejecuta correctamente.
- [ ] Se revisan FKs y ausencia de datos huerfanos.
- [ ] Los rollbacks existen y siguen la misma estructura.
- [ ] README, HU, ADR, DoR/DoD, matriz, plan y seguimiento estan actualizados.
- [ ] La entrega pasa de `dev` a `qa` y luego a `main`.

