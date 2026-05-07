INSERT INTO maintenance.maintenance_dashboard (
  site_id,
  total_rooms,
  available_rooms,
  occupied_rooms,
  rooms_in_maintenance
)
SELECT
  s.id,
  COUNT(h.id),
  COUNT(*) FILTER (WHERE eh.name = 'AVAILABLE'),
  COUNT(*) FILTER (WHERE eh.name = 'OCCUPIED'),
  COUNT(*) FILTER (WHERE eh.name = 'MAINTENANCE')
FROM distribution.site s
LEFT JOIN distribution.room h ON h.site_id = s.id
LEFT JOIN distribution.room_status eh ON eh.id = h.room_status_id
WHERE NOT EXISTS (
  SELECT 1
  FROM maintenance.maintenance_dashboard dm
  WHERE dm.site_id = s.id
)
GROUP BY s.id;


