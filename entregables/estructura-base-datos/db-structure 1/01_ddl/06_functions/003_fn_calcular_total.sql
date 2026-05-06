CREATE OR REPLACE FUNCTION facturacion.fn_calcular_total(
  p_subtotal NUMERIC,
  p_impuesto NUMERIC,
  p_descuento NUMERIC
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
BEGIN
  IF p_subtotal < 0 OR p_impuesto < 0 OR p_descuento < 0 THEN
    RAISE EXCEPTION 'Subtotal, impuesto y descuento no pueden ser negativos';
  END IF;

  RETURN GREATEST(0, p_subtotal + p_impuesto - p_descuento);
END;
$$;
