INSERT INTO security.role (name, description)
VALUES
  ('ADMINISTRATOR', 'General administrative access'),
  ('FRONT_DESK', 'Reservation, check-in and check-out management'),
  ('MAINTENANCE', 'Operational maintenance management'),
  ('INVENTORY', 'Product, service and supplier management')
ON CONFLICT (name) DO UPDATE
SET description = EXCLUDED.description;

INSERT INTO security.permission (name, description, action)
VALUES
  ('MANAGE_RESERVATION', 'Create, update and query reservations', 'WRITE'),
  ('MANAGE_INVOICE', 'Issue and query invoices', 'WRITE'),
  ('MANAGE_INVENTORY', 'Manage products, services and availability', 'WRITE'),
  ('MANAGE_MAINTENANCE', 'Manage room maintenance', 'WRITE'),
  ('READ_DASHBOARD', 'Query operational information', 'READ')
ON CONFLICT (name, action) DO UPDATE
SET description = EXCLUDED.description;

INSERT INTO security.module (name, description, base_path)
VALUES
  ('CONFIGURATION', 'Base business configuration', '/configuration'),
  ('DISTRIBUTION', 'Physical and commercial hotel structure', '/distribution'),
  ('SERVICE_DELIVERY', 'Reservation, availability, check-in, stay and check-out', '/service-delivery'),
  ('BILLING', 'Pre-invoicing, payments, invoices and purchase details', '/billing'),
  ('INVENTORY', 'Products, services, suppliers and availability', '/inventory'),
  ('NOTIFICATION', 'Promotions, alerts, terms and customer loyalty', '/notification'),
  ('SECURITY', 'Users, roles, permissions, modules and system views', '/security'),
  ('MAINTENANCE', 'Maintenance and operational room availability', '/maintenance')
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

INSERT INTO security.user_role (user_id, role_id)
SELECT u.id, r.id
FROM security.user_account u
JOIN security.role r ON r.name = 'ADMINISTRATOR'
WHERE u.username = 'ariel5253'
ON CONFLICT (user_id, role_id) DO NOTHING;

INSERT INTO security.role_permission (role_id, permission_id)
SELECT r.id, p.id
FROM security.role r
CROSS JOIN security.permission p
WHERE r.name = 'ADMINISTRATOR'
ON CONFLICT (role_id, permission_id) DO NOTHING;



