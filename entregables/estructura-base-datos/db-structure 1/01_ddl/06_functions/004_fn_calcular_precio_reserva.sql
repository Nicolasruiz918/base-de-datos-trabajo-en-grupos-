CREATE OR REPLACE FUNCTION parametrizacion.fn_calcular_precio_reserva(
  p_tipo_habitacion_id UUID,
  p_fecha_inicio TIMESTAMPTZ,
  p_fecha_fin TIMESTAMPTZ
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
  v_total NUMERIC(12,2);
BEGIN
  SELECT COALESCE(SUM(px.valor), 0)
  INTO v_total
  FROM generate_series(
    p_fecha_inicio::DATE,
    (p_fecha_fin::DATE - INTERVAL '1 day')::DATE,
    INTERVAL '1 day'
  ) AS d(dia)
  LEFT JOIN LATERAL (
    SELECT p.valor
    FROM parametrizacion.precio p
    JOIN parametrizacion.tipo_dia td ON td.id = p.tipo_dia_id
    WHERE p.tipo_habitacion_id = p_tipo_habitacion_id
      AND p.status = 'ACTIVE'
      AND p.fecha_inicio <= d.dia::DATE
      AND (p.fecha_fin IS NULL OR p.fecha_fin >= d.dia::DATE)
    ORDER BY p.fecha_inicio DESC
    LIMIT 1
  ) px ON true;

  RETURN v_total;
END;
$$;
