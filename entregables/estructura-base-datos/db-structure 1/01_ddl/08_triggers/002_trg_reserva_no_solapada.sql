CREATE OR REPLACE FUNCTION prestacion_servicio.fn_validar_reserva_habitacion()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
  v_permite_reserva BOOLEAN;
BEGIN
  SELECT eh.permite_reserva INTO v_permite_reserva
  FROM distribucion.habitacion h
  JOIN distribucion.estado_habitacion eh ON eh.id = h.estado_habitacion_id
  WHERE h.id = NEW.habitacion_id;

  IF COALESCE(v_permite_reserva, false) = false THEN
    RAISE EXCEPTION 'La habitacion % no permite reserva en su estado actual', NEW.habitacion_id;
  END IF;

  IF EXISTS (
    SELECT 1
    FROM prestacion_servicio.reserva_habitacion r
    WHERE r.habitacion_id = NEW.habitacion_id
      AND r.id <> COALESCE(NEW.id, -1)
      AND r.status = 'ACTIVE'
      AND r.estado_reserva NOT IN ('CANCELADA', 'FINALIZADA')
      AND tstzrange(r.fecha_inicio, r.fecha_fin, '[)') && tstzrange(NEW.fecha_inicio, NEW.fecha_fin, '[)')
  ) THEN
    RAISE EXCEPTION 'La habitacion % ya tiene una reserva activa en el rango solicitado', NEW.habitacion_id;
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_reserva_no_solapada ON prestacion_servicio.reserva_habitacion;
CREATE TRIGGER trg_reserva_no_solapada
BEFORE INSERT OR UPDATE OF habitacion_id, fecha_inicio, fecha_fin, estado_reserva, status
ON prestacion_servicio.reserva_habitacion
FOR EACH ROW
EXECUTE FUNCTION prestacion_servicio.fn_validar_reserva_habitacion();
