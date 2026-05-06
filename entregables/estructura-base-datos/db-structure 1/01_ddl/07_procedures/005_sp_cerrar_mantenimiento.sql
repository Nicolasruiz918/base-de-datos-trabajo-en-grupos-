CREATE OR REPLACE PROCEDURE mantenimiento.sp_cerrar_mantenimiento(
  p_mantenimiento_id UUID,
  p_observacion TEXT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
  v_habitacion_id UUID;
  v_estado_disponible UUID;
BEGIN
  SELECT habitacion_id INTO v_habitacion_id
  FROM mantenimiento.mantenimiento_habitacion
  WHERE id = p_mantenimiento_id;

  SELECT id INTO v_estado_disponible
  FROM distribucion.estado_habitacion
  WHERE nombre = 'DISPONIBLE'
  LIMIT 1;

  UPDATE mantenimiento.mantenimiento_habitacion
  SET estado_mantenimiento = 'FINALIZADO',
      fecha_fin = COALESCE(fecha_fin, now()),
      observacion = COALESCE(p_observacion, observacion)
  WHERE id = p_mantenimiento_id;

  IF v_estado_disponible IS NOT NULL THEN
    UPDATE distribucion.habitacion
    SET estado_habitacion_id = v_estado_disponible
    WHERE id = v_habitacion_id;
  END IF;
END;
$$;
