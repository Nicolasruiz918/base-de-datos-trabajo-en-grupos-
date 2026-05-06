CREATE OR REPLACE FUNCTION inventario.fn_validar_venta_producto_stock()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
  v_stock INTEGER;
BEGIN
  SELECT stock_actual INTO v_stock
  FROM inventario.producto
  WHERE id = NEW.producto_id AND status = 'ACTIVE'
  FOR UPDATE;

  IF v_stock IS NULL THEN
    RAISE EXCEPTION 'Producto % no existe o no esta activo', NEW.producto_id;
  END IF;

  IF v_stock < NEW.cantidad THEN
    RAISE EXCEPTION 'Stock insuficiente para producto %. Disponible %, solicitado %', NEW.producto_id, v_stock, NEW.cantidad;
  END IF;

  NEW.valor_total := NEW.cantidad * NEW.valor_unitario;

  UPDATE inventario.producto
  SET stock_actual = stock_actual - NEW.cantidad
  WHERE id = NEW.producto_id;

  INSERT INTO inventario.seguimiento_producto (producto_id, tipo_movimiento, cantidad, observacion)
  VALUES (NEW.producto_id, 'SALIDA', NEW.cantidad, 'Venta asociada a estadia ' || NEW.estadia_id);

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_venta_producto_stock ON inventario.venta_producto;
CREATE TRIGGER trg_venta_producto_stock
BEFORE INSERT
ON inventario.venta_producto
FOR EACH ROW
EXECUTE FUNCTION inventario.fn_validar_venta_producto_stock();
