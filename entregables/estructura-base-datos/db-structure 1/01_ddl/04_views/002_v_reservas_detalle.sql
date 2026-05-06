CREATE OR REPLACE VIEW prestacion_servicio.v_reservas_detalle AS
SELECT
  r.id AS reserva_id,
  c.numero_documento AS cliente_documento,
  c.nombre || ' ' || c.apellido AS cliente,
  h.numero AS habitacion,
  s.nombre AS sede,
  r.fecha_inicio,
  r.fecha_fin,
  r.cantidad_persona,
  r.estado_reserva,
  r.valor_estimado,
  r.status
FROM prestacion_servicio.reserva_habitacion r
JOIN parametrizacion.cliente c ON c.id = r.cliente_id
JOIN distribucion.habitacion h ON h.id = r.habitacion_id
JOIN distribucion.sede s ON s.id = h.sede_id;
