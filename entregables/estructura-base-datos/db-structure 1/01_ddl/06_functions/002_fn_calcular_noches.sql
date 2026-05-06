CREATE OR REPLACE FUNCTION prestacion_servicio.fn_calcular_noches(
  p_fecha_inicio TIMESTAMPTZ,
  p_fecha_fin TIMESTAMPTZ
)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
BEGIN
  IF p_fecha_fin <= p_fecha_inicio THEN
    RAISE EXCEPTION 'La fecha fin debe ser mayor que la fecha inicio';
  END IF;

  RETURN GREATEST(1, CEIL(EXTRACT(EPOCH FROM (p_fecha_fin - p_fecha_inicio)) / 86400.0)::INTEGER);
END;
$$;
