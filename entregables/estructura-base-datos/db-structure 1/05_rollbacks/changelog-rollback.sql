-- Orden sugerido de rollback, espejo de DDL, DML, DCL y TCL.

\ir 03_dcl/02_policies/001_drop_policies.sql
\ir 03_dcl/01_grants/001_revoke_grants.sql
\ir 03_dcl/00_roles/001_drop_roles.sql
\ir 02_dml/04_patches/001_rollback_patch_refresh_reports.sql
\ir 02_dml/03_upserts/001_delete_upsert_catalogs.sql
\ir 02_dml/02_deletes/001_revert_soft_delete_demo.sql
\ir 02_dml/01_updates/001_revert_update_operational_statuses.sql
\ir 02_dml/00_inserts/001_delete_seed_data.sql
\ir 01_ddl/09_indexes/001_drop_indexes.sql
\ir 01_ddl/08_triggers/001_drop_triggers.sql
\ir 01_ddl/07_procedures/001_drop_procedures.sql
\ir 01_ddl/06_functions/001_drop_functions.sql
\ir 01_ddl/05_materialized_views/001_drop_materialized_views.sql
\ir 01_ddl/04_views/001_drop_views.sql
\ir 01_ddl/03_tables/001_drop_tables.sql
\ir 01_ddl/02_types/001_drop_types.sql
\ir 01_ddl/01_schemas/001_drop_schemas.sql
\ir 01_ddl/00_extensions/001_drop_extensions.sql


