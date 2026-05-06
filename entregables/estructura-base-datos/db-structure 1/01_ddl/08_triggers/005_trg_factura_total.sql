DROP TRIGGER IF EXISTS trg_factura_total ON facturacion.factura;
CREATE TRIGGER trg_factura_total
BEFORE INSERT OR UPDATE OF subtotal, impuesto, descuento
ON facturacion.factura
FOR EACH ROW
EXECUTE FUNCTION facturacion.fn_normalizar_total_facturacion();
