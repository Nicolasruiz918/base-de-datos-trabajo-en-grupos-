-- Orden maestro de ejecucion para PostgreSQL.
-- Run with psql after creating the hotel_management database.

\ir ../01_ddl/00_extensions/001_extensions.sql
\ir ../01_ddl/01_schemas/001_schemas.sql
\ir ../01_ddl/02_types/001_domain_types.sql
\ir ../01_ddl/03_tables/001_configuration.sql
\ir ../01_ddl/03_tables/002_security.sql
\ir ../01_ddl/03_tables/003_distribution.sql
\ir ../01_ddl/03_tables/004_service_delivery.sql
\ir ../01_ddl/03_tables/005_inventory.sql
\ir ../01_ddl/03_tables/006_billing.sql
\ir ../01_ddl/03_tables/007_notification.sql
\ir ../01_ddl/03_tables/008_maintenance.sql
\ir ../01_ddl/06_functions/001_fn_set_updated_at.sql
\ir ../01_ddl/06_functions/002_fn_calculate_nights.sql
\ir ../01_ddl/06_functions/003_fn_calculate_total.sql
\ir ../01_ddl/06_functions/004_fn_calculate_reservation_price.sql
\ir ../01_ddl/06_functions/005_fn_available_stock.sql
\ir ../01_ddl/07_procedures/001_sp_create_reservation.sql
\ir ../01_ddl/07_procedures/002_sp_soft_delete.sql
\ir ../01_ddl/07_procedures/003_sp_register_product_entry.sql
\ir ../01_ddl/07_procedures/004_sp_issue_invoice.sql
\ir ../01_ddl/07_procedures/005_sp_close_maintenance.sql
\ir ../01_ddl/08_triggers/001_trg_room_capacity.sql
\ir ../01_ddl/08_triggers/002_trg_reservation_no_overlap.sql
\ir ../01_ddl/08_triggers/003_trg_product_sale_stock.sql
\ir ../01_ddl/08_triggers/004_trg_pre_invoice_total.sql
\ir ../01_ddl/08_triggers/005_trg_invoice_total.sql
\ir ../01_ddl/08_triggers/006_trg_set_updated_at.sql
\ir ../01_ddl/04_views/001_v_room_availability.sql
\ir ../01_ddl/04_views/002_v_reservation_detail.sql
\ir ../01_ddl/04_views/003_v_stay_billing.sql
\ir ../01_ddl/04_views/004_v_user_roles.sql
\ir ../01_ddl/04_views/005_v_current_maintenance_dashboard.sql
\ir ../01_ddl/05_materialized_views/001_mv_monthly_revenue.sql
\ir ../01_ddl/05_materialized_views/002_mv_site_occupancy.sql
\ir ../01_ddl/09_indexes/001_domain_indexes.sql
\ir ../02_dml/00_inserts/001_configuration.sql
\ir ../02_dml/00_inserts/002_security.sql
\ir ../02_dml/00_inserts/003_distribution.sql
\ir ../02_dml/00_inserts/004_service_delivery.sql
\ir ../02_dml/00_inserts/005_inventory.sql
\ir ../02_dml/00_inserts/006_billing.sql
\ir ../02_dml/00_inserts/007_notification.sql
\ir ../02_dml/00_inserts/008_maintenance.sql
\ir ../02_dml/01_updates/001_update_operational_statuses.sql
\ir ../02_dml/02_deletes/001_soft_delete_demo.sql
\ir ../02_dml/03_upserts/001_upsert_catalogs.sql
\ir ../02_dml/04_patches/001_patch_refresh_reports.sql
\ir ../03_dcl/00_roles/001_roles.sql
\ir ../03_dcl/01_grants/001_grants.sql
\ir ../03_dcl/02_policies/001_rls_policies.sql
\ir ../04_tcl/00_transaction_blocks/001_safe_load.sql
\ir ../04_tcl/01_manual_recoveries/001_refresh_materialized_views.sql


