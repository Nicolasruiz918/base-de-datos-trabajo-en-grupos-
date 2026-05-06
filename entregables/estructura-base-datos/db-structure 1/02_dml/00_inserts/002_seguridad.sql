INSERT INTO seguridad.rol (nombre, descripcion)
VALUES
  ('ADMINISTRADOR', 'Acceso administrativo general'),
  ('RECEPCION', 'Gestion de reservas, check in y check out'),
  ('MANTENIMIENTO', 'Gestion operativa de mantenimiento'),
  ('INVENTARIO', 'Gestion de productos, servicios y proveedores')
ON CONFLICT (nombre) DO UPDATE
SET descripcion = EXCLUDED.descripcion;

INSERT INTO seguridad.permiso (nombre, descripcion, accion)
VALUES
  ('GESTIONAR_RESERVA', 'Crear, actualizar y consultar reservas', 'WRITE'),
  ('GESTIONAR_FACTURA', 'Emitir y consultar facturas', 'WRITE'),
  ('GESTIONAR_INVENTARIO', 'Administrar productos, servicios y disponibilidad', 'WRITE'),
  ('GESTIONAR_MANTENIMIENTO', 'Administrar mantenimiento de habitaciones', 'WRITE'),
  ('CONSULTAR_DASHBOARD', 'Consultar informacion operativa', 'READ')
ON CONFLICT (nombre, accion) DO UPDATE
SET descripcion = EXCLUDED.descripcion;

INSERT INTO seguridad.modulo (nombre, descripcion, ruta_base)
VALUES
  ('PARAMETRIZACION', 'Configuracion base del negocio hotelero', '/parametrizacion'),
  ('DISTRIBUCION', 'Estructura fisica y comercial del hotel', '/distribucion'),
  ('PRESTACION_SERVICIO', 'Reserva, disponibilidad, check in, estadia y check out', '/prestacion-servicio'),
  ('FACTURACION', 'Pre facturacion, pagos, factura y detalle de compra', '/facturacion'),
  ('INVENTARIO', 'Productos, servicios, proveedores y disponibilidad', '/inventario'),
  ('NOTIFICACION', 'Promociones, alertas, terminos y fidelizacion', '/notificacion'),
  ('SEGURIDAD', 'Usuarios, roles, permisos, modulos y vistas', '/seguridad'),
  ('MANTENIMIENTO', 'Mantenimiento y disponibilidad operativa de habitaciones', '/mantenimiento')
ON CONFLICT (nombre) DO UPDATE
SET descripcion = EXCLUDED.descripcion,
    ruta_base = EXCLUDED.ruta_base;

INSERT INTO seguridad.usuario (persona_id, username, password_hash)
SELECT p.id, 'ariel5253', crypt('ariel5253', gen_salt('bf'))
FROM parametrizacion.persona p
WHERE p.numero_documento = '52530001'
ON CONFLICT (username) DO UPDATE
SET password_hash = EXCLUDED.password_hash,
    bloqueado = false,
    status = 'ACTIVE';

INSERT INTO seguridad.usuario_rol (usuario_id, rol_id)
SELECT u.id, r.id
FROM seguridad.usuario u
JOIN seguridad.rol r ON r.nombre = 'ADMINISTRADOR'
WHERE u.username = 'ariel5253'
ON CONFLICT (usuario_id, rol_id) DO NOTHING;

INSERT INTO seguridad.rol_permiso (rol_id, permiso_id)
SELECT r.id, p.id
FROM seguridad.rol r
CROSS JOIN seguridad.permiso p
WHERE r.nombre = 'ADMINISTRADOR'
ON CONFLICT (rol_id, permiso_id) DO NOTHING;

