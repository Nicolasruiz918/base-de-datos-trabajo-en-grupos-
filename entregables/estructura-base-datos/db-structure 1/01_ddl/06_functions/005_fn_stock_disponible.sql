CREATE OR REPLACE FUNCTION inventario.fn_stock_disponible(p_producto_id UUID)
RETURNS INTEGER
LANGUAGE sql
STABLE
AS $$
  SELECT COALESCE(stock_actual, 0)
  FROM inventario.producto
  WHERE id = p_producto_id
    AND status = 'ACTIVE';
$$;
