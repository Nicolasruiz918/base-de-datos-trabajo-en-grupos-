INSERT INTO configuration.company (name, nit, legal_name, phone, email, address, website)
VALUES ('Hotel Demo', '900000000-1', 'Hotel Demo S.A.S.', '3000000000', 'contacto@hoteldemo.local', 'Direccion principal', 'https://hoteldemo.local')
ON CONFLICT (nit) DO UPDATE
SET name = EXCLUDED.name,
    legal_name = EXCLUDED.legal_name,
    phone = EXCLUDED.phone,
    email = EXCLUDED.email,
    address = EXCLUDED.address,
    website = EXCLUDED.website;

INSERT INTO configuration.day_type (name, description, applies_season, applies_holiday, applies_special)
SELECT v.name, v.description, v.applies_season, v.applies_holiday, v.applies_special
FROM (
  VALUES
    ('WEEKDAY', 'Dia operativo regular entre semana', false, false, false),
    ('WEEKEND', 'Dia de fin de semana', false, false, false),
    ('HOLIDAY', 'Dia feriado', false, true, false),
    ('HIGH_SEASON', 'Dia con regla de temporada alta', true, false, false)
) AS v(name, description, applies_season, applies_holiday, applies_special)
WHERE NOT EXISTS (
  SELECT 1
  FROM configuration.day_type td
  WHERE td.name = v.name
    AND td.date IS NULL
);

INSERT INTO configuration.payment_method (name, description, requires_reference, allows_partial_payment)
VALUES
  ('CASH', 'Pago en efectivo', false, true),
  ('CARD', 'Pago con tarjeta debito o credito', true, true),
  ('BANK_TRANSFER', 'Pago por transferencia bancaria', true, true)
ON CONFLICT (name) DO UPDATE
SET description = EXCLUDED.description,
    requires_reference = EXCLUDED.requires_reference,
    allows_partial_payment = EXCLUDED.allows_partial_payment;

INSERT INTO configuration.customer (document_type, document_number, name, last_name, phone, email, address)
VALUES
  ('CC', '100000001', 'Sofia', 'Martinez', '3001112233', 'sofia.martinez@example.local', 'Calle 10 # 1-20'),
  ('CC', '100000002', 'Carlos', 'Rojas', '3002223344', 'carlos.rojas@example.local', 'Carrera 15 # 30-50')
ON CONFLICT (document_type, document_number) DO UPDATE
SET name = EXCLUDED.name,
    last_name = EXCLUDED.last_name,
    phone = EXCLUDED.phone,
    email = EXCLUDED.email,
    address = EXCLUDED.address;

INSERT INTO configuration.person (document_type, document_number, name, last_name, phone, email)
VALUES
  ('CC', '52530001', 'Ariel', 'Administrator', '3005253001', 'ariel5253@example.local'),
  ('CC', '52530002', 'Recepcion', 'Demo', '3005253002', 'recepcion@example.local')
ON CONFLICT (document_type, document_number) DO UPDATE
SET name = EXCLUDED.name,
    last_name = EXCLUDED.last_name,
    phone = EXCLUDED.phone,
    email = EXCLUDED.email;

INSERT INTO configuration.employee (person_id, position, hire_date, work_phone, work_email)
SELECT p.id, 'Administrator', DATE '2026-01-01', '3005253001', 'ariel5253@hotel.local'
FROM configuration.person p
WHERE p.document_number = '52530001'
ON CONFLICT (person_id) DO UPDATE
SET position = EXCLUDED.position,
    work_phone = EXCLUDED.work_phone,
    work_email = EXCLUDED.work_email;



