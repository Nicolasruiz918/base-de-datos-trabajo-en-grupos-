DROP PROCEDURE IF EXISTS mantenimiento.sp_cerrar_mantenimiento(UUID, TEXT);
DROP PROCEDURE IF EXISTS facturacion.sp_emitir_factura(UUID, VARCHAR);
DROP PROCEDURE IF EXISTS inventario.sp_registrar_entrada_producto(UUID, INTEGER, TEXT);
DROP PROCEDURE IF EXISTS seguridad.sp_soft_delete(TEXT, TEXT, UUID, UUID);
DROP PROCEDURE IF EXISTS prestacion_servicio.sp_crear_reserva(UUID, UUID, TIMESTAMPTZ, TIMESTAMPTZ, SMALLINT);
