# Orden de carga

## Orden logico

1. `01_ddl/00_extensions`
2. `01_ddl/01_schemas`
3. `01_ddl/02_types`
4. `01_ddl/03_tables`
5. `01_ddl/06_functions`
6. `01_ddl/07_procedures`
7. `01_ddl/08_triggers`
8. `01_ddl/04_views`
9. `01_ddl/05_materialized_views`
10. `01_ddl/09_indexes`
11. `02_dml`
12. `03_dcl`
13. `04_tcl`

## Changelogs disponibles

| Uso | Archivo |
|-----|---------|
| Ejecucion completa con Liquibase | `changelog/changelog-master.yaml` |
| Ejecucion completa con psql | `changelog/changelog-master.sql` |
| DDL | `01_ddl/changelog-master.yaml` |
| DML | `02_dml/changelog-master.yaml` |
| DCL | `03_dcl/changelog-master.yaml` |
| TCL | `04_tcl/changelog-master.yaml` |

## Ejecucion recomendada con Docker

Desde `entregables/estructura-base-datos/db-structure 1/docker`:

```bash
docker compose up liquibase
```

Ese comando levanta PostgreSQL, espera el healthcheck y ejecuta Liquibase.

Para validar despues de la carga:

```bash
docker compose exec postgres psql -U admin -d sistema_hotelero -f /scripts/smoke-test.sql
```

Para detener el ambiente:

```bash
docker compose down
```

Para borrar tambien los datos del volumen:

```bash
docker compose down -v
```
