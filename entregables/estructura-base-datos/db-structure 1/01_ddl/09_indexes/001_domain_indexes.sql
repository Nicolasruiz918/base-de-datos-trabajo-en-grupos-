CREATE UNIQUE INDEX IF NOT EXISTS ux_cliente_documento ON parametrizacion.cliente (tipo_documento, numero_documento);
CREATE UNIQUE INDEX IF NOT EXISTS ux_cliente_correo ON parametrizacion.cliente (correo) WHERE correo IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS ux_persona_documento ON parametrizacion.persona (tipo_documento, numero_documento);
CREATE UNIQUE INDEX IF NOT EXISTS ux_persona_correo ON parametrizacion.persona (correo) WHERE correo IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS ux_empresa_nit ON parametrizacion.empresa (nit);
CREATE UNIQUE INDEX IF NOT EXISTS ux_tipo_dia_nombre_fecha ON parametrizacion.tipo_dia (nombre, fecha);
CREATE UNIQUE INDEX IF NOT EXISTS ux_metodo_pago_nombre ON parametrizacion.metodo_pago (nombre);
CREATE UNIQUE INDEX IF NOT EXISTS ux_empleado_persona ON parametrizacion.empleado (persona_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_empleado_correo_laboral ON parametrizacion.empleado (correo_laboral) WHERE correo_laboral IS NOT NULL;
CREATE UNIQUE INDEX IF NOT EXISTS ux_precio_tipo_dia_inicio ON parametrizacion.precio (tipo_habitacion_id, tipo_dia_id, fecha_inicio);

CREATE UNIQUE INDEX IF NOT EXISTS ux_rol_nombre ON seguridad.rol (nombre);
CREATE UNIQUE INDEX IF NOT EXISTS ux_permiso_nombre_accion ON seguridad.permiso (nombre, accion);
CREATE UNIQUE INDEX IF NOT EXISTS ux_modulo_nombre ON seguridad.modulo (nombre);
CREATE UNIQUE INDEX IF NOT EXISTS ux_modulo_ruta_base ON seguridad.modulo (ruta_base);
CREATE UNIQUE INDEX IF NOT EXISTS ux_vista_modulo_ruta ON seguridad.vista (modulo_id, ruta);
CREATE UNIQUE INDEX IF NOT EXISTS ux_usuario_persona ON seguridad.usuario (persona_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_usuario_username ON seguridad.usuario (username);
CREATE UNIQUE INDEX IF NOT EXISTS ux_usuario_rol ON seguridad.usuario_rol (usuario_id, rol_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_rol_permiso ON seguridad.rol_permiso (rol_id, permiso_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_modulo_vista ON seguridad.modulo_vista (modulo_id, vista_id);

CREATE UNIQUE INDEX IF NOT EXISTS ux_sede_empresa_nombre ON distribucion.sede (empresa_id, nombre);
CREATE UNIQUE INDEX IF NOT EXISTS ux_tipo_habitacion_nombre ON distribucion.tipo_habitacion (nombre);
CREATE UNIQUE INDEX IF NOT EXISTS ux_estado_habitacion_nombre ON distribucion.estado_habitacion (nombre);
CREATE UNIQUE INDEX IF NOT EXISTS ux_habitacion_sede_numero ON distribucion.habitacion (sede_id, numero);
CREATE UNIQUE INDEX IF NOT EXISTS ux_catalogo_habitacion ON distribucion.catalogo_habitacion (habitacion_id);
CREATE INDEX IF NOT EXISTS ix_disponibilidad_habitacion_fecha ON distribucion.disponibilidad_habitacion (habitacion_id, fecha_inicio, fecha_fin);

CREATE INDEX IF NOT EXISTS ix_reserva_cliente ON prestacion_servicio.reserva_habitacion (cliente_id);
CREATE INDEX IF NOT EXISTS ix_reserva_habitacion_fecha ON prestacion_servicio.reserva_habitacion (habitacion_id, fecha_inicio, fecha_fin);
CREATE UNIQUE INDEX IF NOT EXISTS ux_cancelacion_reserva ON prestacion_servicio.cancelacion_habitacion (reserva_habitacion_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_estadia_reserva ON prestacion_servicio.estadia (reserva_habitacion_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_check_in_reserva ON prestacion_servicio.check_in (reserva_habitacion_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_check_out_estadia ON prestacion_servicio.check_out (estadia_id);

CREATE UNIQUE INDEX IF NOT EXISTS ux_proveedor_nit ON inventario.proveedor (nit);
CREATE UNIQUE INDEX IF NOT EXISTS ux_producto_nombre ON inventario.producto (nombre);
CREATE UNIQUE INDEX IF NOT EXISTS ux_servicio_nombre ON inventario.servicio (nombre);
CREATE INDEX IF NOT EXISTS ix_venta_producto_estadia ON inventario.venta_producto (estadia_id);
CREATE INDEX IF NOT EXISTS ix_venta_servicio_estadia ON inventario.venta_servicio (estadia_id);
CREATE INDEX IF NOT EXISTS ix_seguimiento_producto_fecha ON inventario.seguimiento_producto (producto_id, fecha_movimiento);
CREATE INDEX IF NOT EXISTS ix_disponibilidad_inv_producto ON inventario.disponibilidad_inventario (producto_id);
CREATE INDEX IF NOT EXISTS ix_disponibilidad_inv_servicio ON inventario.disponibilidad_inventario (servicio_id);

CREATE UNIQUE INDEX IF NOT EXISTS ux_pre_factura_estadia ON facturacion.pre_factura (estadia_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_factura_numero ON facturacion.factura (numero_factura);
CREATE UNIQUE INDEX IF NOT EXISTS ux_factura_estadia ON facturacion.factura (estadia_id);
CREATE INDEX IF NOT EXISTS ix_pago_reserva ON facturacion.pago_parcial (reserva_habitacion_id);
CREATE INDEX IF NOT EXISTS ix_pago_factura ON facturacion.pago_parcial (factura_id);
CREATE INDEX IF NOT EXISTS ix_detalle_factura ON facturacion.detalle_compra (factura_id);

CREATE INDEX IF NOT EXISTS ix_promocion_fecha ON notificacion.promocion (fecha_inicio, fecha_fin);
CREATE INDEX IF NOT EXISTS ix_alerta_cliente ON notificacion.alerta (cliente_id);
CREATE INDEX IF NOT EXISTS ix_alerta_reserva ON notificacion.alerta (reserva_habitacion_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_termino_version ON notificacion.termino_condicion (version);
CREATE UNIQUE INDEX IF NOT EXISTS ux_fidelizacion_cliente ON notificacion.fidelizacion_cliente (cliente_id);

CREATE INDEX IF NOT EXISTS ix_mantenimiento_habitacion_fecha ON mantenimiento.mantenimiento_habitacion (habitacion_id, fecha_inicio, fecha_fin);
CREATE INDEX IF NOT EXISTS ix_mantenimiento_empleado ON mantenimiento.mantenimiento_habitacion (empleado_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_mantenimiento_uso ON mantenimiento.mantenimiento_uso (mantenimiento_habitacion_id);
CREATE UNIQUE INDEX IF NOT EXISTS ux_mantenimiento_remodelacion ON mantenimiento.mantenimiento_remodelacion (mantenimiento_habitacion_id);
CREATE INDEX IF NOT EXISTS ix_dashboard_mantenimiento_sede_fecha ON mantenimiento.dashboard_mantenimiento (sede_id, fecha_corte);

CREATE UNIQUE INDEX IF NOT EXISTS ux_mv_ingresos_por_mes ON facturacion.mv_ingresos_por_mes (mes);
CREATE UNIQUE INDEX IF NOT EXISTS ux_mv_ocupacion_por_sede ON distribucion.mv_ocupacion_por_sede (sede_id);




