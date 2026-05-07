CREATE OR REPLACE VIEW maintenance.v_current_maintenance_dashboard AS
SELECT DISTINCT ON (dm.site_id)
  dm.site_id,
  s.name AS site,
  dm.total_rooms,
  dm.available_rooms,
  dm.occupied_rooms,
  dm.rooms_in_maintenance,
  dm.report_date
FROM maintenance.maintenance_dashboard dm
JOIN distribution.site s ON s.id = dm.site_id
ORDER BY dm.site_id, dm.report_date DESC;


