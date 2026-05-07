INSERT INTO security.role (name, description)
VALUES
  ('ADMINISTRATOR', 'Acceso administrativo general'),
  ('FRONT_DESK', 'Gestion de reservations, check in y check out'),
  ('MAINTENANCE', 'Gestion operativa de maintenance'),
  ('INVENTORY', 'Gestion de products, services y supplieres')
ON CONFLICT (name) DO UPDATE
SET description = EXCLUDED.description;

INSERT INTO security.permission (name, description, action)
VALUES
  ('MANAGE_RESERVATION', 'Crear, actualizar y consultar reservations', 'WRITE'),
  ('MANAGE_INVOICE', 'Emitir y consultar invoices', 'WRITE'),
  ('MANAGE_INVENTORY', 'Administrar products, services y availability', 'WRITE'),
  ('MANAGE_MAINTENANCE', 'Administrar maintenance de rooms', 'WRITE'),
  ('READ_DASHBOARD', 'Consultar informacion operativa', 'READ')
ON CONFLICT (name, action) DO UPDATE
SET description = EXCLUDED.description;

INSERT INTO security.module (name, description, base_path)
VALUES
  ('CONFIGURATION', 'Configuracion base del negocio hotelero', '/configuration'),
  ('DISTRIBUTION', 'Estructura fisica y comercial del hotel', '/distribution'),
  ('SERVICE_DELIVERY', 'Reserva, availability, check in, stay y check out', '/service-delivery'),
  ('BILLING', 'Pre billing, payments, invoice y detail de compra', '/billing'),
  ('INVENTORY', 'Productos, services, supplieres y availability', '/inventory'),
  ('NOTIFICATION', 'Promociones, alerts, terminos y fidelizacion', '/notification'),
  ('SECURITY', 'Usuarios, roles, permissions, modules y system_views', '/security'),
  ('MAINTENANCE', 'Mantenimiento y availability operativa de rooms', '/maintenance')
ON CONFLICT (name) DO UPDATE
SET description = EXCLUDED.description,
    base_path = EXCLUDED.base_path;

INSERT INTO security.user_account (person_id, username, password_hash)
SELECT p.id, 'ariel5253', crypt('ariel5253', gen_salt('bf'))
FROM configuration.person p
WHERE p.document_number = '52530001'
ON CONFLICT (username) DO UPDATE
SET password_hash = EXCLUDED.password_hash,
    blocked = false,
    status = 'ACTIVE';

INSERT INTO security.user_rolee (user_id, rolee_id)
SELECT u.id, r.id
FROM security.user_account u
JOIN security.role r ON r.name = 'ADMINISTRATOR'
WHERE u.username = 'ariel5253'
ON CONFLICT (user_id, rolee_id) DO NOTHING;

INSERT INTO security.rolee_permission (rolee_id, permission_id)
SELECT r.id, p.id
FROM security.role r
CROSS JOIN security.permission p
WHERE r.name = 'ADMINISTRATOR'
ON CONFLICT (rolee_id, permission_id) DO NOTHING;



