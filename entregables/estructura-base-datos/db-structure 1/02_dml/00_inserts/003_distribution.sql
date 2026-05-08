INSERT INTO distribution.room_type (name, description, base_capacity, max_capacity)
VALUES
  ('SINGLE', 'Room for one guest', 1, 1),
  ('DOUBLE', 'Room for two guests', 2, 2),
  ('SUITE', 'Premium room with higher capacity and amenities', 2, 4)
ON CONFLICT (name) DO UPDATE
SET description = EXCLUDED.description,
    base_capacity = EXCLUDED.base_capacity,
    max_capacity = EXCLUDED.max_capacity;

INSERT INTO distribution.room_status (name, description, allows_reservation, allows_check_in)
VALUES
  ('AVAILABLE', 'Available for reservation and check-in', true, true),
  ('RESERVED', 'Reserved for a customer', false, true),
  ('OCCUPIED', 'Currently occupied', false, false),
  ('CLEANING', 'Pending or in cleaning process', false, false),
  ('BLOCKED', 'Blocked by operational decision', false, false),
  ('MAINTENANCE', 'Unavailable for maintenance', false, false)
ON CONFLICT (name) DO UPDATE
SET description = EXCLUDED.description,
    allows_reservation = EXCLUDED.allows_reservation,
    allows_check_in = EXCLUDED.allows_check_in;

INSERT INTO distribution.site (company_id, name, address, city, phone, email)
SELECT e.id, 'Main Site', 'Main address', 'Bogota', '3000000000', 'site.principal@hoteldemo.local'
FROM configuration.company e
WHERE e.nit = '900000000-1'
ON CONFLICT (company_id, name) DO UPDATE
SET address = EXCLUDED.address,
    city = EXCLUDED.city,
    phone = EXCLUDED.phone,
    email = EXCLUDED.email;

INSERT INTO distribution.room (site_id, room_type_id, room_status_id, number, floor, capacity, description)
SELECT s.id, th.id, eh.id, '101', 1, 1, 'Reference single room'
FROM distribution.site s
JOIN configuration.company e ON e.id = s.company_id
JOIN distribution.room_type th ON th.name = 'SINGLE'
JOIN distribution.room_status eh ON eh.name = 'AVAILABLE'
WHERE e.nit = '900000000-1'
ON CONFLICT (site_id, number) DO UPDATE
SET room_type_id = EXCLUDED.room_type_id,
    room_status_id = EXCLUDED.room_status_id,
    floor = EXCLUDED.floor,
    capacity = EXCLUDED.capacity,
    description = EXCLUDED.description;

INSERT INTO distribution.room (site_id, room_type_id, room_status_id, number, floor, capacity, description)
SELECT s.id, th.id, eh.id, '201', 2, 2, 'Reference double room'
FROM distribution.site s
JOIN configuration.company e ON e.id = s.company_id
JOIN distribution.room_type th ON th.name = 'DOUBLE'
JOIN distribution.room_status eh ON eh.name = 'AVAILABLE'
WHERE e.nit = '900000000-1'
ON CONFLICT (site_id, number) DO UPDATE
SET room_type_id = EXCLUDED.room_type_id,
    room_status_id = EXCLUDED.room_status_id,
    floor = EXCLUDED.floor,
    capacity = EXCLUDED.capacity,
    description = EXCLUDED.description;

INSERT INTO distribution.room_catalog (room_id, title, description, base_price, visible)
SELECT h.id, 'Room ' || h.number, h.description, CASE h.number WHEN '101' THEN 120000 ELSE 180000 END, true
FROM distribution.room h
WHERE h.number IN ('101', '201')
ON CONFLICT (room_id) DO UPDATE
SET title = EXCLUDED.title,
    description = EXCLUDED.description,
    base_price = EXCLUDED.base_price,
    visible = EXCLUDED.visible;


-- Loads prices for the configuration domain.
-- Runs here because it depends on room types loaded in distribution.
INSERT INTO configuration.price (room_type_id, day_type_id, value, start_date, end_date, condition)
SELECT th.id, td.id,
  CASE th.name
    WHEN 'SINGLE' THEN 120000
    WHEN 'DOUBLE' THEN 180000
    ELSE 320000
  END,
  DATE '2026-01-01',
  NULL,
  'Initial base price pending final dynamic rules'
FROM distribution.room_type th
CROSS JOIN configuration.day_type td
WHERE td.name = 'WEEKDAY'
ON CONFLICT (room_type_id, day_type_id, start_date) DO UPDATE
SET value = EXCLUDED.value,
    condition = EXCLUDED.condition;




