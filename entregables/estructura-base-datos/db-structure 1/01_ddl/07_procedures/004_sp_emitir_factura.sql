CREATE OR REPLACE PROCEDURE facturacion.sp_emitir_factura(
  p_estadia_id UUID,
  p_numero_factura VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
  v_pre_factura facturacion.pre_factura%ROWTYPE;
BEGIN
  SELECT * INTO v_pre_factura
  FROM facturacion.pre_factura
  WHERE estadia_id = p_estadia_id AND status = 'ACTIVE';

  IF v_pre_factura.id IS NULL THEN
    RAISE EXCEPTION 'No existe pre factura activa para la estadia %', p_estadia_id;
  END IF;

  INSERT INTO facturacion.factura (
    cliente_id, estadia_id, numero_factura, subtotal, impuesto, descuento, total, estado_factura
  )
  VALUES (
    v_pre_factura.cliente_id, v_pre_factura.estadia_id, p_numero_factura,
    v_pre_factura.subtotal, v_pre_factura.impuesto, v_pre_factura.descuento,
    v_pre_factura.total, 'EMITIDA'
  );
END;
$$;
