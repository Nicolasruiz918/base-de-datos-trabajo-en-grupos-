BEGIN;

REFRESH MATERIALIZED VIEW billing.mv_monthly_revenue;
REFRESH MATERIALIZED VIEW distribution.mv_site_occupancy;

COMMIT;



