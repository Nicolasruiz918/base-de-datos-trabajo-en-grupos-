# Estructura de base de datos usada

La entrega conserva 8 dominios oficiales: parametrizacion, distribucion, prestacion_servicio, facturacion, inventario, notificacion, seguridad y mantenimiento.

```text
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
04_tcl/
05_rollbacks/
changelog/
docker/
scripts/
```

Nota: se elimino `01_ddl/10_configuration` porque no hace parte de la estructura solicitada.

## Reglas de organizacion

- Cada view vive en su propio archivo.
- Cada materialized view vive en su propio archivo.
- Cada function vive en su propio archivo.
- Cada procedure vive en su propio archivo.
- Cada trigger vive en su propio archivo.
- Los tipos compartidos se ubican dentro de los schemas de los 8 dominios, no en un schema adicional.
## Changelogs Liquibase

- `01_ddl/changelog-master.yaml` incluye los changelogs de extensions, schemas, types, tables, views, materialized views, functions, procedures, triggers e indexes.
- `02_dml/changelog-master.yaml` incluye los changelogs de inserts, updates, deletes, upserts y patches.
- `03_dcl/changelog-master.yaml` incluye los changelogs de roles, grants y policies.
- `04_tcl/changelog-master.yaml` incluye los changelogs de transaction blocks y manual recoveries.
- `changelog/changelog-master.yaml` incluye los cuatro maestros anteriores.
- Cada changeSet apunta al SQL principal y a un rollback individual dentro de `05_rollbacks`.
## Configuracion de ejecucion

- `docker/docker-compose.yml` define los servicios `postgres` y `liquibase`.
- `liquibase.properties` define la conexion JDBC y el changelog maestro.
- El puerto local usado por PostgreSQL es `25432` para evitar choques con instalaciones locales en `5432`.
## Decisiones de identificadores

- Los identificadores definitivos usan `UUID`.
- PostgreSQL genera los IDs con `gen_random_uuid()`.
- Los campos `created_by`, `updated_by` y `deleted_by` quedan tipados como `UUID`.
- La politica de eliminacion por defecto es logica usando `status`, `deleted_at` y `deleted_by`.
