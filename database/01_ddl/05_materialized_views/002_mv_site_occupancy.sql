CREATE MATERIALIZED VIEW IF NOT EXISTS distribution.mv_site_occupancy AS
SELECT
  s.id AS site_id,
  s.name AS site,
  COUNT(h.id) AS total_rooms,
  COUNT(*) FILTER (WHERE eh.name = 'OCCUPIED') AS occupied_rooms,
  COUNT(*) FILTER (WHERE eh.allows_reservation) AS available_for_reservation
FROM distribution.site s
LEFT JOIN distribution.room h ON h.site_id = s.id AND h.status = 'ACTIVE'
LEFT JOIN distribution.room_status eh ON eh.id = h.room_status_id
GROUP BY s.id, s.name
WITH NO DATA;


