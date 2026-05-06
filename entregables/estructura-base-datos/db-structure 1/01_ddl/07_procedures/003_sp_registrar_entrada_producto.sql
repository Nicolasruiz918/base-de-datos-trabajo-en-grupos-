CREATE OR REPLACE PROCEDURE inventario.sp_registrar_entrada_producto(
  p_producto_id UUID,
  p_cantidad INTEGER,
  p_observacion TEXT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
  IF p_cantidad <= 0 THEN
    RAISE EXCEPTION 'La cantidad de entrada debe ser mayor que cero';
  END IF;

  UPDATE inventario.producto
  SET stock_actual = stock_actual + p_cantidad
  WHERE id = p_producto_id;

  INSERT INTO inventario.seguimiento_producto (producto_id, tipo_movimiento, cantidad, observacion)
  VALUES (p_producto_id, 'ENTRADA', p_cantidad, p_observacion);
END;
$$;
