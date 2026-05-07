CREATE OR REPLACE PROCEDURE maintenance.sp_close_maintenance(
  p_maintenance_id UUID,
  p_notes TEXT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
  v_room_id UUID;
  v_estado_available UUID;
BEGIN
  SELECT room_id INTO v_room_id
  FROM maintenance.room_maintenance
  WHERE id = p_maintenance_id;

  SELECT id INTO v_estado_available
  FROM distribution.room_status
  WHERE name = 'AVAILABLE'
  LIMIT 1;

  UPDATE maintenance.room_maintenance
  SET maintenance_status = 'FINISHED',
      end_date = COALESCE(end_date, now()),
      notes = COALESCE(p_notes, notes)
  WHERE id = p_maintenance_id;

  IF v_estado_available IS NOT NULL THEN
    UPDATE distribution.room
    SET room_status_id = v_estado_available
    WHERE id = v_room_id;
  END IF;
END;
$$;


