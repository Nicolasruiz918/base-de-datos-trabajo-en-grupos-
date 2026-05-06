CREATE OR REPLACE FUNCTION facturacion.fn_normalizar_total_facturacion()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  NEW.total := facturacion.fn_calcular_total(NEW.subtotal, NEW.impuesto, NEW.descuento);
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_pre_factura_total ON facturacion.pre_factura;
CREATE TRIGGER trg_pre_factura_total
BEFORE INSERT OR UPDATE OF subtotal, impuesto, descuento
ON facturacion.pre_factura
FOR EACH ROW
EXECUTE FUNCTION facturacion.fn_normalizar_total_facturacion();
