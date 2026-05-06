INSERT INTO prestacion_servicio.reserva_habitacion (
  cliente_id,
  habitacion_id,
  fecha_inicio,
  fecha_fin,
  cantidad_persona,
  estado_reserva,
  valor_estimado
)
SELECT c.id, h.id, TIMESTAMPTZ '2026-05-10 15:00:00-05', TIMESTAMPTZ '2026-05-12 12:00:00-05', 1, 'CONFIRMADA', 240000
FROM parametrizacion.cliente c
JOIN distribucion.habitacion h ON h.numero = '101'
WHERE c.numero_documento = '100000001'
  AND NOT EXISTS (
    SELECT 1
    FROM prestacion_servicio.reserva_habitacion r
    WHERE r.cliente_id = c.id
      AND r.habitacion_id = h.id
      AND r.fecha_inicio = TIMESTAMPTZ '2026-05-10 15:00:00-05'
  );

INSERT INTO prestacion_servicio.estadia (
  reserva_habitacion_id,
  cliente_id,
  habitacion_id,
  fecha_inicio,
  estado_estadia
)
SELECT r.id, r.cliente_id, r.habitacion_id, r.fecha_inicio, 'ACTIVA'
FROM prestacion_servicio.reserva_habitacion r
WHERE r.fecha_inicio = TIMESTAMPTZ '2026-05-10 15:00:00-05'
  AND NOT EXISTS (
    SELECT 1
    FROM prestacion_servicio.estadia e
    WHERE e.reserva_habitacion_id = r.id
  );

