CREATE OR REPLACE PROCEDURE prestacion_servicio.sp_crear_reserva(
  p_cliente_id UUID,
  p_habitacion_id UUID,
  p_fecha_inicio TIMESTAMPTZ,
  p_fecha_fin TIMESTAMPTZ,
  p_cantidad_persona SMALLINT
)
LANGUAGE plpgsql
AS $$
DECLARE
  v_tipo_habitacion_id UUID;
  v_valor_estimado NUMERIC(12,2);
BEGIN
  SELECT tipo_habitacion_id INTO v_tipo_habitacion_id
  FROM distribucion.habitacion
  WHERE id = p_habitacion_id AND status = 'ACTIVE';

  IF v_tipo_habitacion_id IS NULL THEN
    RAISE EXCEPTION 'Habitacion % no existe o no esta activa', p_habitacion_id;
  END IF;

  v_valor_estimado := parametrizacion.fn_calcular_precio_reserva(v_tipo_habitacion_id, p_fecha_inicio, p_fecha_fin);

  INSERT INTO prestacion_servicio.reserva_habitacion (
    cliente_id, habitacion_id, fecha_inicio, fecha_fin, cantidad_persona, valor_estimado, estado_reserva
  )
  VALUES (
    p_cliente_id, p_habitacion_id, p_fecha_inicio, p_fecha_fin, p_cantidad_persona, v_valor_estimado, 'PENDIENTE'
  );
END;
$$;
