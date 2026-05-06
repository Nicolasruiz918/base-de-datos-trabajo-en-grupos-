CREATE OR REPLACE VIEW mantenimiento.v_dashboard_mantenimiento_actual AS
SELECT DISTINCT ON (dm.sede_id)
  dm.sede_id,
  s.nombre AS sede,
  dm.total_habitacion,
  dm.habitacion_disponible,
  dm.habitacion_ocupada,
  dm.habitacion_mantenimiento,
  dm.fecha_corte
FROM mantenimiento.dashboard_mantenimiento dm
JOIN distribucion.sede s ON s.id = dm.sede_id
ORDER BY dm.sede_id, dm.fecha_corte DESC;
