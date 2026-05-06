INSERT INTO seguridad.permiso (nombre, descripcion, accion)
VALUES ('CONSULTAR_RESERVA', 'Consultar reservas y disponibilidad', 'READ')
ON CONFLICT (nombre, accion) DO UPDATE
SET descripcion = EXCLUDED.descripcion;

INSERT INTO inventario.servicio (nombre, descripcion, valor_venta, disponible)
VALUES ('Parqueadero', 'Servicio de parqueadero por noche', 15000, true)
ON CONFLICT (nombre) DO UPDATE
SET descripcion = EXCLUDED.descripcion,
    valor_venta = EXCLUDED.valor_venta,
    disponible = EXCLUDED.disponible;

