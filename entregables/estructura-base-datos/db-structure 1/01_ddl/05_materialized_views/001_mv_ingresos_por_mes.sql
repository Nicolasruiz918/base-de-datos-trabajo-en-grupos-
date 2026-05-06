CREATE MATERIALIZED VIEW IF NOT EXISTS facturacion.mv_ingresos_por_mes AS
SELECT
  date_trunc('month', fecha_emision)::DATE AS mes,
  COUNT(*) AS facturas_emitidas,
  SUM(total) AS total_facturado
FROM facturacion.factura
WHERE status = 'ACTIVE'
GROUP BY date_trunc('month', fecha_emision)::DATE
WITH NO DATA;
