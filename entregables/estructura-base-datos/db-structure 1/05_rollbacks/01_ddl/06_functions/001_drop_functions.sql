DROP FUNCTION IF EXISTS facturacion.fn_normalizar_total_facturacion() CASCADE;
DROP FUNCTION IF EXISTS inventario.fn_validar_venta_producto_stock() CASCADE;
DROP FUNCTION IF EXISTS prestacion_servicio.fn_validar_reserva_habitacion() CASCADE;
DROP FUNCTION IF EXISTS distribucion.fn_validar_capacidad_habitacion() CASCADE;
DROP FUNCTION IF EXISTS inventario.fn_stock_disponible(UUID);
DROP FUNCTION IF EXISTS parametrizacion.fn_calcular_precio_reserva(UUID, TIMESTAMPTZ, TIMESTAMPTZ);
DROP FUNCTION IF EXISTS facturacion.fn_calcular_total(NUMERIC, NUMERIC, NUMERIC);
DROP FUNCTION IF EXISTS prestacion_servicio.fn_calcular_noches(TIMESTAMPTZ, TIMESTAMPTZ);
DROP FUNCTION IF EXISTS parametrizacion.fn_set_updated_at() CASCADE;
