# Changelogs Liquibase

Archivo maestro YAML:

```bash
liquibase --changelog-file=changelog/changelog-master.yaml update
```

Cada carpeta principal tiene su propio `changelog.yaml` con changeSets tipo `databaseChangeLog`.
Cada changeSet ejecuta un archivo `.sql` y apunta a su rollback individual en `05_rollbacks`.

El archivo `changelog-master.sql` se conserva como orden maestro para ejecucion directa con `psql`.
## Masters por bloque

- `01_ddl/changelog-master.yaml`
- `02_dml/changelog-master.yaml`
- `03_dcl/changelog-master.yaml`
- `04_tcl/changelog-master.yaml`

El maestro global `changelog/changelog-master.yaml` incluye esos cuatro archivos.


