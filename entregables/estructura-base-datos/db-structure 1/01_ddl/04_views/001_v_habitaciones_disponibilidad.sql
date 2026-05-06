CREATE OR REPLACE VIEW distribucion.v_habitaciones_disponibilidad AS
SELECT
  h.id AS habitacion_id,
  s.nombre AS sede,
  h.numero,
  h.piso,
  th.nombre AS tipo_habitacion,
  h.capacidad,
  eh.nombre AS estado_habitacion,
  eh.permite_reserva,
  eh.permite_check_in,
  h.status
FROM distribucion.habitacion h
JOIN distribucion.sede s ON s.id = h.sede_id
JOIN distribucion.tipo_habitacion th ON th.id = h.tipo_habitacion_id
JOIN distribucion.estado_habitacion eh ON eh.id = h.estado_habitacion_id
WHERE h.status = 'ACTIVE';
