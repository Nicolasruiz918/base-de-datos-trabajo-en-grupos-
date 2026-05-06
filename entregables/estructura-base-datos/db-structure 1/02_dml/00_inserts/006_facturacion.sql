INSERT INTO facturacion.pre_factura (
  estadia_id,
  reserva_habitacion_id,
  cliente_id,
  subtotal,
  impuesto,
  descuento
)
SELECT e.id, e.reserva_habitacion_id, e.cliente_id, 240000, 45600, 0
FROM prestacion_servicio.estadia e
WHERE NOT EXISTS (
  SELECT 1
  FROM facturacion.pre_factura pf
  WHERE pf.estadia_id = e.id
);

INSERT INTO facturacion.pago_parcial (reserva_habitacion_id, metodo_pago_id, valor, referencia_pago)
SELECT r.id, mp.id, 100000, 'ABONO-DEMO-001'
FROM prestacion_servicio.reserva_habitacion r
JOIN parametrizacion.metodo_pago mp ON mp.nombre = 'TRANSFERENCIA'
WHERE r.fecha_inicio = TIMESTAMPTZ '2026-05-10 15:00:00-05'
  AND NOT EXISTS (
    SELECT 1
    FROM facturacion.pago_parcial pp
    WHERE pp.reserva_habitacion_id = r.id
      AND pp.referencia_pago = 'ABONO-DEMO-001'
  );

