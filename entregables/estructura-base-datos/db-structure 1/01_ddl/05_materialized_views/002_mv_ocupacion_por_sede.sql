CREATE MATERIALIZED VIEW IF NOT EXISTS distribucion.mv_ocupacion_por_sede AS
SELECT
  s.id AS sede_id,
  s.nombre AS sede,
  COUNT(h.id) AS total_habitaciones,
  COUNT(*) FILTER (WHERE eh.nombre = 'OCUPADA') AS ocupadas,
  COUNT(*) FILTER (WHERE eh.permite_reserva) AS disponibles_para_reserva
FROM distribucion.sede s
LEFT JOIN distribucion.habitacion h ON h.sede_id = s.id AND h.status = 'ACTIVE'
LEFT JOIN distribucion.estado_habitacion eh ON eh.id = h.estado_habitacion_id
GROUP BY s.id, s.nombre
WITH NO DATA;
