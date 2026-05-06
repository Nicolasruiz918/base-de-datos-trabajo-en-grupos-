CREATE OR REPLACE VIEW facturacion.v_facturacion_estadia AS
SELECT
  e.id AS estadia_id,
  c.numero_documento AS cliente_documento,
  c.nombre || ' ' || c.apellido AS cliente,
  pf.total AS total_pre_factura,
  f.numero_factura,
  f.total AS total_factura,
  f.estado_factura,
  COALESCE(SUM(pp.valor), 0) AS total_pagado
FROM prestacion_servicio.estadia e
JOIN parametrizacion.cliente c ON c.id = e.cliente_id
LEFT JOIN facturacion.pre_factura pf ON pf.estadia_id = e.id
LEFT JOIN facturacion.factura f ON f.estadia_id = e.id
LEFT JOIN facturacion.pago_parcial pp ON pp.factura_id = f.id
GROUP BY e.id, c.numero_documento, c.nombre, c.apellido, pf.total, f.numero_factura, f.total, f.estado_factura;
