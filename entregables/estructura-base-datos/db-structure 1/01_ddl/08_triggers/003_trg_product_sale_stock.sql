CREATE OR REPLACE FUNCTION inventory.fn_validate_product_sale_stock()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
  v_stock INTEGER;
BEGIN
  SELECT current_stock INTO v_stock
  FROM inventory.product
  WHERE id = NEW.product_id AND status = 'ACTIVE'
  FOR UPDATE;

  IF v_stock IS NULL THEN
    RAISE EXCEPTION 'Producto % no existe o no esta activo', NEW.product_id;
  END IF;

  IF v_stock < NEW.quantity THEN
    RAISE EXCEPTION 'Stock insuficiente para product %. Disponible %, solicitado %', NEW.product_id, v_stock, NEW.quantity;
  END IF;

  NEW.total_value := NEW.quantity * NEW.unit_value;

  UPDATE inventory.product
  SET current_stock = current_stock - NEW.quantity
  WHERE id = NEW.product_id;

  INSERT INTO inventory.product_tracking (product_id, movement_type, quantity, notes)
  VALUES (NEW.product_id, 'OUT', NEW.quantity, 'Venta asociada a stay ' || NEW.stay_id);

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_product_sale_stock ON inventory.product_sale;
CREATE TRIGGER trg_product_sale_stock
BEFORE INSERT
ON inventory.product_sale
FOR EACH ROW
EXECUTE FUNCTION inventory.fn_validate_product_sale_stock();


