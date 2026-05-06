BEGIN;

REFRESH MATERIALIZED VIEW facturacion.mv_ingresos_por_mes;
REFRESH MATERIALIZED VIEW distribucion.mv_ocupacion_por_sede;

COMMIT;

