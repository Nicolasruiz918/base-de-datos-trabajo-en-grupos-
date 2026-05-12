CREATE MATERIALIZED VIEW IF NOT EXISTS billing.mv_monthly_revenue AS
SELECT
  date_trunc('month', issue_date)::DATE AS mes,
  COUNT(*) AS invoices_emitidas,
  SUM(total) AS total_invoicedo
FROM billing.invoice
WHERE status = 'ACTIVE'
GROUP BY date_trunc('month', issue_date)::DATE
WITH NO DATA;


