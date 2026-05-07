CREATE MATERIALIZED VIEW IF NOT EXISTS distribution.mv_site_occupancy AS
SELECT
  s.id AS site_id,
  s.name AS site,
  COUNT(h.id) AS total_roomses,
  COUNT(*) FILTER (WHERE eh.name = 'OCCUPIED') AS ocupadas,
  COUNT(*) FILTER (WHERE eh.allows_reservationtion) AS availables_para_reservation
FROM distribution.site s
LEFT JOIN distribution.room h ON h.site_id = s.id AND h.status = 'ACTIVE'
LEFT JOIN distribution.room_status eh ON eh.id = h.room_status_id
GROUP BY s.id, s.name
WITH NO DATA;


