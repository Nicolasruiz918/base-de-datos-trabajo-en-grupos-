INSERT INTO mantenimiento.dashboard_mantenimiento (
  sede_id,
  total_habitacion,
  habitacion_disponible,
  habitacion_ocupada,
  habitacion_mantenimiento
)
SELECT
  s.id,
  COUNT(h.id),
  COUNT(*) FILTER (WHERE eh.nombre = 'DISPONIBLE'),
  COUNT(*) FILTER (WHERE eh.nombre = 'OCUPADA'),
  COUNT(*) FILTER (WHERE eh.nombre = 'MANTENIMIENTO')
FROM distribucion.sede s
LEFT JOIN distribucion.habitacion h ON h.sede_id = s.id
LEFT JOIN distribucion.estado_habitacion eh ON eh.id = h.estado_habitacion_id
WHERE NOT EXISTS (
  SELECT 1
  FROM mantenimiento.dashboard_mantenimiento dm
  WHERE dm.sede_id = s.id
)
GROUP BY s.id;
